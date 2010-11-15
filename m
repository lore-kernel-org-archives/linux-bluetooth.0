Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Keith Mok <ek9852@gmail.com>
Subject: Re: [PATCH v3] Add iwmmxt optimization for sbc for pxa series cpu
Date: Mon, 15 Nov 2010 13:08:19 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com> <201011121522.51428.siarhei.siamashka@gmail.com> <AANLkTimQR5wMTTEO6KGuv3YvPBaftO-i+96WKYQEOzFU@mail.gmail.com>
In-Reply-To: <AANLkTimQR5wMTTEO6KGuv3YvPBaftO-i+96WKYQEOzFU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1639289.ttqiGpaNB8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201011151308.31972.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart1639289.ttqiGpaNB8
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 15 November 2010 04:46:25 Keith Mok wrote:
> > I sometimes use different indentation levels in such cases in order to
> > improve readability after instructions reordering, so that each
> > logically independent block of code has its own indentation level and it
> > is still easily visible
>=20
> > after instructions reordering. For example, with the original code:
> Thanks for the hints. I rearranged the code.

Thanks, now the assembly code looks ok to me. I also discovered that qemu
supports iwmmxt1 emulation just fine and also tried to test your optimizati=
ons
for correctness myself (with a script which tries different encoding parama=
ters=20
for different audio samples and checks md5 checksums), no problems detected.

So if somebody else could check whether the other things are right (copyrig=
ht
notices for example), then we are done with it.

> I removed the scale_factor optimization since from the result I
> tested, it shows little help in performance.

I guess after easily doubling performance by adding simd optimizations to t=
he
sbc analysis filter, just roughly ~10% improvement (as measured for x86 and
arm neon) does not look particularly impressive anymore:=20
http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3D95465b816f0ce=
7f0ec10a183ce7ff0c6f83d86eb
http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3Dd049a9a2aec2b=
518e04f11ef0ecc355db8237291

But I still think that every little bit helps. Did you also get something l=
ike=20
10% speedup, or was it even worse than that?

A bit more important in practice is the optimization for joint stereo scale=
=20
factors calculation (because it is typically used for A2DP). And it provided
almost 20% of performance improvement for arm neon:
http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3De1ea3e76c72d5=
6041c30b317818e8d7b5a0c7350

So 'sbc_calc_scalefactors_j_iwmmxt' may be a nice addition too, optimized=20
either as a whole for best performance (like in arm neon code), or just with
some small chunks of assembly like in 'sbc_calc_scalefactors_mmx' because it
is easier this way.

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart1639289.ttqiGpaNB8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkzhFK8ACgkQvyB/CfYEEt5UIACgqi777yfvx8jErA2mcpcsPBfo
tPsAoMSsCnxb8YVuR78TwJqDhSStZNLR
=RsLr
-----END PGP SIGNATURE-----

--nextPart1639289.ttqiGpaNB8--
