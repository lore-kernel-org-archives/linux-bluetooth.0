Return-Path: <cyrus@holtmann.org>
Subject: Re: Reaching out again for serious bug in sixaxis plugin
To: simon@mungewell.org, Bastien Nocera <hadess@hadess.net>
References: <55A4BA19.6030109@gmail.com>
 <1436873556.20249.50.camel@hadess.net>
 <a59e2e07885f3ee4bcb02cf370b3ff4c.squirrel@mungewell.org>
From: Sergey Kondakov <virtuousfox@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Antonio Ospite <ospite@studenti.unina.it>,
	Szymon Janc <szymon.janc@gmail.com>
Message-ID: <55A5733E.3020207@gmail.com>
Date: Wed, 15 Jul 2015 01:38:22 +0500
MIME-Version: 1.0
In-Reply-To: <a59e2e07885f3ee4bcb02cf370b3ff4c.squirrel@mungewell.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q721RBOX0T8TjSVsCm88RJGeOdbJ1grML"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q721RBOX0T8TjSVsCm88RJGeOdbJ1grML
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.07.2015 21:54, simon@mungewell.org wrote:
>=20
> As the original poster stated that this DOES NOT occur with a USB
> connection, it does kind of point to a Bluetooth problem (or maybe with=

> device itself). Has anyone been able to replicate?

Indeed. And don't forget that it doesn't occur under Windows either. Or
at least I wasn't able to detect such. The BT dongle used is of quite
questionable quality and DS3 itself is quite old. But no direct signs of
malfunction on their part. And if it's software issue someone should
have stumbled upon it already. So it's quite mysterious.

> My suggestion would be to display/capture the hidraw interface and see =
if
> the missing data is present there. This can be done as root with
> --
> $ hexdump -v -e '49/1 "%02x " "\n"' < /dev/hidraw0
> --
>=20
> The '49' is the byte count, and might be wrong (working from memory).

Now that's the real answer !
I tried that and seen this one odd line in the middle about the time
that stick axises have spiked with bogus values:
01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 ea 01 90 01 e6 0=
1
01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 e9 01 90 01 e7 0=
1
01 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 e9 01 8f 01 e7 0=
1
01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 ea 01 90 01 e6 0=
1

No idea what that means.

>=20
> The multi-touch/many-axis stuff is a pain, but the linux-input list is =
the
> place to discuss that...
> Simon

Yeah, probably. I thought maybe BT stack has some special input handling
for BT input devices.

On 14.07.2015 16:32, Bastien Nocera wrote:
> ...
> Did you re-read your original mail? Are you genuinely still wondering
> why you didn't receive an answer?

I'm not your psychologist, girlfriend or a telepath for figuring out
what magic words are to your liking. I gave pretty detailed description
with all the tech info available. Which you still managed to miss twice,
as was pointed above.
So seeing your behaviour I'm not wondering anymore but advising to read
things at least once. Or get a bug tracker.



--q721RBOX0T8TjSVsCm88RJGeOdbJ1grML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlWlcz4ACgkQrPLi+0dgLoYekgD9E+lhrh/qjZTQf6sNP8AaD6Ry
MWAbehvc+d7Lzdw6PxcA/2IabQSpNTTT3WkToBzMZohTrNXP9f20hptC16ln+3d4
=4206
-----END PGP SIGNATURE-----

--q721RBOX0T8TjSVsCm88RJGeOdbJ1grML--
