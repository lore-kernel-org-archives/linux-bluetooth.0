Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Mon, 12 May 2003 17:43:29 -0700
Message-ID: <000e01c318e8$ac4db940$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052784278.1132.170.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> maybe we have another RFCOMM misbehaviour, which doesn't=20
> matter in the real world, but can confuse the tester.
>=20
> 	< ACL data: handle 0x0029 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x45 len 4 [psm 3]
> 	      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8=20
> 	> ACL data: handle 0x0029 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x40 len 4 [psm 3]
> 	      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
> 	< ACL data: handle 0x0029 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x45 len 4 [psm 3]
> 	      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd=20
> 	< ACL data: handle 0x0029 flags 0x02 dlen 12
> 	    L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
> 	> ACL data: handle 0x0029 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x40 len 4 [psm 3]
> 	      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> 	> ACL data: handle 0x0029 flags 0x02 dlen 12
> 	    L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040
>=20
> The dump above is from a disconnect sequence of RFCOMM. We=20
> don't wait for the UA of the DISC on the dlci 0. We send the=20
> L2CAP disconnect request right after the disconnect of the=20
> dlci 0. The L2CAP channel should be closed after receiving=20
> the UA or after a timeout.

I'd have to learn more about the spec to be able to talk with you
intelligently about this. There were quite a few RFCOMM tests we had to ski=
p
due to the other problems, so if you think you've found something that
doesn't quite follow the spec then we might get caught on it when we do the
rest of the tests. I'll query Cetecom about it.

> > I'll hold off on more testing until we've figured out a=20
> solution for=20
> > the L2CAP config stuff. More than likely something else=20
> will come out=20
> > the woodwork too, but probably not much. A number of tests=20
> had to be=20
> > postponed due to the previous failures.
>=20
> Daryl, this is your decision (and of course your money), but=20
> I think it will be good to see if our patches fixes the=20
> problems. New code can introduce new bugs :)

It'll definitely get tested! I just want to do the testing in batches. We'r=
e
only one failed test away from having a complete set.

-Daryl.
