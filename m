Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection timeout after interrupted software
Message-ID: <20050209143251.GA15985@cirrus.madduck.net>
References: <20050208143303.GA5194@cirrus.madduck.net> <1107880590.7327.180.camel@pegasus> <20050209014831.GA12067@cirrus.madduck.net> <1107930446.14624.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <1107930446.14624.6.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 9 Feb 2005 15:32:51 +0100


--7iMSBzlTiPOCCT2k
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2005.02.09.0727 +0100]:
> make sure that you activate the rswitch for the link policy.

Yeah, that fixed it. I guess I will now go and read up on why that
would make a difference.

> You can also try to load hci_usb with reset=3D1 if available.

Not needed anymore, and I prefer if I don't have to set it
explicitly.

> What kind of dongle is this? Is it already in my list?

Probably not: it's an El Cheapo dongle from around the corner, an
"Abo UB20". lsusb -vvv output attached.

It works just fine...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
this product is under strict quality contril with perfect packing and
quality when leving the factory.please keep away from damp.high
temperature or sun expose.If found any detectives when purchasing.
please return the productby airmail to our administration section and
inform the time, place.and store of this purchase for our
improvement.We shall give you a satisfactory reply.Thanks for your
patronage and welcome your comments.
                                             -- http://www.engrish.com

--FCuugMFkClbJLl1L
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dongle.lsusb-vvv.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWSXlOKMABkdfgH/eQGF/8D8n34A/7//wUASePI0MBSpVRQ1EZI0GjJpoDQDJ
gENNNA00ZDHMAmAmRgBGJiYTCYIaYmmBzAJgJkYARiYmEwmCGmJpgJqohU8QJNpqNqbTIQ0N
DQDRo0yPUPUCKSYUMmhNpR6GiAANADQBoZGwxAFThLakZcvDltWlZDdEDEoSq76DxrXsHj6h
vXRbNm4X06S+A0q0V0K6FejzRERERBBB7VZg/Q/eo1Yg9KseLXtz6dewtWR4c0gJwgk1LnxZ
q2xUoeYcY4hjHtxiYmkK/eszDtNJFpbbZyLf7+fm2tyLfZAtDApLMr57hW1pwqcxqOBAYMi+
7cbgbhadhjh0fCZtVkSIBhDQt2w4rLsVjTRXqXfqGee2PboNKLkYK3q5K9xfxihIv3Yd3TOc
zGROVIgTLb+C6LQgZK44DnezkI6IoIrypIU1QUNGQGkAnBEJIu7UgugIGEifES5ph0CmGu+4
DJIhchy9QO2tNxznIaqjXXIZZs23UVMd1xcrdbWOOcvsWIJjbSsydqWsMxoDpJEjOtcy+xol
CdFaG+bw41bHEFu1cQBMCZcVN53AHRPt8495mq9u88N39jsMY7dtN2b2dQ9elTap6M8NGR2D
I3mlVwPsM60a8mRinozU73cM7uWrfco1VzGh7B0qu/xbVbHvxaaHhqsVecbHLkeKpuRb/caj
1aanAf3RfdVY/k/Edw7/C3dvKO3pquT1jcbPbY7yrrO6ryb8aH3jRgZowM4GmhpYM5vKZ1HN
VajyWf4MYMYqxiMYIjBX5gyAIAuNoA3hOi8OusR1K0WgteMcLKr/hw/apwwMGIYV7hjXAvjM
Vd7xePxHpuI6v9U1Ogx8nlHJRb8CsIVvAHnWyvUAYLZZ0GgKT3q6g3wviGFOmuOquQnV1nU4
1XwzrtLnW88YQ5VkNgB7FyAMjSAWA1iGyOsAkuGRzrT9r6+UAoAWM6Yr/FbgPQiE0DfFYNFM
pxDSHqoYM4OqnRVwvlQOICiQeNXaFAZ1XtwIMz+4LUDnB80jwJVvSufiqngG/GLAxVOA1rU7
jKqtUUwAMQBkt51gwBoLsIV2DCuFMqubCaYxjgZGv2jNU2HRTMXRVdHLbDTA1qsjjwaUXUYq
vCOKq2PSpyG6aVbzhcVU2quBqdVVt1gbQ0/5YW3McgBlqDDEGnAAorivoV8VekeZVdCrnOcd
iVcY7Kr/xdyRThQkCXlOKMA=

--FCuugMFkClbJLl1L--

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCh8TIgvIgzMMSnURAnU7AKCDm6KfYiPMjUlTbfYGQvllQvLoDQCgnkpJ
gzT5JL3s/t+CacFLphMdUyE=
=6Kja
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
