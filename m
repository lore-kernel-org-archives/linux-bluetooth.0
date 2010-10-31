Return-Path: <cyrus@holtmann.org>
Subject: Re: >net-wireless/bluez-4.63 unable to connect audio streams due
 commit
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1287426290.6820.1.camel@localhost.localdomain>
References: <1287426290.6820.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-smxwXs/sFo2kEE+m1skJ"
Date: Sun, 31 Oct 2010 12:25:58 +0100
Message-ID: <1288524358.2654.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-smxwXs/sFo2kEE+m1skJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 18-10-2010 a las 20:24 +0200, Pacho Ramos escribi=C3=B3:
> El lun, 04-10-2010 a las 14:35 +0200, Uwe Kleine-K=C3=B6nig escribi=C3=B3=
:
> > Hello Pacho,
> >=20
> > On Mon, Oct 04, 2010 at 12:25:46PM +0200, Pacho Ramos wrote:
> > > > I would say this was because of double authentication request, but =
it
> > > > seems it is not the case, actually ssp doesn't seems to be used at =
all
> > > > here so this must be something else, maybe you should try this:
> > > >=20
> > > > http://thread.gmane.org/gmane.linux.bluez.kernel/7256
> > > >=20
> > >=20
> > > Thanks but, how should I try to apply that patch? Looks like
> > > net/bluetooth/rfcomm/core.c is not present on bluez-4.72 sources
> > I guess this is a patch to apply to your kernel, not bluez.
> >=20
> > Best regards
> > Uwe
> >=20
>=20
> Downstream affected reported told me it's still failing even with the
> patch:
>=20
> http://bugs.gentoo.org/show_bug.cgi?id=3D327705#c19
>=20
> Attached is the new hcidump output
>=20
> Thanks a lot for your help :-)
>=20

There is no possible solution to this? :-(

Thanks

--=-smxwXs/sFo2kEE+m1skJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkzNUkYACgkQCaWpQKGI+9QnDwCfcWbWUN/973a0eJK1AKRL4IJd
FAwAnA8f8XyYtTXRyvdh/JherThtusQd
=8N1y
-----END PGP SIGNATURE-----

--=-smxwXs/sFo2kEE+m1skJ--

