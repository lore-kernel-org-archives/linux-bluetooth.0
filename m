Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] linux-firmware: Update patch and sysconfig files for
 AR3012.
From: Ben Hutchings <ben@decadent.org.uk>
To: "Li, Steven" <yongli@qca.qualcomm.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Chen, Jack" <skchen@qca.qualcomm.com>,
	"Liu, Haijun" <haijun@qca.qualcomm.com>,
	"Fan, Hong" <hongfan@qca.qualcomm.com>
In-Reply-To: <1309769620-29044-1-git-send-email-Steven.Li@Atheros.com>
References: <1309769620-29044-1-git-send-email-Steven.Li@Atheros.com>
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="=-RKBBDo+hJZWEeOS05tCB"
Date: Tue, 12 Jul 2011 04:50:23 +0100
Message-ID: <1310442623.8783.173.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-RKBBDo+hJZWEeOS05tCB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-07-04 at 08:53 +0000, Li, Steven wrote:
> From: Steven.Li <yongli@qca.qualcomm.com>
>=20
> The new AR3012 keeps same PID/VID after downloading the patch and
> sysconfig files.
[...]

Is this change in behaviour backward-compatible with earlier versions of
the ath3k driver?

Also, please send a fix for the information in the WHENCE file.  The
files are grouped by driver and then licence, so all the AR3012 files
should be listed in the existing section for the ath3k driver and not in
a separate section.

Ben.

--=20
Ben Hutchings
It is easier to write an incorrect program than to understand a correct one=
.

--=-RKBBDo+hJZWEeOS05tCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUAThvEeue/yOyVhhEJAQpUpg/9G55tPk0Tt1DijcBFJ7nFG5adRf5WUa1K
PUvfCWuZQdHwiJO80wmyw13T4EAaQhckXz8W7F1cmpwV1LsHcdQkTIaye/zU5dF0
5SaaQdcaq7graeCk7lG62B69X7v7Yqow7crwSxoeb1S6coqAMnAM1UUCDia9rw3d
sPp/vsgejSpf6sfgN6krbxYFtG15Anm5oV1HsIcm5u+wWQJkwAfuSJDGKT+kEIiY
xQYqCDhq95UG3YY92TMP34wDUbp/AMPvURTy8ZpeynW0xOVFoSYGVL26AqMWclKe
0AoWA7t4ZGVPkhREWC6bKDAHlDh6lqLb8dpK1uUKyBvHz5dT7qyaO1sEdGbJFMWm
biF/WUWPB1Tgb7BderMRmUjmmxxi08nUdKdn8drCXnJmjDG/LzN/1PQuARwjrTH8
0Hy5r0+zxWDTdRWUrdNPoQj/bwJbM1X1os33/nUhI86nQUOvp1RRq20WkJBIjpRA
ZDslTc7WrsfXKD1nSRvxFBWoEdgNlPztEp0KgRo8gguEkTXueUhweEXgkpLLAzsC
YLSrpUytNywE4HY+h62intC7lLyUlWzZbGiVcDkSvu4RZV1bd+ncyetMVZjJtvwg
7nPXt1miZkdKFPJXBFe0cVm5BNoBu7zZX3ZSb4Ygd+BVtWn8fT3TUlk4/qQLiCoF
9BgTjGMWz6A=
=Uyb5
-----END PGP SIGNATURE-----

--=-RKBBDo+hJZWEeOS05tCB--
