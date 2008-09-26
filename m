Return-Path: <cyrus@holtmann.org>
Message-ID: <48DD71F3.90002@dell.com>
Date: Fri, 26 Sep 2008 18:36:19 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetoothd crashing on 4.7
References: <48DD699C.9090307@dell.com>
In-Reply-To: <48DD699C.9090307@dell.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1D1161012C29103DC0A548C5"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D1161012C29103DC0A548C5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So that this doesnt' get lost, I solved this myself on IRC.  The
attached patch resolves it.


/src/dbus-hci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff -Nur -x '*.orig' -x '*~' bluez-4.7/src/dbus-hci.c bluez-4.7.new/src/=
dbus-hci.c

--- bluez-4.7/src/dbus-hci.c	2008-09-26 00:39:55.000000000 -0500

+++ bluez-4.7.new/src/dbus-hci.c	2008-09-26 18:22:33.000000000 -0500

@@ -518,7 +518,7 @@

bonding =3D adapter_get_bonding_info(adapter);
- if (bacmp(&bonding->bdaddr, peer))
+ if (bonding && bacmp(&bonding->bdaddr, peer))
bonding =3D NULL;
if (status =3D=3D 0) {

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig1D1161012C29103DC0A548C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFI3XHz2CrZjkA73YsRAqHwAJ9NtkrJyz3YWUyiq/MSGVSsbb1acgCgk/hj
K3qbjCb+sNrVssaKTbmdTjs=
=nU9C
-----END PGP SIGNATURE-----

--------------enig1D1161012C29103DC0A548C5--
