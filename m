Return-Path: <cyrus@holtmann.org>
Message-ID: <48F63935.9040307@dell.com>
Date: Wed, 15 Oct 2008 13:40:53 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix Apple Wireless keyboard pairing?
References: <1224032783.5268.1418.camel@cookie.hadess.net>
In-Reply-To: <1224032783.5268.1418.camel@cookie.hadess.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDB5F0070613BFA83ABD71EF8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB5F0070613BFA83ABD71EF8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien:

I've got one of these Aluminum BT keyboards, but it's MAC address is
quite different:

00:1B:63:FA:CD:5A Apple Wireless Keyboard

Where did you get your data from indicating that it shared the same
prefix as the mighty mouse?

Regards

Bastien Nocera wrote:
> Heya,
>
> If anyone has an Apple Wireless keyboard to test pairing against. I
> believe the attached patch to be correct. Otherwise Apple keyboards
> (which use the same OUI) will get a PIN of 0000.
>
> Cheers
>  =20

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigDB5F0070613BFA83ABD71EF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj2OTUACgkQ2CrZjkA73YvqIQCgnLelI2FSFfil2Crko2sM1hAi
GY4AnArZCHGL15hkInD82BG+egvwc3p4
=MT32
-----END PGP SIGNATURE-----

--------------enigDB5F0070613BFA83ABD71EF8--
