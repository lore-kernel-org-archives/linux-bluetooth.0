Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH] sbc: overflow bugfix and audio decoding quality improvement
Date: Mon, 17 Oct 2011 04:24:38 +0300
Message-Id: <1318814678-25640-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

The "(((audio_sample << 1) | 1) << frame->scale_factor[ch][sb])"
part of expression
    "frame->sb_sample[blk][ch][sb] =
        (((audio_sample << 1) | 1) << frame->scale_factor[ch][sb]) /
        levels[ch][sb] - (1 << frame->scale_factor[ch][sb])"
in "sbc_unpack_frame" function can sometimes overflow 32-bit signed int.
This problem can be reproduced by first using bitpool 128 and encoding
some random noise data, and then feeding it to sbc decoder. The obvious
thing to do would be to change "audio_sample" variable type to uint32_t.

However the problem is a little bit more complicated. According
to the section "12.6.2 Scale Factors" of A2DP spec:
    scalefactor[ch][sb] = pow(2.0, (scale_factor[ch][sb] + 1))

And according to "12.6.4 Reconstruction of the Subband Samples":
    sb_sample[blk][ch][sb] = scalefactor[ch][sb] *
        ((audio_sample[blk][ch][sb]*2.0+1.0) / levels[ch][sb]-1.0);

Hence the current code for calculating "sb_sample[blk][ch][sb]" is
not quite correct, because it loses one least significant bit of
sample data and passes twice smaller sample values to the synthesis
filter (the filter also deviates from the spec to compensate this).
This all has quite a noticeable impact on audio quality. Moreover,
it makes sense to keep a few extra bits of precision here in order
to minimize rounding errors. So the proposed patch introduces a new
SBCDEC_FIXED_EXTRA_BITS constant and uses uint64_t data type
for intermediate calculations in order to safeguard against
overflows. This patch intentionally addresses only the quality
issue, but performance can be also improved later (like replacing
division with multiplication by reciprocal).

Test for the difference of sbc encoding/decoding roundtrip vs.
the original audio file for joint stereo, bitpool 128, 8 subbands
and http://media.xiph.org/sintel/sintel-master-st.flac sample
demonstrates some quality improvement:

=== before ===
    --- comparing original / sbc_encoder.exe + sbcdec ---
    stddev:    4.64 PSNR: 82.97 bytes:170495708/170496000
=== after ===
    --- comparing original / sbc_encoder.exe + sbcdec ---
    stddev:    1.95 PSNR: 90.50 bytes:170495708/170496000
---
 sbc/sbc.c        |   11 +++++++----
 sbc/sbc_tables.h |    6 ++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 77fcc5d..13f87c0 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -383,7 +383,7 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
 	int crc_pos = 0;
 	int32_t temp;
 
-	int audio_sample;
+	uint32_t audio_sample;
 	int ch, sb, blk, bit;	/* channel, subband, block and bit standard
 				   counters */
 	int bits[2][8];		/* bits distribution */
@@ -494,6 +494,9 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
 		for (ch = 0; ch < frame->channels; ch++) {
 			for (sb = 0; sb < frame->subbands; sb++) {
 				if (levels[ch][sb] > 0) {
+					uint32_t shift =
+						frame->scale_factor[ch][sb] +
+						1 + SBCDEC_FIXED_EXTRA_BITS;
 					audio_sample = 0;
 					for (bit = 0; bit < bits[ch][sb]; bit++) {
 						if (consumed > len * 8)
@@ -505,9 +508,9 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
 						consumed++;
 					}
 
-					frame->sb_sample[blk][ch][sb] =
-						(((audio_sample << 1) | 1) << frame->scale_factor[ch][sb]) /
-						levels[ch][sb] - (1 << frame->scale_factor[ch][sb]);
+					frame->sb_sample[blk][ch][sb] = (int32_t)
+						(((((uint64_t)audio_sample << 1) | 1) << shift) /
+						levels[ch][sb]) - (1 << shift);
 				} else
 					frame->sb_sample[blk][ch][sb] = 0;
 			}
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index 28c0d54..25e24e6 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -40,11 +40,13 @@ static const int sbc_offset8[4][8] = {
 	{ -4, 0, 0, 0, 0, 0, 1, 2 }
 };
 
+/* extra bits of precision for the synthesis filter input data */
+#define SBCDEC_FIXED_EXTRA_BITS 2
 
 #define SS4(val) ASR(val, SCALE_SPROTO4_TBL)
 #define SS8(val) ASR(val, SCALE_SPROTO8_TBL)
-#define SN4(val) ASR(val, SCALE_NPROTO4_TBL)
-#define SN8(val) ASR(val, SCALE_NPROTO8_TBL)
+#define SN4(val) ASR(val, SCALE_NPROTO4_TBL + 1 + SBCDEC_FIXED_EXTRA_BITS)
+#define SN8(val) ASR(val, SCALE_NPROTO8_TBL + 1 + SBCDEC_FIXED_EXTRA_BITS)
 
 static const int32_t sbc_proto_4_40m0[] = {
 	SS4(0x00000000), SS4(0xffa6982f), SS4(0xfba93848), SS4(0x0456c7b8),
-- 
1.7.3.4

