Return-Path: <cyrus@holtmann.org>
Message-ID: <48FF935E.3050705@dell.com>
Date: Wed, 22 Oct 2008 15:55:58 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Add missing IDs for Logitech MX5500
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig59D4A9C739CCBFCAED847B57"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59D4A9C739CCBFCAED847B57
Content-Type: multipart/mixed;
 boundary="------------040801030908030809060606"

This is a multi-part message in MIME format.
--------------040801030908030809060606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

It was reported that the Logitech MX5500 has more IDs than were
previously listed in hid2hci's source.  This patch adds more of those IDs=
=2E

Thanks,
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------040801030908030809060606
Content-Type: text/x-patch;
 name="logitech_5500_ids.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="logitech_5500_ids.patch"

diff -Nur -x '*.orig' -x '*~' bluez-4.12/tools/hid2hci.c bluez-4.12.new/t=
ools/hid2hci.c
--- bluez-4.12/tools/hid2hci.c	2008-10-22 15:54:19.000000000 -0500
+++ bluez-4.12.new/tools/hid2hci.c	2008-10-22 15:55:05.000000000 -0500
@@ -260,6 +260,8 @@
 	{ HCI, 0x046d, 0xc70e, switch_logitech },	/* Logitech diNovo keyboard *=
/
 	{ HCI, 0x046d, 0xc713, switch_logitech },	/* Logitech diNovo Edge */
 	{ HCI, 0x046d, 0xc714, switch_logitech },	/* Logitech diNovo Edge */
+	{ HCI, 0x046d, 0xc71c, switch_logitech },	/* Logitech diNovo Edge */
+	{ HCI, 0x046d, 0xc71b, switch_logitech },	/* Logitech diNovo Edge */
 	{ HCI, 0x413c, 0x8162, switch_dell     },	/* Dell Wireless 365 */
 	{ HCI, 0x413c, 0x8158, switch_dell     },	/* Dell Wireless 370 */
 	{ HCI, 0x413c, 0x8154, switch_dell     },	/* Dell Wireless 410 */

--------------040801030908030809060606--

--------------enig59D4A9C739CCBFCAED847B57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj/k14ACgkQ2CrZjkA73Ys5fwCcDx+EoNfefh1iumSqKMZIZfay
l6YAoI9FYodcsOA3ysBCGRcZzNV/Dyep
=TK+H
-----END PGP SIGNATURE-----

--------------enig59D4A9C739CCBFCAED847B57--
