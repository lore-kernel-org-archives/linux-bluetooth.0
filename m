Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Krause <Andreas.Krause@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407222124.44032.Andreas.Krause@web.de>
References: <200407222124.44032.Andreas.Krause@web.de>
Content-Type: text/plain
Message-Id: <1090529272.21828.41.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 22 Jul 2004 22:47:52 +0200

Hi Andreas,

> I've got a Bluetooth USB Dongle, Vendor ID 0x1131 (ISSC, Integrated System 
> Solution Corp.), Product ID 0x1001, Revision 3.115. All drivers load well and 
> seamless, device is recognized correctly. hcid and sdpd also load well and 
> don't complain. Kernel log is almost silent, no special lines there. However, 
> no inqiry and no device scan is possible ("Connection timed out", see below). 
> Same hardware _does_ find my bluetooth enabled mobile phone when used under 
> Win2k. Any help or any clue?

where do you got these dongle?

> Here's my config:
> 
> Distribution:	Gentoo Linux
> Kernel		gentoo-dev-sources-2.6.7-r11
> 		with patch-2.6.7-mh2
> Packages:
> sweethome root # epm -qa | grep blue
> bluez-utils-2.5
> bluez-libs-2.7
> bluez-sdp-1.5
> bluez-bluefw-1.0
> kdebluetooth-20040416
> bluez-pan-1.1
> bluez-hcidump-1.9
> bluez-hciemu-1.0

you only need bluez-libs-2.8, bluez-utils-2.8 and bluez-hcidump-1.9. The
rest of the BlueZ packages are deprecated and you will run into trouble
installing them.

> (bluez-utils-2.7 does not compile:
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -g -O2 -c ciptool.c
> sdptool.c: In function `add_handsfree':
> sdptool.c:1129: error: `HANDSFREE_SVCLASS_ID' undeclared (first use in this 
> function)
> sdptool.c:1129: error: (Each undeclared identifier is reported only once
> sdptool.c:1129: error: for each function it appears in.)
> sdptool.c:1135: error: `HANDSFREE_PROFILE_ID' undeclared (first use in this 
> function)
> sdptool.c:1151: error: `SDP_SUPPORTED_FEATURES' undeclared (first use in this 
> function)
> sdptool.c: At top level:
> sdptool.c:1578: error: `HANDSFREE_SVCLASS_ID' undeclared here (not in a 
> function)
> )

I will need at least bluez-libs-2.7 as written in the ChangeLog.

> sweethome root # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:11:67:00:0B:9E ACL MTU: 678:12  SCO MTU: 48:5
>         UP RUNNING PSCAN ISCAN INQUIRY
>         RX bytes:384 acl:0 sco:0 events:17 errors:0
>         TX bytes:317 acl:0 sco:0 commands:17 errors:0
>         Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x172 LMP Ver: 1.1 (0x1) LMP Subver: 0x172
>         Manufacturer: Integrated System Solution Corp. (57)

Never seen a device from ISSC, but you already run an inquiry. Looks a
little bit weird.

> sweethome root # hcitool inq
> Inquiring ...
> Inquiry failed.: Connection timed out
> sweethome root # hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out

Run "hcidump -x" and show it to us while executing these commands.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
