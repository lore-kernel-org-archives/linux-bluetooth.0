Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-hcidump-1.42 fails to build against bluez-4.61
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Seyfried <stefan.seyfried@googlemail.com>,  linux-bluetooth@vger.kernel.org
In-Reply-To: <1267998239.3712.11.camel@localhost.localdomain>
References: <1267998239.3712.11.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qgnDnbFKoiklef6aB47o"
Date: Mon, 08 Mar 2010 14:56:54 +0100
Message-Id: <1268056614.7822.4.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-qgnDnbFKoiklef6aB47o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 07-03-2010 a las 13:43 -0800, Marcel Holtmann escribi=C3=B3:
> Hi Stefan,
>=20
> > > This is for recovering:
> > > http://comments.gmane.org/gmane.linux.bluez.kernel/4619
> > >=20
> > > since more users are getting this problem and I would like to know if
> > > patches provided in that thread can be used and accepted by upstream =
or
> > > they are not good enough.
> >=20
> > In case they only got overlooked, I can of course resend them.
> >=20
> > If they are not good enough, mentioning the problems might be
> > helpful, so that I can do something about it ;)
>=20
> they didn't get overlooked. It was my mistake that I broke hcidump and I
> now put everything back in the library. So 4.62 should fix it. I was
> under the assumption that nothing ever used these symbols, but as it
> seems I was clearly wrong. Sorry about that.
>=20
> Regards
>=20
> Marcel
>=20
>=20

We should then simply wait for bluez-4.62 and, then, no patches would be
needed for bluez-hcidump, not? (or I have missed anything?)

Thanks a lot and best regards :-)

--=-qgnDnbFKoiklef6aB47o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuVAiYACgkQCaWpQKGI+9R82wCdENMF5aG2WRX0ajFt0aGfqit5
YekAnihq/1ylTyFZ3Rgy96jkjKfhT5nv
=tNRc
-----END PGP SIGNATURE-----

--=-qgnDnbFKoiklef6aB47o--
