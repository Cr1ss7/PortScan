#!/bin/bash

function ctrl_c(){
    echo -e "\n\n[!] Saliendo...\n"
    exit 1
}

#CTRL C
trap ctrl_c SIGINT

declare -a ports=( $(seq 1 65535) )

function myport(){
    (exec 3<> /dev/tcp/$1/$2) 2>/dev/null

    if [ $? -eq 0 ]; then
        echo -e "\n[+] El puerto $2 esta abierto"
    fi

    exec 3>&-
    exec 3<&-
}

if [ $1 ]; then
    for port in ${ports[@]}; do
        myport $1 $port &
    done
else
    echo -e "\n[+] Digite una ip a escanear..."
    exit 1;
fi

wait
