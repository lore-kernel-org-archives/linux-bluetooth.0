Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: Rfcomm qualification
Date: Wed, 30 Jul 2003 09:25:12 -0700
Message-ID: <000501c356b7$2887faf0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1059519805.26914.127.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Yes, it's ok that the tester doesn't send the PN command. In 1.0B, the PN
command is optional. In the 1.1 spec, part F:1, section 5.5.3 "DLC paramete=
r
negotiation (PN)", it says that it is optional in the TS 07.10 spec, but is
mandatory in BT spec 1.1 and later.

Will making the default value of credits zero break other things?

-Daryl.

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de]=20
> Sent: July 29, 2003 4:03 PM
> To: Daryl Van Vorst
> Cc: BlueZ Mailing List
> Subject: Re: Rfcomm qualification
>=20
>=20
> Hi Daryl,
>=20
> > We ran into another 1.0B problem with rfcomm testing. We=20
> didn't notice=20
> > this last time because the tests were done slightly differently=20
> > (without an automated tester).
> >=20
> > The tester acts as a 1.0B device and establishes a=20
> connection with the=20
> > IUT. The IUT sent credits (pf bit =3D 1) after the MSC echange. It=20
> > shouldn't. Attached is an hcidump of it.
>=20
> the problem is that the tester don't sends a PN CMD (btw is=20
> this really
> allowed?) and so we use RFCOMM_MAX_CREDITS at two points=20
> (once for the session and for every DLC). If the PN CMD is=20
> present and shows us a 1.0b device we set credits to zero and=20
> don't make use of credit based flow control. It seems that=20
> the default value of credits must be zero and not RFCOMM_MAX_CREDITS.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
