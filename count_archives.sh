#!/bin/bash

# [?] Script to count files in a directory, separating by file extension type and overall count

# [*] Developer: sirProxy_ <joao@tavares.dev.br>
# [*] Website: https://tavares.dev.br
# [*] Github: https://github.com/SirProxy

CIANO="\e[1;36m"
VERDE="\e[1;32m"
ENDCOLOR="\e[0m"

function loading() {
    local load_interval="${1}"
    local loading_message="${2}"
    local elapsed=0
    local loading_animation=( '—' "\\" '|' '/' )

    echo -n "${loading_message} "

    tput civis
    trap "tput cnorm" EXIT
    while [ "${load_interval}" -ne "${elapsed}" ]; do
        for frame in "${loading_animation[@]}" ; do
            printf "%s\b" "${frame}"
            sleep 0.25
        done
        elapsed=$(( elapsed + 1 ))
    done
    printf " \b\n"
    tput cuu1; tput dl1 
}

function escrever() {
  echo -e "[${CIANO}$1${ENDCOLOR}] $2"
}

function banner() {

  echo -e " " 
  echo -e "${CIANO}          _   ___  ___ _  _ _____   _____ ___  ${ENDCOLOR}"
  echo -e "${CIANO}         /_\ | _ \/ __| || |_ _\ \ / / __/ __| ${ENDCOLOR}"
  echo -e "${CIANO}        / _ \|   / (__| __ || | \ V /| _|\__ \ ${ENDCOLOR}"
  echo -e "${CIANO}       /_/ \_\_|_\\___|_||_|___| \_/ |___|___/ ${ENDCOLOR}"
  echo -e " " 
  escrever "?" "Script to count files in a directory, separating by file extension type and overall count"
  escrever "?" "Feel free to improve this version. Thank you ${CIANO}╰(*°▽°*)╯${ENDCOLOR}"
  escrever "?" "Version: ${CIANO}0.1${ENDCOLOR}"
  echo -e " "
  escrever "@" "Developer: ${CIANO}sirProxy_ ${ENDCOLOR}<${CIANO}joao@tavares.dev.br${ENDCOLOR}>"
  escrever "@" "Website: ${CIANO}https://tavares.dev.br${ENDCOLOR}"
  escrever "@" "Github: ${CIANO}https://github.com/SirProxy${ENDCOLOR}"
  echo -e " "
}

#loading 2 "Loading Count Archives"

if [ "$1" == "" ]
then

  banner

  escrever "*" "Using: $0 <diretory>"
  escrever "*" "Example: $0 ./usr/bin"

else

  declare -A EXT
  DIRETORIO="$1"

  banner

  while read FILE
  do
    ((EXT[${FILE##*.}]++))
  done < <(find "$DIRETORIO" -type f -regextype egrep -regex '^.*\.\w+$' 2>/dev/null)

  escrever "*" "Total files by extensions:"
  for ext in ${!EXT[@]}
  do
    escrever "+" ".$ext: ${CIANO}${EXT[$ext]}${ENDCOLOR} files"
    TOTAL+="+"${EXT[$ext]}
  done

  echo ""
  escrever "+" "Total: ${CIANO}$((TOTAL))${ENDCOLOR} files."
  echo ""

fi

