Return-Path: <cyrus@holtmann.org>
Message-ID: <48FD2C78.7050903@dell.com>
Date: Mon, 20 Oct 2008 20:12:24 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Add support for HID->HCI switching on Dell BT365
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF0711579F1F0903534F6C08"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF0711579F1F0903534F6C08
Content-Type: multipart/mixed;
 boundary="------------040304040300010709040900"

This is a multi-part message in MIME format.
--------------040304040300010709040900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:

This patch adds the VID/PID for this adapter which uses the same
methodology for switching modes as the BT370 and BT410.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------040304040300010709040900
Content-Type: text/x-patch;
 name="dell_bt_365.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dell_bt_365.patch"

diff -Nur -x '*.orig' -x '*~' bluez-4.12/tools/hid2hci.c bluez-4.12.new/t=
ools/hid2hci.c
--- bluez-4.12/tools/hid2hci.c	2008-08-05 16:14:56.000000000 -0500
+++ bluez-4.12.new/tools/hid2hci.c	2008-10-20 20:10:40.000000000 -0500
@@ -260,6 +260,7 @@
 	{ HCI, 0x046d, 0xc70e, switch_logitech },	/* Logitech diNovo keyboard *=
/
 	{ HCI, 0x046d, 0xc713, switch_logitech },	/* Logitech diNovo Edge */
 	{ HCI, 0x046d, 0xc714, switch_logitech },	/* Logitech diNovo Edge */
+	{ HCI, 0x413c, 0x8162, switch_dell     },	/* Dell Wireless 365 */
 	{ HCI, 0x413c, 0x8158, switch_dell     },	/* Dell Wireless 370 */
 	{ HCI, 0x413c, 0x8154, switch_dell     },	/* Dell Wireless 410 */
 	{ -1 }

--------------040304040300010709040900--

--------------enigEF0711579F1F0903534F6C08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj9LHgACgkQ2CrZjkA73YvuAQCfRL/HepeR1zR5KlWBg82oHma4
OlEAniBju0epnf/Fw/vcUaOkWOX0w09U
=/aGw
-----END PGP SIGNATURE-----

--------------enigEF0711579F1F0903534F6C08--
