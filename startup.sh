#!/bin/sh
export RED="\e[31m"
export GREEN="\e[32m"
export ENDCOLOR="\e[0m"

echo "Export variable fron .env"
export $(grep -v '^#' .env | xargs)

# Get variable env
if [ ! -f ".env" ];then
  echo -e "${RED} Error: .env does not exits!! ${ENDCOLOR}"
  exit
fi

export GITLAB_HOME=$(pwd)/"${NAME_STORE}"
echo "Set variable GITLAB_HOME = ${GITLAB_HOME}"

# Default will store at folder gitlab have been clone.
if [ ! -d "${GITLAB_HOME}" ];then
  echo "Look like not have folder ${NAME_STORE}"
  mkdir -p "${GITLAB_HOME}"/{config,logs,data}
  echo "Create folder complete"
fi

echo "Found exits folder gitlab now start replace data and copy to container docker"

########### Option ##############
## Config SSL for gitlab manual
#################################

#################################
## Ubuntu
#################################
# Install package
# if [[ ! "$OSTYPE" == "darwin"* ]];then
#  apt install certbot openssl
# fi

# General ssl by certbot
# certbot certonly --rsa-key-size 2048 --agree-tos --no-eff-email --email "${EMAIL}" -d "${EXTERNAL_URL}"
# echo "Provide ssl ${EXTERNAL_URL} complete!"

# Copy certificate ssl by certbot.
# cp /etc/letsencrypt/live/"${EXTERNAL_URL}"/fullchain.pem "${GITLAB_HOME}"/config/ssl/
# cp /etc/letsencrypt/live/"${EXTERNAL_URL}"/privkey.pem "${GITLAB_HOME}"/config/ssl/

# Provide openssl output at GITLAB_HOME
# sudo openssl dhparam -out "${GITLAB_HOME}"/config/ssl/dhparams.pem 2048
# echo "Provide openssl have been created in ${GITLAB_HOME}/config/ssl/"

#
################################

# Run docker
docker-compose up -d
echo -e "${GREEN}Docker compose run gitlab complete! Wait a minnute for the starting gitlab config${ENDCOLOR}"

###############################
# Export password root account
# echo "User: root"
# echo "Password: ${ROOT_PASSWORD}"