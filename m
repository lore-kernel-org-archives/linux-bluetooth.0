Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 04/16] sbc: add odd member variable to sbc_encoder_state
Date: Tue, 30 Oct 2012 10:39:23 +0100
Message-Id: <1351589975-22640-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives.c |    2 ++
 sbc/sbc_primitives.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index dce0ed2..0b48ddb 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -521,6 +521,8 @@ static int sbc_calc_scalefactors_j(
  */
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
+	state->odd = 1;
+
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4s = sbc_analyze_4b_4s_simd;
 	state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 267c277..ffee339 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -40,6 +40,7 @@ struct sbc_encoder_state {
 	int position;
 	/* Number of consecutive blocks handled by the encoder */
 	int increment;
+	int odd;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles "increment" blocks at once */
-- 
1.7.9.5

