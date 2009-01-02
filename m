Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Fri, 2 Jan 2009 18:07:17 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <1230800283.4530.3.camel@californication>
In-Reply-To: <1230800283.4530.3.camel@californication>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1ujXJ84TPt6k+Lj"
Message-Id: <200901021807.17443.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_1ujXJ84TPt6k+Lj
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 01 January 2009 10:58:03 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > This is a preliminary preview of SIMD optimizations for SBC encoder
> > analysis filter.
> >
> > It already contains MMX optimization for 4 subbands case (yes, all this
> > insane amount of extra lines of code finally starts to pay off) ;)
> >
> > Important notice: in order to test MMX optimizations, you need to have
> > extra '-mmmx' command line option passed to gcc. Runtime MMX
> > autodetection can be easily added later. Also don't forget to pass -s4
> > option to sbcenc because 8 subbands case is still not accelerated. By the
> > way, SSE2 is twice wider than MMX and should be a lot faster. Though MMX
> > is supported on virtually every x86 cpu that is in use nowadays and can
> > be considered "lowest common denominator".
> >
> > My quick benchmark showed that the performance gets improved about ~10%
> > overall (and about twice better for the analysis filter function alone)
> > when compared with bluez-4.23 release which had the old buggy code.
> > Improvement is much more noticeable over the release 4.25 which contains
> > a new fixed and mostly nonoptimized filter.
> >
> > So now the performance is better than ever. And I guess, all the
> > platforms should use SIMD optimizations nowadays, so they should gain
> > performance improvements too. Those 'anamatrix' style optimizations in
> > older code feel so much like the previous century ;)
> >
> > I'm going to primarily focus on NEON and maybe ARMv6 SIMD optimizations,
> > these will be submitted a bit later. Also, as I have already written
> > before, the other parts of code are quite inefficient too and can be
> > optimized. There are still lots of things to improve.
> >
> >
> > But right now I would like to hear some opinions about the following
> > things regarding the attached patch:
> >
> > The first question is about the use of extra source file for SIMD
> > optimizations and introduction of
> > 'sbc_encoder_init_simd_optimized_analyze' function to the global
> > namespace. The rationale for that is the intention to stop adding changes
> > to 'sbc.c' (otherwise it will become bloated pretty soon with the
> > addition of multiple optimizations for various platforms). If anyone has
> > a better idea, I'm very much interested to hear it.
> >
> > And if the addition of a new source file gets approved, I wonder about
> > what text should go to the copyright header?
> >
> > Now we have two "reference" C implementations of analysis filter. Is it
> > OK to keep both? Or only SIMD-friendly one should remain in the end?
>
> I am fine with keeping both, but if one is just not useful, we are going
> to remove it.

The only problem with SIMD-friendly code is that it uses two tables instead of
one (that's a sacrifice for the nice and symmetric code layout which fits SIMD
instructions of modern processors quite well). It may be somewhat less
optimal for the legacy processors without SIMD capabilities.

I wonder what CPU architectures are the most important for bluez?

> Also two separate files are fine for me. Personally I prefer a runtime
> selection since compile time options are always painful 
> to test before making the release.

The attached patch contains what I would consider to be a final variant. MMX
support is now complete. It works for both x86 and amd64, has runtime
autodetection of MMX availability, supports 4 and 8 subbands cases. I also
ensured that only original MMX instructions are used (and no SSE or other
later additions), so the code should work fine even on the old Pentium1 MMX.
New MMX optimized functions produce bit identical results when compared
with bluez-4.25 release.

With this patch applied, new filtering functions are noticeably faster than
than the old ones on x86 (so now they are both faster and have better
quality). Assembly optimizations for the other platforms can be easily
added too. 

> For the copyright header it is pretty simple. We copy the current header
> and then later on I will add the appropriate Nokia copyright to it. So
> don't worry about that part, I take care of that.

OK, thanks


Best regards,
Siarhei Siamashka

--Boundary-00=_1ujXJ84TPt6k+Lj
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-SIMD-optimizations-for-SBC-encoder-analysis-filter.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-SIMD-optimizations-for-SBC-encoder-analysis-filter.patch"

>From 42543fb826b4f86d878a997c0adb0b428b459ffd Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Wed, 31 Dec 2008 16:52:08 +0200
Subject: [PATCH] SIMD optimizations for SBC encoder analysis filter

Added SIMD-friendly C implementation of SBC analysis filter (the
structure of code had to be changed a bit and constants in the
tables reordered). This code can be used as a reference for
developing platform specific SIMD optimizations. MMX optimizations
for x86/amd64 processors are included.
---
 sbc/Makefile.am   |    2 +-
 sbc/sbc.c         |   17 ++-
 sbc/sbc.h         |    6 +
 sbc/sbc_analyze.c |  617 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_tables.h  |  256 ++++++++++++++++++++++-
 5 files changed, 892 insertions(+), 6 deletions(-)
 create mode 100644 sbc/sbc_analyze.c

diff --git a/sbc/Makefile.am b/sbc/Makefile.am
index c42f162..d0d48ad 100644
--- a/sbc/Makefile.am
+++ b/sbc/Makefile.am
@@ -8,7 +8,7 @@ endif
 if SBC
 noinst_LTLIBRARIES = libsbc.la
 
-libsbc_la_SOURCES = sbc.h sbc.c sbc_math.h sbc_tables.h
+libsbc_la_SOURCES = sbc.h sbc.c sbc_analyze.c sbc_math.h sbc_tables.h
 
 libsbc_la_CFLAGS = -finline-functions -funswitch-loops -fgcse-after-reload
 
diff --git a/sbc/sbc.c b/sbc/sbc.c
index b349090..0b64b4c 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -94,7 +94,8 @@ struct sbc_decoder_state {
 struct sbc_encoder_state {
 	int subbands;
 	int position[2];
-	int16_t X[2][256];
+	int16_t buffer[2][256 + 8];
+	int16_t *X[2];
 	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
 				  int32_t *out, int out_stride);
 	void (*sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
@@ -1053,9 +1054,23 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 	state->subbands = frame->subbands;
 	state->position[0] = state->position[1] = 12 * frame->subbands;
 
+	/* Initialize X pointers (ensure 16 byte alignment) */
+	state->X[0] = state->buffer[0];
+	state->X[1] = state->buffer[1];
+	while ((int) state->X[0] & 0xF)
+		state->X[0]++;
+	while ((int) state->X[1] & 0xF)
+		state->X[1]++;
+
 	/* Default implementation for analyze function */
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+
+	/* Try to override the default implementation with faster SIMD
+	   optimized functions if possible */
+	sbc_encoder_init_simd_optimized_analyze(
+		&state->sbc_analyze_4b_4s,
+		&state->sbc_analyze_4b_8s);
 }
 
 struct sbc_priv {
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 2838b1f..5beff88 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -90,6 +90,12 @@ int sbc_get_frame_duration(sbc_t *sbc);
 int sbc_get_codesize(sbc_t *sbc);
 void sbc_finish(sbc_t *sbc);
 
+void sbc_encoder_init_simd_optimized_analyze(
+	void (**sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
+				   int32_t *out, int out_stride),
+	void (**sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
+				   int32_t *out, int out_stride));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/sbc/sbc_analyze.c b/sbc/sbc_analyze.c
new file mode 100644
index 0000000..dbd9d65
--- /dev/null
+++ b/sbc/sbc_analyze.c
@@ -0,0 +1,617 @@
+#include <stdint.h>
+#include <limits.h>
+#include "sbc.h"
+#include "sbc_math.h"
+#include "sbc_tables.h"
+
+/*
+ * A reference C code of analysis filter with SIMD-friendly tables
+ * reordering and code layout. This code can be used to develop platform
+ * specific SIMD optimizations. Also it may be used as some kind of test
+ * for compiler autovectorization capabilities (who knows, if the compiler
+ * is very good at this stuff, hand optimized assembly may be not strictly
+ * needed for some platform).
+ */
+
+static inline void _sbc_analyze_four_simd(const int16_t *in, int32_t *out,
+					  const FIXED_T *const_table)
+{
+	FIXED_A t1[4];
+	FIXED_T t2[4];
+	int hop = 0;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 40; hop += 8) {
+		t1[0] += (FIXED_A) in[hop] * const_table[hop];
+		t1[0] += (FIXED_A) in[hop + 1] * const_table[hop + 1];
+		t1[1] += (FIXED_A) in[hop + 2] * const_table[hop + 2];
+		t1[1] += (FIXED_A) in[hop + 3] * const_table[hop + 3];
+		t1[2] += (FIXED_A) in[hop + 4] * const_table[hop + 4];
+		t1[2] += (FIXED_A) in[hop + 5] * const_table[hop + 5];
+		t1[3] += (FIXED_A) in[hop + 6] * const_table[hop + 6];
+		t1[3] += (FIXED_A) in[hop + 7] * const_table[hop + 7];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED4_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED4_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED4_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED4_SCALE;
+
+	/* do the cos transform */
+	t1[0]  = (FIXED_A) t2[0] * const_table[40 + 0];
+	t1[0] += (FIXED_A) t2[1] * const_table[40 + 1];
+	t1[1]  = (FIXED_A) t2[0] * const_table[40 + 2];
+	t1[1] += (FIXED_A) t2[1] * const_table[40 + 3];
+	t1[2]  = (FIXED_A) t2[0] * const_table[40 + 4];
+	t1[2] += (FIXED_A) t2[1] * const_table[40 + 5];
+	t1[3]  = (FIXED_A) t2[0] * const_table[40 + 6];
+	t1[3] += (FIXED_A) t2[1] * const_table[40 + 7];
+
+	t1[0] += (FIXED_A) t2[2] * const_table[40 + 8];
+	t1[0] += (FIXED_A) t2[3] * const_table[40 + 9];
+	t1[1] += (FIXED_A) t2[2] * const_table[40 + 10];
+	t1[1] += (FIXED_A) t2[3] * const_table[40 + 11];
+	t1[2] += (FIXED_A) t2[2] * const_table[40 + 12];
+	t1[2] += (FIXED_A) t2[3] * const_table[40 + 13];
+	t1[3] += (FIXED_A) t2[2] * const_table[40 + 14];
+	t1[3] += (FIXED_A) t2[3] * const_table[40 + 15];
+
+	out[0] = t1[0] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	out[1] = t1[1] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	out[2] = t1[2] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	out[3] = t1[3] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+}
+
+static inline void _sbc_analyze_eight_simd(const int16_t *in, int32_t *out,
+					   const FIXED_T *consts)
+{
+	FIXED_A t1[8];
+	FIXED_T t2[8];
+	int i, hop;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED8_SCALE-1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 80; hop += 16) {
+		t1[0] += (FIXED_A) in[hop] * consts[hop];
+		t1[0] += (FIXED_A) in[hop + 1] * consts[hop + 1];
+		t1[1] += (FIXED_A) in[hop + 2] * consts[hop + 2];
+		t1[1] += (FIXED_A) in[hop + 3] * consts[hop + 3];
+		t1[2] += (FIXED_A) in[hop + 4] * consts[hop + 4];
+		t1[2] += (FIXED_A) in[hop + 5] * consts[hop + 5];
+		t1[3] += (FIXED_A) in[hop + 6] * consts[hop + 6];
+		t1[3] += (FIXED_A) in[hop + 7] * consts[hop + 7];
+		t1[4] += (FIXED_A) in[hop + 8] * consts[hop + 8];
+		t1[4] += (FIXED_A) in[hop + 9] * consts[hop + 9];
+		t1[5] += (FIXED_A) in[hop + 10] * consts[hop + 10];
+		t1[5] += (FIXED_A) in[hop + 11] * consts[hop + 11];
+		t1[6] += (FIXED_A) in[hop + 12] * consts[hop + 12];
+		t1[6] += (FIXED_A) in[hop + 13] * consts[hop + 13];
+		t1[7] += (FIXED_A) in[hop + 14] * consts[hop + 14];
+		t1[7] += (FIXED_A) in[hop + 15] * consts[hop + 15];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED8_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED8_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED8_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED8_SCALE;
+	t2[4] = t1[4] >> SBC_PROTO_FIXED8_SCALE;
+	t2[5] = t1[5] >> SBC_PROTO_FIXED8_SCALE;
+	t2[6] = t1[6] >> SBC_PROTO_FIXED8_SCALE;
+	t2[7] = t1[7] >> SBC_PROTO_FIXED8_SCALE;
+
+
+	/* do the cos transform */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] = 0;
+
+	for (i = 0; i < 4; i++) {
+		t1[0] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 0];
+		t1[0] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 1];
+		t1[1] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 2];
+		t1[1] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 3];
+		t1[2] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 4];
+		t1[2] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 5];
+		t1[3] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 6];
+		t1[3] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 7];
+		t1[4] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 8];
+		t1[4] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 9];
+		t1[5] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 10];
+		t1[5] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 11];
+		t1[6] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 12];
+		t1[6] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 13];
+		t1[7] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 14];
+		t1[7] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 15];
+	}
+
+	for (i = 0; i < 8; i++)
+		out[i] = t1[i] >>
+			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
+}
+
+static inline void sbc_analyze_4b_4s_simd(int16_t *pcm, int16_t *x,
+					  int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[64] = x[0]  = pcm[8 + 7];
+	x[65] = x[1]  = pcm[8 + 3];
+	x[66] = x[2]  = pcm[8 + 6];
+	x[67] = x[3]  = pcm[8 + 4];
+	x[68] = x[4]  = pcm[8 + 0];
+	x[69] = x[5]  = pcm[8 + 2];
+	x[70] = x[6]  = pcm[8 + 1];
+	x[71] = x[7]  = pcm[8 + 5];
+
+	x[72] = x[8]  = pcm[0 + 7];
+	x[73] = x[9]  = pcm[0 + 3];
+	x[74] = x[10] = pcm[0 + 6];
+	x[75] = x[11] = pcm[0 + 4];
+	x[76] = x[12] = pcm[0 + 0];
+	x[77] = x[13] = pcm[0 + 2];
+	x[78] = x[14] = pcm[0 + 1];
+	x[79] = x[15] = pcm[0 + 5];
+
+	/* Analyze blocks */
+	_sbc_analyze_four_simd(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	_sbc_analyze_four_simd(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	_sbc_analyze_four_simd(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	_sbc_analyze_four_simd(x + 0, out, analysis_consts_fixed4_simd_even);
+}
+
+static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
+					  int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[128] = x[0]  = pcm[16 + 15];
+	x[129] = x[1]  = pcm[16 + 7];
+	x[130] = x[2]  = pcm[16 + 14];
+	x[131] = x[3]  = pcm[16 + 8];
+	x[132] = x[4]  = pcm[16 + 13];
+	x[133] = x[5]  = pcm[16 + 9];
+	x[134] = x[6]  = pcm[16 + 12];
+	x[135] = x[7]  = pcm[16 + 10];
+	x[136] = x[8]  = pcm[16 + 11];
+	x[137] = x[9]  = pcm[16 + 3];
+	x[138] = x[10] = pcm[16 + 6];
+	x[139] = x[11] = pcm[16 + 0];
+	x[140] = x[12] = pcm[16 + 5];
+	x[141] = x[13] = pcm[16 + 1];
+	x[142] = x[14] = pcm[16 + 4];
+	x[143] = x[15] = pcm[16 + 2];
+
+	x[144] = x[16] = pcm[0 + 15];
+	x[145] = x[17] = pcm[0 + 7];
+	x[146] = x[18] = pcm[0 + 14];
+	x[147] = x[19] = pcm[0 + 8];
+	x[148] = x[20] = pcm[0 + 13];
+	x[149] = x[21] = pcm[0 + 9];
+	x[150] = x[22] = pcm[0 + 12];
+	x[151] = x[23] = pcm[0 + 10];
+	x[152] = x[24] = pcm[0 + 11];
+	x[153] = x[25] = pcm[0 + 3];
+	x[154] = x[26] = pcm[0 + 6];
+	x[155] = x[27] = pcm[0 + 0];
+	x[156] = x[28] = pcm[0 + 5];
+	x[157] = x[29] = pcm[0 + 1];
+	x[158] = x[30] = pcm[0 + 4];
+	x[159] = x[31] = pcm[0 + 2];
+
+	/* Analyze blocks */
+	_sbc_analyze_eight_simd(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	_sbc_analyze_eight_simd(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	_sbc_analyze_eight_simd(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	_sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
+}
+
+/*
+ * MMX optimizations
+ */
+
+#if defined(__GNUC__) && (defined(__i386__) || defined(__amd64__))
+#ifndef SBC_HIGH_PRECISION
+#define SBC_BUILD_WITH_MMX_SUPPORT
+#endif
+#endif
+
+#ifdef SBC_BUILD_WITH_MMX_SUPPORT
+
+static inline void _sbc_analyze_four_mmx(const int16_t *in, int32_t *out,
+					 const FIXED_T *consts)
+{
+	static const SIMD_ALIGNED int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+	};
+	asm volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"pmaddwd     (%1), %%mm0\n"
+		"pmaddwd    8(%1), %%mm1\n"
+		"paddd       (%2), %%mm0\n"
+		"paddd       (%2), %%mm1\n"
+		"\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"pmaddwd   16(%1), %%mm2\n"
+		"pmaddwd   24(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      32(%0), %%mm2\n"
+		"movq      40(%0), %%mm3\n"
+		"pmaddwd   32(%1), %%mm2\n"
+		"pmaddwd   40(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      48(%0), %%mm2\n"
+		"movq      56(%0), %%mm3\n"
+		"pmaddwd   48(%1), %%mm2\n"
+		"pmaddwd   56(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      64(%0), %%mm2\n"
+		"movq      72(%0), %%mm3\n"
+		"pmaddwd   64(%1), %%mm2\n"
+		"pmaddwd   72(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"psrad         %4, %%mm0\n"
+		"psrad         %4, %%mm1\n"
+		"packssdw   %%mm0, %%mm0\n"
+		"packssdw   %%mm1, %%mm1\n"
+		"\n"
+		"movq       %%mm0, %%mm2\n"
+		"pmaddwd   80(%1), %%mm0\n"
+		"pmaddwd   88(%1), %%mm2\n"
+		"\n"
+		"movq       %%mm1, %%mm3\n"
+		"pmaddwd   96(%1), %%mm1\n"
+		"pmaddwd  104(%1), %%mm3\n"
+		"paddd      %%mm1, %%mm0\n"
+		"paddd      %%mm3, %%mm2\n"
+		"\n"
+		"movq       %%mm0, (%3)\n"
+		"movq       %%mm2, 8(%3)\n"
+		:
+		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
+		  "i" (SBC_PROTO_FIXED4_SCALE)
+		: "memory");
+}
+
+static inline void _sbc_analyze_eight_mmx(const int16_t *in, int32_t *out,
+					  const FIXED_T *consts)
+{
+	static const SIMD_ALIGNED int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+	};
+	asm volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"pmaddwd     (%1), %%mm0\n"
+		"pmaddwd    8(%1), %%mm1\n"
+		"pmaddwd   16(%1), %%mm2\n"
+		"pmaddwd   24(%1), %%mm3\n"
+		"paddd       (%2), %%mm0\n"
+		"paddd       (%2), %%mm1\n"
+		"paddd       (%2), %%mm2\n"
+		"paddd       (%2), %%mm3\n"
+		"\n"
+		"movq      32(%0), %%mm4\n"
+		"movq      40(%0), %%mm5\n"
+		"movq      48(%0), %%mm6\n"
+		"movq      56(%0), %%mm7\n"
+		"pmaddwd   32(%1), %%mm4\n"
+		"pmaddwd   40(%1), %%mm5\n"
+		"pmaddwd   48(%1), %%mm6\n"
+		"pmaddwd   56(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq      64(%0), %%mm4\n"
+		"movq      72(%0), %%mm5\n"
+		"movq      80(%0), %%mm6\n"
+		"movq      88(%0), %%mm7\n"
+		"pmaddwd   64(%1), %%mm4\n"
+		"pmaddwd   72(%1), %%mm5\n"
+		"pmaddwd   80(%1), %%mm6\n"
+		"pmaddwd   88(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq      96(%0), %%mm4\n"
+		"movq     104(%0), %%mm5\n"
+		"movq     112(%0), %%mm6\n"
+		"movq     120(%0), %%mm7\n"
+		"pmaddwd   96(%1), %%mm4\n"
+		"pmaddwd  104(%1), %%mm5\n"
+		"pmaddwd  112(%1), %%mm6\n"
+		"pmaddwd  120(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq     128(%0), %%mm4\n"
+		"movq     136(%0), %%mm5\n"
+		"movq     144(%0), %%mm6\n"
+		"movq     152(%0), %%mm7\n"
+		"pmaddwd  128(%1), %%mm4\n"
+		"pmaddwd  136(%1), %%mm5\n"
+		"pmaddwd  144(%1), %%mm6\n"
+		"pmaddwd  152(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"psrad         %4, %%mm0\n"
+		"psrad         %4, %%mm1\n"
+		"psrad         %4, %%mm2\n"
+		"psrad         %4, %%mm3\n"
+		"\n"
+		"packssdw   %%mm0, %%mm0\n"
+		"packssdw   %%mm1, %%mm1\n"
+		"packssdw   %%mm2, %%mm2\n"
+		"packssdw   %%mm3, %%mm3\n"
+		"\n"
+		"movq       %%mm0, %%mm4\n"
+		"movq       %%mm0, %%mm5\n"
+		"pmaddwd  160(%1), %%mm4\n"
+		"pmaddwd  168(%1), %%mm5\n"
+		"\n"
+		"movq       %%mm1, %%mm6\n"
+		"movq       %%mm1, %%mm7\n"
+		"pmaddwd  192(%1), %%mm6\n"
+		"pmaddwd  200(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm2, %%mm6\n"
+		"movq       %%mm2, %%mm7\n"
+		"pmaddwd  224(%1), %%mm6\n"
+		"pmaddwd  232(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm3, %%mm6\n"
+		"movq       %%mm3, %%mm7\n"
+		"pmaddwd  256(%1), %%mm6\n"
+		"pmaddwd  264(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm4, (%3)\n"
+		"movq       %%mm5, 8(%3)\n"
+		"\n"
+		"movq       %%mm0, %%mm5\n"
+		"pmaddwd  176(%1), %%mm0\n"
+		"pmaddwd  184(%1), %%mm5\n"
+		"\n"
+		"movq       %%mm1, %%mm7\n"
+		"pmaddwd  208(%1), %%mm1\n"
+		"pmaddwd  216(%1), %%mm7\n"
+		"paddd      %%mm1, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm2, %%mm7\n"
+		"pmaddwd  240(%1), %%mm2\n"
+		"pmaddwd  248(%1), %%mm7\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm3, %%mm7\n"
+		"pmaddwd  272(%1), %%mm3\n"
+		"pmaddwd  280(%1), %%mm7\n"
+		"paddd      %%mm3, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm0, 16(%3)\n"
+		"movq       %%mm5, 24(%3)\n"
+		:
+		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
+		  "i" (SBC_PROTO_FIXED8_SCALE)
+		: "memory");
+}
+
+static inline void sbc_analyze_4b_4s_mmx(int16_t *pcm, int16_t *x,
+					 int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[0]  = pcm[8 + 7];
+	x[1]  = pcm[8 + 3];
+	x[2]  = pcm[8 + 6];
+	x[3]  = pcm[8 + 4];
+	x[4]  = pcm[8 + 0];
+	x[5]  = pcm[8 + 2];
+	x[6]  = pcm[8 + 1];
+	x[7]  = pcm[8 + 5];
+
+	x[8]  = pcm[0 + 7];
+	x[9]  = pcm[0 + 3];
+	x[10] = pcm[0 + 6];
+	x[11] = pcm[0 + 4];
+	x[12] = pcm[0 + 0];
+	x[13] = pcm[0 + 2];
+	x[14] = pcm[0 + 1];
+	x[15] = pcm[0 + 5];
+
+	/* Analyze blocks */
+	_sbc_analyze_four_mmx(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	_sbc_analyze_four_mmx(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	_sbc_analyze_four_mmx(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	_sbc_analyze_four_mmx(x + 0, out, analysis_consts_fixed4_simd_even);
+
+	/* Copy x[0 .. 15] to x[64 .. 79] using MMX */
+	asm volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"\n"
+		"movq       %%mm0, 128(%0)\n"
+		"movq       %%mm1, 136(%0)\n"
+		"movq       %%mm2, 144(%0)\n"
+		"movq       %%mm3, 152(%0)\n"
+		"\n"
+		"emms\n"
+		:
+		: "r" (x)
+		: "memory");
+}
+
+static inline void sbc_analyze_4b_8s_mmx(int16_t *pcm, int16_t *x,
+					 int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[0]  = pcm[16 + 15];
+	x[1]  = pcm[16 + 7];
+	x[2]  = pcm[16 + 14];
+	x[3]  = pcm[16 + 8];
+	x[4]  = pcm[16 + 13];
+	x[5]  = pcm[16 + 9];
+	x[6]  = pcm[16 + 12];
+	x[7]  = pcm[16 + 10];
+	x[8]  = pcm[16 + 11];
+	x[9]  = pcm[16 + 3];
+	x[10] = pcm[16 + 6];
+	x[11] = pcm[16 + 0];
+	x[12] = pcm[16 + 5];
+	x[13] = pcm[16 + 1];
+	x[14] = pcm[16 + 4];
+	x[15] = pcm[16 + 2];
+
+	x[16] = pcm[0 + 15];
+	x[17] = pcm[0 + 7];
+	x[18] = pcm[0 + 14];
+	x[19] = pcm[0 + 8];
+	x[20] = pcm[0 + 13];
+	x[21] = pcm[0 + 9];
+	x[22] = pcm[0 + 12];
+	x[23] = pcm[0 + 10];
+	x[24] = pcm[0 + 11];
+	x[25] = pcm[0 + 3];
+	x[26] = pcm[0 + 6];
+	x[27] = pcm[0 + 0];
+	x[28] = pcm[0 + 5];
+	x[29] = pcm[0 + 1];
+	x[30] = pcm[0 + 4];
+	x[31] = pcm[0 + 2];
+
+	/* Analyze blocks */
+	_sbc_analyze_eight_mmx(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	_sbc_analyze_eight_mmx(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	_sbc_analyze_eight_mmx(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	_sbc_analyze_eight_mmx(x + 0, out, analysis_consts_fixed8_simd_even);
+
+	/* Copy x[0 .. 31] to x[128 .. 159] using MMX */
+	asm volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"movq      32(%0), %%mm4\n"
+		"movq      40(%0), %%mm5\n"
+		"movq      48(%0), %%mm6\n"
+		"movq      56(%0), %%mm7\n"
+		"\n"
+		"movq       %%mm0, 256(%0)\n"
+		"movq       %%mm1, 264(%0)\n"
+		"movq       %%mm2, 272(%0)\n"
+		"movq       %%mm3, 280(%0)\n"
+		"movq       %%mm4, 288(%0)\n"
+		"movq       %%mm5, 296(%0)\n"
+		"movq       %%mm6, 304(%0)\n"
+		"movq       %%mm7, 312(%0)\n"
+		"\n"
+		"emms\n"
+		:
+		: "r" (x)
+		: "memory");
+}
+
+static int check_mmx_support()
+{
+#ifdef __amd64__
+	return 1; /* We assume that all 64-bit processors have MMX support */
+#else
+	int cpuid_feature_information;
+	asm volatile (
+		/* According to Intel manual, CPUID instruction is supported
+		   if the value of ID bit (bit 21) in EFLAGS can be modified */
+		"pushf\n"
+		"movl     (%%esp),   %0\n"
+		"xorl     $0x200000, (%%esp)\n" /* try to modify ID bit */
+		"popf\n"
+		"pushf\n"
+		"xorl     (%%esp),   %0\n"      /* check if ID bit changed */
+		"jz       1f\n"
+		"push     %%eax\n"
+		"push     %%ebx\n"
+		"push     %%ecx\n"
+		"mov      $1,        %%eax\n"
+		"cpuid\n"
+		"pop      %%ecx\n"
+		"pop      %%ebx\n"
+		"pop      %%eax\n"
+		"1:\n"
+		"popf\n"
+		: "=d" (cpuid_feature_information)
+		:
+		: "cc");
+    return cpuid_feature_information & (1 << 23);
+#endif
+}
+
+#endif
+
+/*
+ * Detect CPU features and setup the best implementation of
+ * the SBC analysis filter
+ */
+
+void sbc_encoder_init_simd_optimized_analyze(
+	void (**sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
+				   int32_t *out, int out_stride),
+	void (**sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
+				   int32_t *out, int out_stride))
+{
+#ifdef SBC_BUILD_WITH_MMX_SUPPORT
+	if (check_mmx_support()) {
+		*sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
+		*sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+	}
+#endif
+}
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index f1dfe6c..cd3ecfb 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -157,8 +157,9 @@ static const int32_t synmatrix8[16][8] = {
  */
 #define SBC_PROTO_FIXED4_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) - SBC_FIXED_EXTRA_BITS + 1)
-#define F(x) (FIXED_A) ((x * 2) * \
+#define F_PROTO4(x) (FIXED_A) ((x * 2) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_PROTO4(x)
 static const FIXED_T _sbc_proto_fixed4[40] = {
 	 F(0.00000000E+00),  F(5.36548976E-04),
 	-F(1.49188357E-03),  F(2.73370904E-03),
@@ -206,8 +207,9 @@ static const FIXED_T _sbc_proto_fixed4[40] = {
  */
 #define SBC_COS_TABLE_FIXED4_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) + SBC_FIXED_EXTRA_BITS)
-#define F(x) (FIXED_A) ((x) * \
+#define F_COS4(x) (FIXED_A) ((x) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_COS4(x)
 static const FIXED_T cos_table_fixed_4[32] = {
 	 F(0.7071067812),  F(0.9238795325), -F(1.0000000000),  F(0.9238795325),
 	 F(0.7071067812),  F(0.3826834324),  F(0.0000000000),  F(0.3826834324),
@@ -233,8 +235,9 @@ static const FIXED_T cos_table_fixed_4[32] = {
  */
 #define SBC_PROTO_FIXED8_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) - SBC_FIXED_EXTRA_BITS + 2)
-#define F(x) (FIXED_A) ((x * 4) * \
+#define F_PROTO8(x) (FIXED_A) ((x * 4) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_PROTO8(x)
 static const FIXED_T _sbc_proto_fixed8[80] = {
 	 F(0.00000000E+00),  F(1.56575398E-04),
 	 F(3.43256425E-04),  F(5.54620202E-04),
@@ -301,8 +304,9 @@ static const FIXED_T _sbc_proto_fixed8[80] = {
  */
 #define SBC_COS_TABLE_FIXED8_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) + SBC_FIXED_EXTRA_BITS)
-#define F(x) (FIXED_A) ((x) * \
+#define F_COS8(x) (FIXED_A) ((x) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_COS8(x)
 static const FIXED_T cos_table_fixed_8[128] = {
 	 F(0.7071067812),  F(0.8314696123),  F(0.9238795325),  F(0.9807852804),
 	-F(1.0000000000),  F(0.9807852804),  F(0.9238795325),  F(0.8314696123),
@@ -345,3 +349,247 @@ static const FIXED_T cos_table_fixed_8[128] = {
 	-F(0.0000000000), -F(0.1950903220),  F(0.3826834324), -F(0.5555702330),
 };
 #undef F
+
+/*
+ * Constant tables for the use in SIMD optimized analysis filters
+ * Each table consists of two parts:
+ * 1. reordered "proto" table
+ * 2. reordered "cos" table
+ *
+ * Due to non-symmetrical reordering, separate tables for "even"
+ * and "odd" cases are needed
+ */
+
+#ifdef __GNUC__
+#define SIMD_ALIGNED __attribute__((aligned(16)))
+#else
+#define SIMD_ALIGNED
+#endif
+
+static const FIXED_T SIMD_ALIGNED analysis_consts_fixed4_simd_even[40 + 16] = {
+#define F(x) F_PROTO4(x)
+	 F(0.00000000E+00),  F(3.83720193E-03),
+	 F(5.36548976E-04),  F(2.73370904E-03),
+	 F(3.06012286E-03),  F(3.89205149E-03),
+	 F(0.00000000E+00), -F(1.49188357E-03),
+	 F(1.09137620E-02),  F(2.58767811E-02),
+	 F(2.04385087E-02),  F(3.21939290E-02),
+	 F(7.76463494E-02),  F(6.13245186E-03),
+	 F(0.00000000E+00), -F(2.88757392E-02),
+	 F(1.35593274E-01),  F(2.94315332E-01),
+	 F(1.94987841E-01),  F(2.81828203E-01),
+	-F(1.94987841E-01),  F(2.81828203E-01),
+	 F(0.00000000E+00), -F(2.46636662E-01),
+	-F(1.35593274E-01),  F(2.58767811E-02),
+	-F(7.76463494E-02),  F(6.13245186E-03),
+	-F(2.04385087E-02),  F(3.21939290E-02),
+	 F(0.00000000E+00),  F(2.88217274E-02),
+	-F(1.09137620E-02),  F(3.83720193E-03),
+	-F(3.06012286E-03),  F(3.89205149E-03),
+	-F(5.36548976E-04),  F(2.73370904E-03),
+	 F(0.00000000E+00), -F(1.86581691E-03),
+#undef F
+#define F(x) F_COS4(x)
+	 F(0.7071067812),  F(0.9238795325),
+	-F(0.7071067812),  F(0.3826834324),
+	-F(0.7071067812), -F(0.3826834324),
+	 F(0.7071067812), -F(0.9238795325),
+	 F(0.3826834324), -F(1.0000000000),
+	-F(0.9238795325), -F(1.0000000000),
+	 F(0.9238795325), -F(1.0000000000),
+	-F(0.3826834324), -F(1.0000000000),
+#undef F
+};
+
+static const FIXED_T SIMD_ALIGNED analysis_consts_fixed4_simd_odd[40 + 16] = {
+#define F(x) F_PROTO4(x)
+	 F(2.73370904E-03),  F(5.36548976E-04),
+	-F(1.49188357E-03),  F(0.00000000E+00),
+	 F(3.83720193E-03),  F(1.09137620E-02),
+	 F(3.89205149E-03),  F(3.06012286E-03),
+	 F(3.21939290E-02),  F(2.04385087E-02),
+	-F(2.88757392E-02),  F(0.00000000E+00),
+	 F(2.58767811E-02),  F(1.35593274E-01),
+	 F(6.13245186E-03),  F(7.76463494E-02),
+	 F(2.81828203E-01),  F(1.94987841E-01),
+	-F(2.46636662E-01),  F(0.00000000E+00),
+	 F(2.94315332E-01), -F(1.35593274E-01),
+	 F(2.81828203E-01), -F(1.94987841E-01),
+	 F(6.13245186E-03), -F(7.76463494E-02),
+	 F(2.88217274E-02),  F(0.00000000E+00),
+	 F(2.58767811E-02), -F(1.09137620E-02),
+	 F(3.21939290E-02), -F(2.04385087E-02),
+	 F(3.89205149E-03), -F(3.06012286E-03),
+	-F(1.86581691E-03),  F(0.00000000E+00),
+	 F(3.83720193E-03),  F(0.00000000E+00),
+	 F(2.73370904E-03), -F(5.36548976E-04),
+#undef F
+#define F(x) F_COS4(x)
+	 F(0.9238795325), -F(1.0000000000),
+	 F(0.3826834324), -F(1.0000000000),
+	-F(0.3826834324), -F(1.0000000000),
+	-F(0.9238795325), -F(1.0000000000),
+	 F(0.7071067812),  F(0.3826834324),
+	-F(0.7071067812), -F(0.9238795325),
+	-F(0.7071067812),  F(0.9238795325),
+	 F(0.7071067812), -F(0.3826834324),
+#undef F
+};
+
+static const FIXED_T SIMD_ALIGNED analysis_consts_fixed8_simd_even[80 + 64] = {
+#define F(x) F_PROTO8(x)
+	 F(0.00000000E+00),  F(2.01182542E-03),
+	 F(1.56575398E-04),  F(1.78371725E-03),
+	 F(3.43256425E-04),  F(1.47640169E-03),
+	 F(5.54620202E-04),  F(1.13992507E-03),
+	-F(8.23919506E-04),  F(0.00000000E+00),
+	 F(2.10371989E-03),  F(3.49717454E-03),
+	 F(1.99454554E-03),  F(1.64973098E-03),
+	 F(1.61656283E-03),  F(1.78805361E-04),
+	 F(5.65949473E-03),  F(1.29371806E-02),
+	 F(8.02941163E-03),  F(1.53184106E-02),
+	 F(1.04584443E-02),  F(1.62208471E-02),
+	 F(1.27472335E-02),  F(1.59045603E-02),
+	-F(1.46525263E-02),  F(0.00000000E+00),
+	 F(8.85757540E-03),  F(5.31873032E-02),
+	 F(2.92408442E-03),  F(3.90751381E-02),
+	-F(4.91578024E-03),  F(2.61098752E-02),
+	 F(6.79989431E-02),  F(1.46955068E-01),
+	 F(8.29847578E-02),  F(1.45389847E-01),
+	 F(9.75753918E-02),  F(1.40753505E-01),
+	 F(1.11196689E-01),  F(1.33264415E-01),
+	-F(1.23264548E-01),  F(0.00000000E+00),
+	 F(1.45389847E-01), -F(8.29847578E-02),
+	 F(1.40753505E-01), -F(9.75753918E-02),
+	 F(1.33264415E-01), -F(1.11196689E-01),
+	-F(6.79989431E-02),  F(1.29371806E-02),
+	-F(5.31873032E-02),  F(8.85757540E-03),
+	-F(3.90751381E-02),  F(2.92408442E-03),
+	-F(2.61098752E-02), -F(4.91578024E-03),
+	 F(1.46404076E-02),  F(0.00000000E+00),
+	 F(1.53184106E-02), -F(8.02941163E-03),
+	 F(1.62208471E-02), -F(1.04584443E-02),
+	 F(1.59045603E-02), -F(1.27472335E-02),
+	-F(5.65949473E-03),  F(2.01182542E-03),
+	-F(3.49717454E-03),  F(2.10371989E-03),
+	-F(1.64973098E-03),  F(1.99454554E-03),
+	-F(1.78805361E-04),  F(1.61656283E-03),
+	-F(9.02154502E-04),  F(0.00000000E+00),
+	 F(1.78371725E-03), -F(1.56575398E-04),
+	 F(1.47640169E-03), -F(3.43256425E-04),
+	 F(1.13992507E-03), -F(5.54620202E-04),
+#undef F
+#define F(x) F_COS8(x)
+	 F(0.7071067812),  F(0.8314696123),
+	-F(0.7071067812), -F(0.1950903220),
+	-F(0.7071067812), -F(0.9807852804),
+	 F(0.7071067812), -F(0.5555702330),
+	 F(0.7071067812),  F(0.5555702330),
+	-F(0.7071067812),  F(0.9807852804),
+	-F(0.7071067812),  F(0.1950903220),
+	 F(0.7071067812), -F(0.8314696123),
+	 F(0.9238795325),  F(0.9807852804),
+	 F(0.3826834324),  F(0.8314696123),
+	-F(0.3826834324),  F(0.5555702330),
+	-F(0.9238795325),  F(0.1950903220),
+	-F(0.9238795325), -F(0.1950903220),
+	-F(0.3826834324), -F(0.5555702330),
+	 F(0.3826834324), -F(0.8314696123),
+	 F(0.9238795325), -F(0.9807852804),
+	-F(1.0000000000),  F(0.5555702330),
+	-F(1.0000000000), -F(0.9807852804),
+	-F(1.0000000000),  F(0.1950903220),
+	-F(1.0000000000),  F(0.8314696123),
+	-F(1.0000000000), -F(0.8314696123),
+	-F(1.0000000000), -F(0.1950903220),
+	-F(1.0000000000),  F(0.9807852804),
+	-F(1.0000000000), -F(0.5555702330),
+	 F(0.3826834324),  F(0.1950903220),
+	-F(0.9238795325), -F(0.5555702330),
+	 F(0.9238795325),  F(0.8314696123),
+	-F(0.3826834324), -F(0.9807852804),
+	-F(0.3826834324),  F(0.9807852804),
+	 F(0.9238795325), -F(0.8314696123),
+	-F(0.9238795325),  F(0.5555702330),
+	 F(0.3826834324), -F(0.1950903220),
+#undef F
+};
+
+static const FIXED_T SIMD_ALIGNED analysis_consts_fixed8_simd_odd[80 + 64] = {
+#define F(x) F_PROTO8(x)
+	 F(0.00000000E+00), -F(8.23919506E-04),
+	 F(1.56575398E-04),  F(1.78371725E-03),
+	 F(3.43256425E-04),  F(1.47640169E-03),
+	 F(5.54620202E-04),  F(1.13992507E-03),
+	 F(2.01182542E-03),  F(5.65949473E-03),
+	 F(2.10371989E-03),  F(3.49717454E-03),
+	 F(1.99454554E-03),  F(1.64973098E-03),
+	 F(1.61656283E-03),  F(1.78805361E-04),
+	 F(0.00000000E+00), -F(1.46525263E-02),
+	 F(8.02941163E-03),  F(1.53184106E-02),
+	 F(1.04584443E-02),  F(1.62208471E-02),
+	 F(1.27472335E-02),  F(1.59045603E-02),
+	 F(1.29371806E-02),  F(6.79989431E-02),
+	 F(8.85757540E-03),  F(5.31873032E-02),
+	 F(2.92408442E-03),  F(3.90751381E-02),
+	-F(4.91578024E-03),  F(2.61098752E-02),
+	 F(0.00000000E+00), -F(1.23264548E-01),
+	 F(8.29847578E-02),  F(1.45389847E-01),
+	 F(9.75753918E-02),  F(1.40753505E-01),
+	 F(1.11196689E-01),  F(1.33264415E-01),
+	 F(1.46955068E-01), -F(6.79989431E-02),
+	 F(1.45389847E-01), -F(8.29847578E-02),
+	 F(1.40753505E-01), -F(9.75753918E-02),
+	 F(1.33264415E-01), -F(1.11196689E-01),
+	 F(0.00000000E+00),  F(1.46404076E-02),
+	-F(5.31873032E-02),  F(8.85757540E-03),
+	-F(3.90751381E-02),  F(2.92408442E-03),
+	-F(2.61098752E-02), -F(4.91578024E-03),
+	 F(1.29371806E-02), -F(5.65949473E-03),
+	 F(1.53184106E-02), -F(8.02941163E-03),
+	 F(1.62208471E-02), -F(1.04584443E-02),
+	 F(1.59045603E-02), -F(1.27472335E-02),
+	 F(0.00000000E+00), -F(9.02154502E-04),
+	-F(3.49717454E-03),  F(2.10371989E-03),
+	-F(1.64973098E-03),  F(1.99454554E-03),
+	-F(1.78805361E-04),  F(1.61656283E-03),
+	 F(2.01182542E-03),  F(0.00000000E+00),
+	 F(1.78371725E-03), -F(1.56575398E-04),
+	 F(1.47640169E-03), -F(3.43256425E-04),
+	 F(1.13992507E-03), -F(5.54620202E-04),
+#undef F
+#define F(x) F_COS8(x)
+	-F(1.0000000000),  F(0.8314696123),
+	-F(1.0000000000), -F(0.1950903220),
+	-F(1.0000000000), -F(0.9807852804),
+	-F(1.0000000000), -F(0.5555702330),
+	-F(1.0000000000),  F(0.5555702330),
+	-F(1.0000000000),  F(0.9807852804),
+	-F(1.0000000000),  F(0.1950903220),
+	-F(1.0000000000), -F(0.8314696123),
+	 F(0.9238795325),  F(0.9807852804),
+	 F(0.3826834324),  F(0.8314696123),
+	-F(0.3826834324),  F(0.5555702330),
+	-F(0.9238795325),  F(0.1950903220),
+	-F(0.9238795325), -F(0.1950903220),
+	-F(0.3826834324), -F(0.5555702330),
+	 F(0.3826834324), -F(0.8314696123),
+	 F(0.9238795325), -F(0.9807852804),
+	 F(0.7071067812),  F(0.5555702330),
+	-F(0.7071067812), -F(0.9807852804),
+	-F(0.7071067812),  F(0.1950903220),
+	 F(0.7071067812),  F(0.8314696123),
+	 F(0.7071067812), -F(0.8314696123),
+	-F(0.7071067812), -F(0.1950903220),
+	-F(0.7071067812),  F(0.9807852804),
+	 F(0.7071067812), -F(0.5555702330),
+	 F(0.3826834324),  F(0.1950903220),
+	-F(0.9238795325), -F(0.5555702330),
+	 F(0.9238795325),  F(0.8314696123),
+	-F(0.3826834324), -F(0.9807852804),
+	-F(0.3826834324),  F(0.9807852804),
+	 F(0.9238795325), -F(0.8314696123),
+	-F(0.9238795325),  F(0.5555702330),
+	 F(0.3826834324), -F(0.1950903220),
+#undef F
+};
-- 
1.5.6.5


--Boundary-00=_1ujXJ84TPt6k+Lj--
