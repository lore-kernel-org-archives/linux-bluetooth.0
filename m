Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Frank Pieczynski <pieczy@web.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200505142306.31290.pieczy@web.de>
Subject: [Bluez-users] EDR support?
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
Date: Sat, 14 May 2005 23:06:31 +0200

Hello,
I just installed a Dell Latitude X1 notebook with Gentoo Linux and BlueZ.
A Dell "TrueMobile 350" BT device is built in (lsusb shows this as id 
413c:8103).
I was able to successful connect a Blutooth notebook mouse by "hama". But I 
wonder if this modul is a real BT 2.0 device with EDR (according to the 
Bluetooth database on heise.de it is such device).

This is the output of 'hciconfig -a'
hci0:	Type: USB
	BD Address: 00:10:C6:63:03:74 ACL MTU: 384:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:18036 acl:899 sco:0 events:399 errors:0
	TX bytes:3320 acl:118 sco:0 commands:67 errors:0
	Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0x679
	Manufacturer: Cambridge Silicon Radio (10)

Is that a BT 2.0 capable device?

Thank you for your help!
Frank


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
