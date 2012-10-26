Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 06/10] sbc: Add mmx primitive for 1b 8s analyse
Date: Fri, 26 Oct 2012 19:20:32 +0200
Message-Id: <1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives_mmx.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index cbacb4e..17065e5 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -276,6 +276,19 @@ static inline void sbc_analyze_4b_8s_mmx(struct sbc_encoder_state *state,
 	__asm__ volatile ("emms\n");
 }
 
+static inline void sbc_analyze_1b_8s_mmx(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	if (state->odd)
+		sbc_analyze_eight_mmx(x, out, analysis_consts_fixed8_simd_odd);
+	else
+		sbc_analyze_eight_mmx(x, out, analysis_consts_fixed8_simd_even);
+
+	state->odd = !state->odd;
+
+	__asm__ volatile ("emms\n");
+}
+
 static void sbc_calc_scalefactors_mmx(
 	int32_t sb_sample_f[16][2][8],
 	uint32_t scale_factor[2][8],
@@ -366,7 +379,10 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 {
 	if (check_mmx_support()) {
 		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
-		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+		if (state->increment == 1)
+			state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_mmx;
+		else
+			state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
 		state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
 		state->implementation_info = "MMX";
 	}
-- 
1.7.9.5

