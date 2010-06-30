Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: SBC encoder/decoder API & errors handling
Date: Wed, 30 Jun 2010 13:07:45 +0000
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
References: <201006291845.53998.siarhei.siamashka@gmail.com> <AANLkTildwDBZR2U6AtxGEiq4Mv-PBnDoqY1xfqHHmzL2@mail.gmail.com> <20100630085347.GA31839@jh-x301>
In-Reply-To: <20100630085347.GA31839@jh-x301>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6700845.i19tOByk09";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201006301307.49874.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart6700845.i19tOByk09
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 30 June 2010 08:53:47 Johan Hedberg wrote:
> Hi Luiz,
>=20
> On Wed, Jun 30, 2010, Luiz Augusto von Dentz wrote:
> > audio/pcm_bluetooth.c:1060:		encoded =3D sbc_encode(&a2dp->sbc,
> > data->buffer, a2dp->codesize,
> > audio/pcm_bluetooth.c:1096:		encoded =3D sbc_encode(&a2dp->sbc, buff,
> > a2dp->codesize,
>=20
> My patch already contained the fix for these two.
>=20
> > audio/gstsbcenc.c:391:		consumed =3D sbc_encode(&enc->sbc,=20
(gpointer) data,
>=20
> This place actually passes NULL as the output parameter so no issue
> there.

Well, it is still kind of an issue because some types of errors are not=20
detected here at all.

> I'll push in a minute the fix in two separate commits (the libsbc
> changes should be in an independent patch so they can easily be exported
> to external copies like pulseaudio).

Yes, I used exactly the same patch myself and it helped. It's a bit artific=
ial=20
problem and does not need an urgent fix. I found it by running a script whi=
ch=20
uses 'sbcenc' with lots with different permutations of configuration option=
s=20
(some of them are invalid) and logs md5 hashes of the encoded results. But =
as=20
long as the SBC encoder is always used with valid settings, no problems sho=
uld=20
happen.

Anyway, API inconsistency is a bit ugly. Maybe it's better to always report=
=20
errors as a negative function return value (and have real constants defined=
=20
instead of some magic numbers)? Or just adjust encoding settings to the clo=
sest=20
valid configuration automatically and never fail there?


Another SBC issue (I found this report just on the last weekend) is the mis=
sing=20
support for the dynamically changing bitpool value:
https://tango.0pointer.de/pipermail/pulseaudio-discuss/2010-January/006042.=
html

It is a clear problem for the SBC decoder (in addition to the other issues =
like=20
not so good audio quality and poor performance, which would have to be=20
addressed eventually).

But SBC encoder could also make some use of this changing bitpool feature t=
o=20
adaptively change it when connection quality is not very good and audio wou=
ld=20
start skipping otherwise (due to the interference from wifi, walking away f=
rom=20
the bluetooth dongle behind a concrete wall or anything else).

So would it be a good idea to just fix the issues in the bluez SBC code as =
we=20
feel appropriate and then notify pulseaudio developers about the changes?

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart6700845.i19tOByk09
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwrQaUACgkQvyB/CfYEEt5cuACglcrbJ+FzG7ZzbI2/8inZ38O4
V6MAoJOO4U1rAF9v7d5YDhW3yga41+2F
=p+/z
-----END PGP SIGNATURE-----

--nextPart6700845.i19tOByk09--
