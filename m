Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 03/16] sbc: Rename sbc_analyze_4b_xx to sbc_analyze_xx
Date: Tue, 30 Oct 2012 10:39:22 +0100
Message-Id: <1351589975-22640-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c                   |    4 ++--
 sbc/sbc_primitives.c        |    4 ++--
 sbc/sbc_primitives.h        |    4 ++--
 sbc/sbc_primitives_armv6.c  |    4 ++--
 sbc/sbc_primitives_iwmmxt.c |    4 ++--
 sbc/sbc_primitives_mmx.c    |    4 ++--
 sbc/sbc_primitives_neon.c   |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 4a7dd2e..ffdf05d 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -692,7 +692,7 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 					state->increment + frame->blocks * 4];
 			for (blk = 0; blk < frame->blocks;
 						blk += state->increment) {
-				state->sbc_analyze_4b_4s(
+				state->sbc_analyze_4s(
 					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
@@ -708,7 +708,7 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 					state->increment + frame->blocks * 8];
 			for (blk = 0; blk < frame->blocks;
 						blk += state->increment) {
-				state->sbc_analyze_4b_8s(
+				state->sbc_analyze_8s(
 					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index f8cc4b6..dce0ed2 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -522,8 +522,8 @@ static int sbc_calc_scalefactors_j(
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
 	/* Default implementation for analyze functions */
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
+	state->sbc_analyze_4s = sbc_analyze_4b_4s_simd;
+	state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
 
 	/* Default implementation for input reordering / deinterleaving */
 	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 2a7d4a1..267c277 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -43,11 +43,11 @@ struct sbc_encoder_state {
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles "increment" blocks at once */
-	void (*sbc_analyze_4b_4s)(struct sbc_encoder_state *state,
+	void (*sbc_analyze_4s)(struct sbc_encoder_state *state,
 			int16_t *x, int32_t *out, int out_stride);
 	/* Polyphase analysis filter for 8 subbands configuration,
 	 * it handles "increment" blocks at once */
-	void (*sbc_analyze_4b_8s)(struct sbc_encoder_state *state,
+	void (*sbc_analyze_8s)(struct sbc_encoder_state *state,
 			int16_t *x, int32_t *out, int out_stride);
 	/* Process input data (deinterleave, endian conversion, reordering),
 	 * depending on the number of subbands and input data byte order */
diff --git a/sbc/sbc_primitives_armv6.c b/sbc/sbc_primitives_armv6.c
index 6ad94c6..068648a 100644
--- a/sbc/sbc_primitives_armv6.c
+++ b/sbc/sbc_primitives_armv6.c
@@ -293,8 +293,8 @@ static void sbc_analyze_4b_8s_armv6(struct sbc_encoder_state *state,
 
 void sbc_init_primitives_armv6(struct sbc_encoder_state *state)
 {
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_armv6;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_armv6;
+	state->sbc_analyze_4s = sbc_analyze_4b_4s_armv6;
+	state->sbc_analyze_8s = sbc_analyze_4b_8s_armv6;
 	state->implementation_info = "ARMv6 SIMD";
 }
 
diff --git a/sbc/sbc_primitives_iwmmxt.c b/sbc/sbc_primitives_iwmmxt.c
index 39cc390..0c8f329 100644
--- a/sbc/sbc_primitives_iwmmxt.c
+++ b/sbc/sbc_primitives_iwmmxt.c
@@ -296,8 +296,8 @@ static inline void sbc_analyze_4b_8s_iwmmxt(struct sbc_encoder_state *state,
 
 void sbc_init_primitives_iwmmxt(struct sbc_encoder_state *state)
 {
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_iwmmxt;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_iwmmxt;
+	state->sbc_analyze_4s = sbc_analyze_4b_4s_iwmmxt;
+	state->sbc_analyze_8s = sbc_analyze_4b_8s_iwmmxt;
 	state->implementation_info = "IWMMXT";
 }
 
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index cbacb4e..03070f5 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -365,8 +365,8 @@ static int check_mmx_support(void)
 void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 {
 	if (check_mmx_support()) {
-		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
-		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+		state->sbc_analyze_4s = sbc_analyze_4b_4s_mmx;
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_mmx;
 		state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
 		state->implementation_info = "MMX";
 	}
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index aeca8df..eda4ed3 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -879,8 +879,8 @@ static int sbc_enc_process_input_8s_le_neon(int position, const uint8_t *pcm,
 
 void sbc_init_primitives_neon(struct sbc_encoder_state *state)
 {
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_neon;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_neon;
+	state->sbc_analyze_4s = sbc_analyze_4b_4s_neon;
+	state->sbc_analyze_8s = sbc_analyze_4b_8s_neon;
 	state->sbc_calc_scalefactors = sbc_calc_scalefactors_neon;
 	state->sbc_calc_scalefactors_j = sbc_calc_scalefactors_j_neon;
 	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le_neon;
-- 
1.7.9.5

