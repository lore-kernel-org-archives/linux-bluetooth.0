Return-Path: <vit@mifki.ru>
Subject: Re: help me
From: Vitaliy Pronkin <vit@mifki.ru>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085328263.8309.25.camel@pegasus>
References: <loom.20040523T164826-243@post.gmane.org>
	 <1085324502.8309.19.camel@pegasus>
	 <loom.20040523T170840-699@post.gmane.org>
	 <1085326200.8309.22.camel@pegasus>  <1085327326.29252.169.camel@n-vit>
	 <1085328263.8309.25.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085328722.23050.175.camel@n-vit>
Mime-Version: 1.0
Date: Sun, 23 May 2004 20:12:02 +0400
List-ID: <bluez-users.lists.sourceforge.net>

I just installed libs and utils ver 2.7.. But getting the same output
from hcidump:

# hcidump
HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0045
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 512 FlushTO 65535
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x0000 result 0 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0045 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0x14
          cont 00
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0045
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0045
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0046
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0046 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 512 FlushTO 65535
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x0000 result 0 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0046 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0x14
          cont 00
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0046
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0046
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Disconn Complete(0x05) plen 4


My laptop is on standard Intel Pentium M processor.
What more info may help you?

Regards,
Vitaliy
