Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: nospam02@van-schelve.de
Message-Id: <200212111244.gBBCihC22523@s01.canserver.net>
To: "BlueZ Users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Bluetooth Init Script with automatic Handy detection.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 Dec 2002 13:44:43 +0100
Content-Type: text/plain; CHARSET=iso-8859-1

Hello together.

Maybe someone of you are interested in my solution about how to make
a gprs connection over a bluetooth connection to a mobile phone.
Round about 10000 Users in our company are working with it and
allthough they are using bluez so Thanx to all developers for their
well done work.

If any suggestions or questions, you can sent me a mail.

-------------------------------------------------------------
#!/bin/bash
#/etc/init.d/connectBT
#set -x
#####################################################################
###########
# Script : connectBT
# Purpose: makes a Bluetooth connection between Laptop and Handy for
use of GPRS
# Autor  : Hans-Gerd van Schelve
# Date	 : 2002-11-13
# Version: 2.0
#####################################################################
###########
#Globale Section						    =20
	 #
#--------------------------------------------------------------------
----------#
RFCOMMSTATUS=3D0
PAIRING=3D0
SYSLOG=3D/var/log/sys.log
CONFOK=3D1
EINGABEOK=3D1
CONFFILE=3D"/etc/bluetooth/handy.conf"
LINKKEY=3D"/etc/bluetooth/link_key"
INQTEMPFILE=3D"/tmp/handyinquiery.tmp"
source /etc/LVM.conf		# Globale config File
source /etc/init.d/functions	# Neccessary functions like echol a.
s. o.
timestamp $BOOTLOG
#--------------------------------------------------------------------
----------#
# Only start if it is an T30 and we are mobile....
#--------------------------------------------------------------------
----------#
if [ "$BLUETOOTH_START" !=3D "yes" ]; then
  echol -n "No need to use bluetooth"
  true ; evaluate_retval
  exit 0
else
   if $(tpblth status | grep "Bluetooth daugher card not found" >&
/dev/null); then
      echol -n "Can not start bluetooth because this is not a
bluetooth system"
      true ; evaluate_retval
      exit 0
   fi
fi

#--------------------------------------------------------------------
----------#
# used functions						    =20
	 #
#--------------------------------------------------------------------
----------#
function func_bluetooth_init() {
   if (tpblth status | grep "Power status =3D Off" >& /dev/null ) ;
then
      tpblth power-on >& /dev/null
      sleep 5
      insmod ussp >& /dev/null
      hcid >& /dev/null
      sleep 2
   fi
}

function func_stop() {
   for i in pppd rfcomm hcid; do
      while (ps aux | grep $i | grep -v grep | grep -v killall) >&
/dev/null; do
	 killall $i >& /dev/null
	 sleep 1
      done
   done
   rmmod ussp >& /dev/null
   tpblth power-off >& /dev/null
   sleep 5
   for i in ppp_async ppp_generic slhc l2cap hci_usb bluez; do
      while (lsmod | grep $i) >& /dev/null; do
	  rmmod $i
      done
   done
   sleep 2
   echol -n "Disconnected from LVM" $BOOTLOG
}

function func_rfcomm_connect() {
   rfcomm 0 $CONFHANDYID >& /dev/null &
   sleep 3
   if ! [ $PAIRING =3D 0 ]; then
      PID=3D""
      PID=3D`/bin/pidof -s hcid`
      echo ""
      echo "Sie haben eine neue Handykonfiguration erzeugt. Dies
setzt"
      echo "vorraus, dass Sie am Mobiltelefon die Pairing Pin
eingeben."
      while [ ! "$SAVING_OK" -a ! "REPLACING_OK" ]; do
	 SAVING_OK=3D`grep $PID $SYSLOG | grep "Saving link key"`
	 REPLACING_OK=3D`grep $PID $SYSLOG | grep "Replacing link key"`
	 sleep 1
      done
      if [ "$CONFHANDYTYPE" =3D "Nokia" ]; then
	 echo ""
	 echo
"--------------------------------------------------------------------
"
	 echo "Stellen Sie nun sicher, dass Sie diesen Laptop in die
Liste der "
	 echo "bekannten Ger=E4te an Ihrem Handy aufgenommen haben.
Dr=FCcken Sie  "
	 echo "Return, sobald dies der Fall ist...		    =20
	 "
	 echo
"--------------------------------------------------------------------
"
	 read FILLER
      fi
      echo ""
      echo
"--------------------------------------------------------------------
"
      echo " Die Bluetooth Verbindung wird nun neu aufgebaut. Bitte
haben Sie"
      echo " noch einen Moment Geduld."
      echo
"--------------------------------------------------------------------
"
      echo ""
      func_stop
      func_bluetooth_init
      rfcomm 0 $CONFHANDYID >& /dev/null &
      sleep 10
   fi
   echo ATZ 2>/dev/null >/dev/ttu/0
   RFCOMMSTATUS=3D$?
   if [ $RFCOMMSTATUS !=3D 0 ]; then
      killall rfcomm >& /dev/null
      echo -n "."
   fi
}

function func_write_conffile() {
   if (printf
"CONFHANDYID=3D$CONFHANDYID\nCONFHANDYTYPE=3D$CONFHANDYTYPE\n" \
      > $CONFFILE 2>/dev/null); then
      echol "Die Konfigurationsdatei wurde erfolgreich aktualisiert."
      chmod 600 $CONFFILE
   else
      echol "Probleme bei der Erzeugung der Konfigurationsdatei: [ $?
]"
      exit 1
   fi
}

function func_update_conffile() {
   if [ "$CONFHANDYTYPE" =3D "" ]; then
      CONFHANDYID=3D$(cat $CONFFILE)
      CONFHANDYTYPE=3D"Nokia"
      func_write_conffile
   fi
}

function func_search_handies() {
   ### User cannot change the class ID but Phone name so use
   ### Class ID to identify Phone Vendor......=20
   CONFHANDYID=3D""
   while [ "$CONFHANDYID" =3D "" ]; do
      sleep 2
      hcitool inq 10 | grep -v Inq | \
	  egrep '0x500204|0x520204|0x502204|0x522204|0x720204' | \
	  sed -e 's/0x500204/Nokia/' \
	  -e 's/0x520204/Nokia/' \
	  -e 's/0x502204/Nokia/' \
	  -e 's/0x522204/Sony-Ericsson/' \
	  -e 's/0x720204/Siemens-S55/' | \
	  awk '{print $1 " " $6}' \
	  > $INQTEMPFILE
     =20
      BTMACARRAY=3D($(cat $INQTEMPFILE | awk '{print $1}'))
      BTCLASSARRAY=3D($(cat $INQTEMPFILE | awk '{print $2}'))
      RECORDS=3D$(wc -l $INQTEMPFILE | awk {'print $1'})
     =20
      if [ $RECORDS -eq 0 ]; then
	 echo ""
	 echo
"--------------------------------------------------------------------
"
	 echo "Es konnte kein bluetoothf=E4higes Mobiltelefon gefunden
werden."
	 echo "Bitte vergewissern Sie Sich, dass Ihr Mobiltelefon
aktiv ist,"
	 echo "Bluetooth eingeschaltet ist und sich das Telefon in
Reichweite"
	 read -p "befindet. Bitte dr=FCcken Sie zur Best=E4tigung
Return." EINGABE
	 echo
"--------------------------------------------------------------------
"
	 case $EINGABE in
	    "backdoor")
		 exit 0
	    ;;
	     =20
	    "*")
		 echol "Erneute Suche nach Ger=E4ten wird durchgef=FChrt"
	    ;;
	     =20
	 esac
	=20
      elif [ $RECORDS -eq 1 ]; then
	 CONFHANDYID=3D${BTMACARRAY[0]}
	 CONFHANDYTYPE=3D${BTCLASSARRAY[0]}
	 echo "Das folgende Ger=E4t wurde erkannt und wird verwendet:"
	 echo " ---->	$CONFHANDYID --- $CONFHANDYTYPE   <----"
	 func_write_conffile
	=20
      elif [ $RECORDS -gt 1 ]; then
	 PS3=3D"Bitte w=E4hlen Sie Ihr Handy aus der Liste aus: "
	 declare -i REPLY     =20
	 echo
"--------------------------------------------------------------------
"
	 echo "Liste der erkannten Mobiltelefone...		    =20
	 "
	 echo
"--------------------------------------------------------------------
"
	 select HANDY in `sed $INQTEMPFILE -e 's/ /@/'`; do
	    if [ $REPLY -gt $RECORDS -o $REPLY =3D 0 ]; then
	       clear
	    else
	       INDEX=3D$(($REPLY - 1))
	       CONFHANDYID=3D${BTMACARRAY[$INDEX]}
	       CONFHANDYTYPE=3D${BTCLASSARRAY[$INDEX]}
	       func_write_conffile
	       break
	    fi
	 done
      fi
   done
   PAIRING=3D1  =20
}

function func_gprs_connect() {

### Create the secrete files under /etc/ppp/

   if test -e /etc/ppp/chap-secrets; then
      rm /etc/ppp/chap-secrets
   fi
   echo "$USER	    *	    $PASS" > /etc/ppp/chap-secrets
   chmod 600 /etc/ppp/chap-secrets

   if test -e /etc/ppp/pap-secrets; then
      rm /etc/ppp/pap-secrets
   fi
   echo "$USER	    *	    $PASS" > /etc/ppp/pap-secrets
   chmod 600 /etc/ppp/pap-secrets

### These are the possible Dial Strings...

   case "$CONFHANDYTYPE" in
      "Nokia")
	 /usr/sbin/pppd /dev/ttu/0 57600 mru 2000 connect 'chat -v ""
ATZ OK AT+CGDCONT=3D1,\"IP\",\"$APN\" OK "ATD *99#" CONNECT'\
	 noauth -chap defaultroute noipdefault persist
ipcp-accept-local noccp novj nobsdcomp nodeflate name $USER debug
      ;;
	=09
      "Siemens-S55")
	 /usr/sbin/pppd /dev/ttu/0 57600 mru 2000 connect 'chat -v ""
ATZ OK AT+CGDCONT=3D1,\"IP\",\"$APN\" OK "ATD *98*1#" CONNECT'\
	 noauth -pap defaultroute noipdefault persist
ipcp-accept-local noccp novj nobsdcomp nodeflate name $USER debug
      ;;
	=09
      "Sony-Ericsson")
	 /usr/sbin/pppd /dev/ttu/0 57600 mru 2000 connect 'chat -v ""
ATZ OK AT+CGDCONT=3D1,\"IP\",\"$APN\" OK "ATD *99#" CONNECT'\
	 noauth -chap defaultroute noipdefault persist
ipcp-accept-local noccp novj nobsdcomp nodeflate name $USER debug
      ;;

   esac

   CONN_ON=3D""
   PID=3D
   PID=3D`/bin/pidof -s pppd`
   sleep 3
   while [ ! "$CONN_OK" ]; do
      sleep 1
      CONN_FAILED=3D`grep $PID $SYSLOG | grep "Connection terminated"`
      CONN_OK=3D`grep $PID $SYSLOG | grep "local	IP"`
      if [ "$CONN_OK" ]; then
	 IP_ADDR=3D`echo $CONN_OK | awk -F"address " '{print $2}'`
	 echol $IP_ADDR
	 echol "" $BOOTLOG
	 echol -n "Connection established (local IP: '$IP_ADDR') "
$BOOTLOG
	 true; evaluate_retval $BOOTLOG
	 echol -n "Setting new hostname" $BOOTLOG
	 HOSTNAME=3D$(host $IP_ADDR | awk '{ print $5 }'|cut -d"." -f1)
	 ### If there is no valid dns-record for recived IP Address
in DNS set HOSTNAME to current IP Address ###
	 if [ "$HOSTNAME" =3D "3(NXDOMAIN)" ]; then
	    /bin/hostname $IP_ADDR
	 else
	    /bin/hostname $HOSTNAME
	 fi
      fi
   done
}

#####################################################################
#########
#  Here we go.....						    =20
       #
#####################################################################
#########

case $1 in
   "start")
      func_bluetooth_init
      if [ -e $CONFFILE -a -r $CONFFILE ]; then
	 if $(grep CONFHANDYTYPE $CONFFILE >& /dev/null); then
	    source $CONFFILE
	 else
	    func_update_conffile
	 fi
      else
	 sleep 2
	 func_search_handies
      fi=20
      func_rfcomm_connect
      while [ $RFCOMMSTATUS !=3D 0 ]; do
	 func_rfcomm_connect
	 if ! [ $RFCOMMSTATUS =3D 0 ]; then
	    echo " "
	    echo
"--------------------------------------------------------------------
"
	    echo "Eine Verbindung zu Ihrem $CONFHANDYTYPE Handy (
$CONFHANDYID )"
	    echo "konnte nicht hergestellt werden. =DCberpr=FCfen Sie
bitte, ob das Ger=E4t"
	    echo "eingeschaltet ist und sich in Reichweite befindet."

	    echo "Dr=FCcken Sie zur Best=E4tigung bitte Return!"
	    echo
"--------------------------------------------------------------------
"
	    trap "" 1 2 3 5 6 7 15
	       EINGABE=3D0
	       read EINGABE
	    trap - 1 2 3 5 6 7 15
	    case $EINGABE in
	       "pairing")
		  func_search_handies
	       ;;
	       "backdoor")=20
		  exit 0
	       ;;
	    esac
	 fi
	 done
	 func_gprs_connect
   ;;
  =20
   "stop")
      func_stop
      evaluate_retval
   ;;

   *)
      echo "Usage: $0 {start|stop}"
   ;;
  =20
esac


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility=20
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
