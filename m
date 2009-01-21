Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Audio quality improvement for 16-bit fixed point SBC encoder
Date: Thu, 22 Jan 2009 01:11:29 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hu6dJic4ktdsAWe"
Message-Id: <200901220111.29248.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_hu6dJic4ktdsAWe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

The attached patch quite noticeably minimizes rounding errors and improves
audio quality.

I decided to drop non-SIMD variant because it would require quite a bit of
work to update for better precision. Most of the CPU cores which are
relevant nowadays have support for some kind of SIMD extension anyway.
I will also do ARMv6 SIMD version of the analysis filter after all the high
level SBC optimizations are in place.

Audio quality estimation done with tiny_psnr (lower stddev value is better):

=== before patch (4 subbands) ===

./sbc_encode_test.rb BigBuckBunny-stereo.flac
[2, 48000]
["-j -s4 -B16 -b128", "-p -j -l16 -n4 -r1584000"]
--- comparing original / sbcenc + sbcdec ---
stddev:    3.58 PSNR: 85.23 bytes:114519660/114520000

--- comparing original / sbcenc + sbc_decoder.exe ---
stddev:    1.70 PSNR: 91.71 bytes:114519660/114520000

--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---
stddev:    1.44 PSNR: 93.09 bytes:114519660/114520000

--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe
stddev:    0.99 PSNR: 96.36 bytes:114519808/114519808

=== after patch (4 subbands) ===

./sbc_encode_test.rb BigBuckBunny-stereo.flac
[2, 48000]
["-j -s4 -B16 -b128", "-p -j -l16 -n4 -r1584000"]
--- comparing original / sbcenc + sbcdec ---
stddev:    3.55 PSNR: 85.31 bytes:114519660/114520000

--- comparing original / sbcenc + sbc_decoder.exe ---
stddev:    1.62 PSNR: 92.09 bytes:114519660/114520000

--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---
stddev:    1.44 PSNR: 93.09 bytes:114519660/114520000

--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe
stddev:    0.77 PSNR: 98.57 bytes:114519808/114519808

=== before patch (8 subbands) ===

./sbc_encode_test.rb BigBuckBunny-stereo.flac
[2, 48000]
["-j -s8 -B16 -b255", "-p -j -l16 -n8 -r1569000"]
--- comparing original / sbcenc + sbcdec ---
stddev:    4.85 PSNR: 82.60 bytes:114519260/114520000

--- comparing original / sbcenc + sbc_decoder.exe ---
stddev:    2.07 PSNR: 89.98 bytes:114519260/114520000

--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---
stddev:    1.09 PSNR: 95.56 bytes:114519260/114520000

--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe
stddev:    1.77 PSNR: 91.34 bytes:114519552/114519552

=== after patch (8 subbands) ===

./sbc_encode_test.rb BigBuckBunny-stereo.flac
[2, 48000]
["-j -s8 -B16 -b255", "-p -j -l16 -n8 -r1569000"]
--- comparing original / sbcenc + sbcdec ---
stddev:    4.55 PSNR: 83.16 bytes:114519260/114520000

--- comparing original / sbcenc + sbc_decoder.exe ---
stddev:    1.28 PSNR: 94.11 bytes:114519260/114520000

--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---
stddev:    1.09 PSNR: 95.56 bytes:114519260/114520000

--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe
stddev:    0.73 PSNR: 98.96 bytes:114519552/114519552

===

So for 4 subbands encode, stddev is down from 1.70 to 1.62 (1.44 for the
reference encoder). For 8 subbands encode stddev is down from 2.07 to 1.28
(1.09 for the reference encoder).


It is very interesting to see what a more advanced PEAQ test will show.


Best regards,
Siarhei Siamashka

--Boundary-00=_hu6dJic4ktdsAWe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Audio-quality-improvement-for-16-bit-fixed-point-SBC.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Audio-quality-improvement-for-16-bit-fixed-point-SBC.patch"

>From 7b6b60b25fbd20b9eab0c3f50d4ab121e4aee058 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 22 Jan 2009 00:12:40 +0200
Subject: [PATCH] Audio quality improvement for 16-bit fixed point SBC encoder

Multiplying the first part of the analysis filter constant tables
by some coefficients and dividing the second part by the same
coefficients is a transformation which should produce the same
results if rounding errors are not taken into account. These
additional C0/C1/... coefficients can be varied in a certain
range (the requirement is that we still do not get overflows).
The 'magic' values for these coefficients are selected in such
a way that the rounding errors are minimized (rounding errors
are unavoidable when putting all the floating constants into
16-bit tables and losing some of the fractional part).

Also non-SIMD variant of the analysis filter is dropped because
keeping it would require applying a similar change to its tables,
which is a bit tricky and just increases maintenance overhead.
---
 sbc/sbc_primitives.c |  157 ++----------------
 sbc/sbc_tables.h     |  460 ++++++++++++++++++++++++++++----------------------
 2 files changed, 270 insertions(+), 347 deletions(-)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index e3a7764..602b473 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -34,155 +34,22 @@
 #include "sbc_primitives_neon.h"
 
 /*
- * A standard C code of analysis filter.
- */
-static inline void sbc_analyze_four(const int16_t *in, int32_t *out)
-{
-	FIXED_A t1[4];
-	FIXED_T t2[4];
-	int i = 0, hop = 0;
-
-	/* rounding coefficient */
-	t1[0] = t1[1] = t1[2] = t1[3] =
-		(FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
-
-	/* low pass polyphase filter */
-	for (hop = 0; hop < 40; hop += 8) {
-		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed4[hop];
-		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed4[hop + 1];
-		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed4[hop + 2];
-		t1[1] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed4[hop + 3];
-		t1[0] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed4[hop + 4];
-		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed4[hop + 5];
-		t1[3] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed4[hop + 7];
-	}
-
-	/* scaling */
-	t2[0] = t1[0] >> SBC_PROTO_FIXED4_SCALE;
-	t2[1] = t1[1] >> SBC_PROTO_FIXED4_SCALE;
-	t2[2] = t1[2] >> SBC_PROTO_FIXED4_SCALE;
-	t2[3] = t1[3] >> SBC_PROTO_FIXED4_SCALE;
-
-	/* do the cos transform */
-	for (i = 0, hop = 0; i < 4; hop += 8, i++) {
-		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_4[0 + hop] +
-			(FIXED_A) t2[1] * cos_table_fixed_4[1 + hop] +
-			(FIXED_A) t2[2] * cos_table_fixed_4[2 + hop] +
-			(FIXED_A) t2[3] * cos_table_fixed_4[5 + hop]) >>
-			(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
-	}
-}
-
-static void sbc_analyze_4b_4s(int16_t *pcm, int16_t *x,
-						int32_t *out, int out_stride)
-{
-	int i;
-
-	/* Input 4 x 4 Audio Samples */
-	for (i = 0; i < 16; i += 4) {
-		x[64 + i] = x[0 + i] = pcm[15 - i];
-		x[65 + i] = x[1 + i] = pcm[14 - i];
-		x[66 + i] = x[2 + i] = pcm[13 - i];
-		x[67 + i] = x[3 + i] = pcm[12 - i];
-	}
-
-	/* Analyze four blocks */
-	sbc_analyze_four(x + 12, out);
-	out += out_stride;
-	sbc_analyze_four(x + 8, out);
-	out += out_stride;
-	sbc_analyze_four(x + 4, out);
-	out += out_stride;
-	sbc_analyze_four(x, out);
-}
-
-static inline void sbc_analyze_eight(const int16_t *in, int32_t *out)
-{
-	FIXED_A t1[8];
-	FIXED_T t2[8];
-	int i, hop;
-
-	/* rounding coefficient */
-	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
-		(FIXED_A) 1 << (SBC_PROTO_FIXED8_SCALE-1);
-
-	/* low pass polyphase filter */
-	for (hop = 0; hop < 80; hop += 16) {
-		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed8[hop];
-		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed8[hop + 1];
-		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed8[hop + 2];
-		t1[3] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed8[hop + 3];
-		t1[4] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed8[hop + 4];
-		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed8[hop + 5];
-		t1[2] += (FIXED_A) in[hop + 6] * _sbc_proto_fixed8[hop + 6];
-		t1[1] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed8[hop + 7];
-		t1[0] += (FIXED_A) in[hop + 8] * _sbc_proto_fixed8[hop + 8];
-		t1[5] += (FIXED_A) in[hop + 9] * _sbc_proto_fixed8[hop + 9];
-		t1[6] += (FIXED_A) in[hop + 10] * _sbc_proto_fixed8[hop + 10];
-		t1[7] += (FIXED_A) in[hop + 11] * _sbc_proto_fixed8[hop + 11];
-		t1[7] += (FIXED_A) in[hop + 13] * _sbc_proto_fixed8[hop + 13];
-		t1[6] += (FIXED_A) in[hop + 14] * _sbc_proto_fixed8[hop + 14];
-		t1[5] += (FIXED_A) in[hop + 15] * _sbc_proto_fixed8[hop + 15];
-	}
-
-	/* scaling */
-	t2[0] = t1[0] >> SBC_PROTO_FIXED8_SCALE;
-	t2[1] = t1[1] >> SBC_PROTO_FIXED8_SCALE;
-	t2[2] = t1[2] >> SBC_PROTO_FIXED8_SCALE;
-	t2[3] = t1[3] >> SBC_PROTO_FIXED8_SCALE;
-	t2[4] = t1[4] >> SBC_PROTO_FIXED8_SCALE;
-	t2[5] = t1[5] >> SBC_PROTO_FIXED8_SCALE;
-	t2[6] = t1[6] >> SBC_PROTO_FIXED8_SCALE;
-	t2[7] = t1[7] >> SBC_PROTO_FIXED8_SCALE;
-
-	/* do the cos transform */
-	for (i = 0, hop = 0; i < 8; hop += 16, i++) {
-		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_8[0 + hop] +
-			(FIXED_A) t2[1] * cos_table_fixed_8[1 + hop] +
-			(FIXED_A) t2[2] * cos_table_fixed_8[2 + hop] +
-			(FIXED_A) t2[3] * cos_table_fixed_8[3 + hop] +
-			(FIXED_A) t2[4] * cos_table_fixed_8[4 + hop] +
-			(FIXED_A) t2[5] * cos_table_fixed_8[9 + hop] +
-			(FIXED_A) t2[6] * cos_table_fixed_8[10 + hop] +
-			(FIXED_A) t2[7] * cos_table_fixed_8[11 + hop]) >>
-			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
-	}
-}
-
-static void sbc_analyze_4b_8s(int16_t *pcm, int16_t *x,
-						int32_t *out, int out_stride)
-{
-	int i;
-
-	/* Input 4 x 8 Audio Samples */
-	for (i = 0; i < 32; i += 8) {
-		x[128 + i] = x[0 + i] = pcm[31 - i];
-		x[129 + i] = x[1 + i] = pcm[30 - i];
-		x[130 + i] = x[2 + i] = pcm[29 - i];
-		x[131 + i] = x[3 + i] = pcm[28 - i];
-		x[132 + i] = x[4 + i] = pcm[27 - i];
-		x[133 + i] = x[5 + i] = pcm[26 - i];
-		x[134 + i] = x[6 + i] = pcm[25 - i];
-		x[135 + i] = x[7 + i] = pcm[24 - i];
-	}
-
-	/* Analyze four blocks */
-	sbc_analyze_eight(x + 24, out);
-	out += out_stride;
-	sbc_analyze_eight(x + 16, out);
-	out += out_stride;
-	sbc_analyze_eight(x + 8, out);
-	out += out_stride;
-	sbc_analyze_eight(x, out);
-}
-
-/*
  * A reference C code of analysis filter with SIMD-friendly tables
  * reordering and code layout. This code can be used to develop platform
  * specific SIMD optimizations. Also it may be used as some kind of test
  * for compiler autovectorization capabilities (who knows, if the compiler
  * is very good at this stuff, hand optimized assembly may be not strictly
  * needed for some platform).
+ *
+ * Note: It is also possible to make a simple variant of analysis filter,
+ * which needs only a single constants table without taking care about
+ * even/odd cases. This simple variant of filter can be implemented without
+ * input data permutation. The only thing that would be lost is the
+ * possibility to use pairwise SIMD multiplications. But for some simple
+ * CPU cores without SIMD extensions it can be useful. If anybody is
+ * interested in implementing such variant of a filter, sourcecode from
+ * bluez versions 4.26/4.27 can be used as a reference and the history of
+ * the changes in git repository done around that time may be worth checking.
  */
 
 static inline void sbc_analyze_four_simd(const int16_t *in, int32_t *out,
@@ -398,8 +265,8 @@ static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
 	/* Default implementation for analyze functions */
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
 
 	/* X86/AMD64 optimizations */
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index bed7e2e..0057c73 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -234,8 +234,8 @@ static const FIXED_T cos_table_fixed_4[32] = {
  * in order to compensate the same change applied to cos_table_fixed_8
  */
 #define SBC_PROTO_FIXED8_SCALE \
-	((sizeof(FIXED_T) * CHAR_BIT - 1) - SBC_FIXED_EXTRA_BITS + 2)
-#define F_PROTO8(x) (FIXED_A) ((x * 4) * \
+	((sizeof(FIXED_T) * CHAR_BIT - 1) - SBC_FIXED_EXTRA_BITS + 1)
+#define F_PROTO8(x) (FIXED_A) ((x * 2) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
 #define F(x) F_PROTO8(x)
 static const FIXED_T _sbc_proto_fixed8[80] = {
@@ -375,229 +375,285 @@ static const FIXED_T cos_table_fixed_8[128] = {
  */
 
 static const FIXED_T SBC_ALIGNED analysis_consts_fixed4_simd_even[40 + 16] = {
+#define C0 1.0932568993
+#define C1 1.3056875580
+#define C2 1.3056875580
+#define C3 1.6772280856
+
 #define F(x) F_PROTO4(x)
-	F(0.00000000E+00),  F(3.83720193E-03),
-	F(5.36548976E-04),  F(2.73370904E-03),
-	F(3.06012286E-03),  F(3.89205149E-03),
-	F(0.00000000E+00), -F(1.49188357E-03),
-	F(1.09137620E-02),  F(2.58767811E-02),
-	F(2.04385087E-02),  F(3.21939290E-02),
-	F(7.76463494E-02),  F(6.13245186E-03),
-	F(0.00000000E+00), -F(2.88757392E-02),
-	F(1.35593274E-01),  F(2.94315332E-01),
-	F(1.94987841E-01),  F(2.81828203E-01),
-	-F(1.94987841E-01),  F(2.81828203E-01),
-	F(0.00000000E+00), -F(2.46636662E-01),
-	-F(1.35593274E-01),  F(2.58767811E-02),
-	-F(7.76463494E-02),  F(6.13245186E-03),
-	-F(2.04385087E-02),  F(3.21939290E-02),
-	F(0.00000000E+00),  F(2.88217274E-02),
-	-F(1.09137620E-02),  F(3.83720193E-03),
-	-F(3.06012286E-03),  F(3.89205149E-03),
-	-F(5.36548976E-04),  F(2.73370904E-03),
-	F(0.00000000E+00), -F(1.86581691E-03),
+	 F(0.00000000E+00 * C0),  F(3.83720193E-03 * C0),
+	 F(5.36548976E-04 * C1),  F(2.73370904E-03 * C1),
+	 F(3.06012286E-03 * C2),  F(3.89205149E-03 * C2),
+	 F(0.00000000E+00 * C3), -F(1.49188357E-03 * C3),
+	 F(1.09137620E-02 * C0),  F(2.58767811E-02 * C0),
+	 F(2.04385087E-02 * C1),  F(3.21939290E-02 * C1),
+	 F(7.76463494E-02 * C2),  F(6.13245186E-03 * C2),
+	 F(0.00000000E+00 * C3), -F(2.88757392E-02 * C3),
+	 F(1.35593274E-01 * C0),  F(2.94315332E-01 * C0),
+	 F(1.94987841E-01 * C1),  F(2.81828203E-01 * C1),
+	-F(1.94987841E-01 * C2),  F(2.81828203E-01 * C2),
+	 F(0.00000000E+00 * C3), -F(2.46636662E-01 * C3),
+	-F(1.35593274E-01 * C0),  F(2.58767811E-02 * C0),
+	-F(7.76463494E-02 * C1),  F(6.13245186E-03 * C1),
+	-F(2.04385087E-02 * C2),  F(3.21939290E-02 * C2),
+	 F(0.00000000E+00 * C3),  F(2.88217274E-02 * C3),
+	-F(1.09137620E-02 * C0),  F(3.83720193E-03 * C0),
+	-F(3.06012286E-03 * C1),  F(3.89205149E-03 * C1),
+	-F(5.36548976E-04 * C2),  F(2.73370904E-03 * C2),
+	 F(0.00000000E+00 * C3), -F(1.86581691E-03 * C3),
 #undef F
 #define F(x) F_COS4(x)
-	F(0.7071067812),  F(0.9238795325),
-	-F(0.7071067812),  F(0.3826834324),
-	-F(0.7071067812), -F(0.3826834324),
-	F(0.7071067812), -F(0.9238795325),
-	F(0.3826834324), -F(1.0000000000),
-	-F(0.9238795325), -F(1.0000000000),
-	F(0.9238795325), -F(1.0000000000),
-	-F(0.3826834324), -F(1.0000000000),
+	 F(0.7071067812 / C0),  F(0.9238795325 / C1),
+	-F(0.7071067812 / C0),  F(0.3826834324 / C1),
+	-F(0.7071067812 / C0), -F(0.3826834324 / C1),
+	 F(0.7071067812 / C0), -F(0.9238795325 / C1),
+	 F(0.3826834324 / C2), -F(1.0000000000 / C3),
+	-F(0.9238795325 / C2), -F(1.0000000000 / C3),
+	 F(0.9238795325 / C2), -F(1.0000000000 / C3),
+	-F(0.3826834324 / C2), -F(1.0000000000 / C3),
 #undef F
+
+#undef C0
+#undef C1
+#undef C2
+#undef C3
 };
 
 static const FIXED_T SBC_ALIGNED analysis_consts_fixed4_simd_odd[40 + 16] = {
+#define C0 1.3056875580
+#define C1 1.6772280856
+#define C2 1.0932568993
+#define C3 1.3056875580
+
 #define F(x) F_PROTO4(x)
-	F(2.73370904E-03),  F(5.36548976E-04),
-	-F(1.49188357E-03),  F(0.00000000E+00),
-	F(3.83720193E-03),  F(1.09137620E-02),
-	F(3.89205149E-03),  F(3.06012286E-03),
-	F(3.21939290E-02),  F(2.04385087E-02),
-	-F(2.88757392E-02),  F(0.00000000E+00),
-	F(2.58767811E-02),  F(1.35593274E-01),
-	F(6.13245186E-03),  F(7.76463494E-02),
-	F(2.81828203E-01),  F(1.94987841E-01),
-	-F(2.46636662E-01),  F(0.00000000E+00),
-	F(2.94315332E-01), -F(1.35593274E-01),
-	F(2.81828203E-01), -F(1.94987841E-01),
-	F(6.13245186E-03), -F(7.76463494E-02),
-	F(2.88217274E-02),  F(0.00000000E+00),
-	F(2.58767811E-02), -F(1.09137620E-02),
-	F(3.21939290E-02), -F(2.04385087E-02),
-	F(3.89205149E-03), -F(3.06012286E-03),
-	-F(1.86581691E-03),  F(0.00000000E+00),
-	F(3.83720193E-03),  F(0.00000000E+00),
-	F(2.73370904E-03), -F(5.36548976E-04),
+	 F(2.73370904E-03 * C0),  F(5.36548976E-04 * C0),
+	-F(1.49188357E-03 * C1),  F(0.00000000E+00 * C1),
+	 F(3.83720193E-03 * C2),  F(1.09137620E-02 * C2),
+	 F(3.89205149E-03 * C3),  F(3.06012286E-03 * C3),
+	 F(3.21939290E-02 * C0),  F(2.04385087E-02 * C0),
+	-F(2.88757392E-02 * C1),  F(0.00000000E+00 * C1),
+	 F(2.58767811E-02 * C2),  F(1.35593274E-01 * C2),
+	 F(6.13245186E-03 * C3),  F(7.76463494E-02 * C3),
+	 F(2.81828203E-01 * C0),  F(1.94987841E-01 * C0),
+	-F(2.46636662E-01 * C1),  F(0.00000000E+00 * C1),
+	 F(2.94315332E-01 * C2), -F(1.35593274E-01 * C2),
+	 F(2.81828203E-01 * C3), -F(1.94987841E-01 * C3),
+	 F(6.13245186E-03 * C0), -F(7.76463494E-02 * C0),
+	 F(2.88217274E-02 * C1),  F(0.00000000E+00 * C1),
+	 F(2.58767811E-02 * C2), -F(1.09137620E-02 * C2),
+	 F(3.21939290E-02 * C3), -F(2.04385087E-02 * C3),
+	 F(3.89205149E-03 * C0), -F(3.06012286E-03 * C0),
+	-F(1.86581691E-03 * C1),  F(0.00000000E+00 * C1),
+	 F(3.83720193E-03 * C2),  F(0.00000000E+00 * C2),
+	 F(2.73370904E-03 * C3), -F(5.36548976E-04 * C3),
 #undef F
 #define F(x) F_COS4(x)
-	F(0.9238795325), -F(1.0000000000),
-	F(0.3826834324), -F(1.0000000000),
-	-F(0.3826834324), -F(1.0000000000),
-	-F(0.9238795325), -F(1.0000000000),
-	F(0.7071067812),  F(0.3826834324),
-	-F(0.7071067812), -F(0.9238795325),
-	-F(0.7071067812),  F(0.9238795325),
-	F(0.7071067812), -F(0.3826834324),
+	 F(0.9238795325 / C0), -F(1.0000000000 / C1),
+	 F(0.3826834324 / C0), -F(1.0000000000 / C1),
+	-F(0.3826834324 / C0), -F(1.0000000000 / C1),
+	-F(0.9238795325 / C0), -F(1.0000000000 / C1),
+	 F(0.7071067812 / C2),  F(0.3826834324 / C3),
+	-F(0.7071067812 / C2), -F(0.9238795325 / C3),
+	-F(0.7071067812 / C2),  F(0.9238795325 / C3),
+	 F(0.7071067812 / C2), -F(0.3826834324 / C3),
 #undef F
+
+#undef C0
+#undef C1
+#undef C2
+#undef C3
 };
 
 static const FIXED_T SBC_ALIGNED analysis_consts_fixed8_simd_even[80 + 64] = {
+#define C0 2.7906148894
+#define C1 2.4270044280
+#define C2 2.8015616024
+#define C3 3.1710363741
+#define C4 2.5377944043
+#define C5 2.4270044280
+#define C6 2.8015616024
+#define C7 3.1710363741
+
 #define F(x) F_PROTO8(x)
-	F(0.00000000E+00),  F(2.01182542E-03),
-	F(1.56575398E-04),  F(1.78371725E-03),
-	F(3.43256425E-04),  F(1.47640169E-03),
-	F(5.54620202E-04),  F(1.13992507E-03),
-	-F(8.23919506E-04),  F(0.00000000E+00),
-	F(2.10371989E-03),  F(3.49717454E-03),
-	F(1.99454554E-03),  F(1.64973098E-03),
-	F(1.61656283E-03),  F(1.78805361E-04),
-	F(5.65949473E-03),  F(1.29371806E-02),
-	F(8.02941163E-03),  F(1.53184106E-02),
-	F(1.04584443E-02),  F(1.62208471E-02),
-	F(1.27472335E-02),  F(1.59045603E-02),
-	-F(1.46525263E-02),  F(0.00000000E+00),
-	F(8.85757540E-03),  F(5.31873032E-02),
-	F(2.92408442E-03),  F(3.90751381E-02),
-	-F(4.91578024E-03),  F(2.61098752E-02),
-	F(6.79989431E-02),  F(1.46955068E-01),
-	F(8.29847578E-02),  F(1.45389847E-01),
-	F(9.75753918E-02),  F(1.40753505E-01),
-	F(1.11196689E-01),  F(1.33264415E-01),
-	-F(1.23264548E-01),  F(0.00000000E+00),
-	F(1.45389847E-01), -F(8.29847578E-02),
-	F(1.40753505E-01), -F(9.75753918E-02),
-	F(1.33264415E-01), -F(1.11196689E-01),
-	-F(6.79989431E-02),  F(1.29371806E-02),
-	-F(5.31873032E-02),  F(8.85757540E-03),
-	-F(3.90751381E-02),  F(2.92408442E-03),
-	-F(2.61098752E-02), -F(4.91578024E-03),
-	F(1.46404076E-02),  F(0.00000000E+00),
-	F(1.53184106E-02), -F(8.02941163E-03),
-	F(1.62208471E-02), -F(1.04584443E-02),
-	F(1.59045603E-02), -F(1.27472335E-02),
-	-F(5.65949473E-03),  F(2.01182542E-03),
-	-F(3.49717454E-03),  F(2.10371989E-03),
-	-F(1.64973098E-03),  F(1.99454554E-03),
-	-F(1.78805361E-04),  F(1.61656283E-03),
-	-F(9.02154502E-04),  F(0.00000000E+00),
-	F(1.78371725E-03), -F(1.56575398E-04),
-	F(1.47640169E-03), -F(3.43256425E-04),
-	F(1.13992507E-03), -F(5.54620202E-04),
+	 F(0.00000000E+00 * C0),  F(2.01182542E-03 * C0),
+	 F(1.56575398E-04 * C1),  F(1.78371725E-03 * C1),
+	 F(3.43256425E-04 * C2),  F(1.47640169E-03 * C2),
+	 F(5.54620202E-04 * C3),  F(1.13992507E-03 * C3),
+	-F(8.23919506E-04 * C4),  F(0.00000000E+00 * C4),
+	 F(2.10371989E-03 * C5),  F(3.49717454E-03 * C5),
+	 F(1.99454554E-03 * C6),  F(1.64973098E-03 * C6),
+	 F(1.61656283E-03 * C7),  F(1.78805361E-04 * C7),
+	 F(5.65949473E-03 * C0),  F(1.29371806E-02 * C0),
+	 F(8.02941163E-03 * C1),  F(1.53184106E-02 * C1),
+	 F(1.04584443E-02 * C2),  F(1.62208471E-02 * C2),
+	 F(1.27472335E-02 * C3),  F(1.59045603E-02 * C3),
+	-F(1.46525263E-02 * C4),  F(0.00000000E+00 * C4),
+	 F(8.85757540E-03 * C5),  F(5.31873032E-02 * C5),
+	 F(2.92408442E-03 * C6),  F(3.90751381E-02 * C6),
+	-F(4.91578024E-03 * C7),  F(2.61098752E-02 * C7),
+	 F(6.79989431E-02 * C0),  F(1.46955068E-01 * C0),
+	 F(8.29847578E-02 * C1),  F(1.45389847E-01 * C1),
+	 F(9.75753918E-02 * C2),  F(1.40753505E-01 * C2),
+	 F(1.11196689E-01 * C3),  F(1.33264415E-01 * C3),
+	-F(1.23264548E-01 * C4),  F(0.00000000E+00 * C4),
+	 F(1.45389847E-01 * C5), -F(8.29847578E-02 * C5),
+	 F(1.40753505E-01 * C6), -F(9.75753918E-02 * C6),
+	 F(1.33264415E-01 * C7), -F(1.11196689E-01 * C7),
+	-F(6.79989431E-02 * C0),  F(1.29371806E-02 * C0),
+	-F(5.31873032E-02 * C1),  F(8.85757540E-03 * C1),
+	-F(3.90751381E-02 * C2),  F(2.92408442E-03 * C2),
+	-F(2.61098752E-02 * C3), -F(4.91578024E-03 * C3),
+	 F(1.46404076E-02 * C4),  F(0.00000000E+00 * C4),
+	 F(1.53184106E-02 * C5), -F(8.02941163E-03 * C5),
+	 F(1.62208471E-02 * C6), -F(1.04584443E-02 * C6),
+	 F(1.59045603E-02 * C7), -F(1.27472335E-02 * C7),
+	-F(5.65949473E-03 * C0),  F(2.01182542E-03 * C0),
+	-F(3.49717454E-03 * C1),  F(2.10371989E-03 * C1),
+	-F(1.64973098E-03 * C2),  F(1.99454554E-03 * C2),
+	-F(1.78805361E-04 * C3),  F(1.61656283E-03 * C3),
+	-F(9.02154502E-04 * C4),  F(0.00000000E+00 * C4),
+	 F(1.78371725E-03 * C5), -F(1.56575398E-04 * C5),
+	 F(1.47640169E-03 * C6), -F(3.43256425E-04 * C6),
+	 F(1.13992507E-03 * C7), -F(5.54620202E-04 * C7),
 #undef F
 #define F(x) F_COS8(x)
-	F(0.7071067812),  F(0.8314696123),
-	-F(0.7071067812), -F(0.1950903220),
-	-F(0.7071067812), -F(0.9807852804),
-	F(0.7071067812), -F(0.5555702330),
-	F(0.7071067812),  F(0.5555702330),
-	-F(0.7071067812),  F(0.9807852804),
-	-F(0.7071067812),  F(0.1950903220),
-	F(0.7071067812), -F(0.8314696123),
-	F(0.9238795325),  F(0.9807852804),
-	F(0.3826834324),  F(0.8314696123),
-	-F(0.3826834324),  F(0.5555702330),
-	-F(0.9238795325),  F(0.1950903220),
-	-F(0.9238795325), -F(0.1950903220),
-	-F(0.3826834324), -F(0.5555702330),
-	F(0.3826834324), -F(0.8314696123),
-	F(0.9238795325), -F(0.9807852804),
-	-F(1.0000000000),  F(0.5555702330),
-	-F(1.0000000000), -F(0.9807852804),
-	-F(1.0000000000),  F(0.1950903220),
-	-F(1.0000000000),  F(0.8314696123),
-	-F(1.0000000000), -F(0.8314696123),
-	-F(1.0000000000), -F(0.1950903220),
-	-F(1.0000000000),  F(0.9807852804),
-	-F(1.0000000000), -F(0.5555702330),
-	F(0.3826834324),  F(0.1950903220),
-	-F(0.9238795325), -F(0.5555702330),
-	F(0.9238795325),  F(0.8314696123),
-	-F(0.3826834324), -F(0.9807852804),
-	-F(0.3826834324),  F(0.9807852804),
-	F(0.9238795325), -F(0.8314696123),
-	-F(0.9238795325),  F(0.5555702330),
-	F(0.3826834324), -F(0.1950903220),
+	 F(0.7071067812 / C0),  F(0.8314696123 / C1),
+	-F(0.7071067812 / C0), -F(0.1950903220 / C1),
+	-F(0.7071067812 / C0), -F(0.9807852804 / C1),
+	 F(0.7071067812 / C0), -F(0.5555702330 / C1),
+	 F(0.7071067812 / C0),  F(0.5555702330 / C1),
+	-F(0.7071067812 / C0),  F(0.9807852804 / C1),
+	-F(0.7071067812 / C0),  F(0.1950903220 / C1),
+	 F(0.7071067812 / C0), -F(0.8314696123 / C1),
+	 F(0.9238795325 / C2),  F(0.9807852804 / C3),
+	 F(0.3826834324 / C2),  F(0.8314696123 / C3),
+	-F(0.3826834324 / C2),  F(0.5555702330 / C3),
+	-F(0.9238795325 / C2),  F(0.1950903220 / C3),
+	-F(0.9238795325 / C2), -F(0.1950903220 / C3),
+	-F(0.3826834324 / C2), -F(0.5555702330 / C3),
+	 F(0.3826834324 / C2), -F(0.8314696123 / C3),
+	 F(0.9238795325 / C2), -F(0.9807852804 / C3),
+	-F(1.0000000000 / C4),  F(0.5555702330 / C5),
+	-F(1.0000000000 / C4), -F(0.9807852804 / C5),
+	-F(1.0000000000 / C4),  F(0.1950903220 / C5),
+	-F(1.0000000000 / C4),  F(0.8314696123 / C5),
+	-F(1.0000000000 / C4), -F(0.8314696123 / C5),
+	-F(1.0000000000 / C4), -F(0.1950903220 / C5),
+	-F(1.0000000000 / C4),  F(0.9807852804 / C5),
+	-F(1.0000000000 / C4), -F(0.5555702330 / C5),
+	 F(0.3826834324 / C6),  F(0.1950903220 / C7),
+	-F(0.9238795325 / C6), -F(0.5555702330 / C7),
+	 F(0.9238795325 / C6),  F(0.8314696123 / C7),
+	-F(0.3826834324 / C6), -F(0.9807852804 / C7),
+	-F(0.3826834324 / C6),  F(0.9807852804 / C7),
+	 F(0.9238795325 / C6), -F(0.8314696123 / C7),
+	-F(0.9238795325 / C6),  F(0.5555702330 / C7),
+	 F(0.3826834324 / C6), -F(0.1950903220 / C7),
 #undef F
+
+#undef C0
+#undef C1
+#undef C2
+#undef C3
+#undef C4
+#undef C5
+#undef C6
+#undef C7
 };
 
 static const FIXED_T SBC_ALIGNED analysis_consts_fixed8_simd_odd[80 + 64] = {
+#define C0 2.5377944043
+#define C1 2.4270044280
+#define C2 2.8015616024
+#define C3 3.1710363741
+#define C4 2.7906148894
+#define C5 2.4270044280
+#define C6 2.8015616024
+#define C7 3.1710363741
+
 #define F(x) F_PROTO8(x)
-	F(0.00000000E+00), -F(8.23919506E-04),
-	F(1.56575398E-04),  F(1.78371725E-03),
-	F(3.43256425E-04),  F(1.47640169E-03),
-	F(5.54620202E-04),  F(1.13992507E-03),
-	F(2.01182542E-03),  F(5.65949473E-03),
-	F(2.10371989E-03),  F(3.49717454E-03),
-	F(1.99454554E-03),  F(1.64973098E-03),
-	F(1.61656283E-03),  F(1.78805361E-04),
-	F(0.00000000E+00), -F(1.46525263E-02),
-	F(8.02941163E-03),  F(1.53184106E-02),
-	F(1.04584443E-02),  F(1.62208471E-02),
-	F(1.27472335E-02),  F(1.59045603E-02),
-	F(1.29371806E-02),  F(6.79989431E-02),
-	F(8.85757540E-03),  F(5.31873032E-02),
-	F(2.92408442E-03),  F(3.90751381E-02),
-	-F(4.91578024E-03),  F(2.61098752E-02),
-	F(0.00000000E+00), -F(1.23264548E-01),
-	F(8.29847578E-02),  F(1.45389847E-01),
-	F(9.75753918E-02),  F(1.40753505E-01),
-	F(1.11196689E-01),  F(1.33264415E-01),
-	F(1.46955068E-01), -F(6.79989431E-02),
-	F(1.45389847E-01), -F(8.29847578E-02),
-	F(1.40753505E-01), -F(9.75753918E-02),
-	F(1.33264415E-01), -F(1.11196689E-01),
-	F(0.00000000E+00),  F(1.46404076E-02),
-	-F(5.31873032E-02),  F(8.85757540E-03),
-	-F(3.90751381E-02),  F(2.92408442E-03),
-	-F(2.61098752E-02), -F(4.91578024E-03),
-	F(1.29371806E-02), -F(5.65949473E-03),
-	F(1.53184106E-02), -F(8.02941163E-03),
-	F(1.62208471E-02), -F(1.04584443E-02),
-	F(1.59045603E-02), -F(1.27472335E-02),
-	F(0.00000000E+00), -F(9.02154502E-04),
-	-F(3.49717454E-03),  F(2.10371989E-03),
-	-F(1.64973098E-03),  F(1.99454554E-03),
-	-F(1.78805361E-04),  F(1.61656283E-03),
-	F(2.01182542E-03),  F(0.00000000E+00),
-	F(1.78371725E-03), -F(1.56575398E-04),
-	F(1.47640169E-03), -F(3.43256425E-04),
-	F(1.13992507E-03), -F(5.54620202E-04),
+	 F(0.00000000E+00 * C0), -F(8.23919506E-04 * C0),
+	 F(1.56575398E-04 * C1),  F(1.78371725E-03 * C1),
+	 F(3.43256425E-04 * C2),  F(1.47640169E-03 * C2),
+	 F(5.54620202E-04 * C3),  F(1.13992507E-03 * C3),
+	 F(2.01182542E-03 * C4),  F(5.65949473E-03 * C4),
+	 F(2.10371989E-03 * C5),  F(3.49717454E-03 * C5),
+	 F(1.99454554E-03 * C6),  F(1.64973098E-03 * C6),
+	 F(1.61656283E-03 * C7),  F(1.78805361E-04 * C7),
+	 F(0.00000000E+00 * C0), -F(1.46525263E-02 * C0),
+	 F(8.02941163E-03 * C1),  F(1.53184106E-02 * C1),
+	 F(1.04584443E-02 * C2),  F(1.62208471E-02 * C2),
+	 F(1.27472335E-02 * C3),  F(1.59045603E-02 * C3),
+	 F(1.29371806E-02 * C4),  F(6.79989431E-02 * C4),
+	 F(8.85757540E-03 * C5),  F(5.31873032E-02 * C5),
+	 F(2.92408442E-03 * C6),  F(3.90751381E-02 * C6),
+	-F(4.91578024E-03 * C7),  F(2.61098752E-02 * C7),
+	 F(0.00000000E+00 * C0), -F(1.23264548E-01 * C0),
+	 F(8.29847578E-02 * C1),  F(1.45389847E-01 * C1),
+	 F(9.75753918E-02 * C2),  F(1.40753505E-01 * C2),
+	 F(1.11196689E-01 * C3),  F(1.33264415E-01 * C3),
+	 F(1.46955068E-01 * C4), -F(6.79989431E-02 * C4),
+	 F(1.45389847E-01 * C5), -F(8.29847578E-02 * C5),
+	 F(1.40753505E-01 * C6), -F(9.75753918E-02 * C6),
+	 F(1.33264415E-01 * C7), -F(1.11196689E-01 * C7),
+	 F(0.00000000E+00 * C0),  F(1.46404076E-02 * C0),
+	-F(5.31873032E-02 * C1),  F(8.85757540E-03 * C1),
+	-F(3.90751381E-02 * C2),  F(2.92408442E-03 * C2),
+	-F(2.61098752E-02 * C3), -F(4.91578024E-03 * C3),
+	 F(1.29371806E-02 * C4), -F(5.65949473E-03 * C4),
+	 F(1.53184106E-02 * C5), -F(8.02941163E-03 * C5),
+	 F(1.62208471E-02 * C6), -F(1.04584443E-02 * C6),
+	 F(1.59045603E-02 * C7), -F(1.27472335E-02 * C7),
+	 F(0.00000000E+00 * C0), -F(9.02154502E-04 * C0),
+	-F(3.49717454E-03 * C1),  F(2.10371989E-03 * C1),
+	-F(1.64973098E-03 * C2),  F(1.99454554E-03 * C2),
+	-F(1.78805361E-04 * C3),  F(1.61656283E-03 * C3),
+	 F(2.01182542E-03 * C4),  F(0.00000000E+00 * C4),
+	 F(1.78371725E-03 * C5), -F(1.56575398E-04 * C5),
+	 F(1.47640169E-03 * C6), -F(3.43256425E-04 * C6),
+	 F(1.13992507E-03 * C7), -F(5.54620202E-04 * C7),
 #undef F
 #define F(x) F_COS8(x)
-	-F(1.0000000000),  F(0.8314696123),
-	-F(1.0000000000), -F(0.1950903220),
-	-F(1.0000000000), -F(0.9807852804),
-	-F(1.0000000000), -F(0.5555702330),
-	-F(1.0000000000),  F(0.5555702330),
-	-F(1.0000000000),  F(0.9807852804),
-	-F(1.0000000000),  F(0.1950903220),
-	-F(1.0000000000), -F(0.8314696123),
-	F(0.9238795325),  F(0.9807852804),
-	F(0.3826834324),  F(0.8314696123),
-	-F(0.3826834324),  F(0.5555702330),
-	-F(0.9238795325),  F(0.1950903220),
-	-F(0.9238795325), -F(0.1950903220),
-	-F(0.3826834324), -F(0.5555702330),
-	F(0.3826834324), -F(0.8314696123),
-	F(0.9238795325), -F(0.9807852804),
-	F(0.7071067812),  F(0.5555702330),
-	-F(0.7071067812), -F(0.9807852804),
-	-F(0.7071067812),  F(0.1950903220),
-	F(0.7071067812),  F(0.8314696123),
-	F(0.7071067812), -F(0.8314696123),
-	-F(0.7071067812), -F(0.1950903220),
-	-F(0.7071067812),  F(0.9807852804),
-	F(0.7071067812), -F(0.5555702330),
-	F(0.3826834324),  F(0.1950903220),
-	-F(0.9238795325), -F(0.5555702330),
-	F(0.9238795325),  F(0.8314696123),
-	-F(0.3826834324), -F(0.9807852804),
-	-F(0.3826834324),  F(0.9807852804),
-	F(0.9238795325), -F(0.8314696123),
-	-F(0.9238795325),  F(0.5555702330),
-	F(0.3826834324), -F(0.1950903220),
+	-F(1.0000000000 / C0),  F(0.8314696123 / C1),
+	-F(1.0000000000 / C0), -F(0.1950903220 / C1),
+	-F(1.0000000000 / C0), -F(0.9807852804 / C1),
+	-F(1.0000000000 / C0), -F(0.5555702330 / C1),
+	-F(1.0000000000 / C0),  F(0.5555702330 / C1),
+	-F(1.0000000000 / C0),  F(0.9807852804 / C1),
+	-F(1.0000000000 / C0),  F(0.1950903220 / C1),
+	-F(1.0000000000 / C0), -F(0.8314696123 / C1),
+	 F(0.9238795325 / C2),  F(0.9807852804 / C3),
+	 F(0.3826834324 / C2),  F(0.8314696123 / C3),
+	-F(0.3826834324 / C2),  F(0.5555702330 / C3),
+	-F(0.9238795325 / C2),  F(0.1950903220 / C3),
+	-F(0.9238795325 / C2), -F(0.1950903220 / C3),
+	-F(0.3826834324 / C2), -F(0.5555702330 / C3),
+	 F(0.3826834324 / C2), -F(0.8314696123 / C3),
+	 F(0.9238795325 / C2), -F(0.9807852804 / C3),
+	 F(0.7071067812 / C4),  F(0.5555702330 / C5),
+	-F(0.7071067812 / C4), -F(0.9807852804 / C5),
+	-F(0.7071067812 / C4),  F(0.1950903220 / C5),
+	 F(0.7071067812 / C4),  F(0.8314696123 / C5),
+	 F(0.7071067812 / C4), -F(0.8314696123 / C5),
+	-F(0.7071067812 / C4), -F(0.1950903220 / C5),
+	-F(0.7071067812 / C4),  F(0.9807852804 / C5),
+	 F(0.7071067812 / C4), -F(0.5555702330 / C5),
+	 F(0.3826834324 / C6),  F(0.1950903220 / C7),
+	-F(0.9238795325 / C6), -F(0.5555702330 / C7),
+	 F(0.9238795325 / C6),  F(0.8314696123 / C7),
+	-F(0.3826834324 / C6), -F(0.9807852804 / C7),
+	-F(0.3826834324 / C6),  F(0.9807852804 / C7),
+	 F(0.9238795325 / C6), -F(0.8314696123 / C7),
+	-F(0.9238795325 / C6),  F(0.5555702330 / C7),
+	 F(0.3826834324 / C6), -F(0.1950903220 / C7),
 #undef F
+
+#undef C0
+#undef C1
+#undef C2
+#undef C3
+#undef C4
+#undef C5
+#undef C6
+#undef C7
 };
-- 
1.5.6.5


--Boundary-00=_hu6dJic4ktdsAWe--
