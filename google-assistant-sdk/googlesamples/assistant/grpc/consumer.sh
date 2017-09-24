#!/bin/sh
STOPS=1
INPUT=/var/www/html/iwave/google/
FINPUT=/var/www/html/iwave/google/*
OUTPUT=/var/www/html/owave/google/
while true
do
    if [ "$(ls -A $FINPUT)" ]
    then
        #echo "Directory is empty. Sleep $STOPS seconds."
        #sleep $STOPS
    #else
        for file in $FINPUT
        do
            fname=${file##*/}
            echo $fname

            mfile=$INPUT'o'$fname
            #echo $mfile

            sox $file -c 1 -r 16k $mfile

            oifile=$OUTPUT'i'$fname
            olfile=$OUTPUT'l'$fname
            orfile=$OUTPUT'r'$fname
            ofile=$OUTPUT$fname
            #echo $ofile

            python -m pushtotalk -i $mfile -o $oifile

            sox $oifile -r 44100 $olfile
            sox $oifile -r 44100 $orfile
            sox -M $olfile $orfile $ofile

            #cat $f
            rm $file
            rm $mfile
            rm $oifile
            rm $olfile
            rm $orfile
        done
    fi
done
