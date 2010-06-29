Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: SBC encoder/decoder API & errors handling
Date: Tue, 29 Jun 2010 18:45:49 +0000
Cc: Lennart Poettering <lennart@poettering.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3540178.qKSoCX0HWa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201006291845.53998.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart3540178.qKSoCX0HWa
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

When I tried to run some SBC encoder tests a few days ago, I noticed that=20
there is a regression introduced by commit:
http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3Dc43f8bdcc1d52=
7e2d77481a66217771038be3acd

It is caused by the change from 'int' to 'size_t' for the type of variable=
=20
'encoded' in 'sbcenc.c'. After this modification, the check for 'encoded <=
=3D 0'=20
does not catch the case when 'sbc_encode' tries to return a negative number=
 in=20
'encoded' variable. Later we end up calling 'write' function with a negativ=
e=20
size for the data block.

Right now, in the case of error 'sbc_encode' function may either return a=20
negative number as a return value, or return a negative value in 'encoded'=
=20
variable. But this second type of error is apparently not handled by anythi=
ng=20
other than 'sbcenc' tool at the moment.

Any opinions about how to fix it in the best way? Because it is a flaw in t=
he=20
library API, comments from the interested parties are welcome.

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart3540178.qKSoCX0HWa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwqP2EACgkQvyB/CfYEEt55WQCgg7a923raI6G2nMUnSoWavcNr
NtMAni9XdlItO85H6F5zOhsdjY0aE/BV
=Yfhz
-----END PGP SIGNATURE-----

--nextPart3540178.qKSoCX0HWa--
