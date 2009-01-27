Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Performance optimizations for input data processing in SBC encoder
Date: Tue, 27 Jan 2009 20:14:13 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_170fJkZFhnJEOo9"
Message-Id: <200901272014.13387.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_170fJkZFhnJEOo9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

Here is a cleaned up version of the previous experimental patch:
http://marc.info/?l=linux-bluetooth&m=123245036109697&w=2

I changed it to be alignment and byte order neutral (input data is read one
byte at a time). It's a bit slower than reading via int16_t * pointer, but
avoids headache of worrying about the other problems. Endian conversion
is still also kept (when reading one byte at a time, it does not affect
performance anyway).

The patch should be safe to apply.

Benchmarks show consistent performance improvement ~30% for both x86
and ARM Cortex-A8. It's even more than I measured before just because
optimizations are cumulative and the effect of each individual change becomes
more visible when the other parts also get faster (the previous benchmark was
run before "-funroll-loops" optimization got committed).

ARM Cortex-A8:

before:
real    1m 24.78s
user    1m 21.20s
sys     0m 3.57s

after:
real    1m 4.72s
user    1m 1.03s
sys     0m 3.68s

Intel Core2:

before:
real    0m10.210s
user    0m9.761s
sys     0m0.324s

after:
real    0m7.729s
user    0m7.268s
sys     0m0.376s


Best regards,
Siarhei Siamashka

--Boundary-00=_170fJkZFhnJEOo9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Performance-optimizations-for-input-data-processing.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Performance-optimizations-for-input-data-processing.patch"

>From 4ba7973335bd19ac364e474bc811c20c3111d4e2 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Tue, 27 Jan 2009 18:57:35 +0200
Subject: [PATCH] Performance optimizations for input data processing in SBC encoder

Channels deinterleaving, endian conversion and samples reordering
is done in one pass, avoiding the use of intermediate buffer. Also
this code is implemented as a new "performance primitive", which
allows further platform specific optimizations (ARMv6 and ARM NEON
should gain quite a lot from assembly optimizations here).
---
 sbc/sbc.c                 |   55 +++++-----
 sbc/sbc_primitives.c      |  260 +++++++++++++++++++++++++++++++++++----------
 sbc/sbc_primitives.h      |   26 ++++--
 sbc/sbc_primitives_mmx.c  |   62 +----------
 sbc/sbc_primitives_neon.c |   58 +----------
 5 files changed, 258 insertions(+), 203 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 190ac17..365ee1f 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -657,14 +657,11 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 		for (ch = 0; ch < frame->channels; ch++)
 			for (blk = 0; blk < frame->blocks; blk += 4) {
 				state->sbc_analyze_4b_4s(
-					&frame->pcm_sample[ch][blk * 4],
-					&state->X[ch][state->position[ch]],
+					&state->X[ch][state->position +
+							48 - blk * 4],
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				state->position[ch] -= 16;
-				if (state->position[ch] < 0)
-					state->position[ch] = 64 - 16;
 			}
 		return frame->blocks * 4;
 
@@ -672,14 +669,11 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 		for (ch = 0; ch < frame->channels; ch++)
 			for (blk = 0; blk < frame->blocks; blk += 4) {
 				state->sbc_analyze_4b_8s(
-					&frame->pcm_sample[ch][blk * 8],
-					&state->X[ch][state->position[ch]],
+					&state->X[ch][state->position +
+							96 - blk * 8],
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
-				state->position[ch] -= 32;
-				if (state->position[ch] < 0)
-					state->position[ch] = 128 - 32;
 			}
 		return frame->blocks * 8;
 
@@ -935,8 +929,7 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 				const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
-	state->subbands = frame->subbands;
-	state->position[0] = state->position[1] = 12 * frame->subbands;
+	state->position = SBC_X_BUFFER_SIZE - frame->subbands * 9;
 
 	sbc_init_primitives(state);
 }
@@ -1060,8 +1053,10 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 		int output_len, int *written)
 {
 	struct sbc_priv *priv;
-	char *ptr;
-	int i, ch, framelen, samples;
+	int framelen, samples;
+	int (*sbc_enc_process_input)(int position,
+			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels);
 
 	if (!sbc && !input)
 		return -EIO;
@@ -1096,20 +1091,28 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 	if (!output || output_len < priv->frame.length)
 		return -ENOSPC;
 
-	ptr = input;
-
-	for (i = 0; i < priv->frame.subbands * priv->frame.blocks; i++) {
-		for (ch = 0; ch < priv->frame.channels; ch++) {
-			int16_t s;
-			if (sbc->endian == SBC_BE)
-				s = (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);
-			else
-				s = (ptr[0] & 0xff) | (ptr[1] & 0xff) << 8;
-			ptr += 2;
-			priv->frame.pcm_sample[ch][i] = s;
-		}
+	/* Select the needed input data processing function and call it */
+	if (priv->frame.subbands == 8) {
+		if (sbc->endian == SBC_BE)
+			sbc_enc_process_input =
+				priv->enc_state.sbc_enc_process_input_8s_be;
+		else
+			sbc_enc_process_input =
+				priv->enc_state.sbc_enc_process_input_8s_le;
+	} else {
+		if (sbc->endian == SBC_BE)
+			sbc_enc_process_input =
+				priv->enc_state.sbc_enc_process_input_4s_be;
+		else
+			sbc_enc_process_input =
+				priv->enc_state.sbc_enc_process_input_4s_le;
 	}
 
+	priv->enc_state.position = sbc_enc_process_input(
+		priv->enc_state.position, (const uint8_t *) input,
+		priv->enc_state.X, priv->frame.subbands * priv->frame.blocks,
+		priv->frame.channels);
+
 	samples = sbc_analyze_audio(&priv->enc_state, &priv->frame);
 
 	framelen = sbc_pack_frame(output, &priv->frame, output_len);
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 602b473..338feb9 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -25,6 +25,7 @@
 
 #include <stdint.h>
 #include <limits.h>
+#include <string.h>
 #include "sbc.h"
 #include "sbc_math.h"
 #include "sbc_tables.h"
@@ -179,28 +180,9 @@ static inline void sbc_analyze_eight_simd(const int16_t *in, int32_t *out,
 			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
 }
 
-static inline void sbc_analyze_4b_4s_simd(int16_t *pcm, int16_t *x,
+static inline void sbc_analyze_4b_4s_simd(int16_t *x,
 						int32_t *out, int out_stride)
 {
-	/* Fetch audio samples and do input data reordering for SIMD */
-	x[64] = x[0]  = pcm[8 + 7];
-	x[65] = x[1]  = pcm[8 + 3];
-	x[66] = x[2]  = pcm[8 + 6];
-	x[67] = x[3]  = pcm[8 + 4];
-	x[68] = x[4]  = pcm[8 + 0];
-	x[69] = x[5]  = pcm[8 + 2];
-	x[70] = x[6]  = pcm[8 + 1];
-	x[71] = x[7]  = pcm[8 + 5];
-
-	x[72] = x[8]  = pcm[0 + 7];
-	x[73] = x[9]  = pcm[0 + 3];
-	x[74] = x[10] = pcm[0 + 6];
-	x[75] = x[11] = pcm[0 + 4];
-	x[76] = x[12] = pcm[0 + 0];
-	x[77] = x[13] = pcm[0 + 2];
-	x[78] = x[14] = pcm[0 + 1];
-	x[79] = x[15] = pcm[0 + 5];
-
 	/* Analyze blocks */
 	sbc_analyze_four_simd(x + 12, out, analysis_consts_fixed4_simd_odd);
 	out += out_stride;
@@ -211,44 +193,9 @@ static inline void sbc_analyze_4b_4s_simd(int16_t *pcm, int16_t *x,
 	sbc_analyze_four_simd(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
+static inline void sbc_analyze_4b_8s_simd(int16_t *x,
 					  int32_t *out, int out_stride)
 {
-	/* Fetch audio samples and do input data reordering for SIMD */
-	x[128] = x[0]  = pcm[16 + 15];
-	x[129] = x[1]  = pcm[16 + 7];
-	x[130] = x[2]  = pcm[16 + 14];
-	x[131] = x[3]  = pcm[16 + 8];
-	x[132] = x[4]  = pcm[16 + 13];
-	x[133] = x[5]  = pcm[16 + 9];
-	x[134] = x[6]  = pcm[16 + 12];
-	x[135] = x[7]  = pcm[16 + 10];
-	x[136] = x[8]  = pcm[16 + 11];
-	x[137] = x[9]  = pcm[16 + 3];
-	x[138] = x[10] = pcm[16 + 6];
-	x[139] = x[11] = pcm[16 + 0];
-	x[140] = x[12] = pcm[16 + 5];
-	x[141] = x[13] = pcm[16 + 1];
-	x[142] = x[14] = pcm[16 + 4];
-	x[143] = x[15] = pcm[16 + 2];
-
-	x[144] = x[16] = pcm[0 + 15];
-	x[145] = x[17] = pcm[0 + 7];
-	x[146] = x[18] = pcm[0 + 14];
-	x[147] = x[19] = pcm[0 + 8];
-	x[148] = x[20] = pcm[0 + 13];
-	x[149] = x[21] = pcm[0 + 9];
-	x[150] = x[22] = pcm[0 + 12];
-	x[151] = x[23] = pcm[0 + 10];
-	x[152] = x[24] = pcm[0 + 11];
-	x[153] = x[25] = pcm[0 + 3];
-	x[154] = x[26] = pcm[0 + 6];
-	x[155] = x[27] = pcm[0 + 0];
-	x[156] = x[28] = pcm[0 + 5];
-	x[157] = x[29] = pcm[0 + 1];
-	x[158] = x[30] = pcm[0 + 4];
-	x[159] = x[31] = pcm[0 + 2];
-
 	/* Analyze blocks */
 	sbc_analyze_eight_simd(x + 24, out, analysis_consts_fixed8_simd_odd);
 	out += out_stride;
@@ -259,6 +206,201 @@ static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
 	sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
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
+static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s4_internal(
+	int position,
+	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int big_endian)
+{
+	/* handle X buffer wraparound */
+	if (position < nsamples) {
+		if (nchannels > 0)
+			memcpy(&X[0][SBC_X_BUFFER_SIZE - 36], &X[0][position],
+							36 * sizeof(int16_t));
+		if (nchannels > 1)
+			memcpy(&X[1][SBC_X_BUFFER_SIZE - 36], &X[1][position],
+							36 * sizeof(int16_t));
+		position = SBC_X_BUFFER_SIZE - 36;
+	}
+
+	#define PCM(i) (big_endian ? \
+		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
+
+	/* copy/permutate audio samples */
+	while ((nsamples -= 8) >= 0) {
+		position -= 8;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = PCM(0 + 7 * nchannels);
+			x[1]  = PCM(0 + 3 * nchannels);
+			x[2]  = PCM(0 + 6 * nchannels);
+			x[3]  = PCM(0 + 4 * nchannels);
+			x[4]  = PCM(0 + 0 * nchannels);
+			x[5]  = PCM(0 + 2 * nchannels);
+			x[6]  = PCM(0 + 1 * nchannels);
+			x[7]  = PCM(0 + 5 * nchannels);
+		}
+		if (nchannels > 1) {
+			int16_t *x = &X[1][position];
+			x[0]  = PCM(1 + 7 * nchannels);
+			x[1]  = PCM(1 + 3 * nchannels);
+			x[2]  = PCM(1 + 6 * nchannels);
+			x[3]  = PCM(1 + 4 * nchannels);
+			x[4]  = PCM(1 + 0 * nchannels);
+			x[5]  = PCM(1 + 2 * nchannels);
+			x[6]  = PCM(1 + 1 * nchannels);
+			x[7]  = PCM(1 + 5 * nchannels);
+		}
+		pcm += 16 * nchannels;
+	}
+	#undef PCM
+
+	return position;
+}
+
+static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
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
+	/* copy/permutate audio samples */
+	while ((nsamples -= 16) >= 0) {
+		position -= 16;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = PCM(0 + 15 * nchannels);
+			x[1]  = PCM(0 + 7 * nchannels);
+			x[2]  = PCM(0 + 14 * nchannels);
+			x[3]  = PCM(0 + 8 * nchannels);
+			x[4]  = PCM(0 + 13 * nchannels);
+			x[5]  = PCM(0 + 9 * nchannels);
+			x[6]  = PCM(0 + 12 * nchannels);
+			x[7]  = PCM(0 + 10 * nchannels);
+			x[8]  = PCM(0 + 11 * nchannels);
+			x[9]  = PCM(0 + 3 * nchannels);
+			x[10] = PCM(0 + 6 * nchannels);
+			x[11] = PCM(0 + 0 * nchannels);
+			x[12] = PCM(0 + 5 * nchannels);
+			x[13] = PCM(0 + 1 * nchannels);
+			x[14] = PCM(0 + 4 * nchannels);
+			x[15] = PCM(0 + 2 * nchannels);
+		}
+		if (nchannels > 1) {
+			int16_t *x = &X[1][position];
+			x[0]  = PCM(1 + 15 * nchannels);
+			x[1]  = PCM(1 + 7 * nchannels);
+			x[2]  = PCM(1 + 14 * nchannels);
+			x[3]  = PCM(1 + 8 * nchannels);
+			x[4]  = PCM(1 + 13 * nchannels);
+			x[5]  = PCM(1 + 9 * nchannels);
+			x[6]  = PCM(1 + 12 * nchannels);
+			x[7]  = PCM(1 + 10 * nchannels);
+			x[8]  = PCM(1 + 11 * nchannels);
+			x[9]  = PCM(1 + 3 * nchannels);
+			x[10] = PCM(1 + 6 * nchannels);
+			x[11] = PCM(1 + 0 * nchannels);
+			x[12] = PCM(1 + 5 * nchannels);
+			x[13] = PCM(1 + 1 * nchannels);
+			x[14] = PCM(1 + 4 * nchannels);
+			x[15] = PCM(1 + 2 * nchannels);
+		}
+		pcm += 32 * nchannels;
+	}
+	#undef PCM
+
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
+static int sbc_enc_process_input_4s_le(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s4_internal(
+			position, pcm, X, nsamples, 2, 0);
+	else
+		return sbc_encoder_process_input_s4_internal(
+			position, pcm, X, nsamples, 1, 0);
+}
+
+static int sbc_enc_process_input_4s_be(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s4_internal(
+			position, pcm, X, nsamples, 2, 1);
+	else
+		return sbc_encoder_process_input_s4_internal(
+			position, pcm, X, nsamples, 1, 1);
+}
+
+static int sbc_enc_process_input_8s_le(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s8_internal(
+			position, pcm, X, nsamples, 2, 0);
+	else
+		return sbc_encoder_process_input_s8_internal(
+			position, pcm, X, nsamples, 1, 0);
+}
+
+static int sbc_enc_process_input_8s_be(int position,
+		const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels)
+{
+	if (nchannels > 1)
+		return sbc_encoder_process_input_s8_internal(
+			position, pcm, X, nsamples, 2, 1);
+	else
+		return sbc_encoder_process_input_s8_internal(
+			position, pcm, X, nsamples, 1, 1);
+}
+
 /*
  * Detect CPU features and setup function pointers
  */
@@ -268,6 +410,12 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
 
+	/* Default implementation for input reordering / deinterleaving */
+	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le;
+	state->sbc_enc_process_input_4s_be = sbc_enc_process_input_4s_be;
+	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le;
+	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be;
+
 	/* X86/AMD64 optimizations */
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
 	sbc_init_primitives_mmx(state);
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index a418ed8..5b7c9ac 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -27,6 +27,7 @@
 #define __SBC_PRIMITIVES_H
 
 #define SCALE_OUT_BITS 15
+#define SBC_X_BUFFER_SIZE 328
 
 #ifdef __GNUC__
 #define SBC_ALWAYS_INLINE __attribute__((always_inline))
@@ -35,17 +36,28 @@
 #endif
 
 struct sbc_encoder_state {
-	int subbands;
-	int position[2];
-	int16_t SBC_ALIGNED X[2][256];
+	int position;
+	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles 4 blocks at once */
-	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
-					int32_t *out, int out_stride);
+	void (*sbc_analyze_4b_4s)(int16_t *x, int32_t *out, int out_stride);
 	/* Polyphase analysis filter for 8 subbands configuration,
 	 * it handles 4 blocks at once */
-	void (*sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
-					int32_t *out, int out_stride);
+	void (*sbc_analyze_4b_8s)(int16_t *x, int32_t *out, int out_stride);
+	/* Process input data (deinterleave, endian conversion, reordering),
+	 * depending on the number of subbands and input data byte order */
+	int (*sbc_enc_process_input_4s_le)(int position,
+			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels);
+	int (*sbc_enc_process_input_4s_be)(int position,
+			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels);
+	int (*sbc_enc_process_input_8s_le)(int position,
+			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels);
+	int (*sbc_enc_process_input_8s_be)(int position,
+			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels);
 };
 
 /*
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 972e813..7db4af7 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -245,28 +245,9 @@ static inline void sbc_analyze_eight_mmx(const int16_t *in, int32_t *out,
 		: "memory");
 }
 
-static inline void sbc_analyze_4b_4s_mmx(int16_t *pcm, int16_t *x,
-						int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_4s_mmx(int16_t *x, int32_t *out,
+						int out_stride)
 {
-	/* Fetch audio samples and do input data reordering for SIMD */
-	x[64] = x[0]  = pcm[8 + 7];
-	x[65] = x[1]  = pcm[8 + 3];
-	x[66] = x[2]  = pcm[8 + 6];
-	x[67] = x[3]  = pcm[8 + 4];
-	x[68] = x[4]  = pcm[8 + 0];
-	x[69] = x[5]  = pcm[8 + 2];
-	x[70] = x[6]  = pcm[8 + 1];
-	x[71] = x[7]  = pcm[8 + 5];
-
-	x[72] = x[8]  = pcm[0 + 7];
-	x[73] = x[9]  = pcm[0 + 3];
-	x[74] = x[10] = pcm[0 + 6];
-	x[75] = x[11] = pcm[0 + 4];
-	x[76] = x[12] = pcm[0 + 0];
-	x[77] = x[13] = pcm[0 + 2];
-	x[78] = x[14] = pcm[0 + 1];
-	x[79] = x[15] = pcm[0 + 5];
-
 	/* Analyze blocks */
 	sbc_analyze_four_mmx(x + 12, out, analysis_consts_fixed4_simd_odd);
 	out += out_stride;
@@ -279,44 +260,9 @@ static inline void sbc_analyze_4b_4s_mmx(int16_t *pcm, int16_t *x,
 	asm volatile ("emms\n");
 }
 
-static inline void sbc_analyze_4b_8s_mmx(int16_t *pcm, int16_t *x,
-						int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_8s_mmx(int16_t *x, int32_t *out,
+						int out_stride)
 {
-	/* Fetch audio samples and do input data reordering for SIMD */
-	x[128] = x[0]  = pcm[16 + 15];
-	x[129] = x[1]  = pcm[16 + 7];
-	x[130] = x[2]  = pcm[16 + 14];
-	x[131] = x[3]  = pcm[16 + 8];
-	x[132] = x[4]  = pcm[16 + 13];
-	x[133] = x[5]  = pcm[16 + 9];
-	x[134] = x[6]  = pcm[16 + 12];
-	x[135] = x[7]  = pcm[16 + 10];
-	x[136] = x[8]  = pcm[16 + 11];
-	x[137] = x[9]  = pcm[16 + 3];
-	x[138] = x[10] = pcm[16 + 6];
-	x[139] = x[11] = pcm[16 + 0];
-	x[140] = x[12] = pcm[16 + 5];
-	x[141] = x[13] = pcm[16 + 1];
-	x[142] = x[14] = pcm[16 + 4];
-	x[143] = x[15] = pcm[16 + 2];
-
-	x[144] = x[16] = pcm[0 + 15];
-	x[145] = x[17] = pcm[0 + 7];
-	x[146] = x[18] = pcm[0 + 14];
-	x[147] = x[19] = pcm[0 + 8];
-	x[148] = x[20] = pcm[0 + 13];
-	x[149] = x[21] = pcm[0 + 9];
-	x[150] = x[22] = pcm[0 + 12];
-	x[151] = x[23] = pcm[0 + 10];
-	x[152] = x[24] = pcm[0 + 11];
-	x[153] = x[25] = pcm[0 + 3];
-	x[154] = x[26] = pcm[0 + 6];
-	x[155] = x[27] = pcm[0 + 0];
-	x[156] = x[28] = pcm[0 + 5];
-	x[157] = x[29] = pcm[0 + 1];
-	x[158] = x[30] = pcm[0 + 4];
-	x[159] = x[31] = pcm[0 + 2];
-
 	/* Analyze blocks */
 	sbc_analyze_eight_mmx(x + 24, out, analysis_consts_fixed8_simd_odd);
 	out += out_stride;
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index 7589a98..d9c12f9 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -210,28 +210,9 @@ static inline void _sbc_analyze_eight_neon(const int16_t *in, int32_t *out,
 			"d18", "d19");
 }
 
-static inline void sbc_analyze_4b_4s_neon(int16_t *pcm, int16_t *x,
+static inline void sbc_analyze_4b_4s_neon(int16_t *x,
 						int32_t *out, int out_stride)
 {
-	/* Fetch audio samples and do input data reordering for SIMD */
-	x[64] = x[0]  = pcm[8 + 7];
-	x[65] = x[1]  = pcm[8 + 3];
-	x[66] = x[2]  = pcm[8 + 6];
-	x[67] = x[3]  = pcm[8 + 4];
-	x[68] = x[4]  = pcm[8 + 0];
-	x[69] = x[5]  = pcm[8 + 2];
-	x[70] = x[6]  = pcm[8 + 1];
-	x[71] = x[7]  = pcm[8 + 5];
-
-	x[72] = x[8]  = pcm[0 + 7];
-	x[73] = x[9]  = pcm[0 + 3];
-	x[74] = x[10] = pcm[0 + 6];
-	x[75] = x[11] = pcm[0 + 4];
-	x[76] = x[12] = pcm[0 + 0];
-	x[77] = x[13] = pcm[0 + 2];
-	x[78] = x[14] = pcm[0 + 1];
-	x[79] = x[15] = pcm[0 + 5];
-
 	/* Analyze blocks */
 	_sbc_analyze_four_neon(x + 12, out, analysis_consts_fixed4_simd_odd);
 	out += out_stride;
@@ -242,44 +223,9 @@ static inline void sbc_analyze_4b_4s_neon(int16_t *pcm, int16_t *x,
 	_sbc_analyze_four_neon(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static inline void sbc_analyze_4b_8s_neon(int16_t *pcm, int16_t *x,
+static inline void sbc_analyze_4b_8s_neon(int16_t *x,
 						int32_t *out, int out_stride)
 {
-	/* Fetch audio samples and do input data reordering for SIMD */
-	x[128] = x[0]  = pcm[16 + 15];
-	x[129] = x[1]  = pcm[16 + 7];
-	x[130] = x[2]  = pcm[16 + 14];
-	x[131] = x[3]  = pcm[16 + 8];
-	x[132] = x[4]  = pcm[16 + 13];
-	x[133] = x[5]  = pcm[16 + 9];
-	x[134] = x[6]  = pcm[16 + 12];
-	x[135] = x[7]  = pcm[16 + 10];
-	x[136] = x[8]  = pcm[16 + 11];
-	x[137] = x[9]  = pcm[16 + 3];
-	x[138] = x[10] = pcm[16 + 6];
-	x[139] = x[11] = pcm[16 + 0];
-	x[140] = x[12] = pcm[16 + 5];
-	x[141] = x[13] = pcm[16 + 1];
-	x[142] = x[14] = pcm[16 + 4];
-	x[143] = x[15] = pcm[16 + 2];
-
-	x[144] = x[16] = pcm[0 + 15];
-	x[145] = x[17] = pcm[0 + 7];
-	x[146] = x[18] = pcm[0 + 14];
-	x[147] = x[19] = pcm[0 + 8];
-	x[148] = x[20] = pcm[0 + 13];
-	x[149] = x[21] = pcm[0 + 9];
-	x[150] = x[22] = pcm[0 + 12];
-	x[151] = x[23] = pcm[0 + 10];
-	x[152] = x[24] = pcm[0 + 11];
-	x[153] = x[25] = pcm[0 + 3];
-	x[154] = x[26] = pcm[0 + 6];
-	x[155] = x[27] = pcm[0 + 0];
-	x[156] = x[28] = pcm[0 + 5];
-	x[157] = x[29] = pcm[0 + 1];
-	x[158] = x[30] = pcm[0 + 4];
-	x[159] = x[31] = pcm[0 + 2];
-
 	/* Analyze blocks */
 	_sbc_analyze_eight_neon(x + 24, out, analysis_consts_fixed8_simd_odd);
 	out += out_stride;
-- 
1.5.6.5


--Boundary-00=_170fJkZFhnJEOo9--
