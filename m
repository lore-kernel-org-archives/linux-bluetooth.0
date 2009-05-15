Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DC53B.4050304@dell.com>
Date: Fri, 15 May 2009 14:40:43 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 2/3] Add support for switching from HCI->HID mode for Dell
 BT adapters.
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE92CAF705D697BB8128BA68F"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE92CAF705D697BB8128BA68F
Content-Type: multipart/mixed;
 boundary="------------030305080507020200070603"

This is a multi-part message in MIME format.
--------------030305080507020200070603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This allows Dell BT adapters to be able to be switched back to HID mode
(if users desire to do so).

---
 tools/hid2hci.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

Attaching patch to prevent Exchange mangling.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------030305080507020200070603
Content-Type: text/x-patch;
 name="0001-Add-support-for-switching-from-HCI-HID-mode-for-Del.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Add-support-for-switching-from-HCI-HID-mode-for-Del.pat";
 filename*1="ch"

=46rom 216dca63772bc976d8f58b31aa596e53e2bf36a0 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 14:34:15 -0500
Subject: [PATCH] Add support for switching from HCI->HID mode for Dell BT=
 adapters.

---
 tools/hid2hci.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index dace0ea..f57a333 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -208,7 +208,16 @@ static int switch_logitech(struct device_info *devin=
fo)
=20
 static int switch_dell(struct device_info *devinfo)
 {
-	char report[] =3D { 0x7f, 0x13, 0x00, 0x00 };
+	char mode;
+	switch(devinfo->mode) {
+		case HCI:
+			mode =3D 0x13;
+			break;
+		case HID:
+			mode =3D 0x14;
+			break;
+	}
+	char report[] =3D { 0x7f, mode, 0x00, 0x00 };
=20
 	struct usb_dev_handle *handle;
 	int err;
--=20
1.6.0.4



--------------030305080507020200070603--

--------------enigE92CAF705D697BB8128BA68F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoNxTsACgkQ2CrZjkA73YvEYwCfREFkHH9sN8RC1L3htaPYf4kQ
07QAnR5B7LFMKPzZDz3I8eugpMf4FFRW
=rl/A
-----END PGP SIGNATURE-----

--------------enigE92CAF705D697BB8128BA68F--
