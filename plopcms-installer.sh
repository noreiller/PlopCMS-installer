#!/bin/bash
# @author: Aurélien MANCA
# @description: Create a new Plop CMS sandbox

echo "CAUTION: this script will succeed only if you have already created the database."

db_server_default="localhost"
db_user_default="root"
db_pwd_default=""
db_name_default="plop"

echo "Database server ($db_server_default) :"
read db_server
if [ ! -n "$db_server" ]; then
	db_server=$db_server_default
fi

echo "Database user ($db_user_default) :"
read db_user
if [ ! -n "$db_user" ]; then
	db_user="$db_user_default"
fi

echo "Database password ($db_pwd_default) :"
read db_pwd

echo "Database name ($db_name_default) :"
read db_name
if [ ! -n "$db_name" ]; then
	db_name="$db_name_default"
fi

echo "DSN is : \"mysql:host=$db_server;dbname=$db_name\" $db_user $db_pwd."

git clone git@github.com:plopcms/PlopCMS-sandbox.git
cd ./PlopCMS-sandbox/
git submodule update --init --recursive

cp ./config/ProjectConfiguration.class.php.sample ./config/ProjectConfiguration.class.php

./symfony plop:install "mysql:host=$db_server;dbname=$db_name" $db_user $db_pwd
./plugins/sfPlopPlugin/config/build.sh
