Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 May 2009 18:49:14 -0500
From: travis+ml-bluetooth@subspacefield.org
To: linux-bluetooth@vger.kernel.org
Subject: Re: how to connect devices with bluetoothd
Message-ID: <20090514234914.GW4918@subspacefield.org>
References: <20090514222952.GV4918@subspacefield.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="25rOlkxR6a4U87uN"
In-Reply-To: <20090514222952.GV4918@subspacefield.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--25rOlkxR6a4U87uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2009 at 05:29:52PM -0500, travis+ml-bluetooth@subspacefield=
=2Eorg wrote:
> I used to use hidd --connect to pair my keyboard/mouse with the
> computer, but that no longer works.

Actually, I just got it to work once.

I ran hcitool scan to get the MAC (?) addresses, then ran hidd --connect MA=
C.

However, after reboot, they were no longer recognized by the computer
and hcitool scan gave an error saying the Inquiry timed out.

Is there any trick I'm missing?
--=20
Obama Nation | My emails do not have attachments; it's a digital signature
that your mail program doesn't understand. | http://www.subpacefield.org/~t=
ravis/=20
If you are a spammer, please email john@subspacefield.org to get blackliste=
d.

--25rOlkxR6a4U87uN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (OpenBSD)

iQIcBAEBAgAGBQJKDK36AAoJEGQVZZEDJt9Hw1kP/iKHDatS34gMK6QKYudCQKYW
XJAXtGrJiIu5AyS19mi1HB6nQ7m72+SkMTwztWF3HFV2TIfRZ1TTAA95bcjZnWR6
2YS9BbpshjBpfGWZzCxHBf0etlcKZUUZ76R29tTXfEV0Dbq1+V9lQVr0GhLS3oYb
eUbMucGlbXdtsfaEhhCn0PTchU4WEAg4b3EXH+k1wQQ61WKbrPoJTjD9bc0b9Ved
UcOO6cpS4VZ5nGCgrLK1tcGxef1VP0W9pugHRURk/kQLMf7f7Ta6E/fldiU0CSt+
Dvjm0Jf036PxVB6WOkV8hBKbuJGttcztJAugDGqup+97yoHzp6Pewx6JGGtBUV8O
gwv5dBshFUO3vTcLwlzrpFmFZ5RwNMVwpvFQ1wU4D8sQ6FAS8PoKcAOLdQH/YpOV
QyfvXJLtF6ukwQFwPvDEew0ter8tlywZTmbV2wxds81wK+D1q3P7Xp6Y8bFMOa+C
0u4OTUlkTqAqqq1ycB6iUyU8Zj4pdARUodVzJ5pecnUriuJYbfKV8ig+CPhl8pTo
h//Ix520ircyq6iIw3KEwx5R80/dPIc5wNn/VC0mCfw30Tx36mp+xNja36SfC0s1
wMC3u3tpMyOj6BjJzU2niHpp3xpAduAi462ExjbAkIEpSqVKSEAKntTZNd/iOg9s
rIljMg3dEHEuVRf7tfl6
=L6us
-----END PGP SIGNATURE-----

--25rOlkxR6a4U87uN--
