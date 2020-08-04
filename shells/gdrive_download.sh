#!/bin/bash

declare -A FILES

FILES[annotations.zip]="1EsAL5Q9FfOQls28qYmr2sO6rha1d4YVz"
FILES[set00.tar]="1tPeaQr1cVmSABNCJQsd8OekOZIjpJivj"
FILES[set01.tar]="1apo5VxoZA5m-Ou4GoGR_voUgLN0KKc4g"
FILES[set02.tar]="1yvfjtQV6EnKez6TShMZQq_nkGyY9XA4q"
FILES[set03.tar]="1jvF71hw4ztorvz0FWurtyCBs0Dy_Fh0A"
FILES[set04.tar]="11Q7uZcfjHLdwpLKwDQmr5gT8LoGF82xY"
FILES[set05.tar]="1Q0pnxM5cnO8MJJdqzMGIEryZaEKk_Un_"
FILES[set06.tar]="1ft6clVXKdaxFGeihpth_jdBQxOIirSk7"
FILES[set07.tar]="1-E_B3iAPQKTvkZ8XyuLcE2Lytog3AofW"
FILES[set08.tar]="1oXCaTPOV0UYuxJJrxVtY9_7byhOLTT8G"
FILES[set09.tar]="1f0mpL2C2aRoF8bVex8sqWaD8O3f9ZgfR"
FILES[set10.tar]="18TvsJ5TKQYZRlj7AmcIvilVapqAss97X"

# Make data dir

mkdir -p data && cd data

for FILE_NAME in "${!FILES[@]}"; do 
   FILE_ID=${FILES[$FILE_NAME]}
   
   rm -rf /tmp/cookies.txt
   CONFIRM=$(wget -qq --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id="$FILE_ID -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')

   wget -qq --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm="$CONFIRM"&id="$FILE_ID -O $FILE_NAME
   rm -rf /tmp/cookies.txt

   if [[ "$FILE_NAME" == *.zip ]]; then
       unzip $FILE_NAME
   else
       tar -xf $FILE_NAME
   fi

   rm -r $FILE_NAME

done
