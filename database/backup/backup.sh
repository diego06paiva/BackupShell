#!/bin/bash

# Define usuário e senha do banco
USER='root'
PASS='vasco'

# Diretório onde serão salvos os backups
DIR_BK='/home/diego/diego/backup'

# Lista dos bancos de dados que serão realizados o backup
DATABASES=(testdb)

# Verifica se existe o diretório para os backups
if [ ! -d "$DIR_BK" ]; then
    mkdir -p "$DIR_BK"
fi

# Loop para backupear todos os bancos
for db in "${DATABASES[@]}"; do
    # Cria o backup usando docker exec
    # Redireciona a saída do mysqldump para o arquivo
    if docker exec database-db-1 /usr/bin/mysqldump -u$USER -p$PASS $db > "$DIR_BK/backup_${db}.sql"; then
        echo "Backup do banco de dados $db concluído com sucesso."
    else
        echo "Falha ao realizar o backup do banco de dados $db."
    fi
done
