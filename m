Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-5.0 dropped --with-ouifile=PATH
From: Pacho Ramos <pacho@gentoo.org>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1356897940.19248.87.camel@aeonflux>
References: <1356878136.18481.1.camel@belkin4>
	 <1356892983.19248.82.camel@aeonflux> <1356897497.19380.0.camel@belkin4>
	 <1356897940.19248.87.camel@aeonflux>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IB3WytsO8izTLOZ9C0hb"
Date: Sun, 30 Dec 2012 21:12:40 +0100
Message-ID: <1356898360.19380.1.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-IB3WytsO8izTLOZ9C0hb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 30-12-2012 a las 12:05 -0800, Marcel Holtmann escribi=C3=B3:
> Hi Pacho,
>=20
> > > > That option is needed on Gentoo to let it catch oui.txt file presen=
t
> > > > on /usr/share/misc/oui.txt, could it be re-added to prevent us from
> > > > needing to sed src/oui.c looking for that file in our location?
> > >=20
> > > or you build against a recent version of udev that comes with hwdb
> > > support. Then it will actually start using the efficient version of
> > > reading the OUI values from this file.
> > >=20
> > > There is no plan to keep support for oui.txt for very long. It is sti=
ll
> > > supported as transition period, but that is about it.
> >
> > And what is replacing oui.txt? udev directly?
>=20
> as I said above, udev's hwdb. Check udevadm hwdb for a command line
> example too. Also src/oui.c is pretty obvious in that regard.
>=20
> Regards
>=20
> Marcel

OK, thanks

--=-IB3WytsO8izTLOZ9C0hb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlDgoDgACgkQCaWpQKGI+9QuWgCdGs5HSmdp5hENSV4cOx/c8ICZ
684An1greHoPsukoxMnHUbSQdp79NaPh
=d5I+
-----END PGP SIGNATURE-----

--=-IB3WytsO8izTLOZ9C0hb--

