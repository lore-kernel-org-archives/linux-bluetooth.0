Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DFB63.8060006@dell.com>
Date: Fri, 15 May 2009 18:31:47 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Fix dmesg errors about hid2hci not claiming interface before
 usage.
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig17D180E7A2869366D334DEE4"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17D180E7A2869366D334DEE4
Content-Type: multipart/mixed;
 boundary="------------050001090303050608070509"

This is a multi-part message in MIME format.
--------------050001090303050608070509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

These errors were caused from trying to detach the kernel driver from
 the interface, which was unnecessary.  A simple usb_claim_interface
 is all that is necessary.  It is however, important to ensure the
 interface claim is successful.

---
 tools/hid2hci.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------050001090303050608070509
Content-Type: text/x-patch;
 name="0001-Fix-dmesg-errors-about-hid2hci-not-claiming-interfac.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Fix-dmesg-errors-about-hid2hci-not-claiming-interfac.pa";
 filename*1="tch"

=46rom b10d3ab279a4da6a22c9c1272595e8ef8fc80cd0 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 18:30:27 -0500
Subject: [PATCH] Fix dmesg errors about hid2hci not claiming interface be=
fore usage.
 These errors were caused from trying to detach the kernel driver from
 the interface, which was unnecessary.  A simple usb_claim_interface
 is all that is necessary.  It is however, important to ensure the
 interface claim is successful.

---
 tools/hid2hci.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index bf03739..59bd984 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -222,15 +222,11 @@ static int switch_dell(struct device_info *devinfo)=

 	}
=20
 	handle =3D usb_open(devinfo->dev);
-	if (handle) {
-		usb_claim_interface(handle, 0);
-		usb_detach_kernel_driver_np(handle, 0);
-	}
-
-	err =3D usb_control_msg(handle,
+	if (handle && usb_claim_interface(handle,0) =3D=3D 0)
+		err =3D usb_control_msg(handle,
 			USB_ENDPOINT_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			0x09, 0x7f | (0x03 << 8), 0,
-			report, sizeof(report), 10000);
+			USB_REQ_SET_CONFIGURATION, 0x7f | (0x03 << 8), 0,
+			report, sizeof(report), 5000);
=20
 	if (err =3D=3D 0) {
 		err =3D -1;
--=20
1.6.0.4


--------------050001090303050608070509--

--------------enig17D180E7A2869366D334DEE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoN+2MACgkQ2CrZjkA73YvUSACfURK+a/RJ/rRwAg0p2e1i6Q+f
EtUAn1QyxYhsKEzfEtbD8miXeSa4tqUH
=CvOL
-----END PGP SIGNATURE-----

--------------enig17D180E7A2869366D334DEE4--
