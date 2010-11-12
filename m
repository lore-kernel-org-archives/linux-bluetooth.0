Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Keith Mok <ek9852@gmail.com>
Subject: Re: [PATCH v2] Add iwmmxt optimization for sbc for pxa series cpu
Date: Fri, 12 Nov 2010 15:22:44 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com> <201011111346.58906.siarhei.siamashka@gmail.com> <AANLkTi=rVvmwXwtZgMgwfBigyFXKsWRGy==rdcVjkitW@mail.gmail.com>
In-Reply-To: <AANLkTi=rVvmwXwtZgMgwfBigyFXKsWRGy==rdcVjkitW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1844846.W9SxtCkjnb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201011121522.51428.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart1844846.W9SxtCkjnb
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Friday 12 November 2010 09:35:04 Keith Mok wrote:
> > Did you run some benchmarks with these optimizations to measure how much
> > they are helping?
>=20
> Tested on Marvell PXA platform.
> =3D=3D Before =3D=3D
> $ time ./sbcenc   -b53 -s8 -j  c.au  > /dev/null
> real    0m 0.41s
> user    0m 0.40s
> sys     0m 0.00s
>=20
> =3D=3D After =3D=3D
> $ time ./sbcenc   -b53 -s8 -j  c.au  > /dev/null
> real    0m 0.19s
> user    0m 0.17s
> sys     0m 0.02s

Thanks, this looks consistent with the results of optimizations on the other
platforms where the performance increases roughly twice after adding SIMD=20
optimizations to the sbc analysis filter.

But maybe it's better to use a bit bigger test file, so that the total time=
=20
increases to at least several seconds. With very small times, it's hard to =
say
whether it is an actual improvement or random noise. It may be ok for such a
huge performance improvement, but with less significant optimizations the=20
precision of measurements may become a problem.

Also do you have oprofile available on PXA platform? It may provide a nice=
=20
statistics about what functions are used and are the performance hot spots.=
=20

> > Using back-to-back WLDRD instructions has some performance penalty
>=20
> I rearrange the instructions and keep the original one as for reference in
> the block that comment out. Since the code is really difficult to read
> after interleaved.

Thanks, this looks like it really should run quite a bit faster than the
previous variant (based on my understanding of intel pdf files).=20

I sometimes use different indentation levels in such cases in order to impr=
ove=20
readability after instructions reordering, so that each logically independe=
nt
block of code has its own indentation level and it is still easily visible
after instructions reordering. For example, with the original code:

A1
A2
A3
A4
B1
B2
B3
B4

If the instructions need to be reordered in order to improve scheduling for=
 the
cpu pipeline, then for example

A1
A2
  B1
A3
  B2
A4
  B3
  B4

looks much more readable to me than

A1
A2
B1
A3
B2
A4
B3
B4

With different indentation levels, one can still see the flow of instructio=
ns=20
as independent streams. If different levels of indentation in inline assemb=
ly=20
pass coding style test by checkpatch.pl script, then it should be fine.

Also I'm quite curious whether better instructions scheduling provide any c=
lear
improvement, so some numbers comparing older and newer implementation would
be appreciated. I did not suggest that just for entertainment purposes ;) It
really should provide some practical benefit.

If you have time and want to make such a test, iwmmxt intrinsics could be a=
lso
tried, so that instructions scheduling and registers allocation becomes a
responsibility of the compiler. But my previous experiments with arm neon
intrinsics showed that the compiler does a very poor job and can't be trust=
ed
to generate fast code. But maybe iwmmxt could be different or gcc could have
improved since than.

> > The MMX code was using PCMPGTD and the other instructions just because
> > MMX instruction set is very limited and did not have the needed
> > instructions. But you can use WABS and WMAX instructions to do this job
> > better. You can refer to the original C code and also to ARM NEON
> > optimizations to get some ideas about how to do this operation faster.
>=20
> Changed as suggested.
> But got a question that the __IWMMXT__ builtin gcc definition is not a
> reliable way to
> determine whether mcpu=3Diwmmxt2 is turned on or not. It will break when
> compile under pxa270
> which does not support wabs with just mcpu=3Diwmmx on.

Well, as I said before, I'm not familiar with iwmmxt and pxa platform. And I
did not notice that there are actually several revisions of iwmmxt isa, my =
bad.
So looks like iwmmxt1 is just as restrictive as the original mmx and the di=
rect=20
conversion from mmx like you did before may be the right thing. For arm neo=
n=20
optimizations, the effect of using vector ABS/MAX instructions was just
about 1% of overall performance improvement. Not so much, but every little =
bit
helps. And if for iwmmxt it causes such backwards compatibility issues, the=
n it
might be not worth it. It's up to you to decide.

I would still suggest to initially have just optimizations for=20
sbc_analyze_four_iwmmxt/sbc_analyze_eight_iwmmxt in the first patch (or may=
be=20
in two patches). And then add optimization for sbc_calc_scalefactors in a
separate patch later.

Regarding the benchmarks and functions usage:
1. sbc_analyze_four_iwmmxt is important for 4 subbands case ('-s4' option f=
or=20
sbcenc)
2. sbc_analyze_eight_iwmmxt is important for 8 subbands case ('-s8' option =
for=20
sbcenc)
3. sbc_calc_scalefactors is important for either mono audio, or when joint=
=20
stereo is *not* used (sbcenc is run without '-j' option).

All of this is better to be benchmarked/tested separately.

=2D-=20
Best regards,
Siarhei Siamashka

--nextPart1844846.W9SxtCkjnb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkzdP6sACgkQvyB/CfYEEt7BkACgpEJbmD1+WN1TBAmC64O6o5a7
BhMAoMUwdPZBUchSL4yU0SMOQQxIXFg2
=fOkF
-----END PGP SIGNATURE-----

--nextPart1844846.W9SxtCkjnb--
