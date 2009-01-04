Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Use of constant shift in SBC quantization code to make it faster
Date: Sun, 4 Jan 2009 20:09:55 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ztPYJo3yRC1D1p1"
Message-Id: <200901042009.55807.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_ztPYJo3yRC1D1p1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

The attached patch provides quite a nice performance improvement (something
like 8% better overall when benchmarked on desktop PC).

Best regards,
Siarhei Siamashka

--Boundary-00=_ztPYJo3yRC1D1p1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Use-of-constant-shift-in-SBC-quantization-code-to-ma.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Use-of-constant-shift-in-SBC-quantization-code-to-ma.patch"

>From 8399813f77c45eda6aa356977294bed859b02c58 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Sun, 4 Jan 2009 03:11:12 +0200
Subject: [PATCH] Use of constant shift in SBC quantization code to make it faster

The result of 32x32->64 unsigned long multiplication is returned
in two registers (high and low 32-bit parts) for many 32-bit
architectures. For these architectures constant right shift by
32 bits is optimized out by the compiler to just taking the high
32-bit part. Also some data needed at the quantization stage is
precalculated beforehand to improve performance.
---
 sbc/sbc.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index b349090..650bc2f 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -880,11 +880,12 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	uint8_t crc_header[11] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	int crc_pos = 0;
 
-	uint16_t audio_sample;
+	uint32_t audio_sample;
 
 	int ch, sb, blk;	/* channel, subband, block and bit counters */
 	int bits[2][8];		/* bits distribution */
-	int levels[2][8];	/* levels are derived from that */
+	uint32_t levels[2][8];	/* levels are derived from that */
+	uint32_t sb_sample_delta[2][8];
 
 	u_int32_t scalefactor[2][8];	/* derived from frame->scale_factor */
 
@@ -1017,8 +1018,14 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 	sbc_calculate_bits(frame, bits);
 
 	for (ch = 0; ch < frame->channels; ch++) {
-		for (sb = 0; sb < frame->subbands; sb++)
-			levels[ch][sb] = (1 << bits[ch][sb]) - 1;
+		for (sb = 0; sb < frame->subbands; sb++) {
+			levels[ch][sb] = ((1 << bits[ch][sb]) - 1) <<
+				(32 - (frame->scale_factor[ch][sb] +
+					SCALE_OUT_BITS + 2));
+			sb_sample_delta[ch][sb] = (uint32_t) 1 <<
+				(frame->scale_factor[ch][sb] +
+					SCALE_OUT_BITS + 1);
+		}
 	}
 
 	for (blk = 0; blk < frame->blocks; blk++) {
@@ -1029,12 +1036,8 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 					continue;
 
 				audio_sample = ((uint64_t) levels[ch][sb] *
-					(((uint32_t) 1 <<
-					(frame->scale_factor[ch][sb] +
-					SCALE_OUT_BITS + 1)) +
-					frame->sb_sample_f[blk][ch][sb])) >>
-						(frame->scale_factor[ch][sb] +
-						SCALE_OUT_BITS + 2);
+					(sb_sample_delta[ch][sb] +
+					frame->sb_sample_f[blk][ch][sb])) >> 32;
 
 				PUT_BITS(audio_sample, bits[ch][sb]);
 			}
-- 
1.5.6.5


--Boundary-00=_ztPYJo3yRC1D1p1--
