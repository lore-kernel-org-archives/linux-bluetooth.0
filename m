Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Network Access Point - pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: "D.W." <sword@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <7166.1099563749@www18.gmx.net>
References: <7166.1099563749@www18.gmx.net>
Content-Type: text/plain
Message-Id: <1099566332.7022.12.camel@pegasus>
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
Date: Thu, 04 Nov 2004 12:05:32 +0100

Hi Daniel,

> this is the output when I execute hciconfig -a.
> hci0:	Type: USB 
> 	BD Address: 00:02:5B:01:21:14 ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN 
> 	RX bytes:936 acl:0 sco:0 events:23 errors:0
> 	TX bytes:327 acl:0 sco:0 commands:22 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> 	Link policy: HOLD SNIFF PARK 
> 	Link mode: ACCEPT MASTER 
> 	Name: 'BlueZ (0)'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
> 	Manufacturer: Cambridge Silicon Radio (10)

you forcing a role switch (master role), but you aren't allowing it in
the link policy? Fix this.

> This is the output while trying to connect to the NAP at first contact:
> 
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request(0x04) plen 10
>   B0 3A 4C 3D 0F 00 04 01 52 01 
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   B0 3A 4C 3D 0F 00 00 
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 09 04 
> > HCI Event: Role Change(0x12) plen 8
>   00 B0 3A 4C 3D 0F 00 00 
> > HCI Event: Connect Complete(0x03) plen 11
>   00 28 00 B0 3A 4C 3D 0F 00 01 00 
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   28 00 0E 00 
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
>   B0 3A 4C 3D 0F 00 01 
> > HCI Event: Max Slots Change(0x1b) plen 3
>   28 00 05 
> > HCI Event: Command Complete(0x0e) plen 6
>   01 0D 08 00 28 00 
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>   28 00 18 CC 
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 0F 04 
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
>   00 28 00 18 CC 
> > HCI Event: PIN Code Request(0x16) plen 6
>   B0 3A 4C 3D 0F 00 
> < HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
>   B0 3A 4C 3D 0F 00 05 42 6C 75 65 5A 00 00 00 00 00 00 00 00 
>   00 00 00 
> > HCI Event: Command Complete(0x0e) plen 10
>   01 0D 04 00 B0 3A 4C 3D 0F 00 
> > HCI Event: Disconn Complete(0x05) plen 4
>   00 28 00 05 

The PIN code you entered is simply wrong. Try "BlueZ".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
