Return-Path: <cyrus@holtmann.org>
Subject: Re: obexd-0.22 causes gnome-bluetooth sendto dialog to stop
 closing when operation ends
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <l2r2a9506371004100717p500f6b4o48e8a6d2dfb8f0c5@mail.gmail.com>
References: <l2r2a9506371004100717p500f6b4o48e8a6d2dfb8f0c5@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-L6QQTl1eYcfSf+2UlZ/v"
Date: Sat, 10 Apr 2010 20:38:52 +0200
Message-Id: <1270924732.5646.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-L6QQTl1eYcfSf+2UlZ/v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 10-04-2010 a las 11:17 -0300, Vinicius Gomes escribi=C3=B3:
> Hi Pacho,
>=20
> 2010/4/10 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
> > Hello
> >
> > This is a regression over obexd-0.21. After updating to 0.22,
> > gnome-bluetooth sendto dialog no longer closes when operation finishes,
> > even if file is already properly sent.
> >
>=20
> We noticed this regression as well. Luiz already has a fix for this,
> it was just not integrated yet.
>=20
> In case you want to take a look and perhaps help test it, the fix is here=
[1].
>=20
>=20
> Cheers,

Thanks a lot, I will try to use it as soon as I am able to

Best regards

--=-L6QQTl1eYcfSf+2UlZ/v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkvAxbwACgkQCaWpQKGI+9RehACfc3VKv6mDS8Hc82AZbEbkQCZa
DbgAn1jNkK3Q3mLQtmS1VkxMq3PS5HdR
=Dc2q
-----END PGP SIGNATURE-----

--=-L6QQTl1eYcfSf+2UlZ/v--

