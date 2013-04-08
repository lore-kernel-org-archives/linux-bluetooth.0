Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 06/16] sbc: Add iwmmxt primitive for 1b 8s encoding
Date: Mon,  8 Apr 2013 15:24:08 +0200
Message-Id: <1365427458-26911-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1365427458-26911-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1365427458-26911-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives_iwmmxt.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives_iwmmxt.c b/sbc/sbc_primitives_iwmmxt.c
index 0c8f329..5be8933 100644
--- a/sbc/sbc_primitives_iwmmxt.c
+++ b/sbc/sbc_primitives_iwmmxt.c
@@ -294,10 +294,30 @@ static inline void sbc_analyze_4b_8s_iwmmxt(struct sbc_encoder_state *state,
 	sbc_analyze_eight_iwmmxt(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+static inline void sbc_analyze_1b_8s_iwmmxt_even(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride);
+
+static inline void sbc_analyze_1b_8s_iwmmxt_odd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	sbc_analyze_eight_iwmmxt(x, out, analysis_consts_fixed8_simd_odd);
+	state->sbc_analyze_8s = sbc_analyze_1b_8s_iwmmxt_even;
+}
+
+static inline void sbc_analyze_1b_8s_iwmmxt_even(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	sbc_analyze_eight_iwmmxt(x, out, analysis_consts_fixed8_simd_even);
+	state->sbc_analyze_8s = sbc_analyze_1b_8s_iwmmxt_odd;
+}
+
 void sbc_init_primitives_iwmmxt(struct sbc_encoder_state *state)
 {
 	state->sbc_analyze_4s = sbc_analyze_4b_4s_iwmmxt;
-	state->sbc_analyze_8s = sbc_analyze_4b_8s_iwmmxt;
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_iwmmxt_odd;
+	else
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_iwmmxt;
 	state->implementation_info = "IWMMXT";
 }
 
-- 
1.7.9.5

