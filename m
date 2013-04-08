Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 07/16] sbc: Add plain C primitive for 1b 8s analysis
Date: Mon,  8 Apr 2013 15:24:09 +0200
Message-Id: <1365427458-26911-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1365427458-26911-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1365427458-26911-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index dce0ed2..f232f65 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -209,6 +209,23 @@ static inline void sbc_analyze_4b_8s_simd(struct sbc_encoder_state *state,
 	sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+static inline void sbc_analyze_1b_8s_simd_even(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride);
+
+static inline void sbc_analyze_1b_8s_simd_odd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	sbc_analyze_eight_simd(x, out, analysis_consts_fixed8_simd_odd);
+	state->sbc_analyze_8s = sbc_analyze_1b_8s_simd_even;
+}
+
+static inline void sbc_analyze_1b_8s_simd_even(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	sbc_analyze_eight_simd(x, out, analysis_consts_fixed8_simd_even);
+	state->sbc_analyze_8s = sbc_analyze_1b_8s_simd_odd;
+}
+
 static inline int16_t unaligned16_be(const uint8_t *ptr)
 {
 	return (int16_t) ((ptr[0] << 8) | ptr[1]);
@@ -523,7 +540,10 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 {
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4s = sbc_analyze_4b_4s_simd;
-	state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_simd_odd;
+	else
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
 
 	/* Default implementation for input reordering / deinterleaving */
 	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
-- 
1.7.9.5

