Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1071791711.6635.18.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073147533.8729.53.camel@saag>
Mime-Version: 1.0
Date: Sat, 03 Jan 2004 16:32:13 +0000
List-ID: <bluez-users.lists.sourceforge.net>

I have a problem that I believe is caused by the new libs.

Here's what happens: I contact the P800's bluetooth serial port as usual
and look for it connecting back to dund (yes, I have the SP record). 
Unfortunately dund never gets to hear from it.  dund's running on
channel 3.

Reverting the libs seemed to fix this (was running linux/ppc
2.4.22-ben2).  I've also seen the problem under 2.4.23-mh1 and 2.6.0
kernels.  So I don't think it's kernel-specific.

Here's what hcidump shows:

[ successful SDP interrogation ]

> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x00e4
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e4 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x00e4 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x00e4 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
    MTU 672
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c

[a long wait here while nothing happens]

> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x00e4
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x00e4
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x00e3
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x00e3
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Disconn Complete(0x05) plen 4
