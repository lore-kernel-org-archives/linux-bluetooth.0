Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 10/16] sbc: Fix input reordering for 15 blocks case
Date: Fri, 14 Dec 2012 16:03:31 +0100
Message-Id: <1355497417-10357-11-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1355497417-10357-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1355497417-10357-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SBC analysis handles 8 samples at a time. The optimisation requires 8 samples
forming an "odd" block, followed by 8 samples, forming an "even" block. Until
now SBC was used for encoding 4, 8, 12, or 16 blocks in a frame. Reordering
took a frame and for each 16 samples (ie 2 blocks) it produced one "odd" block
and one "even" block.
A mSBC frame encodes 15 blocks of 8 samples. 14 blocks are processed as before,
two at a time. If 8 samples are remaining, it will form the first half of two
blocks (a bit of an "odd" block, and a bit of an "even" block). When processing
the next frame, we detect eight samples were missing at previous iteration and
the two block can be finished.

This reordering is possible because only one sample is moved (x[-7]) AND the
first coefficient in the coef table is 0. Thus x[0] doesn't need to be set and
0 can be used in calculation instead. Note that x[-7] is not used in
analysis for this block.
see: analysis_consts_fixed8_simd_odd.

To detect that two blocks are not completed, the number of processed samples
can be used. This value is stored in position. position starts at
SBC_X_BUFFER_SIZE-72 and is decremented by 16 as long as two blocks can be
formed. If only 8 samples are remaining in input, then position is decremented
by 8 *arbitrarly*, thus indicating that some samples are pending. During next
frame reordering, position will be decremented by 8 again, back to a 16
multiple.

This logic works for SBC_X_BUFFER_SIZE-72 multiple of 16 and bigger than
8*2*15+72=312 and less than 8*3*15+72=432. The current value of 328 matches this
constraint and X buffer is shifted every two frames (30 blocks) in mSBC. This
way, we don't need to care about x[-7] when shifting, we also know that it
won't be before X.
---
 sbc/sbc_primitives.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 319e625..8933132 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -309,8 +309,37 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
 	#define PCM(i) (big_endian ? \
 		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
 
+	if (position % 16 == 8) {
+		position -= 8;
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
+		if (nchannels > 1) {
+			int16_t *x = &X[1][position];
+			x[0]  = PCM(1 + (15-8) * nchannels);
+			x[2]  = PCM(1 + (14-8) * nchannels);
+			x[3]  = PCM(1 + (8-8) * nchannels);
+			x[4]  = PCM(1 + (13-8) * nchannels);
+			x[5]  = PCM(1 + (9-8) * nchannels);
+			x[6]  = PCM(1 + (12-8) * nchannels);
+			x[7]  = PCM(1 + (10-8) * nchannels);
+			x[8]  = PCM(1 + (11-8) * nchannels);
+		}
+
+		pcm += 16 * nchannels;
+	}
+
 	/* copy/permutate audio samples */
-	while ((nsamples -= 16) >= 0) {
+	while (nsamples >= 16) {
 		position -= 16;
 		if (nchannels > 0) {
 			int16_t *x = &X[0][position];
@@ -351,6 +380,33 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
 			x[15] = PCM(1 + 2 * nchannels);
 		}
 		pcm += 32 * nchannels;
+		nsamples -= 16;
+	}
+
+	if (nsamples == 8) {
+		position -= 8;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[-7] = PCM(0 + 7 * nchannels);
+			x[1]  = PCM(0 + 3 * nchannels);
+			x[2]  = PCM(0 + 6 * nchannels);
+			x[3]  = PCM(0 + 0 * nchannels);
+			x[4]  = PCM(0 + 5 * nchannels);
+			x[5]  = PCM(0 + 1 * nchannels);
+			x[6]  = PCM(0 + 4 * nchannels);
+			x[7]  = PCM(0 + 2 * nchannels);
+		}
+		if (nchannels > 1) {
+			int16_t *x = &X[1][position];
+			x[-7] = PCM(1 + 7 * nchannels);
+			x[1]  = PCM(1 + 3 * nchannels);
+			x[2]  = PCM(1 + 6 * nchannels);
+			x[3]  = PCM(1 + 0 * nchannels);
+			x[4]  = PCM(1 + 5 * nchannels);
+			x[5]  = PCM(1 + 1 * nchannels);
+			x[6]  = PCM(1 + 4 * nchannels);
+			x[7]  = PCM(1 + 2 * nchannels);
+		}
 	}
 	#undef PCM
 
-- 
1.7.9.5

