Return-Path: <cyrus@holtmann.org>
Message-ID: <48F50EEB.1060802@dell.com>
Date: Tue, 14 Oct 2008 16:28:11 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Quirk for Apple Aluminum Bluetooth  keyboard FN key
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF6FC2DE8482CF3496A135EA4"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6FC2DE8482CF3496A135EA4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch was present in Ubuntu Hardy, but got dropped by accident in
Intrepid and never submitted upstream.  It adds a quirk enabling the FN
key on the Apple Aluminum Bluetooth Wireless Keyboard.


Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>
---
 net/bluetooth/hidp/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 96434d7..fc6e643 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -684,6 +684,8 @@ static const struct {
 } hidp_blacklist[] =3D {
     /* Apple wireless Mighty Mouse */
     { 0x05ac, 0x030c, HID_QUIRK_MIGHTYMOUSE | HID_QUIRK_INVERT_HWHEEL },=

+    /* Apple wireless Bluetooth Keyboard */
+    { 0x05ac, 0x022c, HID_QUIRK_APPLE_HAS_FN },
=20
     { }    /* Terminating entry */
 };
--=20
1.5.4.3


--------------enigF6FC2DE8482CF3496A135EA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj1DusACgkQ2CrZjkA73YuWrgCeJ5njcW0XgFCRBpG10h/sq+Pf
HQkAnRYcwcYDkhjpIFZU/pBLECrBUbKD
=jD3b
-----END PGP SIGNATURE-----

--------------enigF6FC2DE8482CF3496A135EA4--
