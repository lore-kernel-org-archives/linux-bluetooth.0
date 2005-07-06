Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.63.0507060905270.7056@block.bubble>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] l2ping working only in one direction
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
Date: Wed, 6 Jul 2005 09:15:06 +0200 (CEST)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everybody, I have a desktop machine and a router, both with a
CSR bluetooth USB dongle. On both sides, hcid is running, with 
identical configuration (no auth, no encryption, same pin).

However, I can only do l2ping from desktop to router, not vice versa.
When tried on the router, l2ping fails after a short pause with:

Can't connect: Function not implemented

Here's hciconfig -a from the desktop:

hci0:	Type: USB
	BD Address: 00:50:F2:7D:51:FA ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:25782968 acl:1334369 sco:122643 events:65955 errors:0
	TX bytes:6277536 acl:1388 sco:122547 commands:404 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: ACCEPT MASTER 
	Name: 'FloesServer (block)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver: 0x1f9
	Manufacturer: Cambridge Silicon Radio (10)

And this is hciconfig -a from the router, where l2ping fails:

hci0:	Type: USB
	BD Address: 00:09:DD:10:77:6F ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:957 acl:0 sco:0 events:25 errors:0
	TX bytes:343 acl:0 sco:0 commands:23 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: ACCEPT MASTER 
	Name: 'FloesRouter (flunder)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP Subver: 0x460
	Manufacturer: Cambridge Silicon Radio (10)


Does anybody have a clue why this happens? Additionally, I can l2ping and 
use my headset from the desktop, but again not from the router..

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCy4T+7CzyshGvatgRAs/MAKDadjr13Z/qFPrmkNzmmhl2GPjBPgCggH6g
3qjeVp/PcGnr8s0X/vExHd0=
=9FcR
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
