Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513104509.051ef688@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 10:49:41 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Daryl Van Vorst <daryl@wideray.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052784278.1132.170.camel@pegasus.local>
References: <000901c318df$6b11ad00$1a01010a@baked>
	<000901c318df$6b11ad00$1a01010a@baked>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 05:04 PM 5/12/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> > Daryl, so it is now up to you to do your tests with Cetecom 
>> > again and see what we pass and what we fail. The RFCOMM layer 
>> > should now perform perfect, but the L2CAP config stuff will 
>> > still fail. You can use 2.4.18-mh4 and apply these 5 patches 
>> > from the bt-2.4 repository to it:
>> 
>> Great work guys! Thanks!
>
>maybe we have another RFCOMM misbehaviour, which doesn't matter in the
>real world, but can confuse the tester.
>
>        < ACL data: handle 0x0029 flags 0x02 dlen 8
>            L2CAP(d): cid 0x45 len 4 [psm 3]
>              RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8 
>        > ACL data: handle 0x0029 flags 0x02 dlen 8
>            L2CAP(d): cid 0x40 len 4 [psm 3]
>              RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
>        < ACL data: handle 0x0029 flags 0x02 dlen 8
>            L2CAP(d): cid 0x45 len 4 [psm 3]
>              RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
>        < ACL data: handle 0x0029 flags 0x02 dlen 12
>            L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
>        > ACL data: handle 0x0029 flags 0x02 dlen 8
>            L2CAP(d): cid 0x40 len 4 [psm 3]
>              RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
>        > ACL data: handle 0x0029 flags 0x02 dlen 12
>            L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040
>
>The dump above is from a disconnect sequence of RFCOMM. We don't wait
>for the UA of the DISC on the dlci 0. We send the L2CAP disconnect
>request right after the disconnect of the dlci 0. The L2CAP channel
>should be closed after receiving the UA or after a timeout.
Yeah, this one probably needs to be fixed. Although I think I've heard that 
simply closing L2CAP channel is enough, I mean even sending DISC is optional. 
But we need to verify that in the spec.

Max
