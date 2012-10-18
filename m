Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 05/11] Add simd primitive for 1b 8s analyse
Date: Thu, 18 Oct 2012 18:15:05 +0200
Message-Id: <1350576911-14678-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c            |   12 +++++++---
 sbc/sbc_primitives.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++-
 sbc/sbc_primitives.h |    2 ++
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index c40aa15..fa90e07 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -708,6 +708,10 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 		for (ch = 0; ch < frame->channels; ch++) {
 			x = &state->X[ch][state->position - 8 * state->inc +
 							frame->blocks * 8];
+
+			if (state->pending == state->position)
+				x += 8;
+
 			for (blk = 0; blk < frame->blocks; blk += state->inc) {
 				state->sbc_analyze_4b_8s(
 					state, x,
@@ -904,13 +908,14 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
 	}
 }
 
-static void sbc_encoder_init(struct sbc_encoder_state *state,
+static void sbc_encoder_init(int msbc, struct sbc_encoder_state *state,
 					const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
 	state->inc = 4;
-
+	if (msbc)
+		state->inc = 1;
 	sbc_init_primitives(state);
 }
 
@@ -1068,7 +1073,8 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 		priv->frame.codesize = sbc_get_codesize(sbc);
 		priv->frame.length = sbc_get_frame_length(sbc);
 
-		sbc_encoder_init(&priv->enc_state, &priv->frame);
+		sbc_encoder_init(sbc->flags & SBC_MSBC,
+					&priv->enc_state, &priv->frame);
 		priv->init = 1;
 	} else if (priv->frame.bitpool != sbc->bitpool) {
 		priv->frame.length = sbc_get_frame_length(sbc);
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 7ba0589..bfaafd7 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -209,6 +209,17 @@ static inline void sbc_analyze_4b_8s_simd(struct sbc_encoder_state *state,
 	sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+static inline void sbc_analyze_1b_8s_simd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	if (state->odd)
+		sbc_analyze_eight_simd(x, out, analysis_consts_fixed8_simd_odd);
+	else
+		sbc_analyze_eight_simd(x, out, analysis_consts_fixed8_simd_even);
+
+	state->odd = !state->odd;
+}
+
 static inline int16_t unaligned16_be(const uint8_t *ptr)
 {
 	return (int16_t) ((ptr[0] << 8) | ptr[1]);
@@ -298,8 +309,25 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
 	#define PCM(i) (big_endian ? \
 		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
 
+	if (state->pending >= 0) {
+		state->pending = -1;
+		nsamples -= 8;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = PCM(0 + (15-8) * nchannels);
+			x[2]  = PCM(0 + (14-8) * nchannels);
+			x[3]  = PCM(0 + (8-8) * nchannels);
+			x[4]  = PCM(0 + (13-8) * nchannels);
+			x[5]  = PCM(0 + (9-8) * nchannels);
+			x[6]  = PCM(0 + (12-8) * nchannels);
+			x[7]  = PCM(0 + (10-8) * nchannels);
+			x[8]  = PCM(0 + (11-8) * nchannels);
+		}
+		pcm += 16 * nchannels;
+	}
+
 	/* copy/permutate audio samples */
-	while ((nsamples -= 16) >= 0) {
+	while (nsamples >= 16) {
 		position -= 16;
 		if (nchannels > 0) {
 			int16_t *x = &X[0][position];
@@ -340,6 +368,33 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
 			x[15] = PCM(1 + 2 * nchannels);
 		}
 		pcm += 32 * nchannels;
+		nsamples -= 16;
+	}
+
+	if (nsamples == 8) {
+		position -= 16;
+		state->pending = position;
+
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = 0;
+			x[1]  = PCM(0 + 7 * nchannels);
+			x[2]  = 0;
+			x[3]  = 0;
+			x[4]  = 0;
+			x[5]  = 0;
+			x[6]  = 0;
+			x[7]  = 0;
+			x[8]  = 0;
+			x[9]  = PCM(0 + 3 * nchannels);
+			x[10] = PCM(0 + 6 * nchannels);
+			x[11] = PCM(0 + 0 * nchannels);
+			x[12] = PCM(0 + 5 * nchannels);
+			x[13] = PCM(0 + 1 * nchannels);
+			x[14] = PCM(0 + 4 * nchannels);
+			x[15] = PCM(0 + 2 * nchannels);
+		}
+		pcm += 16 * nchannels;
 	}
 	#undef PCM
 
@@ -523,10 +578,16 @@ static int sbc_calc_scalefactors_j(
  */
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
+	state->pending = -1;
+	state->odd = 1;
+
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
 
+	if (state->inc == 1)
+		state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_simd;
+
 	/* Default implementation for input reordering / deinterleaving */
 	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
 	state->sbc_enc_process_input_4s_be = sbc_enc_process_input_4s_be;
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 39cfbf2..130ad25 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -39,6 +39,8 @@
 struct sbc_encoder_state {
 	int position;
 	int inc;
+	int pending;
+	int odd;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles "inc" blocks at once */
-- 
1.7.9.5

