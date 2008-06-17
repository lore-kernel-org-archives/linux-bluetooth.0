Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jun 2008 17:57:00 +0200
From: Alexander Kerner <lunohod@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20080617155700.GA22485@hosaka.homeunix.net>
MIME-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Simultaneous ingoing and outgoing connections issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hello!

I have a problem running bt server and client at one time on one machine.
Inquiry scan and ingoing conenctions do not work when an outgoing connection is
active. I can reproduce it using only rctest utility. The machine is visible to
other bt devices and the clients can connect, but when I start 
"rctest -n <random bt address>" the machine cannot be discovered and the 
incoming connections stop working until rctest is stopped. hcidump shows only
the outgoing connection attempt and nothing else. 

I tested on two different machines with different bt devices and the behaviour
is the same.


Regards

Alexander


1. bluez 3.32, usb dongle EPOX BT-DG02

hci0:   Type: USB
        BD Address: 00:04:61:80:2C:DB ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
        Manufacturer: Cambridge Silicon Radio (10)
hci0:   Type: USB
        BD Address: 00:04:61:80:2C:DB ACL MTU: 192:8 SCO MTU: 64:8
        HCI 14.3
        Chip version: BlueCore02-External (ES2)
        Max key size: 56 bit
        SCO mapping:  HCI
hci0:   Type: USB
        BD Address: 00:04:61:80:2C:DB ACL MTU: 192:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
                <transparent SCO>

2. bluez 3.29, hp compaq 6910p with built-in BT

hci0:	Type: USB
	BD Address: 00:1A:6B:88:42:AA ACL MTU: 1017:8 SCO MTU: 64:8
	HCI Ver: 2.0 (0x3) HCI Rev: 0x2129 LMP Ver: 2.0 (0x3) LMP Subver: 0x41cf
	Manufacturer: Broadcom Corporation (15)
hci0:	Type: USB
	BD Address: 00:1A:6B:88:42:AA ACL MTU: 1017:8 SCO MTU: 64:8
	Firmware 41.65 / 207
hci0:	Type: USB
	BD Address: 00:1A:6B:88:42:AA ACL MTU: 1017:8 SCO MTU: 64:8
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
		<power control> <transparent SCO> <broadcast encrypt> 
		<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
		<interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
		<extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
		<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
		<AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
		<EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features> 



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
