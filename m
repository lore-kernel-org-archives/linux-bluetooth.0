Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45B4D221.4090303@illokken.net>
Date: Mon, 22 Jan 2007 16:02:57 +0100
From: =?ISO-8859-1?Q?H=E5var_Nielsen?= <havar@illokken.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------010801010209030806010700"
Subject: [Bluez-users] Bluetooth mouse on openSUSE 10.2 needs rootpassword
	on every reconnect
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------010801010209030806010700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear all,

I need some help with my bluetooth mouse.

I just went from ubuntu to openSuSE on my laptop. Everything except for
the bluetooth mouse is working.

I have tried a lot of approaches really, but none seem to work. No
matter what I do, I have to use the command sudo hidd --connect ... to
make my mouse connect to the computer or vice versa (computer to mouse)
every time I want to use the mouse. - That means I also have to type the
root password each time I want to use the mouse.

On ubuntu this was really as simple as adding a line with 'hidd
- --server' in /etc/rc.local. Then after I had connected my mouse with the
hidd --connect command once, it always reconnected by itself, even after
restarts and such.

This approach doesn't seem to work in openSuSE however, even when using
the ubuntu (default) /etc/bluetooth/hcid.conf file. Why is that?

In SuSE, I must go to a terminal, become root and do:
hidd --server
hidd --connect 00:07:61:4a:1b:ef
(press reset button on the mouse) -result-> Mouse connects and works.
Now, if I turn my mouse off for five seconds and turn it back on again,
I have to type another hidd --connect command as root for the mouse to
reconnect.

I have attached the SuSE bluetooth init script and the bluetooth.conf
file used by the bluetooth init script in hopes it can be of use to
anyone who might answer this request.

Some more technical details is found below my signature.

With hopes of help...

Regards,
Håvar Nielsen

Installed bluez & bluetooth packages:
bluez-firmware 1.2-20
bluez-gnome 0.6-7
bluez-hcidump 1.33-8
bluez-libs 3.7-14.1
bluez-test 3.7-29
bluez-utils 3.7-29.2
gnome-bluetooth 0.8.0-26
yast2-bluetooth 2.14.0-33

/etc/init.d/bluetooth status
Checking service bluetooth (enabled) :
      hcid  (activated)      running
      hidd  (activated)      running
   hid2hci  (activated)
      sdpd  (activated)      running
       opd                   unused
    rfcomm  (activated)
      pand                   unused
      dund                   unused

hcitool dev
	Devices:
        	hci0    00:10:C6:9E:0A:D7
hcitool inq
	Inquiring ...

All init-parameters for these profiles can be found in the attached
bluetooth.conf file.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFtNIhurImHjOFF6oRAlpKAJ4iTVYRDheNU3MqGIRfiNXqMksrAwCcDBn5
TAw0jDaWK1e1pZX21rWS4hc=
=HTlD
-----END PGP SIGNATURE-----

--------------010801010209030806010700
Content-Type: text/plain;
 name="bluetooth"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluetooth"

#! /bin/sh
# Copyright (c) 1995-2003 SuSE Linux AG, Nuernberg, Germany.
# All rights reserved.
#
# Author: Stefan Behlert <feedback@suse.de>, based on
#         proposals and templates from Marcel Holtmann
#         and Stefan Reinauer <feedback@suse.de>
#
# /etc/init.d/bluetooth
#   and its symbolic link
# /(usr/)sbin/rcbluetooth
#
### BEGIN INIT INFO
# Provides:          bluetooth
# Required-Start:    $syslog
# X-UnitedLinux-Should-Start: dbus
# Required-Stop:     $syslog
# X-UnitedLinux-Should-Stop:
# Default-Start:     3 5
# Default-Stop:      0 1 2 6
# Short-Description: Bluetooth protocol stack services
# Description:       Bluetooth protocol stack services
#	This services is needed to use bluetooth devices
### END INIT INFO
# 

# Check for existence of needed config file and read it
BLUETOOTH_CONFIG=/etc/sysconfig/bluetooth
test -r $BLUETOOTH_CONFIG || exit 6
. $BLUETOOTH_CONFIG

. /etc/rc.status

# Reset status of this service
rc_reset
	 
#	check_service "hcid" "$HCI_START" "$HCI_DAEMON"
function check_service()
{
	if [ "$2" = "yes" ]; then
		printf "%10s  (%s)" "$1" "activated"
		/sbin/checkproc $3 || rc_failed 7
		rc_status -v
	else
		printf "%10s" "$1"
		/sbin/checkproc $3 || rc_failed 3
		rc_status -v
	fi
}

# we use '/var/lib/bluetooth/opd' as default-path for the opd. we make sure, the dir
# exists and we don't want to have the dir growing and growing
function check_opd_default_path()
{
	if [ ! -e /var/lib/bluetooth/opd ] && [ ! -d /var/lib/bluetooth/opd ]; then
		return
	fi
	# I don't like -exec
	# remove all files older than 3 days
	find /var/lib/bluetooth/opd/ -type f -a -mtime +3 |xargs -I{} /bin/rm {};
}


case "$1" in
    start)
	echo -n "Starting bluetooth: "

	# not generic, because that was to much overhead
	if [ $HID_START = "yes" ] && [ -x "$HID_DAEMON" ] ; then
		#/sbin/checkproc $HID_DAEMON || $HID_DAEMON $HID_DAEMON_ARGS
		$HID_DAEMON $HID_DAEMON_ARGS
		echo -n " hidd"
	fi
	if [ $HID2HCI_START = "yes" ] && [ -x "$HID2HCI_DAEMON" ] ; then
		$HID2HCI_DAEMON $HID2HCI_DAEMON_ARGS > /dev/null 2>&1
		echo -n " hid2hci"
	fi
	if [ $HCI_START = "yes" ] && [ -x "$HCI_DAEMON" ] ; then
		/sbin/checkproc $HCI_DAEMON || $HCI_DAEMON  $HCI_DAEMON_ARGS
		echo -n " hcid"
	fi
	if [ $SDP_START = "yes" ] && [ -x "$SDP_DAEMON" ] ; then
		/sbin/checkproc $SDP_DAEMON || $SDP_DAEMON $SDP_DAEMON_ARGS
		echo -n " sdpd"
	fi
	if [ $OPD_START = "yes" ] && [ -x "$OPD_DAEMON" ] ; then
		check_opd_default_path
		/sbin/checkproc $OPD_DAEMON || $OPD_DAEMON $OPD_DAEMON_ARGS
		echo -n " opd"
	fi
	if [ $RFCOMM_START = "yes" ] && [ -x "$RFCOMM_DAEMON" ] ; then
		$RFCOMM_DAEMON $RFCOMM_DAEMON_ARGS
		echo -n " rfcomm"
	fi
	if [ $PAND_START = "yes" ] && [ -x "$PAND_DAEMON" ] ; then
		/sbin/checkproc $PAND_DAEMON || $PAND_DAEMON $PAND_DAEMON_ARGS
		echo -n " pand"
	fi
	if [ $DUND_START = "yes" ] && [ -x "$DUND_DAEMON" ] ; then
		/sbin/checkproc $DUND_DAEMON || $DUND_DAEMON $DUND_DAEMON_ARGS
		echo -n " dund"
	fi

	rc_status -v
	;;
    stop)
	echo -n "Shutting down bluetooth ("

	if [ -x $DUND_DAEMON ]; then
		/sbin/killproc -TERM $DUND_DAEMON && echo -n " dund"
	fi
	if [ -x $PAND_DAEMON ]; then
		/sbin/killproc -TERM $PAND_DAEMON && echo -n " pand"
	fi
	if [ -x $RFCOMM_DAEMON ]; then
		/sbin/killproc -TERM $RFCOMM_DAEMON && echo -n " rfcomm"
	fi
	if [ -x $OPD_DAEMON ]; then
		/sbin/killproc -TERM $OPD_DAEMON && echo -n " opd"
	fi
	if [ -x $HID2HCI_DAEMON ]; then
		/sbin/killproc -TERM $HID2HCI_DAEMON && echo -n " hid2hci"
	fi
	if [ -x $HID_DAEMON ]; then
		/sbin/killproc -TERM $HID_DAEMON && echo -n " hidd"
	fi
	if [ -x $SDP_DAEMON ]; then
		/sbin/killproc -TERM $SDP_DAEMON && echo -n " sdp"
	fi
	if [ -x $HCI_DAEMON ]; then
		/sbin/killproc -TERM $HCI_DAEMON && echo -n " hcid"
	fi
	echo -n ")"
	rc_status -v
	;;
    try-restart)
	$0 status >/dev/null &&  $0 restart
	rc_status
	;;
    restart)
	$0 stop
	$0 start
	rc_status
	;;
    force-reload)
	echo -n "Reload service BLUETOOTH "
	$0 stop  &&  $0 start
	rc_status
	;;
    reload)
	rc_failed 3
	rc_status -v
	;;
    status)
	echo -n "Checking service bluetooth "
	if [ $START_SERVICES = 'no' ] ; then
		echo "(disabled) :"
	else
		echo "(enabled) :"
	fi;
	check_service "hcid"	"$HCI_START"	"$HCI_DAEMON"
	check_service "hidd"	"$HID_START"	"$HID_DAEMON"
	check_service "hid2hci"	"$HID2HCI_START"	"$HID2HCI_DAEMON"
	check_service "sdpd"	"$SDP_START"	"$SDP_DAEMON"
	check_service "opd"	"$OPD_START"	"$OPD_DAEMON"
	check_service "rfcomm"	"$RFCOMM_START"	"$RFCOMM_DAEMON"
	check_service "pand"	"$PAND_START"	"$PAND_DAEMON"
	check_service "dund"	"$DUND_START"	"$DUND_DAEMON"
	if [ $START_SERVICES = 'no' ] ; then
		rc_failed 3
	else
		rc_failed 0
	fi;

	;;
    probe)
	## Optional: Probe for the necessity of a reload, print out the
	## argument to this init script which is required for a reload.
	## Note: probe is not (yet) part of LSB (as of 1.2)
	# test /etc/FOO/FOO.conf -nt /var/run/FOO.pid && echo reload
	;;
    *)
	echo "Usage: $0 {start|stop|status|try-restart|restart|force-reload|reload|probe}"
	exit 1
	;;
esac
rc_exit


--------------010801010209030806010700
Content-Type: text/plain;
 name="bluetooth.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluetooth.conf"

############ general 
## Path:        Hardware/Bluetooth
## Description: General settings for the Bluetooth device, if set to 'yes' bluetooth is started when hotplug reports 'added bluetooth device'
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth

START_SERVICES="yes"

## Path:        Hardware/Bluetooth
## Description: General settings for the Bluetooth system, if set to 'yes' bluetooth is stopped when a hotplug records 'removed bluetooth device', no matter if there are still active devices left
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth

ALWAYS_STOP_SERVICES="no"

############ HCID 

## Path:        Hardware/Bluetooth
## Description: Start responsible demon for managing Bluetooth hciX-devices
## Type:        yesno
## Default:     yes
## ServiceRestart: bluetooth
HCI_START="yes"

## Path:        Hardware/Bluetooth
## Description: Set responsible demon for managing Bluetooth hciX-devices
## Type:        list("/usr/sbin/hcid","")
## Default:     "/usr/sbin/hcid"
## ServiceRestart: bluetooth
HCI_DAEMON="/usr/sbin/hcid"

## Path:        Hardware/Bluetooth
## Description: Arguments for hci-demon
## Type:	string("-f /etc/bluetooth/hcid.conf")
## Default:     "-f /etc/bluetooth/hcid.conf"
## ServiceRestart: bluetooth

HCI_DAEMON_ARGS=" -f /etc/bluetooth/hcid.conf"

############ SDP 

## Path:        Hardware/Bluetooth
## Description: Start responsible demon for incoming service queries
## Type:        yesno
## Default:     yes
## ServiceRestart: bluetooth
SDP_START="yes"

## Path:        Hardware/Bluetooth
## Description: Set responsible demon for incoming service queries
## Type:        list("/usr/sbin/sdpd","")
## Default:     "/usr/sbin/sdpd"
## ServiceRestart: bluetooth
SDP_DAEMON="/usr/sbin/sdpd"


## Path:        Hardware/Bluetooth
## Description: Arguments for sdp-demon start
## Type:        list("","-n")
## Default:     ""
## ServiceRestart: bluetooth
SDP_DAEMON_ARGS=""

############ OPD 

## Path:        Hardware/Bluetooth
## Description: Start responsible demon for obex push queries
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth
OPD_START="no"

## Path:        Hardware/Bluetooth
## Description: Set responsible demon for obex push queries
## Type:        list("/usr/bin/opd","")
## Default:     "/usr/bin/opd"
## ServiceRestart: bluetooth
OPD_DAEMON="/usr/bin/opd"


## Path:        Hardware/Bluetooth
## Description: Arguments for opd-demon start
## Type:        list("--mode OBEX --channel 10 --sdp --daemonize --path /var/lib/bluetooth/opd","--sdp")
## Default:     "--mode OBEX --channel 10 --sdp --daemonize --path /var/lib/bluetooth/opd"
## ServiceRestart: bluetooth
OPD_DAEMON_ARGS="--mode OBEX --channel 10 --sdp --daemonize --path /var/lib/bluetooth/opd"


############ RFCOMM

## Path:        Hardware/Bluetooth
## Description: Start responsible service for rfcomm
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth
RFCOMM_START="yes"

## Path:        Hardware/Bluetooth
## Description: Set responsible service for rfcomm
## Type:        list("/usr/bin/rfcomm","")
## Default:     "/usr/bin/rfcomm"
## ServiceRestart: bluetooth
RFCOMM_DAEMON="/usr/bin/rfcomm"

## Path:        Hardware/Bluetooth
## Description: Arguments for rfcomm-service start
## Type:        list("-f /etc/bluetooth/rfcomm.conf bind all","")
## Default:     "-f /etc/bluetooth/rfcomm.conf bind all"
## ServiceRestart: bluetooth
RFCOMM_DAEMON_ARGS="-f /etc/bluetooth/rfcomm.conf bind all"


############ PAND

## Path:        Hardware/Bluetooth
## Description: Start responsible demon for Personal Area Network 
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth
PAND_START="no"

## Path:        Hardware/Bluetooth
## Description: Set responsible demon for Personal Area Network 
## Type:        list("/usr/bin/pand","")
## Default:     "/usr/bin/pand"
## ServiceRestart: bluetooth
PAND_DAEMON="/usr/bin/pand"

## Path:        Hardware/Bluetooth
## Description: Arguments for pan-demon start
## Type:        list("--listen --role NAP")
## Default:     "--listen --role NAP"
## ServiceRestart: bluetooth
PAND_DAEMON_ARGS="--listen --role NAP"


############ DUND

## Path:        Hardware/Bluetooth
## Description: Start responsible demon for LAN Access over PPP
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth
DUND_START="no"

## Path:        Hardware/Bluetooth
## Description: Set responsible demon for LAN Access over PPP
## Type:        list("/usr/bin/dund","")
## Default:     "/usr/bin/dund"
## ServiceRestart: bluetooth
DUND_DAEMON="/usr/bin/dund"

## Path:        Hardware/Bluetooth
## Description: Arguments for dun-demon start
## Type:        list("--listen --persist")
## Default:     "--listen --persist"
## ServiceRestart: bluetooth
DUND_DAEMON_ARGS="--listen --persist"

############ HIDD

## Path:        Hardware/Bluetooth
## Description: Start responsible demon for HID Daemon
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth
HID_START="yes"

## Path:        Hardware/Bluetooth
## Description: Set responsible demon for HID 
## Type:        list("/usr/bin/hidd","")
## Default:     "/usr/bin/hidd"
## ServiceRestart: bluetooth
HID_DAEMON="/usr/bin/hidd"

## Path:        Hardware/Bluetooth
## Description: Arguments for hid-demon start
## Type:        list("--server", "")
## Default:     "--server"
## ServiceRestart: bluetooth
HID_DAEMON_ARGS="--server"


############ HID2HCI

## Path:        Hardware/Bluetooth
## Description: Start HID to HCI mode switching utility
## Type:        yesno
## Default:     no
## ServiceRestart: bluetooth
HID2HCI_START="yes"

## Path:        Hardware/Bluetooth
## Description: Set responsible utility for HID to HCI mode switching 
## Type:        list("/usr/bin/hidd","")
## Default:     "/usr/sbin/hid2hci"
## ServiceRestart: bluetooth
HID2HCI_DAEMON="/usr/sbin/hid2hci"

## Path:        Hardware/Bluetooth
## Description: Arguments for RHID to HCI mode switching utility
## Type:        list("--tohci", "")
## Default:     "--tohci"
## ServiceRestart: bluetooth
HID2HCI_DAEMON_ARGS="--tohid "

--------------010801010209030806010700
Content-Type: text/plain;
 name="hcid.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid.conf"

#
# HCI daemon configuration file.
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	security user;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices

	#   once  - Pair once and deny successive attempts
	pairing multi;

	# Default PIN code for incoming connections
	passkey "1234";
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x3e0100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan disable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	lp rswitch,hold,sniff,park;
	pscan disable;
}

--------------010801010209030806010700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010801010209030806010700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------010801010209030806010700--
