Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 3/3] sbc: ARM NEON optimization for scale factors calculation
Date: Tue, 29 Jun 2010 16:48:47 +0300
Message-Id: <1277819327-28592-4-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

Improves SBC encoding performance when joint stereo is not used.
Benchmarked on ARM Cortex-A8:

== Before: ==

$ time ./sbcenc -b53 -s8 test.au > /dev/null

real    0m4.756s
user    0m4.313s
sys     0m0.438s

samples  %        image name               symbol name
2569     27.6296  sbcenc                   sbc_pack_frame
1934     20.8002  sbcenc                   sbc_analyze_4b_8s_neon
1386     14.9064  sbcenc                   sbc_calculate_bits
1221     13.1319  sbcenc                   sbc_calc_scalefactors
996      10.7120  sbcenc                   sbc_enc_process_input_8s_be
878       9.4429  no-vmlinux               /no-vmlinux
204       2.1940  sbcenc                   sbc_encode
56        0.6023  libc-2.10.1.so           memcpy

== After: ==

$ time ./sbcenc -b53 -s8 test.au > /dev/null

real    0m4.220s
user    0m3.797s
sys     0m0.422s

samples  %        image name               symbol name
2563     31.3249  sbcenc                   sbc_pack_frame
1892     23.1239  sbcenc                   sbc_analyze_4b_8s_neon
1368     16.7196  sbcenc                   sbc_calculate_bits
961      11.7453  sbcenc                   sbc_enc_process_input_8s_be
836      10.2176  no-vmlinux               /no-vmlinux
262       3.2022  sbcenc                   sbc_calc_scalefactors_neon
199       2.4322  sbcenc                   sbc_encode
49        0.5989  libc-2.10.1.so           memcpy
---
 sbc/sbc.c                 |    2 +-
 sbc/sbc_primitives_neon.c |   58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7da7313..569dd7c 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -78,7 +78,7 @@ struct sbc_frame {
 	uint8_t joint;
 
 	/* only the lower 4 bits of every element are to be used */
-	uint32_t scale_factor[2][8];
+	uint32_t SBC_ALIGNED scale_factor[2][8];
 
 	/* raw integer subband samples in the frame */
 	int32_t SBC_ALIGNED sb_sample_f[16][2][8];
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index d20eeca..2a4cdf0 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -237,10 +237,68 @@ static inline void sbc_analyze_4b_8s_neon(int16_t *x,
 	_sbc_analyze_eight_neon(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+static void sbc_calc_scalefactors_neon(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	int ch, sb;
+	for (ch = 0; ch < channels; ch++) {
+		for (sb = 0; sb < subbands; sb += 4) {
+			int blk = blocks;
+			int32_t *in = &sb_sample_f[0][ch][sb];
+			asm volatile (
+				"vmov.s32  q0, %[c1]\n"
+				"vmov.s32  q1, %[c1]\n"
+			"1:\n"
+				"vld1.32   {d16, d17}, [%[in], :128], %[inc]\n"
+				"vabs.s32  q8,  q8\n"
+				"vld1.32   {d18, d19}, [%[in], :128], %[inc]\n"
+				"vabs.s32  q9,  q9\n"
+				"vld1.32   {d20, d21}, [%[in], :128], %[inc]\n"
+				"vabs.s32  q10, q10\n"
+				"vld1.32   {d22, d23}, [%[in], :128], %[inc]\n"
+				"vabs.s32  q11, q11\n"
+				"vcgt.s32  q12, q8,  #0\n"
+				"vcgt.s32  q13, q9,  #0\n"
+				"vcgt.s32  q14, q10, #0\n"
+				"vcgt.s32  q15, q11, #0\n"
+				"vadd.s32  q8,  q8,  q12\n"
+				"vadd.s32  q9,  q9,  q13\n"
+				"vadd.s32  q10, q10, q14\n"
+				"vadd.s32  q11, q11, q15\n"
+				"vorr.s32  q0,  q0,  q8\n"
+				"vorr.s32  q1,  q1,  q9\n"
+				"vorr.s32  q0,  q0,  q10\n"
+				"vorr.s32  q1,  q1,  q11\n"
+				"subs      %[blk], %[blk], #4\n"
+				"bgt       1b\n"
+				"vorr.s32  q0,  q0, q1\n"
+				"vmov.s32  q15, %[c2]\n"
+				"vclz.s32  q0,  q0\n"
+				"vsub.s32  q0,  q15, q0\n"
+				"vst1.32   {d0, d1}, [%[out], :128]\n"
+			:
+			  [blk]    "+r" (blk),
+			  [in]     "+r" (in)
+			:
+			  [inc]     "r" ((char *) &sb_sample_f[1][0][0] -
+					 (char *) &sb_sample_f[0][0][0]),
+			  [out]     "r" (&scale_factor[ch][sb]),
+			  [c1]      "i" (1 << SCALE_OUT_BITS),
+			  [c2]      "i" (31 - SCALE_OUT_BITS)
+			: "d0", "d1", "d2", "d3", "d16", "d17", "d18", "d19",
+			  "d20", "d21", "d22", "d23", "d24", "d25", "d26",
+			  "d27", "d28", "d29", "d30", "d31", "cc", "memory");
+		}
+	}
+}
+
 void sbc_init_primitives_neon(struct sbc_encoder_state *state)
 {
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_neon;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_neon;
+	state->sbc_calc_scalefactors = sbc_calc_scalefactors_neon;
 	state->implementation_info = "NEON";
 }
 
-- 
1.6.4.4

