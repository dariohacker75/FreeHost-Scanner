#!/bin/bash

# Arte do Dario Hacker
clear
echo "==================🌍========================"
echo "       SCRIPT SCANNER DE HOSTS"
echo "           by DARIO HACKER"
echo "Entre no Canal do Telegram: t.me/dariohacker75
echo "==================🌍========================"

# Verifica se o arquivo hosts.txt existe
if [ ! -f hosts.txt ]; then
    echo "Erro: O arquivo hosts.txt não foi encontrado!"
    exit 1
fi

# Função para testar um host
testar_host() {
    host=$1
    response=$(curl --connect-timeout 3 -s -o /dev/null -w "%{http_code}" https://$host)

    if [[ "$response" == "200" || "$response" == "301" || "$response" == "302" ]]; then
        echo "[+] Host Válido: $host ($response)"
        echo "$host" >> hosts_validos.txt
    else
        echo "[-] Host Inválido: $host"
    fi
}

# Lê e testa cada host em paralelo
echo "A testar hosts, aguarde..."
> hosts_validos.txt
cat hosts.txt | while read host; do
    testar_host "$host" &
done

wait
echo ""
echo "Scan finalizado!"
