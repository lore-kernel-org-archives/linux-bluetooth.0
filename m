Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 12 Jun 2003 13:54:20 -0700
Message-ID: <001501c33124$cc792160$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
In-Reply-To: <5.1.0.14.2.20030612120846.0ba3b5c8@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Max Krasnyansky
> Sent: June 12, 2003 12:12 PM
> To: Daryl Van Vorst; 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Qualification Testing
>=20
>=20
> At 11:49 AM 6/12/2003, Daryl Van Vorst wrote:
> >> >Apparently, in step 3 above, if we send a config request with no
> >> >options it will also pass the test. How silly is that? (specially=20
> >> >considering that's what we send by default in the first place!)
> >> I'm pretty sure that it's just because they use some dumb
> >> tester implementation. It doesn't make sense to resend the=20
> >> same config request.
> >
> >It's actually written that way in the test case. Here's a quote from=20
> >the updated test case (errata correction ID 241):
> >
> >"Pass Verdict: The IUT sends an L2CAP_ConfigReq with=20
> acceptable values=20
> >received in the L2CAP_ConfigRsp with Result =3D Failure - unacceptable=20
> >parameters, or the L2CAP_ConfigReq contains no options."
> Consider it done then :). Sounds like this will be useful for=20
> other folks to pass qualification. I'll put it in.

Fantastic! Thanks. :)

Yeah, it should help others. Hopefully there aren't other subtleties that
we've missed regarding this.

Looks like all of the current failures now have fixes from you and Marcel.
So far the only way that I've been updating my stack is by using Marcel's
patches. Marcel, any chance you could make another patch once Max has put i=
n
this L2CAP thing?

-Daryl.
