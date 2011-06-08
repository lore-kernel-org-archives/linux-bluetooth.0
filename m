Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth on ubuntu without desktop environment
From: Michael Jarosch <mitsch@riotmusic.de>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20110607231146.GB8705@piper>
References: <1307131935.1862.189.camel@powermacG4>
	 <20110607231146.GB8705@piper>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/Vi3/pwdUQ1qrwa1Aaqy"
Date: Wed, 08 Jun 2011 16:46:27 +0200
Message-ID: <1307544387.1761.8.camel@powermacG4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-/Vi3/pwdUQ1qrwa1Aaqy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 07.06.2011, 20:11 -0300 schrieb Vinicius Costa Gomes:

> This is what I would do:
>=20
> 1. Get the BlueZ sources, and go to the test/ directory;
>=20
> 2. ./simple-agent hci0 <keyboard address>=20
>    (follow the instructions from the keyboard for pairing, usually puttin=
g the
>    same passkey in both sides). This will pair your computer with the
>    keyboard. If it complains about that the pairing already exists, just =
add a
>    third parameter, it can be anything.
>=20
> 3. ./test-device trusted <keyboard address> yes
>    This will set the device as trusted, so connection comming from it wil=
l
>    be automatically accepted.
>=20
> 4. Now as the device is already bonded and connections are automatically
>    accepted, reconnections should work as they should.

Unbelievable: It's working! Thanks!

Those scripts are part of the ubuntu "bluez"-package with a little
change in naming them: There is always a "bluez-" in front of it.

simple-agent -> bluez-simple-agent
test-device -> bluez-test-device

So no need to download them.
I must confess, I was sceptical at first, because I already tried
bluez-simple-agent without success. I guess I was lucky to have the
right combination of packages installed, now - got to figure out, why it
didn't work last time!

Well, then: I'll spread the word!
Thanks again!

Bye!

--=-/Vi3/pwdUQ1qrwa1Aaqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk3vizwACgkQNFzJVOwishmdwQCfQ+Z0a9381syLn14a22lvMwQs
kfYAoK0Cbu4osbut7Q9XBuDvZQF2CYKP
=6V3x
-----END PGP SIGNATURE-----

--=-/Vi3/pwdUQ1qrwa1Aaqy--

