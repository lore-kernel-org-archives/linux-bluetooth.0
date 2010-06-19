Return-Path: <cyrus@holtmann.org>
Subject: Re: Users need to manually run "hid2hci --method dell -v 413c -p
 8158 --mode hci" even when udev rule is installed
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1272134552.7585.9.camel@localhost.localdomain>
References: <1272134552.7585.9.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6+87IoRFMuaK9XVAz/ma"
Date: Sat, 19 Jun 2010 17:05:45 +0200
Message-ID: <1276959945.16187.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-6+87IoRFMuaK9XVAz/ma
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 24-04-2010 a las 20:42 +0200, Pacho Ramos escribi=C3=B3:
> Hello
>=20
> I would like to ask for help to try to find where could be the problem
> causing this:
> http://bugs.gentoo.org/show_bug.cgi?id=3D315749
>=20
> Reporter seems to need to manually run:
> hid2hci --method dell -v 413c -p 8158 --mode hci
>=20
> to get bluetooth switched to hci mode.
>=20
> I don't understand why he needs to run it since involved udev rule file
> seems to be properly installed.
>=20
> Could anybody help us on this please?
>=20
> Thanks a lot

This is still affecting to some users, can anybody help us? At least,
how could we check if udev is, at least, trying to execute hid2hci from
97-bluetooth-hid2hci.rules file?

Thanks

--=-6+87IoRFMuaK9XVAz/ma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwc3MkACgkQCaWpQKGI+9SMggCdEDs+exHRlLkyjQFxTRTODa4M
bnwAniCfl4ivUJlG1jEhf+tYjyQDBaI9
=8pG0
-----END PGP SIGNATURE-----

--=-6+87IoRFMuaK9XVAz/ma--

