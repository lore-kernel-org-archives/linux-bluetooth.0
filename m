Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kOSgA1p6ozvEzOW"
Message-Id: <200404171431.32008.cijoml@volny.cz>
Subject: [Bluez-users] init script 0.1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 17 Apr 2004 14:31:32 +0200


--Boundary-00=_kOSgA1p6ozvEzOW
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

sending you first version of bluetooth init script and bluetooth default 
script.

PLS check it out and tell me your comments.

PAND like master is now started using following switches:
pand -s -M -r NAP
which I think are most common used.

This version needs implement DUNDmaster,DUNDclient, PANDclient

tell me how would you like these to implement

Michal

--Boundary-00=_kOSgA1p6ozvEzOW
Content-Type: application/x-shellscript;
  name="bluetooth"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth"

#! /bin/sh
#
# bluetooth	Bluetooth subsystem starting and stopping
#

NAME=bluetooth
DESC="Bluetooth subsystem"
PATH=/sbin:/bin:/usr/sbin:/usr/bin
DEFAULT=/etc/default/bluetooth
HCID=/usr/sbin/hcid
HCID_CONF=/etc/bluetooth/hcid.conf
HCIATTACH=/usr/sbin/hciattach
UART_CONF=/etc/bluetooth/uart
SDPD=/usr/sbin/sdpd
HIDD=/opt/bluetooth/sbin/bthid
PAND=/usr/bin/pand
DUND=/usr/bin/dund
RFCOMM=/usr/bin/rfcomm
RFCOMM_CONF=/etc/bluetooth/rfcomm.conf

set -e

if [ ! -f "$DEFAULT" ] ; then
	echo "Configuration script "$DEFAULT" does not exist"
	exit 0
fi

start_uarts() 
{
	[ -x "$HCIATTACH" -a -f "$UART_CONF" ] || return
	grep -v '^#' "$UART_CONF" | while read i; do
		"$HCIATTACH" "$i"
	done
}

stop_uarts()
{
	killall "$HCIATTACH" > /dev/null 2>&1 || true
}

case "$1" in
  start)
	echo -n "Starting $DESC:"

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^HCID' |awk {'print $3'}` = true ] ; then 
		if [ -x "$HCID" -a -f "$HCID_CONF" ] ; then
			"$HCID" -f "$HCID_CONF"
			echo -n " hcid"
		fi
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^SDPD' |awk {'print $3'}` = true ] ; then
		if [ -x "$SDPD" ] ; then
			"$SDPD"
			echo -n " sdpd"
		fi
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^HIDD' |awk {'print $3'}` = true ] ; then
        	if [ -x "$HIDD" ] ; then
			"$HIDD" -d
			echo -n " hidd"
		fi
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^RFCOMM' |awk {'print $3'}` = true ] ; then
		if [ -x "$RFCOMM" -a -f "$RFCOMM_CONF" ] ; then
			"$RFCOMM" -f "$RFCOMM_CONF" bind all
			echo -n " rfcomm"
		fi
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^PAND' |awk {'print $3'}` = true ] ; then
		"$PAND" -s -M -r NAP
		echo -n " pand"
		
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^CLIENT_PAND' |awk {'print $3'}` = true ] ; then
		echo -n " pand_client"
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^DUND' |awk {'print $3'}` = true ] ; then
		echo -n " dund"
	fi

	if [ `cat "$DEFAULT" |grep -v '^#' |grep '^CLIENT_DUND' |awk {'print $3'}` = true ] ; then
		echo -n " dund_client"
	fi

	echo "."
	start_uarts || true
	;;
  stop)
	echo -n "Stopping $DESC:"
	
	if [ -x "$RFCOMM" ] ; then
		echo -n " rfcomm"
		"$RFCOMM" release all
	fi
	
	echo -n " sdpd"
	killall "$SDPD" > /dev/null 2>&1 || true
	
	echo -n " hcid"
	killall "$HCID" > /dev/null 2>&1 || true
	
	echo -n " hidd"
	killall "$HIDD" > /dev/null 2>&1 || true

	echo -n " pand"
	killall "$PAND" > /dev/null 2>&1 || true

	echo -n " dund"
	killall "$DUND" > /dev/null 2>&1 || true
	
	echo "."

	stop_uarts
	;;
  restart|force-reload)
	echo "Restarting $DESC:"
	$0 stop
	sleep 5 #hidd needs longer time to finish
	$0 start
	echo "."
	;;
  *)
	N=/etc/init.d/bluetooth
	echo "Usage: "$N" {start|stop|restart|force-reload}" >&2
	exit 1
	;;
esac

exit 0

--Boundary-00=_kOSgA1p6ozvEzOW
Content-Type: text/plain;
  charset="iso-8859-2";
  name="bluetooth"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth"

#!!!!!!!!!!!!!!!!!!!
#there MUST BE spaces around equal sign
#!!!!!!!!!!!!!!!!!!!
#
#
#
#if you wand start hcid select true
HCID = true 
#if you wand start sdpd select true
SDPD = true
#if you wand start rfcomm tty support select true
RFCOMM = true 
#if you wand start hidd select true
HIDD = true
#if you wand start pand like server select true
PAND = false
#if you wand start pand like client select true
CLIENT_PAND = false
#if you wand start dund like server select true
DUND = false
#if you wand start dund like client select true
CLIENT_DUND = false


--Boundary-00=_kOSgA1p6ozvEzOW--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
