Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/5] Add msbc encoding and decoding flag
Date: Thu, 27 Sep 2012 16:44:24 +0200
Message-Id: <1348757068-31048-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also enable 15 blocks support using stdc sbc primitives
---
 Makefile.am               |    1 +
 sbc/sbc.c                 |  123 +++++++++--------
 sbc/sbc.h                 |    3 +
 sbc/sbc_primitives.c      |    8 +-
 sbc/sbc_primitives.h      |    7 +-
 sbc/sbc_primitives_stdc.c |  321 +++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_stdc.h |   36 +++++
 7 files changed, 443 insertions(+), 56 deletions(-)
 create mode 100644 sbc/sbc_primitives_stdc.c
 create mode 100644 sbc/sbc_primitives_stdc.h

diff --git a/Makefile.am b/Makefile.am
index cad6a3b..75e3a4a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,6 +14,7 @@ sbc_headers = sbc/sbc.h
 
 sbc_sources = sbc/sbc.c sbc/sbc_private.h sbc/sbc_math.h sbc/sbc_tables.h \
 		sbc/sbc_primitives.h sbc/sbc_primitives.c \
+		sbc/sbc_primitives_stdc.h sbc/sbc_primitives_stdc.c \
 		sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
 		sbc/sbc_primitives_iwmmxt.h sbc/sbc_primitives_iwmmxt.c \
 		sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
diff --git a/sbc/sbc.c b/sbc/sbc.c
index f0c77c7..7e4faa0 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
  *  Copyright (C) 2005-2008  Brad Midgley <bmidgley@xmission.com>
+ *  Copyright (C) 2012       Intel Corporation
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -51,6 +52,17 @@
 #include "sbc_primitives.h"
 
 #define SBC_SYNCWORD	0x9C
+#define MSBC_SYNCWORD	0xAD
+#define SBC_BLOCKS(sbc, blocks) (((sbc)->flags & SBC_MSBC) \
+				? MSBC_BLOCKS : (blocks))
+
+#define MSBC_BLOCKMODE		SBC_BLK_16
+#define MSBC_BLOCKS		15
+#define MSBC_BITPOOL		26
+#define MSBC_SUBBAND_MODE	1
+#define MSBC_SUBBANDS		8
+#define MSBC_CHANNEL		1
+#define MSBC_ALLOCATION		SBC_AM_LOUDNESS
 
 /* This structure contains an unpacked SBC frame.
    Yes, there is probably quite some unused space herein */
@@ -373,9 +385,11 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
  *  -2   Sync byte incorrect
  *  -3   CRC8 incorrect
  *  -4   Bitpool value out of bounds
+ *  -5   msbc reserved byte 1 not 0
+ *  -6   msbc reserved byte 2 not 0
  */
-static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
-								size_t len)
+static int sbc_unpack_frame(sbc_t *sbc, const uint8_t *data,
+		struct sbc_frame *frame, size_t len)
 {
 	unsigned int consumed;
 	/* Will copy the parts of the header that are relevant to crc
@@ -413,6 +427,8 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
 		frame->blocks = 16;
 		break;
 	}
+	if (sbc->flags & SBC_MSBC)
+		frame->blocks = MSBC_BLOCKS;
 
 	frame->mode = (data[1] >> 2) & 0x03;
 	switch (frame->mode) {
@@ -690,13 +706,13 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 		for (ch = 0; ch < frame->channels; ch++) {
 			x = &state->X[ch][state->position - 16 +
 							frame->blocks * 4];
-			for (blk = 0; blk < frame->blocks; blk += 4) {
+			for (blk = 0; blk < frame->blocks; blk += state->inc) {
 				state->sbc_analyze_4b_4s(
 					x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				x -= 16;
+				x -= 4 * state->inc;
 			}
 		}
 		return frame->blocks * 4;
@@ -705,13 +721,13 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 		for (ch = 0; ch < frame->channels; ch++) {
 			x = &state->X[ch][state->position - 32 +
 							frame->blocks * 8];
-			for (blk = 0; blk < frame->blocks; blk += 4) {
+			for (blk = 0; blk < frame->blocks; blk += state->inc) {
 				state->sbc_analyze_4b_8s(
 					x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				x -= 32;
+				x -= 8 * state->inc;
 			}
 		}
 		return frame->blocks * 8;
@@ -764,10 +780,9 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
  * -99 not implemented
  */
 
-static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
-					struct sbc_frame *frame, size_t len,
-					int frame_subbands, int frame_channels,
-					int joint)
+static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(sbc_t *sbc,
+			uint8_t *data, struct sbc_frame *frame, size_t len,
+			int frame_subbands, int frame_channels, int joint)
 {
 	/* Bitstream writer starts from the fourth byte */
 	uint8_t *data_ptr = data + 4;
@@ -785,37 +800,37 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
 	uint32_t levels[2][8];	/* levels are derived from that */
 	uint32_t sb_sample_delta[2][8];
 
-	data[0] = SBC_SYNCWORD;
+		data[0] = SBC_SYNCWORD;
 
-	data[1] = (frame->frequency & 0x03) << 6;
+		data[1] = (frame->frequency & 0x03) << 6;
 
-	data[1] |= (frame->block_mode & 0x03) << 4;
+		data[1] |= (frame->block_mode & 0x03) << 4;
 
-	data[1] |= (frame->mode & 0x03) << 2;
+		data[1] |= (frame->mode & 0x03) << 2;
 
-	data[1] |= (frame->allocation & 0x01) << 1;
+		data[1] |= (frame->allocation & 0x01) << 1;
 
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
+		switch (frame_subbands) {
+		case 4:
+			/* Nothing to do */
+			break;
+		case 8:
+			data[1] |= 0x01;
+			break;
+		default:
+			return -4;
+			break;
+		}
 
-	data[2] = frame->bitpool;
+		data[2] = frame->bitpool;
 
-	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
-			frame->bitpool > frame_subbands << 4)
-		return -5;
+		if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
+				frame->bitpool > frame_subbands << 4)
+			return -5;
 
-	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
-			frame->bitpool > frame_subbands << 5)
-		return -5;
+		if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
+				frame->bitpool > frame_subbands << 5)
+			return -5;
 
 	/* Can't fill in crc yet */
 
@@ -881,33 +896,33 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
 	return data_ptr - data;
 }
 
-static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len,
-								int joint)
+static ssize_t sbc_pack_frame(sbc_t *sbc, uint8_t *data,
+		struct sbc_frame *frame, size_t len, int joint)
 {
 	if (frame->subbands == 4) {
 		if (frame->channels == 1)
 			return sbc_pack_frame_internal(
-				data, frame, len, 4, 1, joint);
+				sbc, data, frame, len, 4, 1, joint);
 		else
 			return sbc_pack_frame_internal(
-				data, frame, len, 4, 2, joint);
+				sbc, data, frame, len, 4, 2, joint);
 	} else {
 		if (frame->channels == 1)
 			return sbc_pack_frame_internal(
-				data, frame, len, 8, 1, joint);
+				sbc, data, frame, len, 8, 1, joint);
 		else
 			return sbc_pack_frame_internal(
-				data, frame, len, 8, 2, joint);
+				sbc, data, frame, len, 8, 2, joint);
 	}
 }
 
-static void sbc_encoder_init(struct sbc_encoder_state *state,
+static void sbc_encoder_init(int msbc, struct sbc_encoder_state *state,
 					const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
 
-	sbc_init_primitives(state);
+	sbc_init_primitives(msbc, state);
 }
 
 struct sbc_priv {
@@ -919,6 +934,7 @@ struct sbc_priv {
 
 static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
 {
+	sbc->flags = flags;
 	sbc->frequency = SBC_FREQ_44100;
 	sbc->mode = SBC_MODE_STEREO;
 	sbc->subbands = SBC_SB_8;
@@ -971,7 +987,7 @@ SBC_EXPORT ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 
 	priv = sbc->priv;
 
-	framelen = sbc_unpack_frame(input, &priv->frame, input_len);
+	framelen = sbc_unpack_frame(sbc, input, &priv->frame, input_len);
 
 	if (!priv->init) {
 		sbc_decoder_init(&priv->dec_state, &priv->frame);
@@ -980,7 +996,7 @@ SBC_EXPORT ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 		sbc->frequency = priv->frame.frequency;
 		sbc->mode = priv->frame.mode;
 		sbc->subbands = priv->frame.subband_mode;
-		sbc->blocks = priv->frame.block_mode;
+		sbc->blocks = SBC_BLOCKS(sbc, priv->frame.block_mode);
 		sbc->allocation = priv->frame.allocation;
 		sbc->bitpool = priv->frame.bitpool;
 
@@ -1054,12 +1070,13 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 		priv->frame.subband_mode = sbc->subbands;
 		priv->frame.subbands = sbc->subbands ? 8 : 4;
 		priv->frame.block_mode = sbc->blocks;
-		priv->frame.blocks = 4 + (sbc->blocks * 4);
+		priv->frame.blocks = SBC_BLOCKS(sbc, 4 + (sbc->blocks * 4));
 		priv->frame.bitpool = sbc->bitpool;
 		priv->frame.codesize = sbc_get_codesize(sbc);
 		priv->frame.length = sbc_get_frame_length(sbc);
 
-		sbc_encoder_init(&priv->enc_state, &priv->frame);
+		sbc_encoder_init(sbc->flags & SBC_MSBC,
+				&priv->enc_state, &priv->frame);
 		priv->init = 1;
 	} else if (priv->frame.bitpool != sbc->bitpool) {
 		priv->frame.length = sbc_get_frame_length(sbc);
@@ -1102,13 +1119,15 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 		int j = priv->enc_state.sbc_calc_scalefactors_j(
 			priv->frame.sb_sample_f, priv->frame.scale_factor,
 			priv->frame.blocks, priv->frame.subbands);
-		framelen = sbc_pack_frame(output, &priv->frame, output_len, j);
+		framelen = sbc_pack_frame(sbc, output,
+				&priv->frame, output_len, j);
 	} else {
 		priv->enc_state.sbc_calc_scalefactors(
 			priv->frame.sb_sample_f, priv->frame.scale_factor,
 			priv->frame.blocks, priv->frame.channels,
 			priv->frame.subbands);
-		framelen = sbc_pack_frame(output, &priv->frame, output_len, 0);
+		framelen = sbc_pack_frame(sbc, output,
+				&priv->frame, output_len, 0);
 	}
 
 	if (written)
@@ -1138,7 +1157,7 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
 		return priv->frame.length;
 
 	subbands = sbc->subbands ? 8 : 4;
-	blocks = 4 + (sbc->blocks * 4);
+	blocks = SBC_BLOCKS(sbc, 4 + (sbc->blocks * 4));
 	channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	joint = sbc->mode == SBC_MODE_JOINT_STEREO ? 1 : 0;
 	bitpool = sbc->bitpool;
@@ -1162,10 +1181,10 @@ SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		blocks = SBC_BLOCKS(sbc, 4 + (sbc->blocks * 4));
 	} else {
 		subbands = priv->frame.subbands;
-		blocks = priv->frame.blocks;
+		blocks = SBC_BLOCKS(sbc, priv->frame.blocks);
 	}
 
 	switch (sbc->frequency) {
@@ -1199,11 +1218,11 @@ SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
 	priv = sbc->priv;
 	if (!priv->init) {
 		subbands = sbc->subbands ? 8 : 4;
-		blocks = 4 + (sbc->blocks * 4);
+		blocks = SBC_BLOCKS(sbc, 4 + (sbc->blocks * 4));
 		channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
 	} else {
 		subbands = priv->frame.subbands;
-		blocks = priv->frame.blocks;
+		blocks = SBC_BLOCKS(sbc, priv->frame.blocks);
 		channels = priv->frame.channels;
 	}
 
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
index ad780d0..1ed61d1 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -32,6 +32,7 @@
 #include "sbc_tables.h"
 
 #include "sbc_primitives.h"
+#include "sbc_primitives_stdc.h"
 #include "sbc_primitives_mmx.h"
 #include "sbc_primitives_iwmmxt.h"
 #include "sbc_primitives_neon.h"
@@ -519,8 +520,10 @@ static int sbc_calc_scalefactors_j(
 /*
  * Detect CPU features and setup function pointers
  */
-void sbc_init_primitives(struct sbc_encoder_state *state)
+void sbc_init_primitives(int msbc, struct sbc_encoder_state *state)
 {
+	state->inc = 4;
+
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
@@ -551,4 +554,7 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 #ifdef SBC_BUILD_WITH_NEON_SUPPORT
 	sbc_init_primitives_neon(state);
 #endif
+
+	if (msbc)
+		sbc_init_primitives_stdc(state);
 }
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 17ad4f7..22778ff 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -38,12 +38,13 @@
 
 struct sbc_encoder_state {
 	int position;
+	int inc;
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
-	 * it handles 4 blocks at once */
+	 * it handles "inc" blocks at once */
 	void (*sbc_analyze_4b_4s)(int16_t *x, int32_t *out, int out_stride);
 	/* Polyphase analysis filter for 8 subbands configuration,
-	 * it handles 4 blocks at once */
+	 * it handles "inc" blocks at once */
 	void (*sbc_analyze_4b_8s)(int16_t *x, int32_t *out, int out_stride);
 	/* Process input data (deinterleave, endian conversion, reordering),
 	 * depending on the number of subbands and input data byte order */
@@ -75,6 +76,6 @@ struct sbc_encoder_state {
  * of SBC codec. Best implementation is selected based on target CPU
  * capabilities.
  */
-void sbc_init_primitives(struct sbc_encoder_state *encoder_state);
+void sbc_init_primitives(int msbc, struct sbc_encoder_state *encoder_state);
 
 #endif
diff --git a/sbc/sbc_primitives_stdc.c b/sbc/sbc_primitives_stdc.c
new file mode 100644
index 0000000..02ad8eb
--- /dev/null
+++ b/sbc/sbc_primitives_stdc.c
@@ -0,0 +1,321 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2008-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
+ *  Copyright (C) 2005-2006  Brad Midgley <bmidgley@xmission.com>
+ *  Copyright (C) 2012 Intel Corporation
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <limits.h>
+#include <string.h>
+#include "sbc.h"
+#include "sbc_math.h"
+#include "sbc_tables.h"
+
+#include "sbc_primitives.h"
+#include "sbc_primitives_stdc.h"
+
+/*
+ * stdc optimizations
+ */
+
+#ifdef SBC_BUILD_WITH_STDC_SUPPORT
+
+/*
+ * A standard C code of analysis filter.
+ */
+static inline void sbc_analyze_four_stdc(const int16_t *in, int32_t *out)
+{
+	FIXED_A t1[4];
+	FIXED_T t2[4];
+	int i = 0, hop = 0;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 40; hop += 8) {
+		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed4[hop];
+		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed4[hop + 1];
+		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed4[hop + 2];
+		t1[1] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed4[hop + 3];
+		t1[0] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed4[hop + 4];
+		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed4[hop + 5];
+		t1[3] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed4[hop + 7];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED4_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED4_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED4_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED4_SCALE;
+
+	/* do the cos transform */
+	for (i = 0, hop = 0; i < 4; hop += 8, i++) {
+		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_4[0 + hop] +
+			  (FIXED_A) t2[1] * cos_table_fixed_4[1 + hop] +
+			  (FIXED_A) t2[2] * cos_table_fixed_4[2 + hop] +
+			  (FIXED_A) t2[3] * cos_table_fixed_4[5 + hop]) >>
+			(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	}
+}
+
+static inline void sbc_analyze_eight_stdc(const int16_t *in, int32_t *out)
+{
+	FIXED_A t1[8];
+	FIXED_T t2[8];
+	int i, hop;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED8_SCALE-1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 80; hop += 16) {
+		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed8[hop];
+		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed8[hop + 1];
+		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed8[hop + 2];
+		t1[3] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed8[hop + 3];
+		t1[4] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed8[hop + 4];
+		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed8[hop + 5];
+		t1[2] += (FIXED_A) in[hop + 6] * _sbc_proto_fixed8[hop + 6];
+		t1[1] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed8[hop + 7];
+		t1[0] += (FIXED_A) in[hop + 8] * _sbc_proto_fixed8[hop + 8];
+		t1[5] += (FIXED_A) in[hop + 9] * _sbc_proto_fixed8[hop + 9];
+		t1[6] += (FIXED_A) in[hop + 10] * _sbc_proto_fixed8[hop + 10];
+		t1[7] += (FIXED_A) in[hop + 11] * _sbc_proto_fixed8[hop + 11];
+		t1[7] += (FIXED_A) in[hop + 13] * _sbc_proto_fixed8[hop + 13];
+		t1[6] += (FIXED_A) in[hop + 14] * _sbc_proto_fixed8[hop + 14];
+		t1[5] += (FIXED_A) in[hop + 15] * _sbc_proto_fixed8[hop + 15];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED8_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED8_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED8_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED8_SCALE;
+	t2[4] = t1[4] >> SBC_PROTO_FIXED8_SCALE;
+	t2[5] = t1[5] >> SBC_PROTO_FIXED8_SCALE;
+	t2[6] = t1[6] >> SBC_PROTO_FIXED8_SCALE;
+	t2[7] = t1[7] >> SBC_PROTO_FIXED8_SCALE;
+
+	/* do the cos transform */
+	for (i = 0, hop = 0; i < 8; hop += 16, i++) {
+		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_8[0 + hop] +
+			  (FIXED_A) t2[1] * cos_table_fixed_8[1 + hop] +
+			  (FIXED_A) t2[2] * cos_table_fixed_8[2 + hop] +
+			  (FIXED_A) t2[3] * cos_table_fixed_8[3 + hop] +
+			  (FIXED_A) t2[4] * cos_table_fixed_8[4 + hop] +
+			  (FIXED_A) t2[5] * cos_table_fixed_8[9 + hop] +
+			  (FIXED_A) t2[6] * cos_table_fixed_8[10 + hop] +
+			  (FIXED_A) t2[7] * cos_table_fixed_8[11 + hop]) >>
+			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
+	}
+}
+
+static inline void sbc_analyze_4b_4s_stdc(int16_t *x, int32_t *out,
+						int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_four_stdc(x + 0, out);
+}
+
+static inline void sbc_analyze_4b_8s_stdc(int16_t *x, int32_t *out,
+						int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_eight_stdc(x + 0, out);
+}
+
+static inline int16_t unaligned16_be(const uint8_t *ptr)
+{
+	return (int16_t) ((ptr[0] << 8) | ptr[1]);
+}
+
+static inline int16_t unaligned16_le(const uint8_t *ptr)
+{
+	return (int16_t) (ptr[0] | (ptr[1] << 8));
+}
+
+/*
+ * Internal helper functions for input data processing. In order to get
+ * optimal performance, it is important to have "nsamples", "nchannels"
+ * and "big_endian" arguments used with this inline function as compile
+ * time constants.
+ */
+
+static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s4_stdc(
+	int position,
+	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int big_endian)
+{
+	/* handle X buffer wraparound */
+	if (position < nsamples) {
+		if (nchannels > 0)
+			memcpy(&X[0][SBC_X_BUFFER_SIZE - 40], &X[0][position],
+							36 * sizeof(int16_t));
+		if (nchannels > 1)
+			memcpy(&X[1][SBC_X_BUFFER_SIZE - 40], &X[1][position],
+							36 * sizeof(int16_t));
+		position = SBC_X_BUFFER_SIZE - 40;
+	}
+
+	#define PCM(i) (big_endian ? \
+		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
+
+	/* copy audio samples */
+	while ((nsamples -= 1) >= 0) {
+		position -= 1;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = PCM(0 + 0 * nchannels);
+		}
+		if (nchannels > 1) {
+			int16_t *x = &X[1][position];
+			x[1]  = PCM(1 + 0 * nchannels);
+		}
+		pcm += 2 * nchannels;
+	}
+
+
+	#undef PCM
+
+	return position;
+}
+
+
+static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_stdc(
+	int position,
+	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int big_endian)
+{
+	/* handle X buffer wraparound */
+	if (position < nsamples) {
+		if (nchannels > 0)
+			memcpy(&X[0][SBC_X_BUFFER_SIZE - 72], &X[0][position],
+							72 * sizeof(int16_t));
+		if (nchannels > 1)
+			memcpy(&X[1][SBC_X_BUFFER_SIZE - 72], &X[1][position],
+							72 * sizeof(int16_t));
+		position = SBC_X_BUFFER_SIZE - 72;
+	}
+
+	#define PCM(i) (big_endian ? \
+		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
+
+	/* copy audio samples */
+	while ((nsamples -= 1) >= 0) {
+		position -= 1;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = PCM(0 + 0 * nchannels);
+		}
+		if (nchannels > 1) {
+			int16_t *x = &X[1][position];
+			x[1]  = PCM(1 + 0 * nchannels);
+		}
+		pcm += 2 * nchannels;
+	}
+
+	#undef PCM
+	return position;
+}
+
+/*
+ * Input data processing functions. The data is endian converted if needed,
+ * channels are deintrleaved and audio samples are reordered for use in
+ * SIMD-friendly analysis filter function. The results are put into "X"
+ * array, getting appended to the previous data (or it is better to say
+ * prepended, as the buffer is filled from top to bottom). Old data is
+ * discarded when neededed, but availability of (10 * nrof_subbands)
+ * contiguous samples is always guaranteed for the input to the analysis
+ * filter. This is achieved by copying a sufficient part of old data
+ * to the top of the buffer on buffer wraparound.
+ */
+
+static int sbc_enc_process_input_4s_le_stdc(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s4_stdc(
+			position, pcm, X, nsamples, 2, 0);
+	else
+		return sbc_encoder_process_input_s4_stdc(
+			position, pcm, X, nsamples, 1, 0);
+}
+
+static int sbc_enc_process_input_4s_be_stdc(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s4_stdc(
+			position, pcm, X, nsamples, 2, 1);
+	else
+		return sbc_encoder_process_input_s4_stdc(
+			position, pcm, X, nsamples, 1, 1);
+}
+
+static int sbc_enc_process_input_8s_le_stdc(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s8_stdc(
+			position, pcm, X, nsamples, 2, 0);
+	else
+		return sbc_encoder_process_input_s8_stdc(
+			position, pcm, X, nsamples, 1, 0);
+}
+
+static int sbc_enc_process_input_8s_be_stdc(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s8_stdc(
+			position, pcm, X, nsamples, 2, 1);
+	else
+		return sbc_encoder_process_input_s8_stdc(
+			position, pcm, X, nsamples, 1, 1);
+}
+
+
+void sbc_init_primitives_stdc(struct sbc_encoder_state *state)
+{
+	state->inc = 1;
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_stdc;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_stdc;
+
+	/* Default implementation for input reordering / deinterleaving */
+	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le_stdc;
+	state->sbc_enc_process_input_4s_be = sbc_enc_process_input_4s_be_stdc;
+	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le_stdc;
+	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be_stdc;
+
+	state->implementation_info = "stdc";
+}
+
+#endif
diff --git a/sbc/sbc_primitives_stdc.h b/sbc/sbc_primitives_stdc.h
new file mode 100644
index 0000000..e313047
--- /dev/null
+++ b/sbc/sbc_primitives_stdc.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2008-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
+ *  Copyright (C) 2005-2006  Brad Midgley <bmidgley@xmission.com>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __SBC_PRIMITIVES_STDC_H
+#define __SBC_PRIMITIVES_STDC_H
+
+#include "sbc_primitives.h"
+
+#define SBC_BUILD_WITH_STDC_SUPPORT
+
+void sbc_init_primitives_stdc(struct sbc_encoder_state *encoder_state);
+
+#endif
-- 
1.7.9.5

