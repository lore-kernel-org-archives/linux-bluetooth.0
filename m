Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Wed, 31 Dec 2008 18:03:45 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hf5WJlE34UL6a4K"
Message-Id: <200812311803.45279.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_hf5WJlE34UL6a4K
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

This is a preliminary preview of SIMD optimizations for SBC encoder analysis filter.

It already contains MMX optimization for 4 subbands case (yes, all this insane
amount of extra lines of code finally starts to pay off) ;)

Important notice: in order to test MMX optimizations, you need to have
extra '-mmmx' command line option passed to gcc. Runtime MMX autodetection
can be easily added later. Also don't forget to pass -s4 option to sbcenc
because 8 subbands case is still not accelerated. By the way, SSE2 is twice
wider than MMX and should be a lot faster. Though MMX is supported on
virtually every x86 cpu that is in use nowadays and can be considered "lowest
common denominator".

My quick benchmark showed that the performance gets improved about ~10%
overall (and about twice better for the analysis filter function alone) when
compared with bluez-4.23 release which had the old buggy code. Improvement is
much more noticeable over the release 4.25 which contains a new fixed and
mostly nonoptimized filter.

So now the performance is better than ever. And I guess, all the platforms
should use SIMD optimizations nowadays, so they should gain performance
improvements too. Those 'anamatrix' style optimizations in older code feel
so much like the previous century ;)

I'm going to primarily focus on NEON and maybe ARMv6 SIMD optimizations,
these will be submitted a bit later. Also, as I have already written before,
the other parts of code are quite inefficient too and can be optimized. There
are still lots of things to improve.


But right now I would like to hear some opinions about the following things
regarding the attached patch:

The first question is about the use of extra source file for SIMD
optimizations and introduction of 'sbc_encoder_init_simd_optimized_analyze'
function to the global namespace. The rationale for that is the intention to
stop adding changes to 'sbc.c' (otherwise it will become bloated pretty soon
with the addition of multiple optimizations for various platforms). If anyone
has a better idea, I'm very much interested to hear it.

And if the addition of a new source file gets approved, I wonder about what
text should go to the copyright header?

Now we have two "reference" C implementations of analysis filter. Is it OK to
keep both? Or only SIMD-friendly one should remain in the end?

PS. Happy New Year

Best regards,
Siarhei Siamashka

--Boundary-00=_hf5WJlE34UL6a4K
Content-Type: text/x-diff;
  charset="us-ascii";
  name="preview-0002-SIMD-optimizations-for-SBC-encoder-analysis-filter.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="preview-0002-SIMD-optimizations-for-SBC-encoder-analysis-filter.patch"

>From e8f98db87085f8394c68363a4a971aea5b025a9b Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Wed, 31 Dec 2008 16:52:08 +0200
Subject: [PATCH] SIMD optimizations for SBC encoder analysis filter

Added SIMD-friendly "reference" C implementation of SBC
analysis filter (code layout had to be changed a bit and
constants in the tables reshuffled). This code can be used
as a starting point for MMX/SSE2/NEON/ARMv6 and probably
some others (MIPS?, SPARC?, PPC?) platform specific
optimizations. Initial test version of MMX optimization
for 4 subbands case is also included.
---
 sbc/Makefile.am  |    2 +-
 sbc/sbc.c        |   16 +++-
 sbc/sbc.h        |    6 +
 sbc/sbc_simd.c   |  335 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_tables.h |  256 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 609 insertions(+), 6 deletions(-)
 create mode 100644 sbc/sbc_simd.c

diff --git a/sbc/Makefile.am b/sbc/Makefile.am
index c42f162..45c2e09 100644
--- a/sbc/Makefile.am
+++ b/sbc/Makefile.am
@@ -8,7 +8,7 @@ endif
 if SBC
 noinst_LTLIBRARIES = libsbc.la
 
-libsbc_la_SOURCES = sbc.h sbc.c sbc_math.h sbc_tables.h
+libsbc_la_SOURCES = sbc.h sbc.c sbc_simd.c sbc_math.h sbc_tables.h
 
 libsbc_la_CFLAGS = -finline-functions -funswitch-loops -fgcse-after-reload
 
diff --git a/sbc/sbc.c b/sbc/sbc.c
index 01b4011..e313d4a 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -94,7 +94,8 @@ struct sbc_decoder_state {
 struct sbc_encoder_state {
 	int subbands;
 	int position[2];
-	int16_t X[2][256];
+	int16_t buffer[2][256 + 15];
+	int16_t *X[2];
 	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
 				  int32_t *out, int out_stride);
 	void (*sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
@@ -1053,9 +1054,22 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
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
+	/* Try to override it with something faster */
+	sbc_encoder_init_simd_optimized_analyze(
+		&state->sbc_analyze_4b_4s,
+		&state->sbc_analyze_4b_8s);
 }
 
 struct sbc_priv {
diff --git a/sbc/sbc.h b/sbc/sbc.h
index ab47e32..fd6f18e 100644
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
diff --git a/sbc/sbc_simd.c b/sbc/sbc_simd.c
new file mode 100644
index 0000000..865f88e
--- /dev/null
+++ b/sbc/sbc_simd.c
@@ -0,0 +1,335 @@
+#include <stdint.h>
+#include <stdio.h>
+#include <limits.h>
+#include "sbc.h"
+#include "sbc_math.h"
+#include "sbc_tables.h"
+
+/*
+ * A reference C code with SIMD-friendly tables reordering and code layout.
+ * This code can be used to develop platform specific SIMD optimizations.
+ * Also it may be theoretically used as some kind of test for compiler
+ * autovectorization capabilities :)
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
+
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
+	int i;
+	/* Input audio samples and do reordering for SIMD */
+	for (i = 0; i < 16; i += 8) {
+		int16_t *pcm1 = pcm + 8 - i;
+		int16_t *pcm2 = pcm + 8 - i + 4;
+		x[i + 64] = x[i + 0] = pcm2[3];
+		x[i + 65] = x[i + 1] = pcm1[3];
+		x[i + 66] = x[i + 2] = pcm2[2];
+		x[i + 67] = x[i + 3] = pcm2[0];
+		x[i + 68] = x[i + 4] = pcm1[0];
+		x[i + 69] = x[i + 5] = pcm1[2];
+		x[i + 70] = x[i + 6] = pcm1[1];
+		x[i + 71] = x[i + 7] = pcm2[1];
+	}
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
+	int i;
+	/* Input audio samples and do reordering for SIMD */
+	for (i = 0; i < 32; i += 16) {
+		int16_t *pcm1 = pcm + 16 - i;
+		int16_t *pcm2 = pcm + 16 - i + 8;
+		x[i + 128] = x[i + 0] = pcm2[7];
+		x[i + 129] = x[i + 1] = pcm1[7];
+		x[i + 130] = x[i + 2] = pcm2[6];
+		x[i + 131] = x[i + 3] = pcm2[0];
+		x[i + 132] = x[i + 4] = pcm2[5];
+		x[i + 133] = x[i + 5] = pcm2[1];
+		x[i + 134] = x[i + 6] = pcm2[4];
+		x[i + 135] = x[i + 7] = pcm2[2];
+		x[i + 136] = x[i + 8] = pcm2[3];
+		x[i + 137] = x[i + 9] = pcm1[3];
+		x[i + 138] = x[i + 10] = pcm1[6];
+		x[i + 139] = x[i + 11] = pcm1[0];
+		x[i + 140] = x[i + 12] = pcm1[5];
+		x[i + 141] = x[i + 13] = pcm1[1];
+		x[i + 142] = x[i + 14] = pcm1[4];
+		x[i + 143] = x[i + 15] = pcm1[2];
+	}
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
+ * MMX optimized implementation
+ */
+
+#if defined(__GNUC__) && defined(__MMX__) && !defined(SBC_HIGH_PRECISION)
+#define USE_MMX
+#endif
+
+#ifdef USE_MMX
+
+static inline void _sbc_analyze_four_mmx(const int16_t *in, int32_t *out,
+					 const FIXED_T *const_table)
+{
+	static int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+	};
+	asm volatile (
+		"movq       (%0), %%mm0\n"
+		"movq      8(%0), %%mm1\n"
+		"pmaddwd    (%1), %%mm0\n"
+		"pmaddwd   8(%1), %%mm1\n"
+		"paddd      (%2), %%mm0\n"
+		"paddd      (%2), %%mm1\n"
+		"\n"
+		"movq     16(%0), %%mm2\n"
+		"movq     24(%0), %%mm3\n"
+		"pmaddwd  16(%1), %%mm2\n"
+		"pmaddwd  24(%1), %%mm3\n"
+		"paddd     %%mm2, %%mm0\n"
+		"paddd     %%mm3, %%mm1\n"
+		"\n"
+		"movq     32(%0), %%mm2\n"
+		"movq     40(%0), %%mm3\n"
+		"pmaddwd  32(%1), %%mm2\n"
+		"pmaddwd  40(%1), %%mm3\n"
+		"paddd     %%mm2, %%mm0\n"
+		"paddd     %%mm3, %%mm1\n"
+		"\n"
+		"movq     48(%0), %%mm2\n"
+		"movq     56(%0), %%mm3\n"
+		"pmaddwd  48(%1), %%mm2\n"
+		"pmaddwd  56(%1), %%mm3\n"
+		"paddd     %%mm2, %%mm0\n"
+		"paddd     %%mm3, %%mm1\n"
+		"\n"
+		"movq     64(%0), %%mm2\n"
+		"movq     72(%0), %%mm3\n"
+		"pmaddwd  64(%1), %%mm2\n"
+		"pmaddwd  72(%1), %%mm3\n"
+		"paddd     %%mm2, %%mm0\n"
+		"paddd     %%mm3, %%mm1\n"
+		"\n"
+		"psrad        %4, %%mm0\n"
+		"psrad        %4, %%mm1\n"
+		"pshufw    $0x88, %%mm0, %%mm0\n"
+		"pshufw    $0x88, %%mm1, %%mm1\n"
+		"\n"
+		"movq      %%mm0, %%mm2\n"
+		"pmaddwd  80(%1), %%mm0\n"
+		"pmaddwd  88(%1), %%mm2\n"
+		"\n"
+		"movq      %%mm1, %%mm3\n"
+		"pmaddwd  96(%1), %%mm1\n"
+		"pmaddwd 104(%1), %%mm3\n"
+		"paddd     %%mm1, %%mm0\n"
+		"paddd     %%mm3, %%mm2\n"
+		"\n"
+		"movq      %%mm0, (%3)\n"
+		"movq      %%mm2, 8(%3)\n"
+		:
+		: "r" (in), "r" (const_table), "r" (&round_c), "r" (out),
+		  "i" (SBC_PROTO_FIXED4_SCALE)
+		: "memory");
+}
+
+static inline void sbc_analyze_4b_4s_mmx(int16_t *pcm, int16_t *x,
+					 int32_t *out, int out_stride)
+{
+	/* Input audio samples and do reordering for SIMD */
+	asm volatile (
+		"pshufw $0x23,  24(%0), %%mm0\n"
+		"pshufw $0x18,  16(%0), %%mm1\n"
+		"pinsrw    $1,  22(%0), %%mm0\n"
+		"pinsrw    $3,  26(%0), %%mm1\n"
+		"movq   %%mm0,   (%1)\n"
+		"movq   %%mm1,  8(%1)\n"
+		"movq   %%mm0, 128(%1)\n"
+		"movq   %%mm1, 136(%1)\n"
+		"\n"
+		"pshufw $0x23,   8(%0), %%mm0\n"
+		"pshufw $0x18,    (%0), %%mm1\n"
+		"pinsrw    $1,   6(%0), %%mm0\n"
+		"pinsrw    $3,  10(%0), %%mm1\n"
+		"movq   %%mm0,  16(%1)\n"
+		"movq   %%mm1,  24(%1)\n"
+		"movq   %%mm0, 144(%1)\n"
+		"movq   %%mm1, 152(%1)\n"
+		:
+		: "r" (pcm), "r" (x)
+		: "memory");
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
+	asm volatile ("emms");
+}
+
+#endif
+
+/*
+ * TODO: runtime MMX detection (right now -mmmx gcc option is required)
+ */
+void sbc_encoder_init_simd_optimized_analyze(
+	void (**sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
+				   int32_t *out, int out_stride),
+	void (**sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
+				   int32_t *out, int out_stride))
+{
+#ifdef USE_MMX
+	*sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
+#endif
+}
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index 8df8c1f..4955f93 100644
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


--Boundary-00=_hf5WJlE34UL6a4K--
