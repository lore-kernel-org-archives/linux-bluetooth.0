Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 1/3] sbc: new 'sbc_calc_scalefactors_j' function added to sbc primitives
Date: Tue, 29 Jun 2010 16:48:45 +0300
Message-Id: <1277819327-28592-2-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

The code for scale factors calculation with joint stereo support has
been moved to a separate function. It can get platform-specific
SIMD optimizations later for best possible performance.

But even this change in C code improves performance because of the
use of __builtin_clz() instead of loops similar to what was done
to sbc_calc_scalefactors earlier. Also technically it does loop
unrolling by processing two channels at once, which might be either
good or bad for performance (if the registers pressure is increased
and more data is spilled to memory). But the benchmark from 32-bit
x86 system (pentium-m) shows that it got clearly faster:

$ time ./sbcenc.old -b53 -s8 -j test.au > /dev/null

real    0m1.868s
user    0m1.808s
sys     0m0.048s

$ time ./sbcenc.new -b53 -s8 -j test.au > /dev/null

real    0m1.742s
user    0m1.668s
sys     0m0.064s
---
 sbc/sbc.c            |   92 +++++++++++++-------------------------------------
 sbc/sbc_primitives.c |   75 ++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives.h |    4 ++
 3 files changed, 103 insertions(+), 68 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 86399dd..7da7313 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -745,7 +745,8 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 
 static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(uint8_t *data,
 					struct sbc_frame *frame, size_t len,
-					int frame_subbands, int frame_channels)
+					int frame_subbands, int frame_channels,
+					int joint)
 {
 	/* Bitstream writer starts from the fourth byte */
 	uint8_t *data_ptr = data + 4;
@@ -802,63 +803,6 @@ static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(uint8_t *data,
 	crc_pos = 16;
 
 	if (frame->mode == JOINT_STEREO) {
-		/* like frame->sb_sample but joint stereo */
-		int32_t sb_sample_j[16][2];
-		/* scalefactor and scale_factor in joint case */
-		uint32_t scalefactor_j[2];
-		uint8_t scale_factor_j[2];
-
-		uint8_t joint = 0;
-		frame->joint = 0;
-
-		for (sb = 0; sb < frame_subbands - 1; sb++) {
-			scale_factor_j[0] = 0;
-			scalefactor_j[0] = 2 << SCALE_OUT_BITS;
-			scale_factor_j[1] = 0;
-			scalefactor_j[1] = 2 << SCALE_OUT_BITS;
-
-			for (blk = 0; blk < frame->blocks; blk++) {
-				uint32_t tmp;
-				/* Calculate joint stereo signal */
-				sb_sample_j[blk][0] =
-					ASR(frame->sb_sample_f[blk][0][sb], 1) +
-					ASR(frame->sb_sample_f[blk][1][sb], 1);
-				sb_sample_j[blk][1] =
-					ASR(frame->sb_sample_f[blk][0][sb], 1) -
-					ASR(frame->sb_sample_f[blk][1][sb], 1);
-
-				/* calculate scale_factor_j and scalefactor_j for joint case */
-				tmp = fabs(sb_sample_j[blk][0]);
-				while (scalefactor_j[0] < tmp) {
-					scale_factor_j[0]++;
-					scalefactor_j[0] *= 2;
-				}
-				tmp = fabs(sb_sample_j[blk][1]);
-				while (scalefactor_j[1] < tmp) {
-					scale_factor_j[1]++;
-					scalefactor_j[1] *= 2;
-				}
-			}
-
-			/* decide whether to join this subband */
-			if ((frame->scale_factor[0][sb] +
-					frame->scale_factor[1][sb]) >
-					(scale_factor_j[0] +
-					scale_factor_j[1])) {
-				/* use joint stereo for this subband */
-				joint |= 1 << (frame_subbands - 1 - sb);
-				frame->joint |= 1 << sb;
-				frame->scale_factor[0][sb] = scale_factor_j[0];
-				frame->scale_factor[1][sb] = scale_factor_j[1];
-				for (blk = 0; blk < frame->blocks; blk++) {
-					frame->sb_sample_f[blk][0][sb] =
-							sb_sample_j[blk][0];
-					frame->sb_sample_f[blk][1][sb] =
-							sb_sample_j[blk][1];
-				}
-			}
-		}
-
 		PUT_BITS(data_ptr, bits_cache, bits_count,
 			joint, frame_subbands);
 		crc_header[crc_pos >> 3] = joint;
@@ -916,18 +860,23 @@ static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(uint8_t *data,
 	return data_ptr - data;
 }
 
-static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
+static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len,
+								int joint)
 {
 	if (frame->subbands == 4) {
 		if (frame->channels == 1)
-			return sbc_pack_frame_internal(data, frame, len, 4, 1);
+			return sbc_pack_frame_internal(
+				data, frame, len, 4, 1, joint);
 		else
-			return sbc_pack_frame_internal(data, frame, len, 4, 2);
+			return sbc_pack_frame_internal(
+				data, frame, len, 4, 2, joint);
 	} else {
 		if (frame->channels == 1)
-			return sbc_pack_frame_internal(data, frame, len, 8, 1);
+			return sbc_pack_frame_internal(
+				data, frame, len, 8, 1, joint);
 		else
-			return sbc_pack_frame_internal(data, frame, len, 8, 2);
+			return sbc_pack_frame_internal(
+				data, frame, len, 8, 2, joint);
 	}
 }
 
@@ -1121,11 +1070,18 @@ ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 
 	samples = sbc_analyze_audio(&priv->enc_state, &priv->frame);
 
-	priv->enc_state.sbc_calc_scalefactors(
-		priv->frame.sb_sample_f, priv->frame.scale_factor,
-		priv->frame.blocks, priv->frame.channels, priv->frame.subbands);
-
-	framelen = sbc_pack_frame(output, &priv->frame, output_len);
+	if (priv->frame.mode == JOINT_STEREO) {
+		int j = priv->enc_state.sbc_calc_scalefactors_j(
+			priv->frame.sb_sample_f, priv->frame.scale_factor,
+			priv->frame.blocks, priv->frame.subbands);
+		framelen = sbc_pack_frame(output, &priv->frame, output_len, j);
+	} else {
+		priv->enc_state.sbc_calc_scalefactors(
+			priv->frame.sb_sample_f, priv->frame.scale_factor,
+			priv->frame.blocks, priv->frame.channels,
+			priv->frame.subbands);
+		framelen = sbc_pack_frame(output, &priv->frame, output_len, 0);
+	}
 
 	if (written)
 		*written = framelen;
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 41934d3..c73fb1c 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -440,6 +440,80 @@ static void sbc_calc_scalefactors(
 	}
 }
 
+static int sbc_calc_scalefactors_j(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int subbands)
+{
+	int blk, joint = 0;
+	int32_t tmp0, tmp1;
+	uint32_t x, y;
+
+	/* last subband does not use joint stereo */
+	int sb = subbands - 1;
+	x = 1 << SCALE_OUT_BITS;
+	y = 1 << SCALE_OUT_BITS;
+	for (blk = 0; blk < blocks; blk++) {
+		tmp0 = fabs(sb_sample_f[blk][0][sb]);
+		tmp1 = fabs(sb_sample_f[blk][1][sb]);
+		if (tmp0 != 0)
+			x |= tmp0 - 1;
+		if (tmp1 != 0)
+			y |= tmp1 - 1;
+	}
+	scale_factor[0][sb] = (31 - SCALE_OUT_BITS) - sbc_clz(x);
+	scale_factor[1][sb] = (31 - SCALE_OUT_BITS) - sbc_clz(y);
+
+	/* the rest of subbands can use joint stereo */
+	while (--sb >= 0) {
+		int32_t sb_sample_j[16][2];
+		x = 1 << SCALE_OUT_BITS;
+		y = 1 << SCALE_OUT_BITS;
+		for (blk = 0; blk < blocks; blk++) {
+			tmp0 = sb_sample_f[blk][0][sb];
+			tmp1 = sb_sample_f[blk][1][sb];
+			sb_sample_j[blk][0] = ASR(tmp0, 1) + ASR(tmp1, 1);
+			sb_sample_j[blk][1] = ASR(tmp0, 1) - ASR(tmp1, 1);
+			tmp0 = fabs(tmp0);
+			tmp1 = fabs(tmp1);
+			if (tmp0 != 0)
+				x |= tmp0 - 1;
+			if (tmp1 != 0)
+				y |= tmp1 - 1;
+		}
+		scale_factor[0][sb] = (31 - SCALE_OUT_BITS) -
+			sbc_clz(x);
+		scale_factor[1][sb] = (31 - SCALE_OUT_BITS) -
+			sbc_clz(y);
+		x = 1 << SCALE_OUT_BITS;
+		y = 1 << SCALE_OUT_BITS;
+		for (blk = 0; blk < blocks; blk++) {
+			tmp0 = fabs(sb_sample_j[blk][0]);
+			tmp1 = fabs(sb_sample_j[blk][1]);
+			if (tmp0 != 0)
+				x |= tmp0 - 1;
+			if (tmp1 != 0)
+				y |= tmp1 - 1;
+		}
+		x = (31 - SCALE_OUT_BITS) - sbc_clz(x);
+		y = (31 - SCALE_OUT_BITS) - sbc_clz(y);
+
+		/* decide whether to use joint stereo for this subband */
+		if ((scale_factor[0][sb] + scale_factor[1][sb]) > x + y) {
+			joint |= 1 << (subbands - 1 - sb);
+			scale_factor[0][sb] = x;
+			scale_factor[1][sb] = y;
+			for (blk = 0; blk < blocks; blk++) {
+				sb_sample_f[blk][0][sb] = sb_sample_j[blk][0];
+				sb_sample_f[blk][1][sb] = sb_sample_j[blk][1];
+			}
+		}
+	}
+
+	/* bitmask with the information about subbands using joint stereo */
+	return joint;
+}
+
 /*
  * Detect CPU features and setup function pointers
  */
@@ -457,6 +531,7 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 
 	/* Default implementation for scale factors calculation */
 	state->sbc_calc_scalefactors = sbc_calc_scalefactors;
+	state->sbc_calc_scalefactors_j = sbc_calc_scalefactors_j;
 	state->implementation_info = "Generic C";
 
 	/* X86/AMD64 optimizations */
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 3be02ed..3fec8d5 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -63,6 +63,10 @@ struct sbc_encoder_state {
 	void (*sbc_calc_scalefactors)(int32_t sb_sample_f[16][2][8],
 			uint32_t scale_factor[2][8],
 			int blocks, int channels, int subbands);
+	/* Scale factors calculation with joint stereo support */
+	int (*sbc_calc_scalefactors_j)(int32_t sb_sample_f[16][2][8],
+			uint32_t scale_factor[2][8],
+			int blocks, int subbands);
 	const char *implementation_info;
 };
 
-- 
1.6.4.4

