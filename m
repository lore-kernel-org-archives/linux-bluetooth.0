Return-Path: <cyrus@holtmann.org>
Subject: RE: headset target seems to be playing but no sound
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD12CDF72D40@EXMBXSD.dm.solekai.com>
References: <8396c2281001242007n5ae20eccj53d496f1297e5d22@mail.gmail.com>
	 <8396c2281001242013y1246bcaaq73ad85ff82f57cab@mail.gmail.com>
	 <1264393316.22989.862.camel@pc.interlinx.bc.ca>
	 <20100125192334.6725779d@atom.pigiron.org>
	 <8396c2281001261928r31d2a5a9w6e4a2a3b5b96221e@mail.gmail.com>
	 <20100128215042.4cfc0eb1@atom.pigiron.org>
	 <1264796636.26570.612.camel@pc.interlinx.bc.ca>
	 <FE57175CCE23E5419899C1B0CFA26FAD12CDF72D40@EXMBXSD.dm.solekai.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-v23miXUhis86NqSeLGC9"
Date: Fri, 29 Jan 2010 17:03:20 -0500
Message-ID: <1264802600.26570.717.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-v23miXUhis86NqSeLGC9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-01-29 at 13:42 -0800, Gunn, Brian wrote:=20
>=20
> Don't know if this will help you guys or not, but I get garbled audio unl=
ess I specify a 48 byte buffer.

Sadly, no, this does not help.  :-(

> Here's the command I use to send audio to headsets:
>=20
> aplay -D bluetooth -f S16_LE --buffer-size=3D48 test.wav
>=20
> For me though, without the "--buffer-size=3D48", I get audio; it's just r=
eally garbled.

I've never got garbled.  Just always get the beep before and after the
audio is supposed to be playing.

b.


--=-v23miXUhis86NqSeLGC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktjWyQACgkQl3EQlGLyuXCBHACfW/bBpu7IBMtXDiCAoiA8ntuS
KNMAoOGxm2hVZykaw2V+XRlWfaRycYuv
=qvUR
-----END PGP SIGNATURE-----

--=-v23miXUhis86NqSeLGC9--

