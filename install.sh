#!/bin/bash

echo """                                          
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗      █████╗ ██████╗ 
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██╔══██╗██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ███████║██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██╔══██║██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗██║  ██║██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
                    Jacob I.A Project
""" 

# Detect the platform (similar to $OSTYPE)
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    alias ls='ls --color=auto'
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin') 
    OS='Mac'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac

if [ "$OS" = "Linux" ]; then
    echo "\033[01;32m[!] Você está utilizando Linux \033[01;37m"
    sleep 3
    echo "\033[01;33m[!] Instalando...\033[01;37m\n"
    sleep 6
    sudo apt-get install python3
    sudo apt-get install python3-pip
    sudo apt-get install portaudio19-dev 
    sudo apt-get install python-pyaudio
    sudo apt-get install python3-pyaudio
    sudo apt-get update
    sleep 2
    pip install -r requirements.txt
    pip install gTTS
    sleep 2
    echo "\n\033[01;07m[!] Instalação concluída !\033[01;32m"
    read -p "[!] Deseja iniciar o software? [S/N]: " choose
    if [ "$choose" = "S" ]; then
        echo "\n\033[01;07m[!] Iniciando em instantes...\033[0;0m"
        sleep 2
        python jacob.py || python3 jacob.py
        echo "Okay"
    else
        echo "Você não iniciou"
    fi
elif [ "$OS" = "Windows" ]; then
    echo "\033[01;32m[!] Você está utilizando o Windows \033[01;37m"
    sleep 1
    echo "\n\033[01;31m[!] Não há suporte. Instale manualmente...\033[0;0m\n"
    echo "=> Siga os passos descritos no repositório abaixo para efetuar a instalação..."
    sleep 2
    echo "\n\033[01;31mgithub.com/mvrquxs/jacob-neural\033[0;0m\n"

    
else
    echo "\n\033[01;31m[!] Você está utilizando Mac OS?\033[0;0m"
    echo "\n\033[01;31m[!] Não há suporte. Instale manualmente...\033[0;0m\n"
    echo "=> Siga os passos descritos no repositório abaixo para efetuar a instalação..."
    sleep 2
    echo "\n\033[01;31mgithub.com/mvrquxs/jacob-neural\033[0;0m\n"
fi
