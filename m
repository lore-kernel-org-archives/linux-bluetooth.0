Return-Path: <cyrus@holtmann.org>
Message-ID: <4D760E47.4000006@interlinx.bc.ca>
Date: Tue, 08 Mar 2011 06:08:55 -0500
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: Andrei Warkentin
	<public-andreiw-3WKxDLwmzFNWk0Htik3J/w@plane.gmane.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTikbv=9T3t_Y6LO4faqC5k1X_usWYH8ghmt8TGHV@mail.gmail.com>
In-Reply-To: <AANLkTikbv=9T3t_Y6LO4faqC5k1X_usWYH8ghmt8TGHV@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F18A71862CCA88AF871513A"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F18A71862CCA88AF871513A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-07 05:57 PM, Andrei Warkentin wrote:
>=20
> What do you get for hcitool info 00:1F:20:0F:30:6A?

$ hcitool info 00:1F:20:0F:30:6A
Requesting information ...
	BD Address:  00:1F:20:0F:30:6A
	Device Name: Bluetooth Laser Travel Mouse
	LMP Version: 2.0 (0x3) LMP Subversion: 0x229
	Manufacturer: Broadcom Corporation (15)
	Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
		<encryption> <slot offset> <timing accuracy> <role switch>
		<sniff mode> <RSSI> <power control> <enhanced iscan>
		<interlaced iscan> <interlaced pscan> <AFH cap. slave>

Cheers,
b.






--------------enig8F18A71862CCA88AF871513A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk12DkcACgkQl3EQlGLyuXC6wACggkoZQlqUK1oXoqbiEeYF90cP
b/0AoN63KA4Ky4mRlN8fr5i+FBR9TPcC
=sce6
-----END PGP SIGNATURE-----

--------------enig8F18A71862CCA88AF871513A--
