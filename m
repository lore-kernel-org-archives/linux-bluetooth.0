Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 15 Aug 2006 16:29:52 -0500
From: digitalfredy <digitalfredy@debiancolombia.org>
In-reply-to: <44E1187E.6030401@mackintoshweb.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1155677394.9855.21.camel@YODA>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_siju4SH9UM73c9XojfVHyg)"
References: <44E1187E.6030401@mackintoshweb.com>
Subject: Re: [Bluez-users] Totally confused
Reply-To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--Boundary_(ID_siju4SH9UM73c9XojfVHyg)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

Hello, i have a moto l6 and i write script (can be usable with other
phones, is tested in moto l6 and sonyericsson t610) for download al the
photos or all the videos with a single comand, it isn't totaly finish
but in this moment you can use for mv or cp your photos or your videos
to the pc.

# cp getmovil /usr/local/bin
# chmod 755 /usr/local/bin/getmovil

$ cp .getmovil ~        //you need modfy for use your home folder
$ getmovil -p -m        // it get all the photos

in moto l6 photos and videos use notation DD-MM-YY_HHMM
getmovil fist parameter: -p|-i|-r|-v|-s|-t // -p is photos, -v is videos

For can recive files seding from the phone you can use obexserver if you
are using debian apt-get install obexserver, remember read the man
before use obexserver comand.

El lun, 14-08-2006 a las 20:42 -0400, Terry Mackintosh escribió:
> Hi
> 
> 
> There are so many pieces to the puzzle: hci* sdp* rfcomm others?
> 
> What comes first? second? ...?
> 
> I just want to get pictures off my Motorola V710 picture phone.
> Has anyone done this?
> 
> What programs do I run in what order and what config/password files need 
> to be messed with?
> 
> I have read man pages and some of the howtos and such, that are totally 
> confusing.  Do I really need to know about stacks and protocols and the 
> inner workings of all the different programs?  Is there no single doc or 
> howto that puts it all together in simple to the point terms?
> 
> I am computer literate, especially on Linux, but bluetooth is causing me 
> no end of frustration.
> 
> Thanks
> 

--Boundary_(ID_siju4SH9UM73c9XojfVHyg)
Content-type: application/x-shellscript; name=getmovil
Content-transfer-encoding: 7bit
Content-disposition: attachment; filename=getmovil

#!/bin/bash

###############################################################
## ATENCION este script puede presentar problemas debido
## a la codificacion de caracteres -ojo con las tildes-
###############################################################

PHONEMAC=$(cat $HOME/.getmovil.conf | grep phonemac | awk '{print $2}')
case "$1" in
    -p)
    REGEXP=$(cat $HOME/.getmovil.conf | grep phtregexp | awk '{print $2}')
    PHONEDIR=$(cat $HOME/.getmovil.conf | grep phonephtdir | awk '{print $2}')
    OBJETSDIR=$(cat $HOME/.getmovil.conf | grep pcphtdir | awk '{print $2}')/$(date +%Y)
    ;;
    -i)
    REGEXP=$(cat $HOME/.getmovil.conf | grep imgregexp | awk '{print $2}')
    PHONEDIR=$(cat $HOME/.getmovil.conf | grep phoneimgdir | awk '{print $2}')
    OBJETSDIR=$(cat $HOME/.getmovil.conf | grep pcimgdir | awk '{print $2}')/$(date +%Y)
    ;;
    -r)
    REGEXP=$(cat $HOME/.getmovil.conf | grep recregexp | awk '{print $2}')
    PHONEDIR=$(cat $HOME/.getmovil.conf | grep phonesnddir | awk '{print $2}')
    OBJETSDIR=$(cat $HOME/.getmovil.conf | grep pcrecdir | awk '{print $2}')/$(date +%Y)
    ;;
    -v)
    REGEXP=$(cat $HOME/.getmovil.conf | grep vidregexp | awk '{print $2}')
    PHONEDIR=$(cat $HOME/.getmovil.conf | grep phoneviddir | awk '{print $2}')
    OBJETSDIR=$(cat $HOME/.getmovil.conf | grep pcviddir | awk '{print $2}')/$(date +%Y)
    ;;
    -s)
    REGEXP=$(cat $HOME/.getmovil.conf | grep sndregexp | awk '{print $2}')
    PHONEDIR=$(cat $HOME/.getmovil.conf | grep phonesnddir | awk '{print $2}')
    OBJETSDIR=$(cat $HOME/.getmovil.conf | grep pcsnddir | awk '{print $2}')/$(date +%Y)
    echo -e "\033[1;5mSin implementar\033[0;0m"
    ;;
    -t)
    REGEXP=$(cat $HOME/.getmovil.conf | grep thmregexp | awk '{print $2}')
    PHONEDIR=$(cat $HOME/.getmovil.conf | grep phonethmdir | awk '{print $2}')
    OBJETSDIR=$(cat $HOME/.getmovil.conf | grep pcsnddir | awk '{print $2}')/$(date +%Y)
    echo -e "\033[1;5mSin implementar\033[0;0m"
    ;;
    *)
    echo -e "\033[1;5mPrimer parametro: [-p|-i|-r|-v|-s|-t]\033[0;0m"
    ;;
esac

#Funcion para obtener la lista con los nombres de los objetos (fotos, sonidos ...)
function get_list 
{
LISTA=$(obexftp -b $PHONEMAC  -l $PHONEDIR | grep file\ name | cut -d\" -f2 | grep "$REGEXP")
}

#Funcion para descargar objetos (fotos, sonidos ...) al pc eliminandolos del telefono
function mv_objets
{
cd $OBJETSDIR
for i in $(echo $LISTA);do
obexftp -b $PHONEMAC  -c $PHONEDIR -G $i
#mv $i $(date +%B_%d)_$i && chmod 440 $(date +%B_%d)_$i
done
}

#Funcion para descargar objetos (fotos, sonidos ...) al pc sin eliminarlos del telefono
function cp_objets
{
cd $OBJETSDIR
for i in $(echo $LISTA);do
obexftp -b $PHONEMAC  -c $PHONEDIR -g $i
#mv $i $(date +%B_%d)_$i && chmod 440 $(date +%B_%d)_$i
done
}

#Funcion para revisar existencia de directorios, si no existen los crea
function test_dir
{
test -d $OBJETSDIR
if [ $? -eq 1 ]
    then mkdir -p $OBJETSDIR
fi
}

case "$2" in
    -m)
    test_dir
    get_list
    mv_objets
    ;;
    -c)
    test_dir
    get_list
    cp_objets
    ;;
    -l)
    get_list
    echo $LISTA
    ;;
    *)
    echo -e "\033[1;5mSegundo parametro: [-m|-c|-l]\033[0;0m"
    ;;
esac

--Boundary_(ID_siju4SH9UM73c9XojfVHyg)
Content-type: text/plain; name=.getmovil.conf; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=.getmovil.conf

phonemac 00:17:00:F4:E6:D7

#patron en el nombre, soporta expresiones regulares de grep (no entrecomillar)
phtregexp [0-3][0-9]-[0-1][0-9]-[0-9][0-9]_[0-2][0-9][0-6][0-9]
imgregexp [^([0-3][0-9]-[0-1][0-9]-[0-9][0-9]_[0-2][0-9][0-6][0-9])]
recregexp 
vidregexp [0-3][0-9]-[0-1][0-9]-[0-9][0-9]_[0-2][0-9][0-6][0-9]
sndregexp 
thmregexp

#carpetas en el telefono
phonephtdir picture
phoneimgdir picture
phonerecdir 
phoneviddir video
phonesnddir
phonethmdir

#carpetas en el computador
pcphtdir /home/digitalfredy/avi-local/img/fotos/fotos_telefono
pcimgdir /home/digitalfredy/avi-local/img/imagenes_telefono
pcrecdir 
pcviddir /home/digitalfredy/avi-local/video/videos_telefono
pcsnddir 
pcthmdir

--Boundary_(ID_siju4SH9UM73c9XojfVHyg)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary_(ID_siju4SH9UM73c9XojfVHyg)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary_(ID_siju4SH9UM73c9XojfVHyg)--
