Return-Path: <cyrus@holtmann.org>
Subject: Users need to manually run "hid2hci --method dell -v 413c -p 8158
 --mode hci" even when udev rule is installed
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-xi4FE6jRzZoeIIFdEGd0"
Date: Sat, 24 Apr 2010 20:42:32 +0200
Message-ID: <1272134552.7585.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-xi4FE6jRzZoeIIFdEGd0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

I would like to ask for help to try to find where could be the problem
causing this:
http://bugs.gentoo.org/show_bug.cgi?id=3D315749

Reporter seems to need to manually run:
hid2hci --method dell -v 413c -p 8158 --mode hci

to get bluetooth switched to hci mode.

I don't understand why he needs to run it since involved udev rule file
seems to be properly installed.

Could anybody help us on this please?

Thanks a lot

--=-xi4FE6jRzZoeIIFdEGd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkvTO5gACgkQCaWpQKGI+9QcRQCeLddFIptE/JfKpTnqBRfeKXkj
ctQAnjTu0ETqZuaGWhIYnpcrGMobXq38
=IHry
-----END PGP SIGNATURE-----

--=-xi4FE6jRzZoeIIFdEGd0--

