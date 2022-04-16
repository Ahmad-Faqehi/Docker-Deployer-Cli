#!/bin/bash

tfs_token="" #  put your TFS token if you want use option 9.
looping=true

while [ $looping ]
do

echo "
Options:
1- Load Image
2- Show Images
3- Tag Image
4- Remove Image
5- Run Continer
6- Stop Continer
7- Show Continers
8- Remove Coniner
9- Download tar file from TFS 
10- Show logs
11- Pull Image from Docker Hub
12- Exit

";

read -p 'Select one option: ' option



if [ $option == 1 ] # todo: 1- Load Image
then
    ls -l ;
    read -p "Enter your tar file name, or enter [N] to back: " image_file
    
    if [ $image_file == 'N' ]
    then
    clear
    continue
    fi

    docker load -i $image_file;
    docker images;

elif [ $option == 2 ] # todo: 2- Show Images
then
    docker images;
    echo " "
    read -p 'Press enter to continue... ' someran
    continue

elif [ $option == 3 ] # todo: 3- Tag Image
then
    docker images
    echo " "

    read -p 'Enter Image ID, or enter [N] to back: ' image_id
    if [ $image_id == 'N' ]
    then
    clear
    continue
    fi

    read -p 'Enter Tag Name, or enter [N] to back:' tag_name
    if [ $tag_name == 'N' ]
    then
    clear
    continue
    fi
    read -p 'Enter Tag Version, or enter [N] to back:' tag_version
    if [ $tag_version == 'N' ]
    then
    clear
    continue
    fi

    docker tag $image_id $tag_name:$tag_version


elif [ $option == 4 ] # todo: 4- Remove Image
then

    read -p 'Are you sure you want remove an image? [Y] [N]: ' remove
    if [ $remove == 'Y' ]
    then
            docker images
            read -p "Enter image id:  " image_id
            docker rmi $image_id
    fi

elif [ $option == 5 ] # todo: 5- Run Continer
then

    
    docker images
    read -p "Enter image name with version(tag), or enter [N] to back: " image
    if [ $image == 'N' ]
    then
    clear
    continue
    fi
    port_string=""
    read -p "Run continer with port? [Y] " has_port
    if [ $has_port == 'Y' ]
    then
    read -p "Enter continer port: " continer_port
    read -p "Enter expose port: " expose_port
    port_string="-p $expose_port:$continer_port"
    fi
    env_string=""
    read -p "Has enviorment varibles? [Y]: " has_env
    if [ $has_env == 'Y' ]
    then
    read -p "Enter enviorment varibles all on one line (example: -e TZ=Asia/Riyadh -e User=Ahmed): " enviorment_varible
    env_string="$enviorment_varible"
    fi
    read -p "Enter continer name, or enter [N] to back: " container_name
    if [ $container_name == 'N' ]
    then
    clear
    continue
    fi
    docker run -d --restart on-failure $env_string $port_string --name  $container_name $image




elif [ $option == 6 ] # todo: 6- Stop Continer
then
     docker ps;
     echo " "
      read -p 'Enter continer ID, or enter [N] to back: ' continer_id
    if [ $continer_id == 'N' ]
    then
    clear
    continue
    fi
     docker stop $continer_id

elif [ $option == 7 ]
then
    docker ps;
    echo " "
    read -p 'Press enter to continue... ' someran
    continue

elif [ $option == 8 ] # todo: 8- Remove Continer
then
    read -p 'Are you sure you want remove an container? [Y / N]: ' remove
    if [ $remove == 'Y' ]
    then
     docker ps -a;
      read -p 'Enter continer ID: ' continer_id
     docker rm -f $continer_id
    fi

elif [ $option == 9 ] # todo: Download file from tfs DevOps
then
    read -p 'Enter URL, or enter [N] to back: ' url_tar
    if [ $url_tar == 'N' ]
    then
    clear
    continue
    fi
    # read -p 'Enter File Name with tar extension, or enter [N] to back: ' file_name
    # if [ $file_name == 'N' ]
    # then
    # clear
    # continue
    # fi
    #curl --location --request GET $url_tar --header "Authorization: Basic $tfs_token" -o $file_name
    wget --header="Authorization: Bearer $tfs_token" $url_tar
elif [ $option == 10 ]
then
    docker ps;
    echo " " 
    read -p 'Enter continer id, or enter [N] to back: ' continer_id
    if [ $continer_id == 'N' ]
    then
    clear
    continue
    fi
    docker logs $continer_id

elif [ $option == 11 ] # todo: 10- Exit
then
    read -p 'Enter image name: or enter [N] to back: ' image_name
    docker pull $image_name

elif [ $option == 12 ]
then
exit
else
    echo "Wrong chooes."
fi





done
exit
