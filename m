Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/5] Add support for mSBC frame header
Date: Thu, 27 Sep 2012 16:44:25 +0200
Message-Id: <1348757068-31048-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mSBC modifies header so that it contains: OxAD 0x00 0x00.
The first bytes allows to distinguish mSBC packets from standard SBC
packets used in A2DP. The two zero bytes are reserved for future definition.
---
 sbc/sbc.c |  104 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 41 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7e4faa0..131755b 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -407,55 +407,71 @@ static int sbc_unpack_frame(sbc_t *sbc, const uint8_t *data,
 	if (len < 4)
 		return -1;
 
-	if (data[0] != SBC_SYNCWORD)
-		return -2;
-
-	frame->frequency = (data[1] >> 6) & 0x03;
+	if (sbc->flags & SBC_MSBC) {
+		if (data[0] != MSBC_SYNCWORD)
+			return -2;
+		if (data[1] != 0)
+			return -5;
+		if (data[2] != 0)
+			return -6;
 
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
-	if (sbc->flags & SBC_MSBC)
+		frame->frequency = SBC_FREQ_16000;
+		frame->block_mode = SBC_BLK_4;
 		frame->blocks = MSBC_BLOCKS;
-
-	frame->mode = (data[1] >> 2) & 0x03;
-	switch (frame->mode) {
-	case MONO:
+		frame->allocation = LOUDNESS;
+		frame->mode = MONO;
 		frame->channels = 1;
-		break;
-	case DUAL_CHANNEL:	/* fall-through */
-	case STEREO:
-	case JOINT_STEREO:
-		frame->channels = 2;
-		break;
-	}
+		frame->subband_mode = 1;
+		frame->subbands = 8;
+		frame->bitpool = 26;
+	} else {
+		if (data[0] != SBC_SYNCWORD)
+			return -2;
+
+		frame->frequency = (data[1] >> 6) & 0x03;
+		frame->block_mode = (data[1] >> 4) & 0x03;
+		switch (frame->block_mode) {
+		case SBC_BLK_4:
+			frame->blocks = 4;
+			break;
+		case SBC_BLK_8:
+			frame->blocks = 8;
+			break;
+		case SBC_BLK_12:
+			frame->blocks = 12;
+			break;
+		case SBC_BLK_16:
+			frame->blocks = 16;
+			break;
+		}
+
+		frame->mode = (data[1] >> 2) & 0x03;
+		switch (frame->mode) {
+		case MONO:
+			frame->channels = 1;
+			break;
+		case DUAL_CHANNEL:	/* fall-through */
+		case STEREO:
+		case JOINT_STEREO:
+			frame->channels = 2;
+			break;
+		}
 
-	frame->allocation = (data[1] >> 1) & 0x01;
+		frame->allocation = (data[1] >> 1) & 0x01;
 
-	frame->subband_mode = (data[1] & 0x01);
-	frame->subbands = frame->subband_mode ? 8 : 4;
+		frame->subband_mode = (data[1] & 0x01);
+		frame->subbands = frame->subband_mode ? 8 : 4;
 
-	frame->bitpool = data[2];
+		frame->bitpool = data[2];
 
-	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
-			frame->bitpool > 16 * frame->subbands)
-		return -4;
+		if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
+				frame->bitpool > 16 * frame->subbands)
+			return -4;
 
-	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
-			frame->bitpool > 32 * frame->subbands)
-		return -4;
+		if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
+				frame->bitpool > 32 * frame->subbands)
+			return -4;
+	}
 
 	/* data[3] is crc, we're checking it later */
 
@@ -800,6 +816,11 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(sbc_t *sbc,
 	uint32_t levels[2][8];	/* levels are derived from that */
 	uint32_t sb_sample_delta[2][8];
 
+	if (sbc->flags & SBC_MSBC) {
+		data[0] = MSBC_SYNCWORD;
+		data[1] = 0;
+		data[2] = 0;
+	} else {
 		data[0] = SBC_SYNCWORD;
 
 		data[1] = (frame->frequency & 0x03) << 6;
@@ -831,6 +852,7 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(sbc_t *sbc,
 		if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
 				frame->bitpool > frame_subbands << 5)
 			return -5;
+	}
 
 	/* Can't fill in crc yet */
 
-- 
1.7.9.5

