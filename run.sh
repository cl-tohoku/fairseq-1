#!user/bin/bash

# functions

function echo_fname () {
  local array=($@)
  for a in ${array[@]}
  do
    echo -n "${a%.*} "
  done
  echo -e -n "\n> "
}


# main ================================

USAGE="Usage: bash train.sh -g [GPU_ID]"

while getopts g: OPT
do
  case ${OPT} in
    "g" ) FLG_G="TRUE"; GPU_ID=${OPTARG};;
    * ) echo ${USAGE} 1>&2
      exit 1 ;;
  esac
done

if test “${GPU_ID}” != “TRUE”; then
  GPU_ID=0
fi


echo -e "Which sh-scripts will you intend to run for this time?\n"
LS=`ls ./sh/`
echo_fname ${LS[@]}

read SH
SH=sh/${SH}.sh

# variables
cat << EOS > /tmp/fairseq-work.txt
CUDA=${GPU_ID}

ENC_DROP=0.2
DEC_DROP=0.2

LR=0.005
LR_SHRINK=0.5
OPTIM=adam

MAX_TOKENS=12000

EOS


if [ -f ${SH} ] ; then
  bash ${SH}
else
  echo "NOT FOUND: ${SH}"
fi


echo 'DONE'
