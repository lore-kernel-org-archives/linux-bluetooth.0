Return-Path: <cyrus@holtmann.org>
Subject: help needed harvesting photos from nokia phone
From: acousmetre <acousmetre@gmail.com>
Reply-To: acousmetre@gmail.com
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Jun 2011 10:11:59 -0300
Message-ID: <1309266719.3003.29.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list,

I recently volunteered to help a group of actors in a performance. They
wish to use a mobile phone to take photos during a performance and have
these snaps automatically projected. A laptop with bluetooth and a
projector will be placed on the stage - where they can place the mobile
between shots in order to make the file transfer - they will move in and
out of range of the laptop. 

I thought this should be easy to do and patched together a script to
fetch and display the most recent photo taken. I'm not much of a
programmer however. With a pre-coupled phone and laptop, the script
works some of the time - other times it gets stuck - and I have to
physically remove and replace to bluetooth dongle to get it running
again (this works again, only sometimes!). I'll paste my script below -
can anyone suggest what I might be doing wrong - or a better way? At
present the script is too unreliable to use.

Here it is - cheers, Iain :

#!/bin/sh
folder='Images' #Nokia folder
name='/home/iain/projetos/chuvadesangue/fotos'
address='00:26:69:4D:D1:7C'
cd $name
touch ./preto.jpg
killall geeqie
/usr/bin/geeqie -f -t preto.jpg&

while : ; do
obexftp -b $address -l $folder > /tmp/list_files
trap "rm -f /tmp/list_files; exit 1" INT
cat /tmp/list_files | grep -o "file name="*.*"\ s" | sed 's/name="//' |
sed 's/file//' | sed 's/" s//' > /tmp/list_files2
if [ -s /tmp/list_files2 ] ; then
    sleep 2
    obexftp -b $address  -c $folder -G `cat /tmp/list_files2`
    lastimage=$(ls -c|head -n1)
#     echo "If there was a photo taken since the last loop, show it"
    /usr/bin/geeqie -r file: $lastimage
fi ;        
        sleep 3
done
  rm -f /tmp/list_files
  rm -f /tmp/list_files2
  echo "Done"





