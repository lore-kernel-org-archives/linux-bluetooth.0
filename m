Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] business card transfer problem
From: Marcel Holtmann <marcel@holtmann.org>
To: franz keuner <franz_keuner@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8333.1082451393@www65.gmx.net>
References: <8333.1082451393@www65.gmx.net>
Content-Type: text/plain
Message-Id: <1082459510.23959.10.camel@pegasus>
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
Date: Tue, 20 Apr 2004 13:11:50 +0200

Hi Franz,

> hcidump shows the following trying to the send from the phone to the linux
> computer:
> 
> hcidump r
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request(0x04) plen 10
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connect Complete(0x03) plen 11
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > HCI Event: Command Complete(0x0e) plen 6
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0054
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0054 result 0 status 0
> > HCI Event: Max Slots Change(0x1b) plen 3
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0054 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0054 flags 0x0000 clen 0
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0054 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0054 flags 0x0000 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x0028 flags 0x02 dlen 17
>     L2CAP(d): cid 0x40 len 13 [psm 1]
>         SDP SS Req: tid 0x1 len 0x8
>           pat uuid-16 0x1105 (OBEXObjPush)
>           max 0xffff
>           cont 00
> < ACL data: handle 0x0028 flags 0x02 dlen 22
>     L2CAP(d): cid 0x54 len 18 [psm 1]
>         SDP SS Rsp: tid 0x1 len 0xd
>           cur 0x2 tot 0x2 hndl 0x804d490 0x804d5f8
>           cont 00
> > ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 672
> < ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0054 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0055
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0055 result 0 status 0
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0055
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0055 result 4 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Disconn Complete(0x05) plen 4

the L2CAP config request/response is totally weird. I thing that the
Bluetooth stack of the P900 is buggy. What Linux kernel do you use?

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
