Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: SBC big endian issues?
Date: Tue, 20 Jan 2009 13:13:30 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <d89ddf300901051126g3f8c8dadq8effa23e0a7bf73f@mail.gmail.com> <200901071440.01872.siarhei.siamashka@nokia.com>
In-Reply-To: <200901071440.01872.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aHbdJ9MMKiWu8DG"
Message-Id: <200901201313.30283.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_aHbdJ9MMKiWu8DG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 07 January 2009 14:40:01 ext Siarhei Siamashka wrote:
> On Monday 05 January 2009 21:26:17 ext Brad Midgley wrote:
> > The copy is inefficient but it would be even better if we didn't have
> > to do it at all. I was investigating zero copy here and came up with a
> > patch but it was too complicated to be accepted.
>
> Yes, it is possible to reduce the number of data copies. Having
> both 'sbc_encoder_state->X' and 'sbc_frame->pcm_sample' arrays
> is obviously redundant and only one of them should remain.
>
> But eliminating any kind of data copies completely is hardly possible. The
> encoder needs to always have data for the 72 or 36 previous samples, so
> they need to be stored somewhere between the calls to frame encode
> function. And frame encode function will probably get data in small chunks
> if having low latency is desired. So at least this part of data will need
> to be moved around. Additionally, SIMD optimizations require input data
> permutation, so they can't work directly with the input buffer.
>
> Preserving the input samples 'history' is currently achieved by having
> 'sbc_encoder_state->X' array which works as some kind of ring buffer.
> If this buffer had infinite size, we would not have to duplicate
> information in the lower and higher halves of this buffer. But this is of
> course not possible due to the need to keep memory use reasonable and also
> in order to efficiently use data cache. Anyway, increasing
> 'sbc_encoder_state->X' size to some reasonable value may help to reduce
> extra overhead. One of the variants is to have space in X buffer for all
> the input data of a frame plus these 72/36 samples from the previous frame,
> copy the previous 72/36 samples to it, and then perform "endian conversion
> + channels deinterleaving + do SIMD permutation" in one pass directly into
> the X buffer from the buffer provided by the user at the entry of the frame
> packing function. Increasing X buffer more may allow to copy the previous
> 72/36 samples only once per 2 frames, once per 3 frames or whatever.
>
> This is not complicated at all, but is indeed a bit intrusive in the sense
> that it will touch quite a large part of code. But we are ready to do it
> now, am I right?

The abovementioned optimization is implemented in the attached experimental
patch. It makes sbcenc ~20% faster, which is a really nice improvement.

> > The messy part here is we let the caller specify the byte order of the
> > array. It would simplify a lot to standardize on host endian. I don't
> > remember what the reasoning was against this.

Yeah, this is one of the things that can simplify code and make maintenance
easier.

OK, before I submit a final/committable version of this patch, some things may
need to be discussed/decided:

1. Alignment of the input data. Currently data is passed in as a void *
pointer, which does not imply any alignment requirements. It would be nice if
the input data would be guaranteed to be accessible as  int16_t elements
(16-bit sound samples). On the platforms with strict alignment (older ARM
cores), unaligned memory accesses are not supported. Current sbcenc utility
uses 'unsigned char' buffer to read the data from file and pass it to the
encoder. With this setup, the compiler is theoretically allowed to allocate
this buffer on uneven address, causing the troubles if we interpret it as
(int16_t *) buffer in the encoder. I suggest changing sbc_encode/sbc_decode
function prototypes to int16_t * data type for the buffers with audio samples
and fixing sbcenc utility and other clients (gstreamer/alsa) which may
potentially have alignment problems.

2. Is support for non-simd variant of the analysis filter useful enough to
keep it (sbc_analyze_4b_4s/sbc_analyze_4b_8s functions)? They have
a slight advantage over the simd variant in the sense that they only require a
single table with coefficients (as opposed to two tables for simd). Also it is
possible to implement non-simd input data handling as a simple memory
copy (no permutation needed) or even directly work on some part of the input
data (if the input data is large enough, some copying is still needed to carry
on data between sbc_encode calls). But in the case of having simd/multimedia
extension support, simd variant becomes clearly preferable. Most cpus
have some sort of simd supported nowadays and this is interesting for some
really low end or very old cpu. Is keeping this code worth extra maintenance
burden?

3. Status of endian conversion in the SBC codec. Dropping endian conversion
functionality in SBC and relaying it to the client application will make SBC
code simpler. On the other hand, built-in endian conversion is a bit faster
if we get data in inherently non-native byte order (loaded from big endian
data format on little endian cpu for example). Is it worth extra complexity?

Comments are very much welcome.


Best regards,
Siarhei Siamashka

--Boundary-00=_aHbdJ9MMKiWu8DG
Content-Type: text/x-diff;
  charset="utf-8";
  name="sbc-fast-processing-of-input-data.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="sbc-fast-processing-of-input-data.diff"

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 827b731..2750cc4 100644
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
 
@@ -918,8 +912,7 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 				const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
-	state->subbands = frame->subbands;
-	state->position[0] = state->position[1] = 12 * frame->subbands;
+	state->position = 0;
 
 	sbc_init_primitives(state);
 }
@@ -1043,12 +1036,22 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 		int output_len, int *written)
 {
 	struct sbc_priv *priv;
-	char *ptr;
-	int i, ch, framelen, samples;
+	int framelen, samples;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	int swap_endian = (sbc->endian != SBC_LE);
+#elif __BYTE_ORDER == __BIG_ENDIAN
+	int swap_endian = (sbc->endian != SBC_BE);
+#else
+#error "Unknown byte order"
+#endif
 
 	if (!sbc && !input)
 		return -EIO;
 
+	/* input buffer must be 2 bytes aligned (alignment for audio samples) */
+	if ((uintptr_t) input & 1)
+		return -EIO;
+
 	priv = sbc->priv;
 
 	if (written)
@@ -1079,19 +1082,22 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
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
-	}
+	if (priv->frame.subbands == 4)
+		priv->enc_state.position =
+			priv->enc_state.sbc_encoder_process_input_4s(
+				priv->enc_state.position,
+				(int16_t *) input, priv->enc_state.X,
+				priv->frame.subbands * priv->frame.blocks,
+				priv->frame.channels,
+				swap_endian);
+	else
+		priv->enc_state.position =
+			priv->enc_state.sbc_encoder_process_input_8s(
+				priv->enc_state.position,
+				(int16_t *) input, priv->enc_state.X,
+				priv->frame.subbands * priv->frame.blocks,
+				priv->frame.channels,
+				swap_endian);
 
 	samples = sbc_analyze_audio(&priv->enc_state, &priv->frame);
 
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index e3a7764..45bcccc 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -25,6 +25,8 @@
 
 #include <stdint.h>
 #include <limits.h>
+#include <byteswap.h>
+#include <string.h>
 #include "sbc.h"
 #include "sbc_math.h"
 #include "sbc_tables.h"
@@ -33,6 +35,8 @@
 #include "sbc_primitives_mmx.h"
 #include "sbc_primitives_neon.h"
 
+#if 0
+
 /*
  * A standard C code of analysis filter.
  */
@@ -176,6 +180,8 @@ static void sbc_analyze_4b_8s(int16_t *pcm, int16_t *x,
 	sbc_analyze_eight(x, out);
 }
 
+#endif
+
 /*
  * A reference C code of analysis filter with SIMD-friendly tables
  * reordering and code layout. This code can be used to develop platform
@@ -312,28 +318,9 @@ static inline void sbc_analyze_eight_simd(const int16_t *in, int32_t *out,
 			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
 }
 
-static inline void sbc_analyze_4b_4s_simd(int16_t *pcm, int16_t *x,
-						int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_4s_simd(int16_t *x, int32_t *out,
+							int out_stride)
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
@@ -344,44 +331,9 @@ static inline void sbc_analyze_4b_4s_simd(int16_t *pcm, int16_t *x,
 	sbc_analyze_four_simd(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
-					  int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_8s_simd(int16_t *x, int32_t *out,
+							int out_stride)
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
@@ -392,14 +344,187 @@ static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
 	sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
 }
 
+#ifdef __GNUC__
+#define SBC_ALWAYS_INLINE __attribute__((always_inline))
+#else
+#define SBC_ALWAYS_INLINE inline
+#endif
+
+/*
+ * Input a new portion of data to encode into X buffer
+ */
+static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s4_internal(
+	int position,
+	int16_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int swap_endian)
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
+	#define PCM(i) (swap_endian ? bswap_16(pcm[i]) : pcm[i])
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
+		pcm += 8 * nchannels;
+	}
+	#undef PCM
+
+	return position;
+}
+
+static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
+	int position,
+	int16_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int swap_endian)
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
+	#define PCM(i) (swap_endian ? bswap_16(pcm[i]) : pcm[i])
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
+		pcm += 16 * nchannels;
+	}
+	#undef PCM
+
+	return position;
+}
+
+static int sbc_encoder_process_input_4s(int position,
+		int16_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels, int swap_endian)
+{
+	if (nchannels > 1) {
+		if (swap_endian) {
+			return sbc_encoder_process_input_s4_internal(
+				position, pcm, X, nsamples, 2, 1);
+		} else {
+			return sbc_encoder_process_input_s4_internal(
+				position, pcm, X, nsamples, 2, 0);
+		}
+	} else {
+		if (swap_endian) {
+			return sbc_encoder_process_input_s4_internal(
+				position, pcm, X, nsamples, 1, 1);
+		} else {
+			return sbc_encoder_process_input_s4_internal(
+				position, pcm, X, nsamples, 1, 0);
+		}
+	}
+}
+
+static int sbc_encoder_process_input_8s(int position,
+		int16_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+		int nsamples, int nchannels, int swap_endian)
+{
+	if (nchannels > 1) {
+		if (swap_endian) {
+			return sbc_encoder_process_input_s8_internal(
+				position, pcm, X, nsamples, 2, 1);
+		} else {
+			return sbc_encoder_process_input_s8_internal(
+				position, pcm, X, nsamples, 2, 0);
+		}
+	} else {
+		if (swap_endian) {
+			return sbc_encoder_process_input_s8_internal(
+				position, pcm, X, nsamples, 1, 1);
+		} else {
+			return sbc_encoder_process_input_s8_internal(
+				position, pcm, X, nsamples, 1, 0);
+		}
+	}
+}
+
 /*
  * Detect CPU features and setup function pointers
  */
 void sbc_init_primitives(struct sbc_encoder_state *state)
 {
 	/* Default implementation for analyze functions */
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
+
+	/* Default implementation for input reordering / deinterleaving */
+	state->sbc_encoder_process_input_4s = sbc_encoder_process_input_4s;
+	state->sbc_encoder_process_input_8s = sbc_encoder_process_input_8s;
 
 	/* X86/AMD64 optimizations */
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 91b72ee..71b08f1 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -27,19 +27,23 @@
 #define __SBC_PRIMITIVES_H
 
 #define SCALE_OUT_BITS 15
+#define SBC_X_BUFFER_SIZE 328
 
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
+	int (*sbc_encoder_process_input_4s)(int position,
+			int16_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels, int swap_endian);
+	int (*sbc_encoder_process_input_8s)(int position,
+			int16_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+			int nsamples, int nchannels, int swap_endian);
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

--Boundary-00=_aHbdJ9MMKiWu8DG--
