Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 11/16] sbc: Add SBC_MSBC flag to enable 15 block encoding
Date: Tue, 30 Oct 2012 10:39:30 +0100
Message-Id: <1351589975-22640-12-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c |   23 +++++++++++++++--------
 sbc/sbc.h |    3 +++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index ffdf05d..22fa898 100644
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
@@ -903,12 +906,12 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
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
@@ -922,6 +925,7 @@ struct sbc_priv {
 
 static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 {
+	sbc->flags = flags;
 	sbc->frequency = SBC_FREQ_44100;
 	sbc->mode = SBC_MODE_STEREO;
 	sbc->subbands = SBC_SB_8;
@@ -1057,12 +1061,13 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
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
@@ -1141,7 +1146,7 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
 		return priv->frame.length;
 
 	subbands = sbc->subbands ? 8 : 4;
-	blocks = 4 + (sbc->blocks * 4);
+	blocks = sbc->flags & SBC_MSBC ? MSBC_BLOCKS : 4 + (sbc->blocks * 4);
 	channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	joint = sbc->mode == SBC_MODE_JOINT_STEREO ? 1 : 0;
 	bitpool = sbc->bitpool;
@@ -1165,7 +1170,8 @@ SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		blocks = sbc->flags & SBC_MSBC ?
+					MSBC_BLOCKS : 4 + (sbc->blocks * 4);
 	} else {
 		subbands = priv->frame.subbands;
 		blocks = priv->frame.blocks;
@@ -1202,7 +1208,8 @@ SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
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
 
-- 
1.7.9.5

