Return-Path: <cyrus@holtmann.org>
Subject: About udev rule removal
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PKbTlIk1LUa1jHyKwWr0"
Date: Fri, 29 Jun 2012 22:23:25 +0200
Message-ID: <1341001405.2852.4.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-PKbTlIk1LUa1jHyKwWr0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would like to know what distributions not relying on systemd are
supposed to get bluetoothd autostarted now that udev rule was dropped:
http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3D2ea98a6a04371=
0ad4958355b62c682b4767f292e

Looks like we go back from udev rule to manually starting bluetoothd all
the time, even if bluetooth device is not connected? Why are we going
back to old behavior?

Thanks for the info

--=-PKbTlIk1LUa1jHyKwWr0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk/uDr0ACgkQCaWpQKGI+9T+fgCeKnCe1auIRiobvs78fRnwFmsW
GaAAnRBGONoVZ44RSvER0uQ1AP6iS6Kt
=erF2
-----END PGP SIGNATURE-----

--=-PKbTlIk1LUa1jHyKwWr0--

