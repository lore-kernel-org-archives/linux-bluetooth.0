Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 12/16] sbc: Add support for mSBC frame header
Date: Tue, 30 Oct 2012 10:39:31 +0100
Message-Id: <1351589975-22640-13-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c |  228 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 138 insertions(+), 90 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 22fa898..cd3fd8c 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -377,8 +377,8 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
  *  -3   CRC8 incorrect
  *  -4   Bitpool value out of bounds
  */
-static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
-								size_t len)
+static int sbc_unpack_frame_internal(const uint8_t *data,
+		struct sbc_frame *frame, size_t len)
 {
 	unsigned int consumed;
 	/* Will copy the parts of the header that are relevant to crc
@@ -393,59 +393,6 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
 	int bits[2][8];		/* bits distribution */
 	uint32_t levels[2][8];	/* levels derived from that */
 
-	if (len < 4)
-		return -1;
-
-	if (data[0] != SBC_SYNCWORD)
-		return -2;
-
-	frame->frequency = (data[1] >> 6) & 0x03;
-
-	frame->block_mode = (data[1] >> 4) & 0x03;
-	switch (frame->block_mode) {
-	case SBC_BLK_4:
-		frame->blocks = 4;
-		break;
-	case SBC_BLK_8:
-		frame->blocks = 8;
-		break;
-	case SBC_BLK_12:
-		frame->blocks = 12;
-		break;
-	case SBC_BLK_16:
-		frame->blocks = 16;
-		break;
-	}
-
-	frame->mode = (data[1] >> 2) & 0x03;
-	switch (frame->mode) {
-	case MONO:
-		frame->channels = 1;
-		break;
-	case DUAL_CHANNEL:	/* fall-through */
-	case STEREO:
-	case JOINT_STEREO:
-		frame->channels = 2;
-		break;
-	}
-
-	frame->allocation = (data[1] >> 1) & 0x01;
-
-	frame->subband_mode = (data[1] & 0x01);
-	frame->subbands = frame->subband_mode ? 8 : 4;
-
-	frame->bitpool = data[2];
-
-	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
-			frame->bitpool > 16 * frame->subbands)
-		return -4;
-
-	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
-			frame->bitpool > 32 * frame->subbands)
-		return -4;
-
-	/* data[3] is crc, we're checking it later */
-
 	consumed = 32;
 
 	crc_header[0] = data[1];
@@ -546,6 +493,90 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
 	return consumed >> 3;
 }
 
+static int sbc_unpack_frame(const uint8_t *data,
+		struct sbc_frame *frame, size_t len)
+{
+	if (len < 4)
+		return -1;
+
+	if (data[0] != SBC_SYNCWORD)
+		return -2;
+
+	frame->frequency = (data[1] >> 6) & 0x03;
+	frame->block_mode = (data[1] >> 4) & 0x03;
+
+	switch (frame->block_mode) {
+	case SBC_BLK_4:
+		frame->blocks = 4;
+		break;
+	case SBC_BLK_8:
+		frame->blocks = 8;
+		break;
+	case SBC_BLK_12:
+		frame->blocks = 12;
+		break;
+	case SBC_BLK_16:
+		frame->blocks = 16;
+		break;
+	}
+
+	frame->mode = (data[1] >> 2) & 0x03;
+
+	switch (frame->mode) {
+	case MONO:
+		frame->channels = 1;
+		break;
+	case DUAL_CHANNEL:	/* fall-through */
+	case STEREO:
+	case JOINT_STEREO:
+		frame->channels = 2;
+		break;
+	}
+
+	frame->allocation = (data[1] >> 1) & 0x01;
+
+	frame->subband_mode = (data[1] & 0x01);
+	frame->subbands = frame->subband_mode ? 8 : 4;
+
+	frame->bitpool = data[2];
+
+	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
+			frame->bitpool > 16 * frame->subbands)
+		return -4;
+
+	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
+			frame->bitpool > 32 * frame->subbands)
+		return -4;
+
+	return sbc_unpack_frame_internal(data, frame, len);
+}
+
+static int msbc_unpack_frame(const uint8_t *data,
+		struct sbc_frame *frame, size_t len)
+{
+	if (len < 4)
+		return -1;
+
+	if (data[0] != MSBC_SYNCWORD)
+		return -2;
+	if (data[1] != 0)
+		return -2;
+	if (data[2] != 0)
+		return -2;
+
+	frame->frequency = SBC_FREQ_16000;
+	frame->block_mode = SBC_BLK_4;
+	frame->blocks = MSBC_BLOCKS;
+	frame->allocation = LOUDNESS;
+	frame->mode = MONO;
+	frame->channels = 1;
+	frame->subband_mode = 1;
+	frame->subbands = 8;
+	frame->bitpool = 26;
+
+	return sbc_unpack_frame_internal(data, frame, len);
+}
+
 static void sbc_decoder_init(struct sbc_decoder_state *state,
 					const struct sbc_frame *frame)
 {
@@ -790,38 +821,6 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
 	uint32_t levels[2][8];	/* levels are derived from that */
 	uint32_t sb_sample_delta[2][8];
 
-	data[0] = SBC_SYNCWORD;
-
-	data[1] = (frame->frequency & 0x03) << 6;
-
-	data[1] |= (frame->block_mode & 0x03) << 4;
-
-	data[1] |= (frame->mode & 0x03) << 2;
-
-	data[1] |= (frame->allocation & 0x01) << 1;
-
-	switch (frame_subbands) {
-	case 4:
-		/* Nothing to do */
-		break;
-	case 8:
-		data[1] |= 0x01;
-		break;
-	default:
-		return -4;
-		break;
-	}
-
-	data[2] = frame->bitpool;
-
-	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
-			frame->bitpool > frame_subbands << 4)
-		return -5;
-
-	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
-			frame->bitpool > frame_subbands << 5)
-		return -5;
-
 	/* Can't fill in crc yet */
 
 	crc_header[0] = data[1];
@@ -889,6 +888,28 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
 static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len,
 								int joint)
 {
+	int frame_subbands = 4;
+
+	data[0] = SBC_SYNCWORD;
+
+	data[1] = (frame->frequency & 0x03) << 6;
+	data[1] |= (frame->block_mode & 0x03) << 4;
+	data[1] |= (frame->mode & 0x03) << 2;
+	data[1] |= (frame->allocation & 0x01) << 1;
+
+	data[2] = frame->bitpool;
+
+	if (frame->subbands != 4)
+		frame_subbands = 8;
+
+	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
+			frame->bitpool > frame_subbands << 4)
+		return -5;
+
+	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
+			frame->bitpool > frame_subbands << 5)
+		return -5;
+
 	if (frame->subbands == 4) {
 		if (frame->channels == 1)
 			return sbc_pack_frame_internal(
@@ -897,6 +918,7 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
 			return sbc_pack_frame_internal(
 				data, frame, len, 4, 2, joint);
 	} else {
+		data[1] |= 0x01;
 		if (frame->channels == 1)
 			return sbc_pack_frame_internal(
 				data, frame, len, 8, 1, joint);
@@ -906,6 +928,16 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
 	}
 }
 
+static ssize_t msbc_pack_frame(uint8_t *data, struct sbc_frame *frame,
+						size_t len, int joint)
+{
+	data[0] = MSBC_SYNCWORD;
+	data[1] = 0;
+	data[2] = 0;
+
+	return sbc_pack_frame_internal(data, frame, len, 8, 1, joint);
+}
+
 static void sbc_encoder_init(unsigned long flags,
 		struct sbc_encoder_state *state, const struct sbc_frame *frame)
 {
@@ -921,10 +953,24 @@ struct sbc_priv {
 	struct SBC_ALIGNED sbc_frame frame;
 	struct SBC_ALIGNED sbc_decoder_state dec_state;
 	struct SBC_ALIGNED sbc_encoder_state enc_state;
+	int (*unpack_frame)(const uint8_t *data, struct sbc_frame *frame,
+			size_t len);
+	ssize_t (*pack_frame)(uint8_t *data, struct sbc_frame *frame,
+			size_t len, int joint);
 };
 
 static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 {
+	struct sbc_priv *priv = sbc->priv;
+
+	if (flags & SBC_MSBC) {
+		priv->pack_frame = msbc_pack_frame;
+		priv->unpack_frame = msbc_unpack_frame;
+	} else {
+		priv->pack_frame = sbc_pack_frame;
+		priv->unpack_frame = sbc_unpack_frame;
+	}
+
 	sbc->flags = flags;
 	sbc->frequency = SBC_FREQ_44100;
 	sbc->mode = SBC_MODE_STEREO;
@@ -978,7 +1024,7 @@ SBC_EXPORT ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 
 	priv = sbc->priv;
 
-	framelen = sbc_unpack_frame(input, &priv->frame, input_len);
+	framelen = priv->unpack_frame(input, &priv->frame, input_len);
 
 	if (!priv->init) {
 		sbc_decoder_init(&priv->dec_state, &priv->frame);
@@ -1110,13 +1156,15 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 		int j = priv->enc_state.sbc_calc_scalefactors_j(
 			priv->frame.sb_sample_f, priv->frame.scale_factor,
 			priv->frame.blocks, priv->frame.subbands);
-		framelen = sbc_pack_frame(output, &priv->frame, output_len, j);
+		framelen = priv->pack_frame(output,
+				&priv->frame, output_len, j);
 	} else {
 		priv->enc_state.sbc_calc_scalefactors(
 			priv->frame.sb_sample_f, priv->frame.scale_factor,
 			priv->frame.blocks, priv->frame.channels,
 			priv->frame.subbands);
-		framelen = sbc_pack_frame(output, &priv->frame, output_len, 0);
+		framelen = priv->pack_frame(output,
+				&priv->frame, output_len, 0);
 	}
 
 	if (written)
-- 
1.7.9.5

