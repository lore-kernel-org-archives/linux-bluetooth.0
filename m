Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 08/16] sbc: Add simd primitive for 1b 8s analysis
Date: Tue, 30 Oct 2012 10:39:27 +0100
Message-Id: <1351589975-22640-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 0b48ddb..a4767ef 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -209,6 +209,19 @@ static inline void sbc_analyze_4b_8s_simd(struct sbc_encoder_state *state,
 	sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+static inline void sbc_analyze_1b_8s_simd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	if (state->odd)
+		sbc_analyze_eight_simd(x, out,
+					analysis_consts_fixed8_simd_odd);
+	else
+		sbc_analyze_eight_simd(x, out,
+					analysis_consts_fixed8_simd_even);
+
+	state->odd = !state->odd;
+}
+
 static inline int16_t unaligned16_be(const uint8_t *ptr)
 {
 	return (int16_t) ((ptr[0] << 8) | ptr[1]);
@@ -525,7 +538,10 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4s = sbc_analyze_4b_4s_simd;
-	state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_simd;
+	else
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
 
 	/* Default implementation for input reordering / deinterleaving */
 	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
-- 
1.7.9.5

