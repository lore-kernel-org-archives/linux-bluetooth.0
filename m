Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 file transfer to computer
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102590679.24852.3.camel@nephlim.homenet>
References: <1102381335.13235.8.camel@nephlim.homenet>
	 <1102406104.8447.15.camel@pegasus>
	 <1102438800.21032.3.camel@nephlim.homenet>
	 <1102478181.8447.52.camel@pegasus>
	 <1102553068.22127.5.camel@nephlim.homenet>
	 <1102577073.9988.92.camel@pegasus>
	 <1102590679.24852.3.camel@nephlim.homenet>
Content-Type: text/plain
Message-Id: <1102591469.9988.128.camel@pegasus>
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
Date: Thu, 09 Dec 2004 12:24:29 +0100

Hi Stefan,

> > actually I asked for "hcidump -X" and not "hcidump -x" and it seems that
> > the RFCOMM channel assignment of OBEX don't works. Must be because the
> > 7610 has a quite crazy way to ask for the OBEX push service record. So
> > you should try "hcidump --obex=3 -X".
> 
> Here is the output for hcidump --obex=3 -X
> 
> HCIDump - HCI packet analyzer ver 1.16
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   0000: c4 0f 15 ed 0e 00 0c 02  50 01                    ........P.
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   0000: c4 0f 15 ed 0e 00 01                              .......
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 09 04                                       ....
> > HCI Event: Max Slots Change (0x1b) plen 3
>   0000: 01 00 05                                          ...
> > ACL data: handle 0x0001 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0043
> > HCI Event: Connect Complete (0x03) plen 11
>   0000: 00 01 00 c4 0f 15 ed 0e  00 01 00                 ...........
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   0000: 01 00 0f 00                                       ....
> > HCI Event: Max Slots Change (0x1b) plen 3
>   0000: 01 00 05                                          ...
> > HCI Event: Command Complete (0x0e) plen 6
>   0000: 01 0d 08 00 01 00                                 ......
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>   0000: 01 00 18 cc                                       ....
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 0f 04                                       ....
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>   0000: 00 01 00 18 cc                                    .....
> > HCI Event: Disconn Complete (0x05) plen 4
>   0000: 00 01 00 13                                       ....
> 
> So it still doesn't work. What should I do. I want to get this working.
> It's so bad...

and it is the same problem. Data packet before connection complete.

> Dongle info:
> 
> hci0:   Type: USB
>         BD Address: 00:0B:0D:21:D7:54 ACL MTU: 339:4  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:4898 acl:63 sco:0 events:465 errors:0
>         TX bytes:3038 acl:52 sco:0 commands:201 errors:0
>         Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)...?...'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x93
>         Manufacturer: Transilica, Inc. (24)
> 
> 
> And phone?? It's a 7610 you should know... Or what do you mean?

Actually I meant its chip information (use "hcitool info ..."), because
we need to figure out which Bluetooth chip is the bad one that makes
sending out the ACL data packets before the connection complete event. I
believe your dongle is the problematic part and if you exchange it with
a CSR based one all troubles will be gone.

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
