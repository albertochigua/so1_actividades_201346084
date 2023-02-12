#!/bin/bash
#José Alberto Alarcón Chigua
#201346084
#SO1 - A - 1S2023

#Verificamos si la variable GITHUB_USER esta establecida
if [ -z ${GITHUB_USER+x} ]; then
	echo "Variable GITHUB_USER no establecida";
	exit 1;
fi
#creamos variable url
url="https://api.github.com/users/$GITHUB_USER"
#obtenemos json de la api de GitHub
json=$(curl $url -s)

#Extraemos variables con epxresion regular usando echo, grep, awk y tr
login_regex='"login": "([^,]*)",' 
login=$(echo "${json}" | grep -oP  "${login_regex}" | awk '{print $2}' | tr -d \",)
id_regex='"id": ([^,]*),'
id=$(echo "${json}" | grep -oP  "${id_regex}" | awk '{print $2}' | tr -d \",)
created_at_regex='"created_at": "([^,]*)",'
created_at=$(echo "${json}" | grep -oP  "${created_at_regex}" | awk '{print $2}' | tr -d \",)

#Concatenamos el mensaje de salida
msg="Hola ${login}. User ID:${id}. Cuenta fue creada el:${created_at}"
#Obtenemos fecha actual
now=$(date +"%Y-%m-%d")
#Creamos path de directorio 
dir="/tmp/${now}"
#Creamos path de archivo
file_dir="$dir/saludos.log"

#Verificamos que exista el directorio, de no existir lo creamos
if [ ! -d $dir ]; then
  mkdir -p $dir ;
fi
#Imprimirmos mensaje
echo $msg
#Imprimimos memsaje redirecionando salida al archivo saludos.log
echo $msg > $file_dir
#Terminamos con exito
exit 0
