Return-Path: <cyrus@holtmann.org>
Message-ID: <4991F1F9.9080800@dell.com>
Date: Tue, 10 Feb 2009 15:30:33 -0600
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: How to update SDP records
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig010F4020F4174E34836408D2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig010F4020F4174E34836408D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi guys:

I was looking at the Bluez 4.x API and don't see any way for requesting
an updated set of SDP records for a device.  My Blackberry will not
connect advertising that it can receive OBEX transfers at all (the File
Transfer Agent isn't in SDP records).  This is because by default that
mode is turned off on the device.  There is an option to turn it on
momentarily to receive a file, but then it turns back off.

Because of this, it's impossible to pair the device with the SDP record
for File Transfer on it's list.  Is there somewhere in the API that I am
missing that allows you to request an updated set of records for a device=
?

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig010F4020F4174E34836408D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkmR8fkACgkQ2CrZjkA73Yv8NgCfeLKqCiWr1orugana+6qPsn96
4pYAnijr5flxCPIxK3QltXBxEkJMHvve
=Z5rL
-----END PGP SIGNATURE-----

--------------enig010F4020F4174E34836408D2--
