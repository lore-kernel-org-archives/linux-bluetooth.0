Return-Path: <Maksim.Yevmenkin@cw.com>
MIME-Version: 1.0
Subject: RE: [Bluez-devel] Patch for bluez-hcidump-1.5
Date: Sat, 7 Dec 2002 20:17:33 -0800
Message-ID: <45258A4365C6B24A9832BFE224837D552B1270@sjdcex01.int.exodus.net>
From: "Maksim Yevmenkin" <Maksim.Yevmenkin@cw.com>
To: "Marcel Holtmann" <marcel@rvs.uni-bielefeld.de>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; CHARSET=Windows-1252
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> > normally i would agree with you, but not in this case :) the changes
> > are mostly mechanical, i.e s/__u8/uint8_t/g. this should be very easy
> > to review. i did not change logic or code structure at all. however,
> > if people think it is hard to review i will split it.
>=20
> I like to have this mechanical one as a seperate patch so we can take a
> quick look at it and apply them to CVS. If you have much mechanical
> stuff in it is hard to find the other ones, especially if they are only
> oneliner.

amen :)

> > in the parser/l2cap.c file there is a function called parse_l2cap().
> > after signal l2cap packet gets processed frm->len and frm->ptr
> > are adjusted by hdr->len. i think it should be btohs(hdr->len).
>=20
> Ok, got it. Is it not better to use the defined variable dlen?

yes, you can use dlen. for i386 architecture it probably makes no
difference anyway :)=20

> > > The man page belongs to section 8 like all other *dump programs do. S=
ee
> > > for example irdadump, tcpdump, pppdump etc. I will look at the man pa=
ge
> > > code today.

[...]

> Let's have hcidump.8 because hcidump needs root privilige to work as
> expected.

amen :)

> > *BSD systems have style(9) man page. this page describes the
> > coding style guidelines for *BSD kernel. i found these guidelines
> > very useful and try to follow them. i *personally* try not to put
> > #include lines in the header files. any dependencies should be
> > indicated elsewhere. this comes from my experince with the couple
> > of big projects where is was a pure nightmare to track down some
> > minor change in the distant header file. another reason is that it=20
> > much easier for me to port, because when i see something like
> >=20
> > #include <bluetooth/x.h>
> > #include <bluetooth/y.h>
> > #include <bluetooth/z.h>
> >=20
> > rather then
> >=20
> > #include "something.h"
> >=20
> > i know exactly how to translate BlueZ headers into FreeBSD
> > headers. i admin that it will not matter any more as soon as
> > both systems will have common headers.
>=20
> I agree with you that header files should avoid to include other header
> files. But my question was, why you did the reorder of header files like
> you have done in the patch. I always start with <stdio.h> and following.
> Then take the <sys/*.h> and after that comes <bluetooth/*.h> as needed.
> And I think this is a good order and I can't get the advantage of
> changing it. What do you really need to make it easy to port them to
> FreeBSD?

the answer to your first question lies in the style(9) man page :)
it defines the order of #inlude's. <sys/*.h>, <machine/*.h> and
other <*/*.h> come first, then other headers in alphabetical order
(if possible). i personally got used to this order and think it
makes sense. first you have #incude's that could possibly be system
dependant and then then rest of the #include's. however, i can deal
with any order of #include's as long as everything is working :)

porting to FreeBSD is pretty much straight forward, i.e. mechanical
changes for some types, #define's and structure names. however,
i would really like to not port anything at all, i.e. use original
BlueZ source code. unfortunately it is not possible right now.
low level API for HCI and L2CAP are somewhat different. although my
FreeBSD Bluetooth code also has HCI and L2CAP sockets - the types,
structure names and API (ioctl's, setsockopt defines) are still
different.=20

i will try to make the first step and create hci.h and l2cap.h
that will contain only HCI and L2CAP types and defines - no system
specific code. the next step is to define API for Bluetooth sockets
(HCI and L2CAP), i.e. ioctl names, setsockopt defines etc. i also
propose to define common libBluetooth, libHCI (and probably libL2CAP)
API that will hide possible implementation differences. after we
do that all application just will use defined API and source code
will be 100% portable.

as for RFCOMM, SDP etc. then you guys will lead the parade :)
i'm currently using BlueZ code with the minimal changes. i'm just
hoping that SDP, RFCOMM etc. implementation won't become too
Linux specific :)

thanks,
max
