Return-Path: <cyrus@holtmann.org>
Message-ID: <4F2159DC.4090408@babioch.de>
Date: Thu, 26 Jan 2012 14:49:16 +0100
From: Karol Babioch <karol@babioch.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Changed default configuration in bluez 4.97 and higher?
References: <4F204BDC.1010007@babioch.de> <CABBYNZJk+n2Rh4K2J_fc8A_WXjyBwck4qhYcfe6wCmK7vK7t-Q@mail.gmail.com> <4F2145AF.4050401@babioch.de>
In-Reply-To: <4F2145AF.4050401@babioch.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEDFEDDB9D0D060C194526136"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDFEDDB9D0D060C194526136
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 26.01.2012 13:29, schrieb Luiz Augusto von Dentz:
> do you have any logs when Socket is disabled?

Jan 26 14:28:10 localhost bluetoothd[813]: Discovery session
0x7f5a22e73c50 with :1.41 activated
Jan 26 14:28:13 localhost bluetoothd[813]: Stopping discovery
Jan 26 14:28:24 localhost kernel: [  349.752870] input:
00:16:94:0B:XX:XX as /devices/virtual/input/input17
Jan 26 14:28:24 localhost pulseaudio[1072]: [pulseaudio]
module-bluetooth-device.c: Bluetooth audio service not available
Jan 26 14:28:24 localhost pulseaudio[1072]: [pulseaudio]
module-bluetooth-device.c: Service not connected
Jan 26 14:28:24 localhost pulseaudio[1072]: [pulseaudio] module.c:
Failed to load module "module-bluetooth-device" (argument:
"address=3D"00:16:94:0B:XX:XX"
path=3D"/org/bluez/813/hci0/dev_00_16_94_0B_XX_XX""): initialization fail=
ed.

So you were right, it seems that PulseAudio is the culprit here. However
it works with bluez-4.96, although sockets are not enabled explicitly?
So the question stays whether bluez 4.96 uses sockets implicitly, or
whether PulseAudio doesn't work with bluez-4.98.

Best regards,
Karol Babioch





--------------enigEDFEDDB9D0D060C194526136
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPIVncAAoJEHSaZc1HnzIVGOMP/0NCYLvrqwoqraJpZjjSmiXc
QMpSZ3nJ+V8NN633q0sNOXPQEDDtkFNjXfc/BM0IfuRLMNrO9kf7rjl7FQVm96hy
Wl96FDXZDcJXgeiBZzLNgCsjaGEUHZLJsr4hLcXw3ellmsdDFwuoUdVlo2kYDQmR
oYRI7YPk8FcJIKzwLloA0DIgwZYW6bj5IukQWTCnkNH+ov+cT4Te95pGyTTBqR/R
F15BT5XQFN10+aXQh486wW1yDFXvbqK5OL1dj3iobSBaY9AgcsP2ZqYX4acyMky7
yRCjmQeFaZOBCINvksySZ5vUkBuc85x96czXegbmA7cyLRohVyOU5nH2sr5nLtoG
ghj1XJm5hex0YoJA7Dvek9cb/nYggTroH8UBYgm0bS4TihkY7GY2cIQugU+pfRSF
QxW2xu1Q4nbqSUUGj6AOGpEhTnH9YZmZjeoIvKVKMP2lXltSaSY6cMGO6S+h7TZO
Ytc9yiONgCNDAdJFZUCN4mqHSaq3HdqiUM1MjPjH2RR5yQLfgSJo1qew0abrdqpV
2c6KqZhQ3RW3tUzbfxST+94KeJketx5r/ytNXGkHE4YDRzfO62TVc3jiuszK0qrK
Mb1a5Gp3ZxtrodluJeFr0HOv6QJmFwHhthm74zExtCWDGTOkjtn+bT68BJ+v4nnl
5Hz7A+SBYYv60vnOxVoM
=CNJN
-----END PGP SIGNATURE-----

--------------enigEDFEDDB9D0D060C194526136--
