Return-Path: <cyrus@holtmann.org>
Subject: bluez-5.0 dropped --with-ouifile=PATH
From: Pacho Ramos <pacho@gentoo.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SSIspPm2oAr4DCXI4/zl"
Date: Sun, 30 Dec 2012 15:35:36 +0100
Message-ID: <1356878136.18481.1.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-SSIspPm2oAr4DCXI4/zl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That option is needed on Gentoo to let it catch oui.txt file present
on /usr/share/misc/oui.txt, could it be re-added to prevent us from
needing to sed src/oui.c looking for that file in our location?

Thanks a lot

--=-SSIspPm2oAr4DCXI4/zl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlDgUTgACgkQCaWpQKGI+9QiQACghJ3XHfcRaqQqIsk1A3aWKQ5r
IhEAn3aePkFYvwHYahzV0JwTeea43HD3
=mx+e
-----END PGP SIGNATURE-----

--=-SSIspPm2oAr4DCXI4/zl--

