Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 04/10] sbc: Add msbc flag and generic C primitive
Date: Fri, 26 Oct 2012 19:20:30 +0200
Message-Id: <1351272036-4875-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c            |   27 +++++++++++++++------
 sbc/sbc.h            |    3 +++
 sbc/sbc_primitives.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++--
 sbc/sbc_primitives.h |    2 ++
 4 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 9b0634d..4bc97fc 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -52,6 +52,9 @@
 
 #define SBC_SYNCWORD	0x9C
 
+#define MSBC_SYNCWORD       0xAD
+#define MSBC_BLOCKS         15
+
 /* This structure contains an unpacked SBC frame.
    Yes, there is probably quite some unused space herein */
 struct sbc_frame {
@@ -705,6 +708,10 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 		for (ch = 0; ch < frame->channels; ch++) {
 			x = &state->X[ch][state->position - 8 * state->increment +
 							frame->blocks * 8];
+
+			if (state->pending == state->position)
+				x += 8;
+
 			for (blk = 0; blk < frame->blocks; blk += state->increment) {
 				state->sbc_analyze_4b_8s(
 					state, x,
@@ -901,12 +908,12 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
 	}
 }
 
-static void sbc_encoder_init(struct sbc_encoder_state *state,
-					const struct sbc_frame *frame)
+static void sbc_encoder_init(unsigned long flags,
+		struct sbc_encoder_state *state, const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
-	state->increment = 4;
+	state->increment = flags & SBC_MSBC ? 1 : 4;
 
 	sbc_init_primitives(state);
 }
@@ -920,6 +927,7 @@ struct sbc_priv {
 
 static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 {
+	sbc->flags = flags;
 	sbc->frequency = SBC_FREQ_44100;
 	sbc->mode = SBC_MODE_STEREO;
 	sbc->subbands = SBC_SB_8;
@@ -1055,12 +1063,13 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 		priv->frame.subband_mode = sbc->subbands;
 		priv->frame.subbands = sbc->subbands ? 8 : 4;
 		priv->frame.block_mode = sbc->blocks;
-		priv->frame.blocks = 4 + (sbc->blocks * 4);
+		priv->frame.blocks = sbc->flags & SBC_MSBC ?
+					MSBC_BLOCKS : 4 + (sbc->blocks * 4);
 		priv->frame.bitpool = sbc->bitpool;
 		priv->frame.codesize = sbc_get_codesize(sbc);
 		priv->frame.length = sbc_get_frame_length(sbc);
 
-		sbc_encoder_init(&priv->enc_state, &priv->frame);
+		sbc_encoder_init(sbc->flags, &priv->enc_state, &priv->frame);
 		priv->init = 1;
 	} else if (priv->frame.bitpool != sbc->bitpool) {
 		priv->frame.length = sbc_get_frame_length(sbc);
@@ -1139,7 +1148,7 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
 		return priv->frame.length;
 
 	subbands = sbc->subbands ? 8 : 4;
-	blocks = 4 + (sbc->blocks * 4);
+	blocks = sbc->flags & SBC_MSBC ? MSBC_BLOCKS : 4 + (sbc->blocks * 4);
 	channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	joint = sbc->mode == SBC_MODE_JOINT_STEREO ? 1 : 0;
 	bitpool = sbc->bitpool;
@@ -1163,7 +1172,8 @@ SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		blocks = sbc->flags & SBC_MSBC ?
+					MSBC_BLOCKS : 4 + (sbc->blocks * 4);
 	} else {
 		subbands = priv->frame.subbands;
 		blocks = priv->frame.blocks;
@@ -1200,7 +1210,8 @@ SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		blocks = sbc->flags & SBC_MSBC ?
+					MSBC_BLOCKS : 4 + (sbc->blocks * 4);
 		channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	} else {
 		subbands = priv->frame.subbands;
diff --git a/sbc/sbc.h b/sbc/sbc.h
index bbd45da..3511119 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -64,6 +64,9 @@ extern "C" {
 #define SBC_LE			0x00
 #define SBC_BE			0x01
 
+/* Additional features */
+#define SBC_MSBC		0x01
+
 struct sbc_struct {
 	unsigned long flags;
 
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 7ba0589..47caf11 100644
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
 
@@ -523,9 +578,16 @@ static int sbc_calc_scalefactors_j(
  */
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
+	state->pending = -1;
+	state->odd = 1;
+
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
+
+	if (state->increment == 1)
+		state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_simd;
+	else
+		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
 
 	/* Default implementation for input reordering / deinterleaving */
 	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index eed946e..9a27d3c 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -40,6 +40,8 @@ struct sbc_encoder_state {
 	int position;
 	/* Number of consecutive blocks handled by the encoder */
 	int increment;
+	int pending;
+	int odd;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles "increment" blocks at once */
-- 
1.7.9.5

