Return-Path: <cyrus@holtmann.org>
Subject: bluetooth.h: fix compile issue when using in C++
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-E2I/vEUvr367tFiK+v5U"
Date: Sun, 29 Jul 2012 09:52:34 +0200
Message-ID: <1343548354.25518.1.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-E2I/vEUvr367tFiK+v5U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

Today I got a report downstream showing that old problem:
http://permalink.gmane.org/gmane.linux.bluez.kernel/22306

is still not fixed.=20

Could you please commit debian patch to fix this?
http://patch-tracker.debian.org/patch/series/view/bluez/4.101-1/09_fix_ftbf=
s_with_c99.patch

Thanks  a lot

--=-E2I/vEUvr367tFiK+v5U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlAU68IACgkQCaWpQKGI+9QD+wCdFHGjnLybNbJ/f1bytejJXWHo
1HMAnitw2BkYoJJsK3XKYLSJE/qgC/em
=FpX5
-----END PGP SIGNATURE-----

--=-E2I/vEUvr367tFiK+v5U--

