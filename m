Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 01/11] Pass encoder_state to process input functions
Date: Thu, 18 Oct 2012 18:15:01 +0200
Message-Id: <1350576911-14678-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c                 |    4 ++--
 sbc/sbc_primitives.c      |   30 ++++++++++++++++--------------
 sbc/sbc_primitives.h      |    8 ++++----
 sbc/sbc_primitives_neon.c |   32 ++++++++++++++++----------------
 4 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index f0c77c7..76acf43 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1034,7 +1034,7 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 	struct sbc_priv *priv;
 	int samples;
 	ssize_t framelen;
-	int (*sbc_enc_process_input)(int position,
+	int (*sbc_enc_process_input)(struct sbc_encoder_state *state,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
 
@@ -1092,7 +1092,7 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 	}
 
 	priv->enc_state.position = sbc_enc_process_input(
-		priv->enc_state.position, (const uint8_t *) input,
+		&priv->enc_state, (const uint8_t *) input,
 		priv->enc_state.X, priv->frame.subbands * priv->frame.blocks,
 		priv->frame.channels);
 
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index ad780d0..e137604 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -227,10 +227,11 @@ static inline int16_t unaligned16_le(const uint8_t *ptr)
  */
 
 static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s4_internal(
-	int position,
+	struct sbc_encoder_state *state,
 	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 	int nsamples, int nchannels, int big_endian)
 {
+	int position = state->position;
 	/* handle X buffer wraparound */
 	if (position < nsamples) {
 		if (nchannels > 0)
@@ -278,10 +279,11 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s4_internal(
 }
 
 static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
-	int position,
+	struct sbc_encoder_state *state,
 	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 	int nsamples, int nchannels, int big_endian)
 {
+	int position = state->position;
 	/* handle X buffer wraparound */
 	if (position < nsamples) {
 		if (nchannels > 0)
@@ -356,52 +358,52 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
  * to the top of the buffer on buffer wraparound.
  */
 
-static int sbc_enc_process_input_4s_le(int position,
+static int sbc_enc_process_input_4s_le(struct sbc_encoder_state *state,
 		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 		int nsamples, int nchannels)
 {
 	if (nchannels > 1)
 		return sbc_encoder_process_input_s4_internal(
-			position, pcm, X, nsamples, 2, 0);
+			state, pcm, X, nsamples, 2, 0);
 	else
 		return sbc_encoder_process_input_s4_internal(
-			position, pcm, X, nsamples, 1, 0);
+			state, pcm, X, nsamples, 1, 0);
 }
 
-static int sbc_enc_process_input_4s_be(int position,
+static int sbc_enc_process_input_4s_be(struct sbc_encoder_state *state,
 		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 		int nsamples, int nchannels)
 {
 	if (nchannels > 1)
 		return sbc_encoder_process_input_s4_internal(
-			position, pcm, X, nsamples, 2, 1);
+			state, pcm, X, nsamples, 2, 1);
 	else
 		return sbc_encoder_process_input_s4_internal(
-			position, pcm, X, nsamples, 1, 1);
+			state, pcm, X, nsamples, 1, 1);
 }
 
-static int sbc_enc_process_input_8s_le(int position,
+static int sbc_enc_process_input_8s_le(struct sbc_encoder_state *state,
 		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 		int nsamples, int nchannels)
 {
 	if (nchannels > 1)
 		return sbc_encoder_process_input_s8_internal(
-			position, pcm, X, nsamples, 2, 0);
+			state, pcm, X, nsamples, 2, 0);
 	else
 		return sbc_encoder_process_input_s8_internal(
-			position, pcm, X, nsamples, 1, 0);
+			state, pcm, X, nsamples, 1, 0);
 }
 
-static int sbc_enc_process_input_8s_be(int position,
+static int sbc_enc_process_input_8s_be(struct sbc_encoder_state *state,
 		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 		int nsamples, int nchannels)
 {
 	if (nchannels > 1)
 		return sbc_encoder_process_input_s8_internal(
-			position, pcm, X, nsamples, 2, 1);
+			state, pcm, X, nsamples, 2, 1);
 	else
 		return sbc_encoder_process_input_s8_internal(
-			position, pcm, X, nsamples, 1, 1);
+			state, pcm, X, nsamples, 1, 1);
 }
 
 /* Supplementary function to count the number of leading zeros */
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 17ad4f7..c80337e 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -47,16 +47,16 @@ struct sbc_encoder_state {
 	void (*sbc_analyze_4b_8s)(int16_t *x, int32_t *out, int out_stride);
 	/* Process input data (deinterleave, endian conversion, reordering),
 	 * depending on the number of subbands and input data byte order */
-	int (*sbc_enc_process_input_4s_le)(int position,
+	int (*sbc_enc_process_input_4s_le)(struct sbc_encoder_state *state,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
-	int (*sbc_enc_process_input_4s_be)(int position,
+	int (*sbc_enc_process_input_4s_be)(struct sbc_encoder_state *state,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
-	int (*sbc_enc_process_input_8s_le)(int position,
+	int (*sbc_enc_process_input_8s_le)(struct sbc_encoder_state *state,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
-	int (*sbc_enc_process_input_8s_be)(int position,
+	int (*sbc_enc_process_input_8s_be)(struct sbc_encoder_state *state,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
 	/* Scale factors calculation */
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index 5d4d0e3..83277ae 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -845,36 +845,36 @@ static SBC_ALWAYS_INLINE int sbc_enc_process_input_8s_neon_internal(
 #undef PERM_BE
 #undef PERM_LE
 
-static int sbc_enc_process_input_4s_be_neon(int position, const uint8_t *pcm,
-					int16_t X[2][SBC_X_BUFFER_SIZE],
-					int nsamples, int nchannels)
+static int sbc_enc_process_input_4s_be_neon(struct sbc_encoder_state *state,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
 {
 	return sbc_enc_process_input_4s_neon_internal(
-		position, pcm, X, nsamples, nchannels, 1);
+		state->position, pcm, X, nsamples, nchannels, 1);
 }
 
-static int sbc_enc_process_input_4s_le_neon(int position, const uint8_t *pcm,
-					int16_t X[2][SBC_X_BUFFER_SIZE],
-					int nsamples, int nchannels)
+static int sbc_enc_process_input_4s_le_neon(struct sbc_encoder_state *state,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
 {
 	return sbc_enc_process_input_4s_neon_internal(
-		position, pcm, X, nsamples, nchannels, 0);
+		state->position, pcm, X, nsamples, nchannels, 0);
 }
 
-static int sbc_enc_process_input_8s_be_neon(int position, const uint8_t *pcm,
-					int16_t X[2][SBC_X_BUFFER_SIZE],
-					int nsamples, int nchannels)
+static int sbc_enc_process_input_8s_be_neon(struct sbc_encoder_state *state,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
 {
 	return sbc_enc_process_input_8s_neon_internal(
-		position, pcm, X, nsamples, nchannels, 1);
+		state->position, pcm, X, nsamples, nchannels, 1);
 }
 
-static int sbc_enc_process_input_8s_le_neon(int position, const uint8_t *pcm,
-					int16_t X[2][SBC_X_BUFFER_SIZE],
-					int nsamples, int nchannels)
+static int sbc_enc_process_input_8s_le_neon(struct sbc_encoder_state *state,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
 {
 	return sbc_enc_process_input_8s_neon_internal(
-		position, pcm, X, nsamples, nchannels, 0);
+		state->position, pcm, X, nsamples, nchannels, 0);
 }
 
 void sbc_init_primitives_neon(struct sbc_encoder_state *state)
-- 
1.7.9.5

