Return-Path: <cyrus@holtmann.org>
Message-ID: <4A11A51A.7030109@dell.com>
Date: Mon, 18 May 2009 13:12:42 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Reinstitute usb_detach_kernel_driver_np, but in the proper
 place.
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE42B5113B3F860870A3FD1D"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE42B5113B3F860870A3FD1D
Content-Type: multipart/mixed;
 boundary="------------080304060609050805020802"

This is a multi-part message in MIME format.
--------------080304060609050805020802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Testing a little more, I found that on fresh boots the latest bluez.git
doesn't always work to switch dell BT adapters to HCI mode depending on
the state of the killswitch on boot.  Whenever running hid2hci, the
kernel driver should attempt to be released.  As long as this is done
before trying to claim, each of the scenarios is successful.  The
previous dmesg errors were coming up because the order of the
usb_claim_interface and usb_detach_kernel_driver_np were reversed.

The commit message should be shortened this time too, sorry about that
before.

---
=46rom 3e40fbd035b35613c8d1ad3f0aa11a639f487600 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Mon, 18 May 2009 13:07:40 -0500
Subject: [PATCH] Reinstitute usb_detach_kernel_driver_np, but in the
proper place.
 The kernel might still be grab the usb device, so release it before clai=
m.

---
 tools/hid2hci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------080304060609050805020802
Content-Type: text/x-patch;
 name="0001-Reinstitute-usb_detach_kernel_driver_np-but-in-the.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Reinstitute-usb_detach_kernel_driver_np-but-in-the.patc";
 filename*1="h"

=46rom 3e40fbd035b35613c8d1ad3f0aa11a639f487600 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Mon, 18 May 2009 13:07:40 -0500
Subject: [PATCH] Reinstitute usb_detach_kernel_driver_np, but in the prop=
er place.
 The kernel might still be grab the usb device, so release it before clai=
m.

---
 tools/hid2hci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index d5c8d32..c5b6558 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -223,6 +223,10 @@ static int switch_dell(struct device_info *devinfo)
=20
 	handle =3D usb_open(devinfo->dev);
=20
+	/* Don't need to check return, as might not be in use */
+	if (handle)
+		usb_detach_kernel_driver_np(handle, 0);
+
 	if (handle && usb_claim_interface(handle,0) =3D=3D 0)
 		err =3D usb_control_msg(handle,
 			USB_ENDPOINT_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
--=20
1.6.0.4


--------------080304060609050805020802--

--------------enigDE42B5113B3F860870A3FD1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoRpRoACgkQ2CrZjkA73YvYKgCfb6oRs5Of00QwCqPVGMtA8lNH
gbMAoJ0PkDPVt170zC4pIKdMxnVrEqg5
=vhte
-----END PGP SIGNATURE-----

--------------enigDE42B5113B3F860870A3FD1D--
