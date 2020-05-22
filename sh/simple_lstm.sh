#!user/bin/bash

. /tmp/fairseq-work.txt

CUDA_VISIBLE_DEVICES=${CUDA} fairseq-train data-bin/iwslt14.tokenized.de-en \
  --arch tutorial_simple_lstm \
  --encoder-dropout ${ENC_DROP} --decoder-dropout ${DEC_DROP} \
  --optimizer ${OPTIM} --lr ${LR} --lr-shrink ${LR_SHRINK} \
  --max-tokens ${MAX_TOKENS}

echo -e "\n"
echo 'FIN simple_lstm.sh'
