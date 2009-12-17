Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: gstreamer and sbcdec problem
Date: Thu, 17 Dec 2009 08:41:07 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de> <200912160203.53737.siarhei.siamashka@gmail.com> <aa32413d0912160341i3c9751ccm756780fcc2f457ba@mail.gmail.com>
In-Reply-To: <aa32413d0912160341i3c9751ccm756780fcc2f457ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2539509.biy8HrxkSm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200912170841.14550.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart2539509.biy8HrxkSm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 16 December 2009, Jo=C3=A3o Paulo Rechi Vita wrote:
> On Tue, Dec 15, 2009 at 10:03 PM, Siarhei Siamashka
>
> <siarhei.siamashka@gmail.com> wrote:
> > Also I don't have much trust in the current bluez SBC decoder
> > implementation. Its quality may be not the very best. I was considering
> > to eventually review its code, do some refactoring and merge some of its
> > parts with the encoder (SBC encode and decode are quite symmetric), but
> > did not find some spare time for this yet. Considering that bluez got S=
BC
> > sink support now, improving the decoder may make sense.
>
> IMO it would make sense to export SBC codec in a library, since
> encoding and decoding is done outside bluetoothd (ALSA, gstreamer or
> PulseAudio). Also, the codec could be used for applications different
> from A2DP streaming, and the more people using it, more tested (and
> eventually improved) the code gets.

I don't have first hand information regarding this matter myself, but
according to SBC wikipedia page [1]:
"The patent owners wrote that they allow the free usage of SBC in Bluetooth=
=20
application, with the view to boost the use of this technology. All=20
applications outside Bluetooth are however not free."

So having SBC codec tightly coupled with bluez at least makes some sense. F=
rom
purely technical point of view, a standalone library could be better.


1. http://en.wikipedia.org/wiki/SBC_(codec)

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart2539509.biy8HrxkSm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBLKdKKvyB/CfYEEt4RAl3dAKCUDPvq7cHxCVZQGt9KPu5qo2pOywCgo0Bf
IbPjeWF5oqGIf2otvQZ+FXg=
=L9Ix
-----END PGP SIGNATURE-----

--nextPart2539509.biy8HrxkSm--
