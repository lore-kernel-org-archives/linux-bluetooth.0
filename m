Return-Path: <cyrus@holtmann.org>
Subject: obexd-0.22 causes gnome-bluetooth sendto dialog to stop closing
 when operation ends
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KFXx30xAw/nUYPAFajmp"
Date: Sat, 10 Apr 2010 13:22:26 +0200
Message-Id: <1270898546.5646.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-KFXx30xAw/nUYPAFajmp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello

This is a regression over obexd-0.21. After updating to 0.22,
gnome-bluetooth sendto dialog no longer closes when operation finishes,
even if file is already properly sent.

This has been reported also in:
https://bugzilla.gnome.org/show_bug.cgi?id=3D613196

Thanks a lot for your help

--=-KFXx30xAw/nUYPAFajmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkvAX3IACgkQCaWpQKGI+9Re+QCaAvckRMGC3s7bQT4EOEjRa6su
gfwAn0sJRBJUkWzJuvBkQKEX2XT9BrLy
=3SV0
-----END PGP SIGNATURE-----

--=-KFXx30xAw/nUYPAFajmp--

