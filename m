Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: SBC loudness bug?
Date: Thu, 23 Dec 2010 01:07:32 +0200
Cc: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"'Hagen Hentschel \(Ellisys\)'" <hagen.hentschel@ellisys.com>
References: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com> <000601cba1e2$86077e70$92167b50$@de>
In-Reply-To: <000601cba1e2$86077e70$92167b50$@de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1323762.JzUGcTW9ID";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201012230108.48623.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart1323762.JzUGcTW9ID
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 22 December 2010 16:14:16 Christian Hoene wrote:
> Hello,
>=20
> Mr. Hagen Hentschel was telling me that the BlueZ SBC implementation still
> has an bug.

Yes, unfortunately bluez sbc *decoder* is still as bad as it used to be. Th=
ere
easily may be more than one bug in it.

I feel somewhat responsible for not bringing sbc decoder into a better shape
earlier. But at that time, only properly working and fast sbc *encoder* was
needed for A2DP bluetooth stereo headsets support in Nokia N900. Moreover, I
had run out of allocated time to this task (due to actually having to fix s=
ome
bluez sbc encoder bugs in addition to doing just performance optimizations)=
 and
had to wrap up this activity even before all the planned ARM NEON optimizat=
ions
had been implemented.

=46ortunately I had some spare time on the last summer vacation to spend on=
 bluez
sbc codec. It was a tough choice deciding between either fixing the decoder=
 or
adding missing ARM NEON optimizations to the encoder. But in the end I deci=
ded
to get at least one thing done right (the encoder), especially considering =
that
it happens to be referred from several places as an example of ARM NEON
optimizations. And I just did not feel right about having clearly incomplete
stuff there :) So the encoder got more optimizations [1][2], and the decoder
remained the way it was (it is still in my low priority TODO list).

> As compared to Bluetooth's reference implementation the signal
> is twotimes too silent. We told me, that in the last step of calculating
> the PCM samples a 1 bit right shift was done too much.
>=20
> A correct implementation for C# can be found at
> http://sourceforge.net/projects/sbcsharp/
>=20
> Sorry, due to time limits I cannot provide you with a patch...

Even without looking at the changes (after all, it's not so easy without a
patch), I guess it's more like a band aid. The whole decoder needs to be
seriously reworked. At least dropping the current synthesis filter
completely and reimplementing it straight according to A2DP spec is
necessary. We can't verify whether the current filter is correct, and also
its low precision is likely masking the other bugs and deviations from the
spec. I had some notes about it earlier in [3].

I have no idea when this all might be done unless somebody steps up for this
task (Hagen?). Or unless I myself somehow get an opportunity to work on fix=
ing
sbc decoder full time for at least a week (next summer vacation?).


1. http://marc.info/?l=3Dlinux-bluetooth&m=3D127781938327437&w=3D2
2. http://marc.info/?l=3Dlinux-bluetooth&m=3D127807359119577&w=3D2
3. http://marc.info/?l=3Dlinux-bluetooth&m=3D126106163120842&w=3D2

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart1323762.JzUGcTW9ID
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAk0ShQAACgkQvyB/CfYEEt5krQCfe6i/IqPRTUMKh/p/bBI2HP2V
fHcAn0kdo2WmeLE7tPUxH0qoqt7mEJOy
=9IfY
-----END PGP SIGNATURE-----

--nextPart1323762.JzUGcTW9ID--
