Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v8 11/16] sbc: Add a private boolean flag to enable 15 block encoding
Date: Fri, 29 Mar 2013 16:58:15 +0100
Message-Id: <1364572700-31701-12-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364572700-31701-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1364572700-31701-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduce a new private member which purpose is to encode 15
blocks. It is private to the library and can't be set from standard API.
sbc_init_msbc() function will be defined to set this flag.
---
 sbc/sbc.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 75b30a3..137757b 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -53,6 +53,9 @@
 
 #define SBC_SYNCWORD	0x9C
 
+#define MSBC_SYNCWORD	0xAD
+#define MSBC_BLOCKS	15
+
 /* This structure contains an unpacked SBC frame.
    Yes, there is probably quite some unused space herein */
 struct sbc_frame {
@@ -904,18 +907,22 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
 	}
 }
 
-static void sbc_encoder_init(struct sbc_encoder_state *state,
-					const struct sbc_frame *frame)
+static void sbc_encoder_init(bool msbc, struct sbc_encoder_state *state,
+						const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
-	state->increment = 4;
+	if (msbc)
+		state->increment = 1;
+	else
+		state->increment = 4;
 
 	sbc_init_primitives(state);
 }
 
 struct sbc_priv {
 	int init;
+	bool msbc;
 	struct SBC_ALIGNED sbc_frame frame;
 	struct SBC_ALIGNED sbc_decoder_state dec_state;
 	struct SBC_ALIGNED sbc_encoder_state enc_state;
@@ -923,6 +930,7 @@ struct sbc_priv {
 
 static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 {
+	sbc->flags = flags;
 	sbc->frequency = SBC_FREQ_44100;
 	sbc->mode = SBC_MODE_STEREO;
 	sbc->subbands = SBC_SB_8;
@@ -1058,12 +1066,15 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 		priv->frame.subband_mode = sbc->subbands;
 		priv->frame.subbands = sbc->subbands ? 8 : 4;
 		priv->frame.block_mode = sbc->blocks;
-		priv->frame.blocks = 4 + (sbc->blocks * 4);
+		if (priv->msbc)
+			priv->frame.blocks = MSBC_BLOCKS;
+		else
+			priv->frame.blocks = 4 + (sbc->blocks * 4);
 		priv->frame.bitpool = sbc->bitpool;
 		priv->frame.codesize = sbc_get_codesize(sbc);
 		priv->frame.length = sbc_get_frame_length(sbc);
 
-		sbc_encoder_init(&priv->enc_state, &priv->frame);
+		sbc_encoder_init(priv->msbc, &priv->enc_state, &priv->frame);
 		priv->init = 1;
 	} else if (priv->frame.bitpool != sbc->bitpool) {
 		priv->frame.length = sbc_get_frame_length(sbc);
@@ -1142,7 +1153,10 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
 		return priv->frame.length;
 
 	subbands = sbc->subbands ? 8 : 4;
-	blocks = 4 + (sbc->blocks * 4);
+	if (priv->msbc)
+		blocks = MSBC_BLOCKS;
+	else
+		blocks = 4 + (sbc->blocks * 4);
 	channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	joint = sbc->mode == SBC_MODE_JOINT_STEREO ? 1 : 0;
 	bitpool = sbc->bitpool;
@@ -1166,7 +1180,10 @@ SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		if (priv->msbc)
+			blocks = MSBC_BLOCKS;
+		else
+			blocks = 4 + (sbc->blocks * 4);
 	} else {
 		subbands = priv->frame.subbands;
 		blocks = priv->frame.blocks;
@@ -1203,7 +1220,10 @@ SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		if (priv->msbc)
+			blocks = MSBC_BLOCKS;
+		else
+			blocks = 4 + (sbc->blocks * 4);
 		channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	} else {
 		subbands = priv->frame.subbands;
-- 
1.7.9.5

