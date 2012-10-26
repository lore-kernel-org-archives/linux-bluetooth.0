Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 03/10] sbc: Break 4 blocks processing to variable steps
Date: Fri, 26 Oct 2012 19:20:29 +0200
Message-Id: <1351272036-4875-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now SBC processed 4 blocks at a time. If we want to process 15 blocks,
then we need to break this processing in one block steps. 4 blocks is still
default increment.
---
 sbc/sbc.c            |   13 +++++++------
 sbc/sbc_primitives.h |    6 ++++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 08b4993..9b0634d 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -688,30 +688,30 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 	switch (frame->subbands) {
 	case 4:
 		for (ch = 0; ch < frame->channels; ch++) {
-			x = &state->X[ch][state->position - 16 +
+			x = &state->X[ch][state->position - 4 * state->increment +
 							frame->blocks * 4];
-			for (blk = 0; blk < frame->blocks; blk += 4) {
+			for (blk = 0; blk < frame->blocks; blk += state->increment) {
 				state->sbc_analyze_4b_4s(
 					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				x -= 16;
+				x -= 4 * state->increment;
 			}
 		}
 		return frame->blocks * 4;
 
 	case 8:
 		for (ch = 0; ch < frame->channels; ch++) {
-			x = &state->X[ch][state->position - 32 +
+			x = &state->X[ch][state->position - 8 * state->increment +
 							frame->blocks * 8];
-			for (blk = 0; blk < frame->blocks; blk += 4) {
+			for (blk = 0; blk < frame->blocks; blk += state->increment) {
 				state->sbc_analyze_4b_8s(
 					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				x -= 32;
+				x -= 8 * state->increment;
 			}
 		}
 		return frame->blocks * 8;
@@ -906,6 +906,7 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 {
 	memset(&state->X, 0, sizeof(state->X));
 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
+	state->increment = 4;
 
 	sbc_init_primitives(state);
 }
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 47363db..eed946e 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -38,13 +38,15 @@
 
 struct sbc_encoder_state {
 	int position;
+	/* Number of consecutive blocks handled by the encoder */
+	int increment;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
-	 * it handles 4 blocks at once */
+	 * it handles "increment" blocks at once */
 	void (*sbc_analyze_4b_4s)(struct sbc_encoder_state *state,
 			int16_t *x, int32_t *out, int out_stride);
 	/* Polyphase analysis filter for 8 subbands configuration,
-	 * it handles 4 blocks at once */
+	 * it handles "increment" blocks at once */
 	void (*sbc_analyze_4b_8s)(struct sbc_encoder_state *state,
 			int16_t *x, int32_t *out, int out_stride);
 	/* Process input data (deinterleave, endian conversion, reordering),
-- 
1.7.9.5

