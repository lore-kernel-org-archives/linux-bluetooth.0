Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: help me
From: Marcel Holtmann <marcel@holtmann.org>
To: Vitaliy Pronkin <vit@mifki.ru>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085327326.29252.169.camel@n-vit>
References: <loom.20040523T164826-243@post.gmane.org>
	 <1085324502.8309.19.camel@pegasus>
	 <loom.20040523T170840-699@post.gmane.org>
	 <1085326200.8309.22.camel@pegasus>  <1085327326.29252.169.camel@n-vit>
Content-Type: text/plain
Message-Id: <1085328263.8309.25.camel@pegasus>
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
Date: Sun, 23 May 2004 18:04:23 +0200

Hi,

> HCIDump - HCI packet analyzer ver 1.8
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request(0x04) plen 10
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connect Complete(0x03) plen 11
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
> > HCI Event: Max Slots Change(0x1b) plen 3
> > ACL data: handle 0x002a flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x004d
> < ACL data: handle 0x002a flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004d result 0 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x002a flags 0x02 dlen 20
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
>     MTU 512 FlushTO 65535
> < ACL data: handle 0x002a flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x004d flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002a flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x004d flags 0x0000 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > ACL data: handle 0x002a flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x002a flags 0x02 dlen 17
>     L2CAP(d): cid 0x40 len 13 [psm 1]
>         SDP SS Req: tid 0x0 len 0x8
>           pat uuid-16 0x1002 (PubBrwsGrp)
>           max 0x14
>           cont 00
> > ACL data: handle 0x002a flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x004d
> < ACL data: handle 0x002a flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004d
> > HCI Event: Number of Completed Packets(0x13) plen 5

this looks like a problem in the sdpd. Please install the one from
bluez-utils-2.7 and try again. Is your laptop a big endian machine?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
