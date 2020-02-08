#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

menu() {
    echo -e "##############################################\n#\n#\tWelcome to the docker pannel\n#\n##############################################\n"
    echo -e "\n\tMENU\t\n\n"
    echo -e "0 - Print menu"
    echo -e "1 - List available containers"
    echo -e "2 - List all containers"
    echo -e "3 - List available docker images"
    echo -e "4 - Remove a docker container"
    echo -e "5 - Remove a docker image"
    echo -e "6 - Build a docker"
    echo -e "7 - Run a docker"
    echo -e "8 - Stop all containers"
    echo -e "9 - Remove all containers - FORCE"
}

choice() {
    echo -e "\nWhat is your choice?"
    read -p "Your choice: " userchoice
    return $userchoice
}

removeImage() {
    read -p "Wich Docker image want you to remove?(imageid) " value
    docker rmi $value
}

removeContainer() {
    read -p "Wich Docker container want you to remove?(containerid) " value
    docker rm $value
}

buildDocker() {
    read -p "Which name want you give to your docker? " name
    docker build -t $name --build-arg user=`whoami` --build-arg uid=ìd -u` --build-arg gid=`id -g .

}

runDocker() {
    read -p "What folder dl? " folder
    read -p "Which image use? " name
    docker run --rm -it -v `pwd`/$folder:/home/`whoami`/$folder -v $image bash
}

selectAction() {
    if [ $1 == 0 ]; then
        menu
    elif [ $1 == 1 ]; then
        docker container ls -a
    elif [ $1 == 2 ]; then
        docker container ls
    elif [ $1 == 3 ]; then
        docker images
    elif [ $1 == 4 ]; then
        removeContainer
    elif [ $1 == 5 ]; then
        removeImage
    elif [ $1 == 6 ]; then
        buildDocker
    elif [ $1 == 7 ]; then
        runDocker
    elif [ $1 == 8 ]; then
        docker stop  $(docker ps -a -q)
    elif [ $1 == 9 ]; then
        docker rm -f $(docker ps -aq)
    else
        echo "Wrong answer"
        exit -1
    fi
}

repeatAction() {
    repeatChoice='y'
    while [ $repeatChoice == 'y' ]; do
        choice
        userChoice=$?
        selectAction $userChoice
        echo -e "\n${RED}Do you want to do an other action?(y/n)${NC}"
        read -p "Your choice: " repeatChoice
    done
    echo "Bye"
    exit -1
}

menu
repeatAction
