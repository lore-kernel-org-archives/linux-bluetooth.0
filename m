Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DC542.80206@dell.com>
Date: Fri, 15 May 2009 14:40:50 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 3/3] Update manpage for hid2hci tool from previous patches
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig566C103F98BFAFF6292AAE3B"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig566C103F98BFAFF6292AAE3B
Content-Type: multipart/mixed;
 boundary="------------070507020102000809050001"

This is a multi-part message in MIME format.
--------------070507020102000809050001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This brings the manpage up to the current supported options of hid2hci
from the previous set of patches submitted.

---
 tools/hid2hci.8 |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

Patch is attached to prevent Exchange mangling.

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------070507020102000809050001
Content-Type: text/x-patch;
 name="0001-Update-manpage-for-hid2hci-tool-from-previous-patche.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Update-manpage-for-hid2hci-tool-from-previous-patche.pa";
 filename*1="tch"

=46rom a2f4cd4abb3b7d928c36823bcbfd64e89c3da610 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 14:38:50 -0500
Subject: [PATCH] Update manpage for hid2hci tool from previous patches

---
 tools/hid2hci.8 |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/hid2hci.8 b/tools/hid2hci.8
index 6aa9be2..4181314 100644
--- a/tools/hid2hci.8
+++ b/tools/hid2hci.8
@@ -14,7 +14,7 @@
 .\"	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 .\"
 .\"
-.TH HID2HCI 8 "JUNE 6, 2003" "" ""
+.TH HID2HCI 8 "MAY 15, 2009" "" ""
=20
 .SH NAME
 hid2hci \- Bluetooth HID to HCI mode switching utility
@@ -25,7 +25,7 @@ hid2hci \- Bluetooth HID to HCI mode switching utility
 ]
 .SH DESCRIPTION
 .B hid2hci
-is used to set up switch HID proxy Bluetooth dongle into the HCI
+is used to set up switch supported bluetooth devices into the HCI
 mode and back.
 .SH OPTIONS
 .TP
@@ -35,11 +35,17 @@ Gives a list of possible options.
 .BI -q
 Don't display any messages.
 .TP
-.BI -0
-Switches the device into HCI mode.
+.BI -r [hid,hci]
+Sets the radio mode to switch into
 .TP
-.BI -1
-Switches the device into HID mode.
+.BI -v
+Specifies the 4 digit vendor ID assigned to the device being switched
+.TP
+.BI -p
+Specifies the 4 digit product ID assigned to the device being switched
+.TP
+.BI -m [hidproxy, logitech, dell]
+Which vendor method to use for switching the device.
 .SH AUTHOR
 Written by Marcel Holtmann <marcel@holtmann.org>.
 .br
--=20
1.6.0.4


--------------070507020102000809050001--

--------------enig566C103F98BFAFF6292AAE3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoNxUMACgkQ2CrZjkA73YvzKwCcDuPRL2ckJovHywUKc66CnJBn
OFIAnj3VmJv10xCAKhphhArXId6sI8SY
=F1N1
-----END PGP SIGNATURE-----

--------------enig566C103F98BFAFF6292AAE3B--
