Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes <lintner@c-lab.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4132FF52.3070305@c-lab.de>
References: <412DC001.3000307@c-lab.de> <1093519463.2581.3.camel@pegasus>
	 <4132FF52.3070305@c-lab.de>
Content-Type: text/plain
Message-Id: <1093861640.5620.1.camel@pegasus>
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
Date: Mon, 30 Aug 2004 12:27:20 +0200

Hi Johannes,

> sorry, but my time run out last week.
> I put hcidump -x on, but I'm not familiar with the output, it gives to
> me.
> Perhaps you can help me.
> But this might be the section, that is relevant to my problem:
> 
> <>> ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0068
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0068 result 0 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0068 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0068 flags 0x0000 clen 4
>     MTU 1024
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
>     MTU 672
> > ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x68 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size
> 667 max_retrans 0 credits 3
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x68 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0068
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0068
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> < HCI Command: Disconnect(0x01|0x0006) plen 3
>   29 00 13
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete(0x05) plen 4
>   00 29 00 16
> 
> The String I send to the server is 12bytes long, the other String
> 6bytes, but I can't find any messages for these Strings.

and there are no RFCOMM UIH packets that may transport your data. Check
the connection setup itself, because it looks like that on the other
side there is no service running on channel 2.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
