Return-Path: <cyrus@holtmann.org>
Message-ID: <4A5CAD92.3000607@dell.com>
Date: Tue, 14 Jul 2009 11:08:50 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothd not starting at boot with udev
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig78711B74F870BC623A7C8663"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78711B74F870BC623A7C8663
Content-Type: multipart/mixed;
 boundary="------------080903080207000708000108"

This is a multi-part message in MIME format.
--------------080903080207000708000108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien

Bastien Nocera wrote:
> On Mon, 2009-07-13 at 18:07 -0500, Mario Limonciello wrote:
>  =20
>
> Which is why you need to retry the failed rules later on.
>  =20
OK, good to know that my suspicions were correct.
>  =20
>
> You need to call with the --retry-failed, after the basics of the syste=
m
> have been brought up. This means starting up D-Bus, mounting network
> filesystems, etc.
>  =20
Unfortunately, this makes no difference.  It appears that the previous
invocation of the rules is not registering as a failure.  If I remove my
extra trigger call on the bluetooth subsystem and run:

$ udevadm trigger --type=3Dfailed --verbose --dry-run
(or --retry-failed, they follow the same code path)

No devices are printed, and nothing happens.

Regards

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------080903080207000708000108
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC45IChH
TlUvTGludXgpCkNvbW1lbnQ6IFVzaW5nIEdudVBHIHdpdGggTW96aWxsYSAtIGh0dHA6Ly9l
bmlnbWFpbC5tb3pkZXYub3JnCgppRVlFQVJFQ0FBWUZBa3BjcldnQUNna1EyQ3JaamtBNzNZ
dVJtd0NlUHN1dlpMcUpmVGowUTQzZ0VMdUREZU1MClhuUUFuMEVGUHZnYStSelF6NmthNWxr
RmpGaFdwZDJpCj01OHJ4Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoK
--------------080903080207000708000108--

--------------enig78711B74F870BC623A7C8663
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpcrZIACgkQ2CrZjkA73Yuj9wCeMcQQsB4fvfip+H3HVXMYHTYw
DBwAn3tGoNCISA/2T6e/W+nEPRspKIf4
=xbPL
-----END PGP SIGNATURE-----

--------------enig78711B74F870BC623A7C8663--
