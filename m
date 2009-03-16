Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Mon, 16 Mar 2009 21:32:26 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200901290310.03440.siarhei.siamashka@nokia.com> <200902021248.14496.siarhei.siamashka@nokia.com> <1233588056.4668.16.camel@californication>
In-Reply-To: <1233588056.4668.16.camel@californication>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KlqvJb0V3Hw7RNE"
Message-Id: <200903162132.26530.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_KlqvJb0V3Hw7RNE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 02 February 2009 17:20:56 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > > > > > > cases.
> > > > > >
> > > > > > patch has been applied. Thanks.
> > > > >
> > > > > The tests have passed all.
> > > > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
> > > >
> > > > Thanks a lot for keeping an eye on bluez sbc implementation quality.
> > >
> > > are all patches applied now or am I missing one?
> >
> > Yes, thanks, all the patches have been applied except for this one:
> > http://marc.info/?l=linux-bluetooth&m=123319235104928&w=2
> >
> > It should work fine, but I'm still considering how to better optimize
> > processing of joint stereo, which might also require changing this code
> > a bit. For now it's more like a demonstration that scale factors
> > processing can be SIMD optimized quite fine.
> >
> > I will provide a more complete patch with optimizations for both scale
> > factors and joint stereo a bit later.
>
> please re-sent this one with a proper commit message and I apply it.
> Then you can start from there is you like. Or send me a complete new
> one.

Done. Commit message added and patch attached.

time ./sbcenc tesfile.au > /dev/null

before:
real    0m6.404s
user    0m6.152s
sys     0m0.244s

after:
real    0m5.630s
user    0m5.376s
sys     0m0.248s

-- 
Best regards,
Siarhei Siamashka

--Boundary-00=_KlqvJb0V3Hw7RNE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0002-sbc-MMX-optimization-for-scale-factors-calculation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0002-sbc-MMX-optimization-for-scale-factors-calculation.patch"

=46rom 83bece7b4642dde20b76253b7d18228d6654fa70 Mon Sep 17 00:00:00 2001
=46rom: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Mon, 16 Mar 2009 21:10:32 +0200
Subject: [PATCH] sbc: MMX optimization for scale factors calculation

=2D--
 sbc/sbc_primitives_mmx.c |   54 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 08e9ca2..d8373b3 100644
=2D-- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -275,6 +275,59 @@ static inline void sbc_analyze_4b_8s_mmx(int16_t *x, i=
nt32_t *out,
 	asm volatile ("emms\n");
 }
=20
+static void sbc_calc_scalefactors_mmx(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	static const SBC_ALIGNED int32_t consts[2] =3D {
+		1 << SCALE_OUT_BITS,
+		1 << SCALE_OUT_BITS,
+	};
+	int ch, sb;
+	intptr_t blk;
+	for (ch =3D 0; ch < channels; ch++) {
+		for (sb =3D 0; sb < subbands; sb +=3D 2) {
+			blk =3D (blocks - 1) * (((char *) &sb_sample_f[1][0][0] -
+				(char *) &sb_sample_f[0][0][0]));
+			asm volatile (
+				"movq         (%4), %%mm0\n"
+			"1:\n"
+				"movq     (%1, %0), %%mm1\n"
+				"pxor        %%mm2, %%mm2\n"
+				"pcmpgtd     %%mm2, %%mm1\n"
+				"paddd    (%1, %0), %%mm1\n"
+				"pcmpgtd     %%mm1, %%mm2\n"
+				"pxor        %%mm2, %%mm1\n"
+
+				"por         %%mm1, %%mm0\n"
+
+				"sub            %2, %0\n"
+				"jns            1b\n"
+
+				"movd        %%mm0, %k0\n"
+				"psrlq         $32, %%mm0\n"
+				"bsrl          %k0, %k0\n"
+				"subl           %5, %k0\n"
+				"movl          %k0, (%3)\n"
+
+				"movd        %%mm0, %k0\n"
+				"bsrl          %k0, %k0\n"
+				"subl           %5, %k0\n"
+				"movl          %k0, 4(%3)\n"
+			: "+r" (blk)
+			: "r" (&sb_sample_f[0][ch][sb]),
+				"i" ((char *) &sb_sample_f[1][0][0] -
+					(char *) &sb_sample_f[0][0][0]),
+				"r" (&scale_factor[ch][sb]),
+				"r" (&consts),
+				"i" (SCALE_OUT_BITS)
+			: "memory");
+		}
+	}
+	asm volatile ("emms\n");
+}
+
 static int check_mmx_support(void)
 {
 #ifdef __amd64__
@@ -313,6 +366,7 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *=
state)
 	if (check_mmx_support()) {
 		state->sbc_analyze_4b_4s =3D sbc_analyze_4b_4s_mmx;
 		state->sbc_analyze_4b_8s =3D sbc_analyze_4b_8s_mmx;
+		state->sbc_calc_scalefactors =3D sbc_calc_scalefactors_mmx;
 		state->implementation_info =3D "MMX";
 	}
 }
=2D-=20
1.5.6.5


--Boundary-00=_KlqvJb0V3Hw7RNE--
