Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.62.0503092326330.6694@block>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] SCO blocks incoming connections
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
Date: Wed, 9 Mar 2005 23:34:31 +0100 (CET)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone,

I'm still having problems with SCO. I have a headset and two
HID devices (MS Optical Desktop BT). I can run btsco just fine
and connect/disconnect the SCO channel by pressing the button
on the headset.

However, as long as a SCO connection is up - hcitool con:
Connections:
	< SCO 00:0D:FD:... handle 42 state 1 lm SLAVE 
	< ACL 00:0D:FD:... handle 41 state 1 lm MASTER 
	> ACL 00:50:F2:... handle 46 state 1 lm MASTER 

As you may notice, the keyboard is connected at handle 46 and works
just fine. Unfortunately, the mouse (which I disconnected for testing
purposes with hidd --kill) is not able to reconnect as long as the
SCO link stays up. Worse, even hidd --connect <mouseaddr> does not
work and hits some timeout. Everything is back to normal as soon as
I hit the headset button and the SCO link is down again. It seems to me 
that the connections are blocked on some pretty basic level..

In case it may help, here's the output of hciconfig -a:
(I tried without MASTER link mode, didn't work, too).
hci0:	Type: USB
	BD Address: 00:50:F2:7D:51:FA ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:11568808 acl:100145 sco:196913 events:8128 errors:0
	TX bytes:10034917 acl:657 sco:196451 commands:194 errors:0
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

Thanks for any hint,
Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCL3n77CzyshGvatgRAsG1AJ9VOYSEgOUC5CUScsMDxTB6U4csLQCfQw93
SQXRrcO6g1d9+Hz85JIWkE8=
=rxY6
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
