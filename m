Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A blue chamaleon to be
References: <op.s1tgc9j9xabado@portatilegio> <1134636788.5198.42.camel@localhost> <op.s1tiptlkxabado@portatilegio> <1134638529.11856.1.camel@localhost> <op.s1tj7dd6xabado@portatilegio> <1134642179.11856.30.camel@localhost>
Message-ID: <op.s1t0xmg8xabado@portatilegio>
From: "zio tom" <zio.tom@gmail.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
In-Reply-To: <1134642179.11856.30.camel@localhost>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 15 Dec 2005 16:50:00 +0100

In data Thu, 15 Dec 2005 11:22:59 +0100, Marcel Holtmann  
<marcel@holtmann.org> ha scritto:

> Hi Giovanni,
>
>> 2.19-5 is the number of the version installed.
>
> it would be better to upgrade to bluez-utils-2.23, because it fixed some
> stuff with the PIN helper handling and even the error reporting was
> improved.

Dear Marcel, since I'm not able to create a rpm package from a source  
*tar.gz, sorry, but I'm not able to upgrade my bluez-utils version. I'm  
googling in order to fix my technical lacks.
For the moment, i just reinstalled all bluez rpms on my system, and  
situations seems to be some different:
/etc/bluetooth/pin was BlueZ, and I changed it to 123456 (should I put  
there PIN:123456?)

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
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

	# PIN helper
	# if you want a interactiv query of your pin use /usr/bin/bluepin
	# /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
	# pin_helper /usr/bin/bluepin;
	pin_helper /bin/bluepincat;  [strangely, before there was no mention of  
blupincat, etc. wow!]

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "BlueZ %h (%d)";

	# Local device class
	# e.g.
	#  0xsss100 = Computer
	#  0xsss104 = Computer Desktop
	#  0xsss108 = Computer Server
	#  0xsss10c = Computer Laptop
	# The 'sss' above defines the service-class (not quite, only the
	# first 11 bits, the next 11 define the device-class, than 2 format bits.)
	# See https://www.bluetooth.org/foundry/assignnumb/document/baseband
	# for more information.
	# 0x100bbb stands for "Object Transfer  (v-Inbox, v-Folder, ...)"
	# 0x020bbb stands for "Networking (LAN, Ad hoc, ...)"
	class 0x000100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	# valid parameters: enable | disable
	iscan enable;
	pscan enable;

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

	# Authentication and Encryption (Security Mode 3)
	auth disable;
	encrypt disable;
}

---------------------------------------------------------
bluepincat contains:

#!/bin/bash
#
# simple none interactiv handler for Bluetooth PIN's
# /etc/bluetooth/pin must only contain one line with the
# PIN code
# With big enhancements from Serguei Leontiev <leo@sai.msu.ru>
#

# if e.g. kbluetoothd is not running, kbluepin throws an error and returns  
1
KBLUETOOTHD_RUN=`ps -ea|grep kbluetoothd`
KBLUEPIN=${KBLUEPIN:-/opt/kde3/sbin/kbluepin}
if [ -x ${KBLUEPIN} \
    -a "X$KBLUETOOTHD_RUN" != "X" ]; then
    PIN=`$KBLUEPIN` && {
        case "$PIN" in
          PIN:*)
            echo "$PIN"
            exit 0
            ;;
        esac
    }
fi;

echo -n "PIN:"
cat /etc/bluetooth/pin

------------------------------------------------------------------
/etc/bluetooth/pin contains only 123456 (should it be PIN:123456?)

and finally rfcomm.conf

#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

rfcomm0 {
	# Automatically bind the device at startup
	bind no;

	# Bluetooth address of the device
	device 00:0A:28:0C:D4:EF;

	# RFCOMM channel for the connection
	channel	1;

	# Description of the connection
	comment "V600";
}

Now I try to run a pairing attemp (using ftp Obex transfer) and I post to  
you the output of hcidump -X -V, ok?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
