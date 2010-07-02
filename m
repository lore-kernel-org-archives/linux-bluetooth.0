Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 3/5] sbc: slightly faster 'sbc_calc_scalefactors_neon'
Date: Fri,  2 Jul 2010 15:25:40 +0300
Message-Id: <1278073542-14859-4-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

Previous variant was basically derived from C and MMX implementations.
Now new variant makes use of 'vmax' instruction, which is available in
NEON and can do this job faster. The same method for calculating scale
factors is also used in 'sbc_calc_scalefactors_j_neon'.

Benchmarked without joint stereo on ARM Cortex-A8:

== Before: ==

$ time ./sbcenc -b53 -s8 test.au > /dev/null

real    0m3.851s
user    0m3.375s
sys     0m0.469s

samples  %        image name               symbol name
26260    34.2672  sbcenc                   sbc_pack_frame
20013    26.1154  sbcenc                   sbc_analyze_4b_8s_neon
13796    18.0027  sbcenc                   sbc_calculate_bits
8388     10.9457  no-vmlinux               /no-vmlinux
3229      4.2136  sbcenc                   sbc_enc_process_input_8s_be_neon
2408      3.1422  sbcenc                   sbc_calc_scalefactors_neon
2093      2.7312  sbcenc                   sbc_encode

== After: ==

$ time ./sbcenc -b53 -s8 test.au > /dev/null

real    0m3.796s
user    0m3.344s
sys     0m0.438s

samples  %        image name               symbol name
26582    34.8726  sbcenc                   sbc_pack_frame
20032    26.2797  sbcenc                   sbc_analyze_4b_8s_neon
13808    18.1146  sbcenc                   sbc_calculate_bits
8374     10.9858  no-vmlinux               /no-vmlinux
3187      4.1810  sbcenc                   sbc_enc_process_input_8s_be_neon
2027      2.6592  sbcenc                   sbc_encode
1766      2.3168  sbcenc                   sbc_calc_scalefactors_neon
---
 sbc/sbc_primitives_neon.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index 7713759..0572158 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -248,8 +248,11 @@ static void sbc_calc_scalefactors_neon(
 			int blk = blocks;
 			int32_t *in = &sb_sample_f[0][ch][sb];
 			asm volatile (
-				"vmov.s32  q0, %[c1]\n"
+				"vmov.s32  q0, #0\n"
 				"vmov.s32  q1, %[c1]\n"
+				"vmov.s32  q14, #1\n"
+				"vmov.s32  q15, %[c2]\n"
+				"vadd.s32  q1, q1, q14\n"
 			"1:\n"
 				"vld1.32   {d16, d17}, [%[in], :128], %[inc]\n"
 				"vabs.s32  q8,  q8\n"
@@ -259,22 +262,14 @@ static void sbc_calc_scalefactors_neon(
 				"vabs.s32  q10, q10\n"
 				"vld1.32   {d22, d23}, [%[in], :128], %[inc]\n"
 				"vabs.s32  q11, q11\n"
-				"vcgt.s32  q12, q8,  #0\n"
-				"vcgt.s32  q13, q9,  #0\n"
-				"vcgt.s32  q14, q10, #0\n"
-				"vcgt.s32  q15, q11, #0\n"
-				"vadd.s32  q8,  q8,  q12\n"
-				"vadd.s32  q9,  q9,  q13\n"
-				"vadd.s32  q10, q10, q14\n"
-				"vadd.s32  q11, q11, q15\n"
-				"vorr.s32  q0,  q0,  q8\n"
-				"vorr.s32  q1,  q1,  q9\n"
-				"vorr.s32  q0,  q0,  q10\n"
-				"vorr.s32  q1,  q1,  q11\n"
+				"vmax.s32  q0,  q0,  q8\n"
+				"vmax.s32  q1,  q1,  q9\n"
+				"vmax.s32  q0,  q0,  q10\n"
+				"vmax.s32  q1,  q1,  q11\n"
 				"subs      %[blk], %[blk], #4\n"
 				"bgt       1b\n"
-				"vorr.s32  q0,  q0, q1\n"
-				"vmov.s32  q15, %[c2]\n"
+				"vmax.s32  q0,  q0,  q1\n"
+				"vsub.s32  q0,  q0,  q14\n"
 				"vclz.s32  q0,  q0\n"
 				"vsub.s32  q0,  q15, q0\n"
 				"vst1.32   {d0, d1}, [%[out], :128]\n"
-- 
1.6.4.4

