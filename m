Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 Hub + i-mate smartphone2
From: Marcel Holtmann <marcel@holtmann.org>
To: Neil Fenemor <Neil@OnDrugs.co.nz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088030943.3703.26.camel@localhost.localdomain>
References: <1088029361.3703.17.camel@localhost.localdomain>
	 <1088030296.4296.14.camel@pegasus>
	 <1088030943.3703.26.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1088031569.4296.20.camel@pegasus>
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
Date: Thu, 24 Jun 2004 00:59:29 +0200

Hi Neil,

> [root@localhost neil]# /usr/sbin/hcidump -x
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   BF E1 07 6D 0E 00 18 CC 02 00 00 00 00 
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 05 04 
> > HCI Event: Connect Complete(0x03) plen 11
>   00 29 00 BF E1 07 6D 0E 00 01 00 
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   29 00 0E 00 
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> > HCI Event: Command Complete(0x0e) plen 6
>   01 0D 08 00 29 00 
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
>   BF E1 07 6D 0E 00 01 
> > HCI Event: Max Slots Change(0x1b) plen 3
>   29 00 05 
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0152 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0152 flags 0x0000 clen 4
>     MTU 1024 
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0152 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 8
> 
>     L2CAP(d): cid 0x152 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> > ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> < ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x152 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size
> 667 max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> > ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size
> 667 max_retrans 0 credits 7
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x152 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0152
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0152
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00 
> < HCI Command: Disconnect(0x01|0x0006) plen 3
>   29 00 13 
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 06 04 
> > HCI Event: Disconn Complete(0x05) plen 4
>   00 29 00 16 

what kernel do you use? Everything looks normal and I don't see any
reason why your phone disconnects the L2CAP link.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
