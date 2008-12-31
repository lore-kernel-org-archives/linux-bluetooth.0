Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Added possibility to analyze 4 blocks at once in SBC encoder
Date: Wed, 31 Dec 2008 17:29:30 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a/4WJ3jNSdLDt4u"
Message-Id: <200812311729.30975.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_a/4WJ3jNSdLDt4u
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

With bluez-4.25 release I hope that the SBC encoder sound quality issues are
now solved (though this is yet to be confirmed).

Nevertheless, I think it is time to focus on performance :) The attached patch
contains code preparations which are needed for SIMD optimizations for
the analysis filter. Also theoretically it should be possible to tweak code to
have both 32-bit and 16-bit fixed point analysis filter compiled in and switch
between them at runtime (at user's request or semi-intelligently depending
on audio bitrate).

This patch should be stable and ready to be committed.

Best regards,
Siarhei Siamashka

--Boundary-00=_a/4WJ3jNSdLDt4u
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Added-possibility-to-analyze-4-blocks-at-once-in-SBC.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Added-possibility-to-analyze-4-blocks-at-once-in-SBC.patch"

>From e7e029ee7acb75e0a846c61f19a4244810242cdb Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Date: Wed, 31 Dec 2008 09:14:25 +0200
Subject: [PATCH] Added possibility to analyze 4 blocks at once in SBC encoder

This change is needed for SIMD optimizations which will follow
shortly. And even for non-SIMD capable platforms it still may
be useful to have possibility to merge several analyzing functions
together into one for better code scheduling or reusing loaded
constants. Also analysis filter functions are now called using
function pointers, which allows the default implementation to be
overrided at runtime (with high precision variant or MMX/SSE2/NEON
optimized code).
---
 sbc/sbc.c |  131 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 82 insertions(+), 49 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index ce52e1e..01b4011 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -94,7 +94,11 @@ struct sbc_decoder_state {
 struct sbc_encoder_state {
 	int subbands;
 	int position[2];
-	int16_t X[2][160];
+	int16_t X[2][256];
+	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
+				  int32_t *out, int out_stride);
+	void (*sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
+				  int32_t *out, int out_stride);
 };
 
 /*
@@ -649,14 +653,6 @@ static int sbc_synthesize_audio(struct sbc_decoder_state *state,
 	}
 }
 
-static void sbc_encoder_init(struct sbc_encoder_state *state,
-				const struct sbc_frame *frame)
-{
-	memset(&state->X, 0, sizeof(state->X));
-	state->subbands = frame->subbands;
-	state->position[0] = state->position[1] = 9 * frame->subbands;
-}
-
 static inline void _sbc_analyze_four(const int16_t *in, int32_t *out)
 {
 	FIXED_A t1[4];
@@ -694,23 +690,27 @@ static inline void _sbc_analyze_four(const int16_t *in, int32_t *out)
 	}
 }
 
-static inline void sbc_analyze_four(struct sbc_encoder_state *state,
-				struct sbc_frame *frame, int ch, int blk)
+static void sbc_analyze_4b_4s(int16_t *pcm, int16_t *x,
+			      int32_t *out, int out_stride)
 {
-	int16_t *x = &state->X[ch][state->position[ch]];
-	int16_t *pcm = &frame->pcm_sample[ch][blk * 4];
-
-	/* Input 4 Audio Samples */
-	x[40] = x[0] = pcm[3];
-	x[41] = x[1] = pcm[2];
-	x[42] = x[2] = pcm[1];
-	x[43] = x[3] = pcm[0];
-
-	_sbc_analyze_four(x, frame->sb_sample_f[blk][ch]);
+	int i;
+
+	/* Input 4 x 4 Audio Samples */
+	for (i = 0; i < 16; i += 4) {
+		x[64 + i] = x[0 + i] = pcm[15 - i];
+		x[65 + i] = x[1 + i] = pcm[14 - i];
+		x[66 + i] = x[2 + i] = pcm[13 - i];
+		x[67 + i] = x[3 + i] = pcm[12 - i];
+	}
 
-	state->position[ch] -= 4;
-	if (state->position[ch] < 0)
-		state->position[ch] = 36;
+	/* Analyze four blocks */
+	_sbc_analyze_four(x + 12, out);
+	out += out_stride;
+	_sbc_analyze_four(x + 8, out);
+	out += out_stride;
+	_sbc_analyze_four(x + 4, out);
+	out += out_stride;
+	_sbc_analyze_four(x, out);
 }
 
 static inline void _sbc_analyze_eight(const int16_t *in, int32_t *out)
@@ -766,28 +766,31 @@ static inline void _sbc_analyze_eight(const int16_t *in, int32_t *out)
 	}
 }
 
-static inline void sbc_analyze_eight(struct sbc_encoder_state *state,
-					struct sbc_frame *frame, int ch,
-					int blk)
+static void sbc_analyze_4b_8s(int16_t *pcm, int16_t *x,
+			      int32_t *out, int out_stride)
 {
-	int16_t *x = &state->X[ch][state->position[ch]];
-	int16_t *pcm = &frame->pcm_sample[ch][blk * 8];
-
-	/* Input 8 Audio Samples */
-	x[80] = x[0] = pcm[7];
-	x[81] = x[1] = pcm[6];
-	x[82] = x[2] = pcm[5];
-	x[83] = x[3] = pcm[4];
-	x[84] = x[4] = pcm[3];
-	x[85] = x[5] = pcm[2];
-	x[86] = x[6] = pcm[1];
-	x[87] = x[7] = pcm[0];
-
-	_sbc_analyze_eight(x, frame->sb_sample_f[blk][ch]);
-
-	state->position[ch] -= 8;
-	if (state->position[ch] < 0)
-		state->position[ch] = 72;
+	int i;
+
+	/* Input 4 x 8 Audio Samples */
+	for (i = 0; i < 32; i += 8) {
+		x[128 + i] = x[0 + i] = pcm[31 - i];
+		x[129 + i] = x[1 + i] = pcm[30 - i];
+		x[130 + i] = x[2 + i] = pcm[29 - i];
+		x[131 + i] = x[3 + i] = pcm[28 - i];
+		x[132 + i] = x[4 + i] = pcm[27 - i];
+		x[133 + i] = x[5 + i] = pcm[26 - i];
+		x[134 + i] = x[6 + i] = pcm[25 - i];
+		x[135 + i] = x[7 + i] = pcm[24 - i];
+	}
+
+	/* Analyze four blocks */
+	_sbc_analyze_eight(x + 24, out);
+	out += out_stride;
+	_sbc_analyze_eight(x + 16, out);
+	out += out_stride;
+	_sbc_analyze_eight(x + 8, out);
+	out += out_stride;
+	_sbc_analyze_eight(x, out);
 }
 
 static int sbc_analyze_audio(struct sbc_encoder_state *state,
@@ -798,14 +801,32 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 	switch (frame->subbands) {
 	case 4:
 		for (ch = 0; ch < frame->channels; ch++)
-			for (blk = 0; blk < frame->blocks; blk++)
-				sbc_analyze_four(state, frame, ch, blk);
+			for (blk = 0; blk < frame->blocks; blk += 4) {
+				state->sbc_analyze_4b_4s(
+					&frame->pcm_sample[ch][blk * 4],
+					&state->X[ch][state->position[ch]],
+					frame->sb_sample_f[blk][ch],
+					frame->sb_sample_f[blk + 1][ch] -
+					frame->sb_sample_f[blk][ch]);
+				state->position[ch] -= 16;
+				if (state->position[ch] < 0)
+					state->position[ch] = 64 - 16;
+			}
 		return frame->blocks * 4;
 
 	case 8:
 		for (ch = 0; ch < frame->channels; ch++)
-			for (blk = 0; blk < frame->blocks; blk++)
-				sbc_analyze_eight(state, frame, ch, blk);
+			for (blk = 0; blk < frame->blocks; blk += 4) {
+				state->sbc_analyze_4b_8s(
+					&frame->pcm_sample[ch][blk * 8],
+					&state->X[ch][state->position[ch]],
+					frame->sb_sample_f[blk][ch],
+					frame->sb_sample_f[blk + 1][ch] -
+					frame->sb_sample_f[blk][ch]);
+				state->position[ch] -= 32;
+				if (state->position[ch] < 0)
+					state->position[ch] = 128 - 32;
+			}
 		return frame->blocks * 8;
 
 	default:
@@ -1025,6 +1046,18 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	return data_ptr - data;
 }
 
+static void sbc_encoder_init(struct sbc_encoder_state *state,
+				const struct sbc_frame *frame)
+{
+	memset(&state->X, 0, sizeof(state->X));
+	state->subbands = frame->subbands;
+	state->position[0] = state->position[1] = 12 * frame->subbands;
+
+	/* Default implementation for analyze function */
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+}
+
 struct sbc_priv {
 	int init;
 	struct sbc_frame frame;
-- 
1.5.6.5


--Boundary-00=_a/4WJ3jNSdLDt4u--
