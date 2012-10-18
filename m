Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 03/11] Make increment variable
Date: Thu, 18 Oct 2012 18:15:03 +0200
Message-Id: <1350576911-14678-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c            |   13 +++++++------
 sbc/sbc_primitives.h |    5 +++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 08b4993..6fff132 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -688,30 +688,30 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 	switch (frame->subbands) {
 	case 4:
 		for (ch = 0; ch < frame->channels; ch++) {
-			x = &state->X[ch][state->position - 16 +
+			x = &state->X[ch][state->position - 4 * state->inc +
 							frame->blocks * 4];
-			for (blk = 0; blk < frame->blocks; blk += 4) {
+			for (blk = 0; blk < frame->blocks; blk += state->inc) {
 				state->sbc_analyze_4b_4s(
 					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				x -= 16;
+				x -= 4 * state->inc;
 			}
 		}
 		return frame->blocks * 4;
 
 	case 8:
 		for (ch = 0; ch < frame->channels; ch++) {
-			x = &state->X[ch][state->position - 32 +
+			x = &state->X[ch][state->position - 8 * state->inc +
 							frame->blocks * 8];
-			for (blk = 0; blk < frame->blocks; blk += 4) {
+			for (blk = 0; blk < frame->blocks; blk += state->inc) {
 				state->sbc_analyze_4b_8s(
 					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				x -= 32;
+				x -= 8 * state->inc;
 			}
 		}
 		return frame->blocks * 8;
@@ -906,6 +906,7 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 {
 	memset(&state->X, 0, sizeof(state->X));
 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
+	state->inc = 4;
 
 	sbc_init_primitives(state);
 }
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 47363db..39cfbf2 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -38,13 +38,14 @@
 
 struct sbc_encoder_state {
 	int position;
+	int inc;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
-	 * it handles 4 blocks at once */
+	 * it handles "inc" blocks at once */
 	void (*sbc_analyze_4b_4s)(struct sbc_encoder_state *state,
 			int16_t *x, int32_t *out, int out_stride);
 	/* Polyphase analysis filter for 8 subbands configuration,
-	 * it handles 4 blocks at once */
+	 * it handles "inc" blocks at once */
 	void (*sbc_analyze_4b_8s)(struct sbc_encoder_state *state,
 			int16_t *x, int32_t *out, int out_stride);
 	/* Process input data (deinterleave, endian conversion, reordering),
-- 
1.7.9.5

