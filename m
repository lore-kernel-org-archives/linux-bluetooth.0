Return-Path: <Maksim.Yevmenkin@cw.com>
MIME-Version: 1.0
Subject: RE: [Bluez-devel] Patch for bluez-hcidump-1.5
Date: Sat, 7 Dec 2002 09:07:36 -0800
Message-ID: <45258A4365C6B24A9832BFE224837D552B126F@sjdcex01.int.exodus.net>
From: "Maksim Yevmenkin" <Maksim.Yevmenkin@cw.com>
To: "Marcel Holtmann" <marcel@rvs.uni-bielefeld.de>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; CHARSET=Windows-1252
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> > please find attached patch for the bluez-hcidump-1.5 package.
> > here is the quick summary of the changes
> >=20
> > 1) __uXXX types replaced with uXXX_t=20
> > 2) minor fix for l2cap parser
> > 3) minor fix for hcidump.1 man page
> > 4) get_unaligned stuff fix
> >=20
> > Note: after applying the patch you still need to move
> > hcidump.8 to hcidump.1
> >=20
> > i also re-arranged #include lines .c files and removed #include
> > lines from the headers. this way it much easier to port, because
> > it is clear which headers are used and what needs to be ported.
> > i would appreciate if any new code in BlueZ will follow this
> > simple rules.=20
> >=20
> > please review and if there are no objections commit.
>=20
> please don't put all your changes in one big patch. Such big things are
> hard to review. I have removed your changes to the man page and attached
> the resulting diff to this email. People with non Intel architectures
> please test it. BTW the best command for making diffs is "diff -urN".

normally i would agree with you, but not in this case :) the changes
are mostly mechanical, i.e s/__u8/uint8_t/g. this should be very easy
to review. i did not change logic or code structure at all. however,
if people think it is hard to review i will split it.

> What do mean with 2. Maybe I have missed it, but I don't see any fixes
> to the L2CAP parser.

in the parser/l2cap.c file there is a function called parse_l2cap().
after signal l2cap packet gets processed frm->len and frm->ptr
are adjusted by hdr->len. i think it should be btohs(hdr->len).

> The man page belongs to section 8 like all other *dump programs do. See
> for example irdadump, tcpdump, pppdump etc. I will look at the man page
> code today.

hmmm...

man 1 intro
on Linux - Introduction to user commands
on *BSD  - Introduction to general commands (tools and utilities)
on Solaris - Introduction to commands and application programs

man 8 intro
on Linux - Introduction to administration and privileged commands
on *BSD  - Introduction to system maintainance and opearation commands
on Solaris  - no man page?

tcpdump has .1 man page on *BSD, snoop (similar to tcpdump) has .1M
man page on Solaris. tcpdump has .8 man page on Linux - really *strange*, b=
ecause tcpdump does not even come standard with Linux (well at least
in my case :). i had to install tcpdump RPM.

IMO tcpdump, pppdump, hcidump are hardly an "administration" commands,
however i admit they may be "privileged". if Linux has chosen to
put man pages for these tools in .8 section then it is fine. just
revert Makefile.{im|am} and change section in the hcidump.8 file.

> What did you have used as reference? I ask because we should
> keep the same syntax for all of our man pages. Is there a "best way to
> write a man page"?

man mdoc(7) on *BSD systems gives you general guidelines and page
template. man mdoc(7) on Linux gives you a little bit less information,
but still a good place to start.

> I left the re-arrange of the #include lines in the patch. I don't see
> why this makes it easier, but I have no big experiences on porting stuff
> to other OS. Can you give us (or maybe only me) some explanations why
> this is good to have.

*BSD systems have style(9) man page. this page describes the
coding style guidelines for *BSD kernel. i found these guidelines
very useful and try to follow them. i *personally* try not to put
#include lines in the header files. any dependencies should be
indicated elsewhere. this comes from my experince with the couple
of big projects where is was a pure nightmare to track down some
minor change in the distant header file. another reason is that it=20
much easier for me to port, because when i see something like

#include <bluetooth/x.h>
#include <bluetooth/y.h>
#include <bluetooth/z.h>

rather then

#include "something.h"

i know exactly how to translate BlueZ headers into FreeBSD
headers. i admin that it will not matter any more as soon as
both systems will have common headers.

thanks,
max
