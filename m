Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "Marian Harbach" <harbach@mathematik.uni-marburg.de>
Subject: Re: AW: gstreamer and sbcdec problem
Date: Wed, 16 Dec 2009 12:15:42 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de> <200912160203.53737.siarhei.siamashka@gmail.com> <003c01ca7e29$bd2d1e10$37875a30$@uni-marburg.de>
In-Reply-To: <003c01ca7e29$bd2d1e10$37875a30$@uni-marburg.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1505197.TqY6t6IG9X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200912161215.47014.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart1505197.TqY6t6IG9X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 16 December 2009, Marian Harbach wrote:
> Hey thanks for the reply. To clarify:
>
> I use gstreamer to run a 16kHz PCM wav file through one sbc encoder/decod=
er
> step and save the results back to a 16kHz PCM wav file. When I examine the
> original file and the result file in a tool like Audacity, there is an
> offset between the two files of about 0.0125 secs. If I delay one file
> accordingly, the waveforms in the remaining parts fit.

Yes, this is something to be expected unless I'm mistaken. You can google
for "SBC algorithmic delay" or something like this.

> Yet, the first couple of samples of the original waveform have no
> resamblances with the resulting waveform.

This may actually need a bit of tweaking. When starting encoding, we don't
have a preceding history, but older nonexisting samples are still needed as
input for the polyphase filter. The encoder from bluez currently treats tho=
se
missing samples as zero. Having a quick look at A2DP spec again, I don't see
any special explanations about how the encoding process should start.
Experimenting a bit with the reference binary encoder and trying to guess
how it deals with the initial samples may help.

> If that delay mentioned above was actually a fixed value, I'd have no
> problem in my application.

It should be a fixed value, which only depends on encoding parameters.

> But the delay depends on input filesize=20

This is strange. The encoder/decoder works with the stream of data and is n=
ot
even supposed to know how big is the input file.

Either your tool is not very precise at measuring this delay, or there could
be some bugs in sbc or in the gstreamer layer.

I suggest you to experiment with standalone sbcenc/sbcdec comand line tools
and check if the same behavior is also reproduced there.

> and also increases when running the result file through an sbcenc/sbcdec
> pair again. At least that is the pattern that I see for now.

Sure, there is a constant delay introduced on each encode/decode operation.
Repeating it multiple times will result in this delay accumulating.

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart1505197.TqY6t6IG9X
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBLKLNSvyB/CfYEEt4RAr0PAKDMA4oouSr96ucmFWNUhQrnLB71kACgvZ+X
xiIx20eyF0O5ZzOmi/lv1EQ=
=hMQl
-----END PGP SIGNATURE-----

--nextPart1505197.TqY6t6IG9X--
