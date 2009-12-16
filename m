Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "Marian Harbach" <harbach@mathematik.uni-marburg.de>
Subject: Re: gstreamer and sbcdec problem
Date: Wed, 16 Dec 2009 02:03:47 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de>
In-Reply-To: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2966503.IPKWh2buAI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200912160203.53737.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart2966503.IPKWh2buAI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 December 2009, Marian Harbach wrote:
> Hi,
>
> I have the same problem as described in this post:
>
> http://www.spinics.net/lists/linux-bluetooth/msg03627.html

This looks like either some completely random garbage gets there (valgrind
can probably help), or the decoder is not reinitialized properly and has
some stale data from the previous decode in some of its internal buffers.

> I found that depending on filesize, the original input is delayed by some
> bytes (180-260 for 16kHz PCM input)=20

SBC introduces some delay to the audio data due to the way how it works.
Some of the trailing samples of the buffer you feed to the 'sbc_encode'=20
function are actually not represented fully in the encoded data for this
frame, but are kept in the ring buffer and get processed later on
next 'sbc_encode' call.

The reference binary encoder introduces exactly the same delay.

> and additionally the first few samples=20
> are overwritten when doing sbcenc followed by sbcdec.

Could you please clarify this part? In what way and where do they get
overwritten (in files, memory buffers, ...)?

> Is there a fix for this issue?

My guess is that the client application can be aware of this delay and take=
 it
into account somehow.

Also I don't have much trust in the current bluez SBC decoder implementatio=
n.
Its quality may be not the very best. I was considering to eventually review
its code, do some refactoring and merge some of its parts with the encoder
(SBC encode and decode are quite symmetric), but did not find some spare
time for this yet. Considering that bluez got SBC sink support now, improvi=
ng
the decoder may make sense.

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart2966503.IPKWh2buAI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBLKCPpvyB/CfYEEt4RAgx1AJsFXRArOqNI/9J/TTtpUhyv8bk2LgCgwJyy
9Z8mkl8ccRmN711aUL3JmH4=
=wADU
-----END PGP SIGNATURE-----

--nextPart2966503.IPKWh2buAI--
