Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluepin ERR, HCIDUMP message on RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f16b04cf050330221775fe05a4@mail.gmail.com>
References: <f16b04cf050330221775fe05a4@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112554408.8263.3.camel@pegasus>
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
Date: Sun, 03 Apr 2005 20:53:28 +0200

Hi Hariharan,

>        bluepin (pinhelper) application returns ERR.

this is bad and you must fix this. Replace it with a shell script for
example.

> the message received while connect the RFCOMM .
> 
> HCIDump - HCI packet analyzer ver 1.16
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   56 21 18 00 2D AE 18 CC 00 00 00 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Connect Complete (0x03) plen 11
>   00 06 00 56 21 18 00 2D AE 01 00
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   06 00 0F 00
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 06 00
> > HCI Event: Max Slots Change (0x1b) plen 3
>   06 00 05
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0006 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 1024
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
> > ACL data: handle 0x0006 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 1024
> < ACL data: handle 0x0006 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0006 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
> > ACL data: handle 0x0006 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x0006 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
>       frame_size 1019 max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
> > ACL data: handle 0x0006 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73

If you get a DM to a PN then this normally means that you use the wrong
channel number.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
