Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 13 Aug 2006 00:56:48 -0500
From: digitalfredy <digitalfredy@debiancolombia.org>
In-reply-to: <20060810160526.GC16806@refinery.twat.com.ar>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1155448610.22835.4.camel@YODA>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)"
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<20060810160526.GC16806@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
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


--Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

El jue, 10-08-2006 a las 13:05 -0300, redondos escribió:
> It's pointless, no matter how many different configurations I try, I        
> just can't upload anything to the phone. Am I doing something wrong? Is     
> it supposed to be possible to upload, say, a theme using obexft -b          
> <device> -B <channel> -c Themes -p <theme-name>?                            
> 
> The dump always shows a piece of the file (hex dump) and then:
> < ACL data: handle 1 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2
> > HCI Event: Disconn Complete (0x05) plen 4                                 
>     status 0x00 handle 1 reason 0x08
>     Reason: Connection Timeout
> 
> Fredy: Can I see your scripts for doing such things, please?
the *.conf file is for put in the home desktop, changue Foto in it for
the name to put the phone
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________ Bluez-users mailing list Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)
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

--Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)
Content-type: text/plain; NAME=.getmovil.conf; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: attachment; filename=.getmovil.conf
Content-description: 

phonemac 00:0A:D9:78:ED:5E

#patron en el nombre, soporta expresiones regulares de grep (no entrecomillar)
phtregexp Foto
recregexp .amr
imgregexp ^[^Foto]

#carpetas en el telefono
phonephtdir Imágenes
phonesnddir Sonidos
phoneimgdir Imágenes

#carpetas en el computador
pcphtdir /home/digitalfredy/avi-local/img/t610/fotos
pcimgdir /home/digitalfredy/avi-local/img/t610/imagenes
pcrecdir /home/digitalfredy/avi-local/audio/t610/grabaciones

--Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary_(ID_Q28qtQRg408YD5/MFIfu+Q)--
