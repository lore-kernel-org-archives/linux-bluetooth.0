Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Make the path to oui.txt a compile-time option
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1283786114.7529.25.camel@localhost.localdomain>
References: <1283786114.7529.25.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qzXv28eUnRX8WeYCvZqk"
Date: Mon, 06 Sep 2010 17:16:52 +0200
Message-ID: <1283786212.28657.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-qzXv28eUnRX8WeYCvZqk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 06-09-2010 a las 16:15 +0100, Bastien Nocera escribi=C3=B3:
> On Mon, 2010-09-06 at 17:12 +0200, Pacho Ramos wrote:
> > El lun, 06-09-2010 a las 15:47 +0100, Bastien Nocera escribi=C3=B3:
> > > Heya,
> > >=20
> > > We've been carrying a similar (but hard-coded) patch in Fedora for a
> > > long while, and it would be nice if we could do this properly upstrea=
m
> > > instead.
> > >=20
> > > Patch attached with explanations.
> > >=20
> > > Cheers
> >=20
> > What is the proper package to ship oui.txt file? Thanks a lot for the
> > information :-)
>=20
> No idea. In Fedora we ship it in hwdata. No idea where it lives for
> Debian-based distributions, or others.
>=20

OK, thanks, I asked it because under Gentoo no package is currently
providing it and a user suggested to supply it with bluez... but I
haven't made any decision about this yet

--=-qzXv28eUnRX8WeYCvZqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyFBeQACgkQCaWpQKGI+9RhSQCfT38xDOAxyc7aQeLJ8ri++2Qv
oNgAn0YyJYEw0SXvdyqn/6hf91WyY1vx
=5D1P
-----END PGP SIGNATURE-----

--=-qzXv28eUnRX8WeYCvZqk--

