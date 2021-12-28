#!/bin/bash

# https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes

if [ -z "$1" ]; then
    echo "No argument"
    exit 1
fi

# DATE=$(date '+%Y-%m-%d')
# BACKUP_DIR="${1}/${DATE}"
BACKUP_DIR=$1
mkdir $BACKUP_DIR
# rm -r "${BACKUP_DIR}"/*

docker stop caddy

docker run --rm -v caddy-config:/data -v $BACKUP_DIR:/backup ubuntu tar cvf /backup/caddy-config.tar /data
docker run --rm -v caddy-data:/data -v $BACKUP_DIR:/backup ubuntu tar cvf /backup/caddy-data.tar /data

docker start caddy