Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DE7B8.1030800@dell.com>
Date: Fri, 15 May 2009 17:07:52 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/3] Add support for switching from HCI->HID mode for
 Dell BT adapters.
References: <4A0DC53B.4050304@dell.com> <1242417985.3446.15.camel@localhost.localdomain>
In-Reply-To: <1242417985.3446.15.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3CDF18BF7E348E4E2BFE7B8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3CDF18BF7E348E4E2BFE7B8
Content-Type: multipart/mixed;
 boundary="------------060107030304020507070108"

This is a multi-part message in MIME format.
--------------060107030304020507070108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

Marcel Holtmann wrote:
> Hi Mario,
>
> did you ever tested this patch with --enable-debug compilation? No code=

> before variable declaration. Please fix that.
>
> Regards
>
> Marcel
>  =20
No, I didn't realize I was supposed to test with --enable-debug.  I've
done so now and fixed up this patch.  See attached.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------060107030304020507070108
Content-Type: text/x-patch;
 name="0002-Add-support-for-switching-from-HCI-HID-mode-for-Del.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0002-Add-support-for-switching-from-HCI-HID-mode-for-Del.pat";
 filename*1="ch"

=46rom 424c70338db22122e78e53c767c4224d2c6f2a29 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 16:54:39 -0500
Subject: [PATCH] Add support for switching from HCI->HID mode for Dell BT=
 adapters.
 This allows Dell BT adapters to be able to be switched back to HID
 mode if users desire to do so, such as on shutdown.

---
 tools/hid2hci.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 7692de3..bf03739 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -207,11 +207,20 @@ static int switch_logitech(struct device_info *devi=
nfo)
=20
 static int switch_dell(struct device_info *devinfo)
 {
-	char report[] =3D { 0x7f, 0x13, 0x00, 0x00 };
+	char report[] =3D { 0x7f, 0x00, 0x00, 0x00 };
=20
 	struct usb_dev_handle *handle;
 	int err;
=20
+	switch(devinfo->mode) {
+		case HCI:
+			report[1] =3D 0x13;
+			break;
+		case HID:
+			report[1] =3D 0x14;
+			break;
+	}
+
 	handle =3D usb_open(devinfo->dev);
 	if (handle) {
 		usb_claim_interface(handle, 0);
--=20
1.6.0.4


--------------060107030304020507070108--

--------------enigD3CDF18BF7E348E4E2BFE7B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoN57gACgkQ2CrZjkA73Ys82QCgkIPrfywc2Fha6loOc3sknJsG
BE8An2rziz9T1cCTvsB1X9PkTWw5q+yf
=gDyI
-----END PGP SIGNATURE-----

--------------enigD3CDF18BF7E348E4E2BFE7B8--
