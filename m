Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian <Kimpenhaus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr3x8uqadqdj9uv@mail.gmx.de>
References: <opr3xmdugiqdj9uv@mail.gmx.de>
	 <1077725935.2919.116.camel@pegasus>  <opr3xs5louqdj9uv@mail.gmx.de>
	 <1077734547.2919.147.camel@pegasus>  <opr3xydd1hqdj9uv@mail.gmx.de>
	 <1077740936.2884.2.camel@pegasus>  <opr3x23lc1qdj9uv@mail.gmx.de>
	 <1077747171.2884.5.camel@pegasus>  <opr3x77rphqdj9uv@mail.gmx.de>
	 <1077753099.2754.1.camel@pegasus>  <opr3x8uqadqdj9uv@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1077757118.2754.4.camel@pegasus>
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
Date: Thu, 26 Feb 2004 01:58:38 +0100

Hi Florian,

> Hope this help figure out the problem.
> 
> bash-2.05b# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:03:C9:23:3D:51 ACL MTU: 377:10  SCO MTU: 16:0
>          UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>          RX bytes:6807 acl:0 sco:0 events:488 errors:0
>          TX bytes:5371 acl:0 sco:0 commands:268 errors:0
>          Features: 0xff 0xfd 0x05 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: ACCEPT MASTER
>          Name: 'BT3030 (0)'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 
> 0xf07
>          Manufacturer: Broadcom Corporation (15)
> 
> bash-2.05b# hcidump -x
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Read Local Name(0x03|0x0014) plen 0
> > HCI Event: Command Complete(0x0e) plen 252
>    01 14 0C 00 42 54 33 30 33 30 20 28 30 29 00 40 38 14 03 40
>    00 54 01 40 04 00 00 00 9C 56 01 40 20 48 01 40 0C 4C 01 40
>    C9 89 04 08 A4 F7 FF BF 6A 83 00 40 C9 89 04 08 AC 5A 70 00
>    F0 87 04 08 60 F7 FF BF C0 4B 01 40 02 00 00 00 D0 56 01 40
>    00 00 00 00 01 00 00 00 00 00 00 00 60 F7 FF BF 00 00 00 00
>    17 9C 09 40 48 00 00 00 00 00 00 00 AC 5A 70 00 E0 F7 FF BF
>    70 4A 01 40 E0 63 15 40 60 59 15 40 F8 1B 03 40 00 54 01 40
>    84 F7 FF BF 62 ED 09 40 E0 63 15 40 B0 07 05 08 60 59 15 40
>    00 00 00 00 B0 07 05 08 B8 F7 FF BF AE E4 08 40 B0 07 05 08
>    00 00 00 00 DC 82 00 40 20 48 01 40 44 00 00 00 70 4A 01 40
>    F0 F7 FF BF AE B2 00 40 0C 4C 01 40 D0 56 01 40 01 00 00 00
>    66 46 0D 40 E0 63 15 40 2C 2A 05 08 00 00 00 00 08 F8 FF BF
>    27 97 04 08 00 00 00 00 EC FC 04 08
> < HCI Command: Read Class of Device(0x03|0x0023) plen 0
> > HCI Event: Command Complete(0x0e) plen 7
>    01 23 0C 00 00 01 00
> < HCI Command: Read Local Version Information(0x04|0x0001) plen 0
> > HCI Event: Command Complete(0x0e) plen 12
>    01 01 10 00 01 02 00 01 0F 00 07 0F

I meant from the connection process.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
