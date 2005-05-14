Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Frank Pieczynski <pieczy@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] EDR support?
References: <200505142306.31290.pieczy@web.de> <200505142319.35417.cijoml@volny.cz>
In-Reply-To: <200505142319.35417.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200505150023.09686.pieczy@web.de>
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
Date: Sun, 15 May 2005 00:23:09 +0200

On Saturday 14 May 2005 23:19, Michal Semler wrote:
> > 	Service Classes: Networking, Rendering, Capturing
> > 	Device Class: Computer, Uncategorized
> > 	HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0x679
>
> ^^^^^^^^^^^^
> It is 1.2 device
>
> hciconfig hci0 features
> hciconfig hci0 revision
>
> will give you better knowledge about this device

hciconfig hci0 revision
hci0:	Type: USB
	BD Address: 00:10:C6:63:03:74 ACL MTU: 384:8 SCO MTU: 64:8
	Build 1657
	Chip version: BlueCore4-External
	Max key size: 128 bit
	SCO mapping:  HCI

The BlueCore4 is a BT2.0 capable chip, right?
 
hciconfig hci0 features
hci0:	Type: USB
	BD Address: 00:10:C6:63:03:74 ACL MTU: 384:8 SCO MTU: 64:8
	Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
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

And it supports EDR, nice.

Thank you for your help,
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
