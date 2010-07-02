Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 1/5] sbc: ARM NEON optimized joint stereo processing in SBC encoder
Date: Fri,  2 Jul 2010 15:25:38 +0300
Message-Id: <1278073542-14859-2-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

Improves SBC encoding performance when joint stereo is used, which
is a typical A2DP configuration.

Benchmarked on ARM Cortex-A8:

== Before: ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m5.239s
user    0m4.805s
sys     0m0.430s

samples  %        image name               symbol name
26083    25.0856  sbcenc                   sbc_pack_frame
21548    20.7240  sbcenc                   sbc_calc_scalefactors_j
19910    19.1486  sbcenc                   sbc_analyze_4b_8s_neon
14377    13.8272  sbcenc                   sbc_calculate_bits
9990      9.6080  sbcenc                   sbc_enc_process_input_8s_be
8667      8.3356  no-vmlinux               /no-vmlinux
2263      2.1765  sbcenc                   sbc_encode
696       0.6694  libc-2.10.1.so           memcpy

== After: ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m4.389s
user    0m3.969s
sys     0m0.422s

samples  %        image name               symbol name
26234    29.9625  sbcenc                   sbc_pack_frame
20057    22.9076  sbcenc                   sbc_analyze_4b_8s_neon
14306    16.3393  sbcenc                   sbc_calculate_bits
9866     11.2682  sbcenc                   sbc_enc_process_input_8s_be
8506      9.7149  no-vmlinux               /no-vmlinux
5219      5.9608  sbcenc                   sbc_calc_scalefactors_j_neon
2280      2.6040  sbcenc                   sbc_encode
661       0.7549  libc-2.10.1.so           memcpy
---
 sbc/sbc_primitives_neon.c |  243 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 243 insertions(+), 0 deletions(-)

diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index 2a4cdf0..c6a16ac 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -294,11 +294,254 @@ static void sbc_calc_scalefactors_neon(
 	}
 }
 
+int sbc_calc_scalefactors_j_neon(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int subbands)
+{
+	static SBC_ALIGNED int32_t joint_bits_mask[8] = {
+		8,   4,  2,  1, 128, 64, 32, 16
+	};
+	int joint, i;
+	int32_t  *in0, *in1;
+	int32_t  *in = &sb_sample_f[0][0][0];
+	uint32_t *out0, *out1;
+	uint32_t *out = &scale_factor[0][0];
+	int32_t  *consts = joint_bits_mask;
+
+	i = subbands;
+
+	asm volatile (
+		/*
+		 * constants: q13 = (31 - SCALE_OUT_BITS), q14 = 1
+		 * input:     q0  = ((1 << SCALE_OUT_BITS) + 1)
+		 *            %[in0] - samples for channel 0
+		 *            %[in1] - samples for shannel 1
+		 * output:    q0, q1 - scale factors without joint stereo
+		 *            q2, q3 - scale factors with joint stereo
+		 *            q15    - joint stereo selection mask
+		 */
+		".macro calc_scalefactors\n"
+			"vmov.s32  q1, q0\n"
+			"vmov.s32  q2, q0\n"
+			"vmov.s32  q3, q0\n"
+			"mov       %[i], %[blocks]\n"
+		"1:\n"
+			"vld1.32   {d18, d19}, [%[in1], :128], %[inc]\n"
+			"vbic.s32  q11, q9,  q14\n"
+			"vld1.32   {d16, d17}, [%[in0], :128], %[inc]\n"
+			"vhadd.s32 q10, q8,  q11\n"
+			"vhsub.s32 q11, q8,  q11\n"
+			"vabs.s32  q8,  q8\n"
+			"vabs.s32  q9,  q9\n"
+			"vabs.s32  q10, q10\n"
+			"vabs.s32  q11, q11\n"
+			"vmax.s32  q0,  q0,  q8\n"
+			"vmax.s32  q1,  q1,  q9\n"
+			"vmax.s32  q2,  q2,  q10\n"
+			"vmax.s32  q3,  q3,  q11\n"
+			"subs      %[i], %[i], #1\n"
+			"bgt       1b\n"
+			"vsub.s32  q0,  q0,  q14\n"
+			"vsub.s32  q1,  q1,  q14\n"
+			"vsub.s32  q2,  q2,  q14\n"
+			"vsub.s32  q3,  q3,  q14\n"
+			"vclz.s32  q0,  q0\n"
+			"vclz.s32  q1,  q1\n"
+			"vclz.s32  q2,  q2\n"
+			"vclz.s32  q3,  q3\n"
+			"vsub.s32  q0,  q13, q0\n"
+			"vsub.s32  q1,  q13, q1\n"
+			"vsub.s32  q2,  q13, q2\n"
+			"vsub.s32  q3,  q13, q3\n"
+		".endm\n"
+		/*
+		 * constants: q14 = 1
+		 * input: q15    - joint stereo selection mask
+		 *        %[in0] - value set by calc_scalefactors macro
+		 *        %[in1] - value set by calc_scalefactors macro
+		 */
+		".macro update_joint_stereo_samples\n"
+			"sub       %[out1], %[in1], %[inc]\n"
+			"sub       %[out0], %[in0], %[inc]\n"
+			"sub       %[in1], %[in1], %[inc], asl #1\n"
+			"sub       %[in0], %[in0], %[inc], asl #1\n"
+			"vld1.32   {d18, d19}, [%[in1], :128]\n"
+			"vbic.s32  q11, q9,  q14\n"
+			"vld1.32   {d16, d17}, [%[in0], :128]\n"
+			"vld1.32   {d2, d3}, [%[out1], :128]\n"
+			"vbic.s32  q3,  q1,  q14\n"
+			"vld1.32   {d0, d1}, [%[out0], :128]\n"
+			"vhsub.s32 q10, q8,  q11\n"
+			"vhadd.s32 q11, q8,  q11\n"
+			"vhsub.s32 q2,  q0,  q3\n"
+			"vhadd.s32 q3,  q0,  q3\n"
+			"vbif.s32  q10, q9,  q15\n"
+			"vbif.s32  d22, d16, d30\n"
+			"sub       %[inc], %[zero], %[inc], asl #1\n"
+			"sub       %[i], %[blocks], #2\n"
+		"2:\n"
+			"vbif.s32  d23, d17, d31\n"
+			"vst1.32   {d20, d21}, [%[in1], :128], %[inc]\n"
+			"vbif.s32  d4,  d2,  d30\n"
+			"vld1.32   {d18, d19}, [%[in1], :128]\n"
+			"vbif.s32  d5,  d3,  d31\n"
+			"vst1.32   {d22, d23}, [%[in0], :128], %[inc]\n"
+			"vbif.s32  d6,  d0,  d30\n"
+			"vld1.32   {d16, d17}, [%[in0], :128]\n"
+			"vbif.s32  d7,  d1,  d31\n"
+			"vst1.32   {d4, d5}, [%[out1], :128], %[inc]\n"
+			"vbic.s32  q11, q9,  q14\n"
+			"vld1.32   {d2, d3}, [%[out1], :128]\n"
+			"vst1.32   {d6, d7}, [%[out0], :128], %[inc]\n"
+			"vbic.s32  q3,  q1,  q14\n"
+			"vld1.32   {d0, d1}, [%[out0], :128]\n"
+			"vhsub.s32 q10, q8,  q11\n"
+			"vhadd.s32 q11, q8,  q11\n"
+			"vhsub.s32 q2,  q0,  q3\n"
+			"vhadd.s32 q3,  q0,  q3\n"
+			"vbif.s32  q10, q9,  q15\n"
+			"vbif.s32  d22, d16, d30\n"
+			"subs      %[i], %[i], #2\n"
+			"bgt       2b\n"
+			"sub       %[inc], %[zero], %[inc], asr #1\n"
+			"vbif.s32  d23, d17, d31\n"
+			"vst1.32   {d20, d21}, [%[in1], :128]\n"
+			"vbif.s32  q2,  q1,  q15\n"
+			"vst1.32   {d22, d23}, [%[in0], :128]\n"
+			"vbif.s32  q3,  q0,  q15\n"
+			"vst1.32   {d4, d5}, [%[out1], :128]\n"
+			"vst1.32   {d6, d7}, [%[out0], :128]\n"
+		".endm\n"
+
+		"vmov.s32  q14, #1\n"
+		"vmov.s32  q13, %[c2]\n"
+
+		"cmp   %[i], #4\n"
+		"bne   8f\n"
+
+	"4:\n" /* 4 subbands */
+		"add   %[in0], %[in], #0\n"
+		"add   %[in1], %[in], #32\n"
+		"add   %[out0], %[out], #0\n"
+		"add   %[out1], %[out], #32\n"
+		"vmov.s32  q0, %[c1]\n"
+		"vadd.s32  q0, q0, q14\n"
+
+		"calc_scalefactors\n"
+
+		/* check whether to use joint stereo for subbands 0, 1, 2 */
+		"vadd.s32  q15, q0,  q1\n"
+		"vadd.s32  q9,  q2,  q3\n"
+		"vmov.s32  d31[1], %[zero]\n" /* last subband -> no joint */
+		"vld1.32   {d16, d17}, [%[consts], :128]!\n"
+		"vcgt.s32  q15, q15, q9\n"
+
+		/* calculate and save to memory 'joint' variable */
+		/* update and save scale factors to memory */
+		"  vand.s32  q8, q8, q15\n"
+		"vbit.s32  q0,  q2,  q15\n"
+		"  vpadd.s32 d16, d16, d17\n"
+		"vbit.s32  q1,  q3,  q15\n"
+		"  vpadd.s32 d16, d16, d16\n"
+		"vst1.32   {d0, d1}, [%[out0], :128]\n"
+		"vst1.32   {d2, d3}, [%[out1], :128]\n"
+		"  vst1.32   {d16[0]}, [%[joint]]\n"
+
+		"update_joint_stereo_samples\n"
+		"b     9f\n"
+
+	"8:\n" /* 8 subbands */
+		"add   %[in0], %[in], #16\n\n"
+		"add   %[in1], %[in], #48\n"
+		"add   %[out0], %[out], #16\n\n"
+		"add   %[out1], %[out], #48\n"
+		"vmov.s32  q0, %[c1]\n"
+		"vadd.s32  q0, q0, q14\n"
+
+		"calc_scalefactors\n"
+
+		/* check whether to use joint stereo for subbands 4, 5, 6 */
+		"vadd.s32  q15, q0,  q1\n"
+		"vadd.s32  q9,  q2,  q3\n"
+		"vmov.s32  d31[1], %[zero]\n"  /* last subband -> no joint */
+		"vld1.32   {d16, d17}, [%[consts], :128]!\n"
+		"vcgt.s32  q15, q15, q9\n"
+
+		/* calculate part of 'joint' variable and save it to d24 */
+		/* update and save scale factors to memory */
+		"  vand.s32  q8, q8, q15\n"
+		"vbit.s32  q0,  q2,  q15\n"
+		"  vpadd.s32 d16, d16, d17\n"
+		"vbit.s32  q1,  q3,  q15\n"
+		"vst1.32   {d0, d1}, [%[out0], :128]\n"
+		"vst1.32   {d2, d3}, [%[out1], :128]\n"
+		"  vpadd.s32 d24, d16, d16\n"
+
+		"update_joint_stereo_samples\n"
+
+		"add   %[in0], %[in], #0\n"
+		"add   %[in1], %[in], #32\n"
+		"add   %[out0], %[out], #0\n\n"
+		"add   %[out1], %[out], #32\n"
+		"vmov.s32  q0, %[c1]\n"
+		"vadd.s32  q0, q0, q14\n"
+
+		"calc_scalefactors\n"
+
+		/* check whether to use joint stereo for subbands 0, 1, 2, 3 */
+		"vadd.s32  q15, q0,  q1\n"
+		"vadd.s32  q9,  q2,  q3\n"
+		"vld1.32   {d16, d17}, [%[consts], :128]!\n"
+		"vcgt.s32  q15, q15, q9\n"
+
+		/* combine last part of 'joint' with d24 and save to memory */
+		/* update and save scale factors to memory */
+		"  vand.s32  q8, q8, q15\n"
+		"vbit.s32  q0,  q2,  q15\n"
+		"  vpadd.s32 d16, d16, d17\n"
+		"vbit.s32  q1,  q3,  q15\n"
+		"  vpadd.s32 d16, d16, d16\n"
+		"vst1.32   {d0, d1}, [%[out0], :128]\n"
+		"  vadd.s32  d16, d16, d24\n"
+		"vst1.32   {d2, d3}, [%[out1], :128]\n"
+		"  vst1.32   {d16[0]}, [%[joint]]\n"
+
+		"update_joint_stereo_samples\n"
+	"9:\n"
+		".purgem calc_scalefactors\n"
+		".purgem update_joint_stereo_samples\n"
+		:
+		  [i]      "+&r" (i),
+		  [in]     "+&r" (in),
+		  [in0]    "=&r" (in0),
+		  [in1]    "=&r" (in1),
+		  [out]    "+&r" (out),
+		  [out0]   "=&r" (out0),
+		  [out1]   "=&r" (out1),
+		  [consts] "+&r" (consts)
+		:
+		  [inc]      "r" ((char *) &sb_sample_f[1][0][0] -
+				 (char *) &sb_sample_f[0][0][0]),
+		  [blocks]   "r" (blocks),
+		  [joint]    "r" (&joint),
+		  [c1]       "i" (1 << SCALE_OUT_BITS),
+		  [c2]       "i" (31 - SCALE_OUT_BITS),
+		  [zero]     "r" (0)
+		: "d0", "d1", "d2", "d3", "d4", "d5", "d6", "d7",
+		  "d16", "d17", "d18", "d19", "d20", "d21", "d22",
+		  "d23", "d24", "d25", "d26", "d27", "d28", "d29",
+		  "d30", "d31", "cc", "memory");
+
+	return joint;
+}
+
 void sbc_init_primitives_neon(struct sbc_encoder_state *state)
 {
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_neon;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_neon;
 	state->sbc_calc_scalefactors = sbc_calc_scalefactors_neon;
+	state->sbc_calc_scalefactors_j = sbc_calc_scalefactors_j_neon;
 	state->implementation_info = "NEON";
 }
 
-- 
1.6.4.4

