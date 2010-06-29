Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 2/3] sbc: MMX optimization for scale factors calculation
Date: Tue, 29 Jun 2010 16:48:46 +0300
Message-Id: <1277819327-28592-3-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

Improves SBC encoding performance when joint stereo is not used.
Benchmarked on Pentium-M:

== Before: ==

$ time ./sbcenc -b53 -s8 test.au > /dev/null

real    0m1.439s
user    0m1.336s
sys     0m0.104s

samples  %        image name               symbol name
8642     33.7473  sbcenc                   sbc_pack_frame
5873     22.9342  sbcenc                   sbc_analyze_4b_8s_mmx
4435     17.3188  sbcenc                   sbc_calc_scalefactors
4285     16.7331  sbcenc                   sbc_calculate_bits
1942      7.5836  sbcenc                   sbc_enc_process_input_8s_be
322       1.2574  sbcenc                   sbc_encode

== After: ==

$ time ./sbcenc -b53 -s8 test.au > /dev/null

real    0m1.319s
user    0m1.220s
sys     0m0.084s

samples  %        image name               symbol name
8706     37.9959  sbcenc                   sbc_pack_frame
5740     25.0513  sbcenc                   sbc_analyze_4b_8s_mmx
4307     18.7972  sbcenc                   sbc_calculate_bits
1937      8.4537  sbcenc                   sbc_enc_process_input_8s_be
1801      7.8602  sbcenc                   sbc_calc_scalefactors_mmx
307       1.3399  sbcenc                   sbc_encode
---
 sbc/sbc_primitives_mmx.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index e6900bc..45c62ac 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -276,6 +276,59 @@ static inline void sbc_analyze_4b_8s_mmx(int16_t *x, int32_t *out,
 	asm volatile ("emms\n");
 }
 
+static void sbc_calc_scalefactors_mmx(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	static const SBC_ALIGNED int32_t consts[2] = {
+		1 << SCALE_OUT_BITS,
+		1 << SCALE_OUT_BITS,
+	};
+	int ch, sb;
+	intptr_t blk;
+	for (ch = 0; ch < channels; ch++) {
+		for (sb = 0; sb < subbands; sb += 2) {
+			blk = (blocks - 1) * (((char *) &sb_sample_f[1][0][0] -
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
@@ -314,6 +367,7 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 	if (check_mmx_support()) {
 		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
 		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+		state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
 		state->implementation_info = "MMX";
 	}
 }
-- 
1.6.4.4

