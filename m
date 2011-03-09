Return-Path: <cyrus@holtmann.org>
Message-ID: <4D776D93.1050400@gmail.com>
Date: Wed, 09 Mar 2011 17:37:47 +0530
From: Malar <malarkannan.p@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth-hid2hci.rules no longer works
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7AB1F6E33E6A1F21F1E2C3C1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7AB1F6E33E6A1F21F1E2C3C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,
    the udev rules under scripts/bluetooth-hid2hci.rules uses -v and
-p parameters which are no longer supported by the hid2hci in udev.
Instead it uses --devpath parameter.
Please fix these rules as they fail to switch the mode of the
bluetooth device.

regards,
Malar



--------------enig7AB1F6E33E6A1F21F1E2C3C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNd22TAAoJEL10URRJl/EVo/wIAJi5OmGbtA7ODuwsm0Cr75W5
xiwdTCmbiD8vNYL/liMwEkd4iwE/FsYFGPEeR+YgY8s/ShjAKPnBCYHiFFvPRKeG
YAMwBv7WETPOdi62167Ze8vRa6PjjFbjVi5G5K0Xp+9txUxRtTRW+BFAk0GjUemD
+K2GJuQrj7NHbDFCe7uN51zp3Xb7ZioWIH8K135mXo/RYPdESqDqCv+vRFQi1UQ/
G18YIU8WADIh0PGOGPOvSRpGgTB86LUPJyHkpi2mOoYnnS2SwvT7LpoRdM2cBsjR
dLR4y6+NqnjoOqA+IiCxqikA1Pil+a5JcF4tkltuXDmZnIARnT8I4mvKqogMqvY=
=lPgz
-----END PGP SIGNATURE-----

--------------enig7AB1F6E33E6A1F21F1E2C3C1--
