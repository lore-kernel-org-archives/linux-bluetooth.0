Return-Path: <cyrus@holtmann.org>
Subject: Re: obexd-0.21: configure doesn't work as expected
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2a9506371002190701o2d46102bpd50f9a95b37a816e@mail.gmail.com>
References: <2a9506371002190701o2d46102bpd50f9a95b37a816e@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-mAVu3ZgWnISeC+uZos9V"
Date: Fri, 19 Feb 2010 16:07:57 +0100
Message-Id: <1266592077.5249.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-mAVu3ZgWnISeC+uZos9V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 19-02-2010 a las 12:01 -0300, Vinicius Gomes escribi=C3=B3:
> > In summary, the same files are being *installed* with
> > --with-phonebook=3Debook and --with-phonebook=3Ddummy (in both cases,
> > phonebook files are not being installed at all). A
> > $PREFIX/lib/obex/plugins directory is created but nothing is installed
> > on it.
> >
>=20
> This is not a bug, it is by design, the phonebook driver is a built-in
> module. In fact, all the plugins
> we have currently are built-in. That's why nothing gets installed in
> the plugins folder.

Ah, then, why is plugins folder being created even if nothing will be
installed in it?

> Thanks for the report, this is a bug. There's a patch for it in my
> development tree. Waiting for review.
>=20
> But before the next release happens, disabling a plugin is equivalent
> to setting its value to dummy, i.e.
> --without-phonebook (if it worked ;-) would be the same as
> --with-phonebook=3Ddummy.
>=20

Great, where could I see your development tree?

Thanks a lot :-)

--=-mAVu3ZgWnISeC+uZos9V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt+qU0ACgkQCaWpQKGI+9T18QCgg5YX2nwVEeMNhd6tD4Fs75np
fS0AnjEAZS/HsLADwWCY+T3YrY1CRev4
=1cF8
-----END PGP SIGNATURE-----

--=-mAVu3ZgWnISeC+uZos9V--

