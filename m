Return-Path: <cyrus@holtmann.org>
Message-ID: <490F795B.5090308@dell.com>
Date: Mon, 03 Nov 2008 16:21:15 -0600
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Isa=EDas_Mart=EDnez_Yelmo?= <isaiasmy@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add reset quirk for Dell 365 Bluetooth
References: <200811031947.40187.isaiasmy@gmail.com> 	<200811032158.21654.isaiasmy@gmail.com> <490F6861.5060704@dell.com> <200811032306.41166.isaiasmy@gmail.com>
In-Reply-To: <200811032306.41166.isaiasmy@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig18BA8F5C79059D04A2CE56AC"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18BA8F5C79059D04A2CE56AC
Content-Type: multipart/mixed;
 boundary="------------070003030507070808090508"

This is a multi-part message in MIME format.
--------------070003030507070808090508
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Since Isa=EDas confirmed that the reset quirk is necessary for supporting=

the Dell BT365, here is a patch to add it.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------070003030507070808090508
Content-Type: text/x-patch;
 name="btusb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="btusb.patch"

Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>
--- a/drivers/bluetooth/btusb.c.orig	2008-11-03 16:15:33.000000000 -0600
+++ b/drivers/bluetooth/btusb.c	2008-11-03 16:16:42.000000000 -0600
@@ -125,6 +125,9 @@
 	/* Dell laptop with Broadcom chip */
 	{ USB_DEVICE(0x413c, 0x8126), .driver_info =3D BTUSB_RESET | BTUSB_WRON=
G_SCO_MTU },
=20
+	/* Dell Wireless 365 */
+	{ USB_DEVICE(0x413c, 0x8160), .driver_info =3D BTUSB_RESET },
+
 	/* Dell Wireless 370 */
 	{ USB_DEVICE(0x413c, 0x8156), .driver_info =3D BTUSB_RESET | BTUSB_WRON=
G_SCO_MTU },
=20

--------------070003030507070808090508--

--------------enig18BA8F5C79059D04A2CE56AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkPeVsACgkQ2CrZjkA73YtsVwCeLxbimtHqtCN9WBiddRl135eH
C9UAn1wEBGM9gXIq3Sbrz5Q2f/ImUXOf
=HCpJ
-----END PGP SIGNATURE-----

--------------enig18BA8F5C79059D04A2CE56AC--
