#!/bin/bash

clear
fechar=0

menuCriarContato() {
    mkdir ./contatos
    nome=$(
        dialog --stdout\
            --title 'criação de contato'\
            --inputbox 'nome:'\
            0 0      
    )

    telefone=$(
        dialog --stdout\
            --title 'criação de contato'\
            --inputbox 'telefone:'\
            0 0      
    )

    nascimento=$(
        dialog --stdout\
            --title 'criação de contato'\
            --calendar 'data de nascimento'\
            0 0\
            31 12 1999
    )

    relacao=$(
        dialog --stdout\
            --title 'criação de contato'\
            --radiolist 'qual sua relação com a pessoa?'\
            0 0 0\
            amigo ' ' on\
            parente ' ' off\
            cliente ' ' off
    )

    cancelar=$(
        dialog --stdout\
        --title 'criação de contato'\
        --yesno 'deseja salvar?'\
        0 0
    )
   if test $cancelar=0
   then
        echo -e "$nome\n$telefone\n$nascimento\n$relacao\n$(date +%d)/$(date +%m)/$(date +%y) - $(date +%H):$(date +%M)">>./contatos/$nome
    fi
}

menuMeusContatos() {
    meusContatos=$(dialog --stdout --title 'meus contatos' --fselect ./contatos/ 10 10)

    escolherContato=$(
        dialog --stdout\
            --title 'meus contatos'\
            --inputbox 'qual contato deseja ver?'\
          0 0      
    )

        dialog --stdout\
            --title 'meus contatos'\
            --textbox contatos/$escolherContato\
            10 40
}

menuApagarContato() {
    apagarContato=$(
        dialog --stdout\
        --title 'apagar contato'\
        --inputbox 'qual o nome do contato que deseja apagar?'\
        0 0
        )
    
    rm ./contatos/$apagarContato
}

menuHome() {
    home=$(
        dialog --stdout --title 'Contatos' --menu ' ' 0 0 0 \
            1 'ver todos os contatos cadastrados' \
            2 'cadastrar novo contato' \
            3 'apagar um contato'\
            4 'fechar o programa' 
    )


    case $home in
        1)menuMeusContatos;;

        2)menuCriarContato;;

        3)menuApagarContato;;

        4)fechar=1;;
    esac
}

while test $fechar = 0
do
    menuHome
done

clear