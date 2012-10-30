Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 06/16] sbc: Add armv6 primitive for 1b 8s analysis
Date: Tue, 30 Oct 2012 10:39:25 +0100
Message-Id: <1351589975-22640-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives_armv6.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives_armv6.c b/sbc/sbc_primitives_armv6.c
index 068648a..a2cb2a8 100644
--- a/sbc/sbc_primitives_armv6.c
+++ b/sbc/sbc_primitives_armv6.c
@@ -291,10 +291,26 @@ static void sbc_analyze_4b_8s_armv6(struct sbc_encoder_state *state,
 	sbc_analyze_eight(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+static void sbc_analyze_1b_8s_armv6(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	if (state->odd)
+		sbc_analyze_eight_armv6(x, out,
+					analysis_consts_fixed8_simd_odd);
+	else
+		sbc_analyze_eight_armv6(x, out,
+					analysis_consts_fixed8_simd_even);
+
+	state->odd = !state->odd;
+}
+
 void sbc_init_primitives_armv6(struct sbc_encoder_state *state)
 {
 	state->sbc_analyze_4s = sbc_analyze_4b_4s_armv6;
-	state->sbc_analyze_8s = sbc_analyze_4b_8s_armv6;
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_armv6;
+	else
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_armv6;
 	state->implementation_info = "ARMv6 SIMD";
 }
 
-- 
1.7.9.5

