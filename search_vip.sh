#!/bin/bash

echo "***************************"
echo "***************************"
echo "***************************"
echo "Starting"
echo "***************************"
echo "***************************"
echo "***************************"

while true; do

echo "Que virtual server quieres buscar (IP:Puerto) (Ejemplo 200.0.63.48:443):"

read VS

	if [[ $VS =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3\}:[0-9]{1,4}$ ]]; then

		F5s=/root/scripts/Host.txt

		while read F5s ; do
			echo "-----------------------------------------------------------------------------------------"
			echo "-----------------------------------------------------------------------------------------"
			echo "-----------------------------------------------------------------------------------------"
			echo "BIG-IP:"
			echo $F5s
			echo "---------------------------------------------------------------------------------------------------------"
			data=$(curl -k -u usrpblcc:usrpblcc https://$F5s/mgmt/tm/ltm/virtual?options=destination | jq . | grep $VS)
			ip=$(echo $data | cut -d "/" -f 3 | cut -d "\"" -f 1)
			#echo "VAR"
			var=${#data}
			#echo $var
			#echo "VAR----------------"
			
			if [ $var != 0 ]; then
				#echo "DATA inside the if var not 0"
				#echo $data
				#echo $ip
				if [ $VS == $ip ]; then
					echo "########################"
					echo "########################"
					echo "########################"	
					echo "Esta en el F5:"
					echo $F5s
					echo "########################"
					echo "########################"
					echo "########################"
				fi
			fi
		done < $F5s
	fi
done
