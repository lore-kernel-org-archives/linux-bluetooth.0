Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sigrid Kronenberger <skronenberger@web.de>
To: bluez-users@lists.sourceforge.net
Message-Id: <20040815222056.2160d599@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Kernel 2.6.8 final and AVM BlueFritz
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
Date: Sun, 15 Aug 2004 22:20:56 +0200

Hello :)

I've changed my Kernel from 2.6.3-15mdk to the 2.6.8 final
(Vanilla-Kernel) with Mandrake 10.0 Official. 

Now, the firmware request for my USB-Bluetooth-Dongle is ok :) I'm using
the AVM-Firmware-Version 3-18-39.


[root@localhost sigrid]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:04:0E:81:F3:12 ACL MTU: 672:6  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:119 acl:0 sco:0 events:8 errors:0
        TX bytes:63 acl:0 sco:0 commands:8 errors:0
        Features: 0x2f 0xbe 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Bluetooth Device'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1227 LMP Ver: 1.1 (0x1) LMP
Subver: 0x1
        Manufacturer: AVM Berlin (31)

[root@localhost sigrid]#


[root@localhost sigrid]# sdptool browse
Inquiring ...
Browsing 00:04:0E:81:71:87 ...
[root@localhost sigrid]#


[root@localhost sigrid]# ciptool search
Searching ...
        Checking service for 00:04:0E:81:71:87
        Connecting to device 00:04:0E:81:71:87
Local device is not accepting role switch
Can't connect L2CAP socket: Connection refused
[root@localhost sigrid]#

How can I change the last point? My AP don't accept the role switch. 


My /etc/bluetooth/hcid.conf looks like this: 

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
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
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bin/bluepin;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "BlueZ (%d)";

	# Local device class
	class 0x100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption
	#auth enable;
	#encrypt enable;
}


So, I think, it should work with the role switch. Or do I have to change
another entry in this file?

Regards

Sigrid


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
