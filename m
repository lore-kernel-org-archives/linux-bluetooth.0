Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-5.0 dropped --with-ouifile=PATH
From: Pacho Ramos <pacho@gentoo.org>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1356892983.19248.82.camel@aeonflux>
References: <1356878136.18481.1.camel@belkin4>
	 <1356892983.19248.82.camel@aeonflux>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EerukHeGVbGCImTYNQt0"
Date: Sun, 30 Dec 2012 20:58:17 +0100
Message-ID: <1356897497.19380.0.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-EerukHeGVbGCImTYNQt0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 30-12-2012 a las 10:43 -0800, Marcel Holtmann escribi=C3=B3:
> Hi Pacho,
>=20
> > That option is needed on Gentoo to let it catch oui.txt file present
> > on /usr/share/misc/oui.txt, could it be re-added to prevent us from
> > needing to sed src/oui.c looking for that file in our location?
>=20
> or you build against a recent version of udev that comes with hwdb
> support. Then it will actually start using the efficient version of
> reading the OUI values from this file.
>=20
> There is no plan to keep support for oui.txt for very long. It is still
> supported as transition period, but that is about it.
>=20
> Regards
>=20
> Marcel
>=20

And what is replacing oui.txt? udev directly?

--=-EerukHeGVbGCImTYNQt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlDgnNkACgkQCaWpQKGI+9QXfwCghCQqdfXnArNHgwrfBBGu6ghH
QEcAn10U9ePQIJJNh40TNQtgNDK9m7ov
=NkC2
-----END PGP SIGNATURE-----

--=-EerukHeGVbGCImTYNQt0--

