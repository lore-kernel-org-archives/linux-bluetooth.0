Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool scan ...
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200411301420.24512.wim.delvaux@adaptiveplanet.com>
References: <200411291050.14799.wim.delvaux@adaptiveplanet.com>
	 <200411291136.23173.wim.delvaux@adaptiveplanet.com>
	 <1101724777.7463.31.camel@pegasus>
	 <200411301420.24512.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1101821436.9348.1.camel@notepaq>
Mime-Version: 1.0
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
Date: Tue, 30 Nov 2004 14:30:36 +0100

Hi Wim,

> > > > this depends on the Bluetooth chip and its firmware. Check this with
> > > > hcitool and hciconfig.
> > >
> > >   sorry for my BT ignorance but what option should I use and which
> > >  parameter presents Chip and Firmware ?
> >
> >  hciconfig -a
> >  hciconfig hci0 revision
> >  hcitool info <bdaddr>
> 
>  for the Ipaq it shows
>  /mnt/ramfs/tmp # hciconfig -a
>  hci0:   Type: UART
>         BD Address: 00:02:C7:0D:85:96 ACL MTU: 128:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH
>         RX bytes:252 acl:0 sco:0 events:12 errors:0
>         TX bytes:430 acl:0 sco:0 commands:11 errors:0
>         Features: 0xff 0xff 0x05 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'familiar'
>         Class: 0x120112
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Handheld
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
>         Manufacturer: Cambridge Silicon Radio (10)
> 
>  /mnt/ramfs/tmp # hciconfig hci0 revision
>  hci0:   Type: UART
>         BD Address: 00:02:C7:0D:85:96 ACL MTU: 128:8  SCO MTU: 64:8
>         HCI 11.2 (bc01b)
> 
>  for the desktop is shows
>  buro:# hciconfig -a
>  hci0:   Type: USB
>         BD Address: 00:60:57:02:71:A2 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:4470825 acl:40078 sco:0 events:110377 errors:0
>         TX bytes:14530648 acl:125164 sco:0 commands:1112 errors:0
>         Features: 0xff 0xff 0x09 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'buro-0'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
>         Manufacturer: Cambridge Silicon Radio (10)
> 
>  buro:# hciconfig hci0 revision
>  hci0:   Type: USB
>         BD Address: 00:60:57:02:71:A2 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 12.7
>         Chip version: BlueCore01b
>         SCO mapping:  PCM
> 
>  does that explain why hciconfig scan fails if they are connected ?

actually you won't be happy with anything before HCI 16.4 firmware.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
