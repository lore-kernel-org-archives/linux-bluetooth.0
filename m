Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] role change not allowed when connecting with PAND
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412132025.29208.wim.delvaux@adaptiveplanet.com>
References: <200412132025.29208.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102968434.2143.19.camel@pegasus>
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
Date: Mon, 13 Dec 2004 21:07:14 +0100

Hi Wim,

> When I run
> 
> pand --connect XXXX --persist
> 
> and my server runs 
> 
> pand --listen --role NAP
> 
> and hciconfig -a on the client shows (Had to type this over)
> 
> link policy : RSWITCH, HOLD PARK SNIFF
> link mode : SLAVE ACCEPT
> Features : 0xff 0xff 0x05 0x00
> 
> and on the server it shows
> 
> hci0:   Type: USB
>         BD Address: 00:60:57:02:71:A2 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:4704 acl:33 sco:0 events:445 errors:0
>         TX bytes:12193 acl:111 sco:0 commands:128 errors:0
>         Features: 0xff 0xff 0x09 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'buro-0'
>         Class: 0x100000
>         Service Classes: Object Transfer
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> I get the following HCIDUMP -x output
> 
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   96 85 0D C7 02 00 12 01 12 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   96 85 0D C7 02 00 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Role Change (0x12) plen 8
>   21 96 85 0D C7 02 00 01
> > HCI Event: Link Key Request (0x17) plen 6
>   96 85 0D C7 02 00
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>   96 85 0D C7 02 00 72 97 A4 D0 A0 3A D3 4E E8 50 A4 46 46 F0
>   8A A1
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0B 04 0C 96 85 0D C7 02 00
> > HCI Event: Connect Complete (0x03) plen 11
>   21 28 00 96 85 0D C7 02 00 01 00
> > HCI Event: Connect Request (0x04) plen 10
>   96 85 0D C7 02 00 12 01 12 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   96 85 0D C7 02 00 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Role Change (0x12) plen 8
>   21 96 85 0D C7 02 00 01
> > HCI Event: Link Key Request (0x17) plen 6
>   96 85 0D C7 02 00
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>   96 85 0D C7 02 00 72 97 A4 D0 A0 3A D3 4E E8 50 A4 46 46 F0
>   8A A1
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0B 04 0C 96 85 0D C7 02 00
> > HCI Event: Connect Complete (0x03) plen 11
>   21 29 00 96 85 0D C7 02 00 01 00
> > HCI Event: Connect Request (0x04) plen 10
>   96 85 0D C7 02 00 12 01 12 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   96 85 0D C7 02 00 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Role Change (0x12) plen 8
>   21 96 85 0D C7 02 00 01
> > HCI Event: Link Key Request (0x17) plen 6
>   96 85 0D C7 02 00
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>   96 85 0D C7 02 00 72 97 A4 D0 A0 3A D3 4E E8 50 A4 46 46 F0
>   8A A1
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0B 04 0C 96 85 0D C7 02 00
> > HCI Event: Connect Complete (0x03) plen 11
>   21 28 00 96 85 0D C7 02 00 01 00
> 
> 
> Why don't I get a connection ?

you still have security mode 3 on one side. Disable the "auth" and/or
"encrypt" and try again. Don't set the master link mode on device level,
because pand has a --master for this case.

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
