Return-Path: <jerome.stadelmann@hta-bi.bfh.ch>
From: =?iso-8859-1?Q?J=E9r=F4me_Stadelmann?= <jerome.stadelmann@hta-bi.bfh.ch>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <bluez-devel@lists.sourceforge.net>
Subject: RE : [Bluez-devel] Audio to headset
Date: Wed, 21 Jan 2004 15:22:20 +0100
Message-ID: <001201c3e029$fb43c770$2d105793@N64101>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1074688985.7088.67.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>


Hi Marcel,

I have used hsplay with the same result.
My kernel version is 2.4.21 from a SuSe distribution.
I'll then use your kernel patch.

Regards,

Jerome

-----Message d'origine-----
De=A0: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Envoy=E9=A0: mercredi, 21. janvier 2004 13:43
=C0=A0: J=E9r=F4me Stadelmann
Cc=A0: BlueZ Mailing List
Objet=A0: Re: [Bluez-devel] Audio to headset

Hi Jerome,

> I'm actually working on a diploma project with bluetooth and audio. I =
have
> an Anycom Bluetooth USB adapter and an Ericsson HBH-15 headset. I =
would
use
> first the hstest example in order to send some music to the headset =
but it
> doesn't work. I only hear some noise but no music.
>=20
> Is this command correct ? "hstest play music.mp3 xx:xx:xx:xx:xx:xx"

why don't you try hsplay?

> I have mpg123 and sox installed,
> scoinfo return PSKEY_HOSTIO_MAP_SCO_PCM: 0x00,
> voice setting is 0x0060.
>=20
> The pin works and I receive back from the headset the AT commands
(AT+VGS=3D11
> and AT+CKPD=3D200) but I only hear some noise.
>=20
> Could somebody please help me in this?

What kernel version are you using? Try one of my latest patches for 2.4.

Regards

Marcel
