Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm connection send data
From: Marcel Holtmann <marcel@holtmann.org>
To: franz keuner <franz_keuner@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <27734.1078908349@www43.gmx.net>
References: <1078877588.30990.11.camel@pegasus>
	 <27734.1078908349@www43.gmx.net>
Content-Type: text/plain
Message-Id: <1078914761.2537.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Mar 2004 11:32:41 +0100

Hi Franz,

> thanks a lot for your quick answer. i used the hcidump tool and what i got
> is this: 
> ( i have to admit i don't know what it means...)

you can use the Bluetooth specification ;)

>  hcidump -x
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request(0x04) plen 10
>   AD 1C E8 D9 0A 00 0C 22 50 01
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   AD 1C E8 D9 0A 00 01
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 09 04
> > HCI Event: Connect Complete(0x03) plen 11
>   00 28 00 AD 1C E8 D9 0A 00 01 00
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   28 00 0E 00
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
>   AD 1C E8 D9 0A 00 01
> > HCI Event: Command Complete(0x0e) plen 6
>   01 0D 08 00 28 00
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>   28 00 18 CC
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 0F 04
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
>   00 28 00 18 CC
> > HCI Event: Max Slots Change(0x1b) plen 3
>   28 00 05
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x015d
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x015d result 0 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x015d flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x015d flags 0x0000 clen 4
>     MTU 1024
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > ACL data: handle 0x0028 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
>     MTU 672
> > ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> < ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x15d len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > ACL data: handle 0x0028 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 20 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 667
> max_retrans 0 credits 3
> < ACL data: handle 0x0028 flags 0x02 dlen 18
>     L2CAP(d): cid 0x15d len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 20 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size 667
> max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 20 pf 1 ilen 0 fcs 0xfd
> < ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x15d len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 20 pf 1 ilen 0 fcs 0x36
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(d): cid 0x15d len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(d): cid 0x40 len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(d): cid 0x15d len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(d): cid 0x40 len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 0x0028 flags 0x02 dlen 9
>     L2CAP(d): cid 0x15d len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 20 pf 1 ilen 0 fcs 0xf7
>       21
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00

and at this point the complete RFCOMM connection is established and you
can receive data, but your Symbian phone don't send anything. Search for
the problem on the phone side.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
