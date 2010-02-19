Return-Path: <cyrus@holtmann.org>
Subject: Re: obexd-0.21: configure doesn't work as expected
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2a9506371002190924p2ff4ff6eq243dc3031ae3b3a7@mail.gmail.com>
References: <2a9506371002190924p2ff4ff6eq243dc3031ae3b3a7@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qAUofjiI/gDMevB5Fr3G"
Date: Fri, 19 Feb 2010 18:40:25 +0100
Message-Id: <1266601225.5249.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-qAUofjiI/gDMevB5Fr3G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 19-02-2010 a las 14:24 -0300, Vinicius Gomes escribi=C3=B3:
>=20
> 2010/2/19 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
> > Ah, then, why is plugins folder being created even if nothing will be
> > installed in it?
> >
>=20
> Nothing is installed right now. But it doesn't mean that nothing will
> ever be ;-)
>
> And if you want to have a custom plugin for some application, you just wr=
ite
> it and install it there, no need to mess with core obexd.
>=20

True, silly me!=20

> >> Thanks for the report, this is a bug. There's a patch for it in my
> >> development tree. Waiting for review.
> >>
> >> But before the next release happens, disabling a plugin is equivalent
> >> to setting its value to dummy, i.e.
> >> --without-phonebook (if it worked ;-) would be the same as
> >> --with-phonebook=3Ddummy.
> >>
> >
> > Great, where could I see your development tree?
> >
>=20
> Sure. Forgot the link, here it is:
> http://git.infradead.org/users/vcgomes/obexd.git (devel branch)
>=20
Great :-D

Thanks and best regards

--=-qAUofjiI/gDMevB5Fr3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt+zQkACgkQCaWpQKGI+9QoAwCfeEK2U2zpWgH5I8mpsPaRgv19
68YAn1FHGDKf+PSR//WZz56kRXPW5VBx
=mIpU
-----END PGP SIGNATURE-----

--=-qAUofjiI/gDMevB5Fr3G--

