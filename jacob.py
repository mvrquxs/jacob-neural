from introduce import index

from progress.bar import Bar
from time import sleep 

import json

from googletrans import Translator
from env import __sessions
import os

from vosk import Model, KaldiRecognizer, SetLogLevel
import pyaudio

from playsound import playsound
import openai
import os
import boto3


index.show_banner()

with Bar('[!] Apertando os cintos...', max=10) as bar:
    for i in range(10):
        sleep(0.2)
        bar.next()

model = Model('data/model')
recognizer = KaldiRecognizer(model, 16000)
SetLogLevel(-1)

while 1:
    cap = pyaudio.PyAudio()
    stream = cap.open(format=pyaudio.paInt16, channels=1, rate=16000, input=True, frames_per_buffer=8192)
    stream.start_stream()

    polly_client = boto3.Session(
        aws_access_key_id=__sessions.ack_,
        aws_secret_access_key=__sessions.asak_,
        region_name='us-west-2').client('polly')
    
    def recognizing_voice():
        print(index.JCWarn.Orange + '\n\n[!]', index.JCWarn.Bold + 'Atenção =>', index.JCWarn.Red + 'Estou te escutando.')
        playsound('data/warnUsr.mp3')
        while 1:
            data = stream.read(4096)
            if(recognizer.AcceptWaveform(data)):
                recognition = recognizer.Result()
                jsndecode = json.loads(recognition)
                return jsndecode['text']
                break

    usrsay = recognizing_voice().strip()
    
    if usrsay == '':
            print(index.JCWarn.Red + '\n[!] Atenção =>', index.JCWarn.Orange + 'Estou esperando você falar algo.')
            playsound('data/warnUsr.mp3')
            sleep(0.2)
    else:
            print(index.JCWarn.Reset + '\n[+] Reconhecimento de fala concluído.\n' + index.JCWarn.Bold)
            print(index.JCWarn.Green + '[-] VOCÊ:', usrsay + '')
            
            englishphrase = Translator().translate(usrsay, dest='en')
            
            def OpenAI_Connect():
                openai.api_key = __sessions.opi_k
                contentAI = openai.Completion.create(
                    model="text-davinci-002",
                    prompt="Human:"+englishphrase.text+"\nAI:",
                    temperature=0.85,
                    max_tokens=150,
                    top_p=1,
                    frequency_penalty=0.0,
                    presence_penalty=0.2,
                )
                return contentAI.choices[0].text

            pt = Translator().translate(OpenAI_Connect(), dest='pt')
            ai_answer = pt.text
            responsePT = ai_answer.replace(':' , '').strip(" ")

            response = polly_client.synthesize_speech(VoiceId='Camila',
                OutputFormat='mp3', 
                Text = responsePT,
                Engine = 'neural')

            print(index.JCWarn.Bold + '[-] BOT:', responsePT)

            file = open('data/resultAI.mp3', 'wb')
            file.write(response['AudioStream'].read())
            file.close()
            playsound('data/resultAI.mp3')            

    