Return-Path: <cyrus@holtmann.org>
Message-ID: <4942A74E.2020409@tommie-lie.de>
Date: Fri, 12 Dec 2008 19:02:54 +0100
From: Thomas Liebetraut <thomas@tommie-lie.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: How to set link policy with Logitech diNovo dongle
References: <493D7110.1020508@tommie-lie.de>	 <1228765907.28839.95.camel@violet.holtmann.net>	 <493D9EA5.5000101@tommie-lie.de>	 <1229046523.22285.25.camel@violet.holtmann.net>	 <49429EDF.4050900@tommie-lie.de> <1229104138.22285.113.camel@violet.holtmann.net>
In-Reply-To: <1229104138.22285.113.camel@violet.holtmann.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig37FFA83809C9B24FACA6C9A8"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37FFA83809C9B24FACA6C9A8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann schrieb:
> this is a really old dongle.
Don't know exactly, about 4 years I guess. It's from the first DiNovo
Media Desktop (neither Laser nor 2.0).

> Check hciconfig hci0 revision (as root) if
> it is either a BlueCore01 or BlueCore02.
| thomas@Majestix:~$ sudo hciconfig hci0 revision
| hci0:   Type: USB
|         BD Address: 00:07:61:19:49:79 ACL MTU: 192:8 SCO MTU: 64:8
|         Build 846
|         Chip version: BlueCore02-External
|         Max key size: 56 bit
|         SCO mapping:  HCI

> No idea why the Default Link Policy commands is not implemented here.
> That is really strange.
Isn't there some other way to get smooth communication with my MX900?
After all, the Bluetooth Travel Mouse works fine with the exact same
dongle after just reconnecting it.

Regards,
Thomas


--------------enig37FFA83809C9B24FACA6C9A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklCp04ACgkQxVmZpTAq4IhdbQCfSXy9W39a/lxiXz3dyf9L4MEf
gy8AnRw+Mp/QqxXKFL8BDFWdQAKLjclA
=uORD
-----END PGP SIGNATURE-----

--------------enig37FFA83809C9B24FACA6C9A8--
