Return-Path: <cyrus@holtmann.org>
Message-ID: <4F204BDC.1010007@babioch.de>
Date: Wed, 25 Jan 2012 19:37:16 +0100
From: Karol Babioch <karol@babioch.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Changed default configuration in bluez 4.97 and higher?
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D0E6C7A47AA607E57D69373"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D0E6C7A47AA607E57D69373
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm wondering whether there has been made any change to the default
configuration of bluez 4.97 and/or 4.98? I've looked at the changelog,
but combined with the release notes it looks to me as they were "simple"
bug fixing releases. At least there is no mention of a change of the
default configuration or something like that.

However I'm experiencing trouble with these releases using my bluetooth
headset (A2DP). To be honest I'm using gnome-bluetooth and not that
experienced with the command line tools, but starting with 4.97 it is no
longer possible to use my headset as an audio output device, although it
is possible to discover it and to connect to it. But after the
connection has been established it doesn't even get recognized by
PulseAudio.

I now got it working again by adding "Enable=3DSocket" in the audio.conf
file. However I'm not sure whether this was changed intentional, because
it worked out-of-the-box beforehand and I guess a basic A2DP setup is
supposed to do so.

There are at least two other guys affected by this, see [1]. So before
filing a bug in the bug tracking system of my distribution and asking
for inclusion of the above option, I would like to know why this was
changed and whether this is intentional or not.

[1]
https://mailman.archlinux.org/pipermail/arch-general/2012-January/024386.=
html

Best regards,
Karol Babioch


--------------enig9D0E6C7A47AA607E57D69373
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPIEvdAAoJEHSaZc1HnzIVMkEP/21sSX/bU1pCPozWKLNZ9ln1
qTLuXcVHwXXBx+7hupC0jcEICz8WMncIBiFMZU3XyCUZkF5beGGG84jIO1wKUpNp
ggrvNcKPZQwErMmN8BwG/Z4x3uFTMRiuw6a/aeennJjY0xygHhw4Ob2JXaxtC6p1
ac2KVeEn6MQ+maqyb69lE+Ss4UxGYCgljwj3cVK1AOoFH/iYqoYnO+wNWJ9Mh7iN
FG1FU+W7i+nnkvTe+YIl2L2mpi0oNcqB+lTLv5pHgTVnQzAW2aR6N1EJ5FsV6oJt
TjQz1jHMS7IqSh/7UTHAowmyd6fZjyePd6DWWTDZoH+RTfY49ffDBR1k1omPXSVQ
f5i32sGv8Fdv/cz5Usw2FFTctsyZnchyE3mYxmbRL7TFE7BTHyI90/7VZTq5FL3c
R8KLS8OyfKp/SRL5RsxLPH8Lk3c47EoYNX4XsoJK2pcM7RAcKDLAKIDGYpnV1uGI
V7TYIgVjln18fIfWeuFhrlotsKkzS/ITWn1UQqAM/U6tIxEcW6v5bC4UA3peyRVp
Qwrc7E1jgja50LGnHMr2B0q5kSy0OYy8gDw0j22ZrsOMp1kG94f8IGa1f322GD7J
LErkctJm2g2hBm4mhpms2SyYG7nf2O9ckrGDt2/z6DTeBm3JuXbk8GA08D+folig
di9/wq7z+X6bJcRer/S5
=1Ibp
-----END PGP SIGNATURE-----

--------------enig9D0E6C7A47AA607E57D69373--
