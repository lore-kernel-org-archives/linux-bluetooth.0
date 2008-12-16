Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Tue, 16 Dec 2008 23:46:38 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812112227.07170.siarhei.siamashka@nokia.com> <1229045974.22285.18.camel@violet.holtmann.net>
In-Reply-To: <1229045974.22285.18.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/GCSJieAcbS+Rv6"
Message-Id: <200812162346.39089.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_/GCSJieAcbS+Rv6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 12 December 2008 03:39:34 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > Appears that bitstream packing is also one of the most CPU hungry
> > operations in SBC encoder, which did not get proper attention yet.
> > Could somebody review this patch and provide feedback/comments?
>
> again thanks for working on this. I am actually willing to include your
> patches quickly in one of the next releases to get more wider testing
> audience.

Well, after doing a bit more testing, appears that a bug slipped in:
+					PUT_BITS(audio_sample, bits[ch][sb]);

There should be the following line instead:
+					PUT_BITS(audio_sample & levels[ch][sb], bits[ch][sb]);

Updated patch is attached. Any additional testing/feedback is very much
welcome.

Best regards
Siarhei Siamashka

--Boundary-00=_/GCSJieAcbS+Rv6
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-sbc-bitstream-writing-optimization-for-encoder-try2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-sbc-bitstream-writing-optimization-for-encoder-try2.patch"

>From 0a3818bd86342c60cda2fa87c59ecd5f9d6d4591 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 11 Dec 2008 21:21:28 +0200
Subject: [PATCH] sbc: bitstream writing optimization for encoder.

SBC encoder performance improvement up to 1.5x for ARM11
and almost twice faster for Intel Core2 in some cases.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
---
 sbc/sbc.c |   65 ++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7072673..c495a75 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -909,6 +909,29 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 	}
 }
 
+/* Supplementary bitstream writing macros for 'sbc_pack_frame' */
+
+#define PUT_BITS(v, n)\
+	{\
+		bits_cache = (v) | (bits_cache << (n));\
+		bits_count += (n);\
+		if (bits_count >= 16) {\
+			bits_count -= 8;\
+			*data_ptr++ = (uint8_t)(bits_cache >> bits_count);\
+			bits_count -= 8;\
+			*data_ptr++ = (uint8_t)(bits_cache >> bits_count);\
+		}\
+	} while (0);\
+
+#define FLUSH_BITS()\
+	while (bits_count >= 8) {\
+		bits_count -= 8;\
+		*data_ptr++ = (uint8_t)(bits_cache >> bits_count);\
+	}\
+	if (bits_count > 0) {\
+	    *data_ptr++ = (uint8_t)(bits_cache << (8 - bits_count));\
+	}\
+
 /*
  * Packs the SBC frame from frame into the memory at data. At most len
  * bytes will be used, should more memory be needed an appropriate
@@ -926,14 +949,18 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 
 static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 {
-	int produced;
+	/* Bitstream writer starts from the fourth byte */
+	uint8_t *data_ptr = data + 4;
+	uint32_t bits_cache = 0;
+	uint32_t bits_count = 0;
+
 	/* Will copy the header parts for CRC-8 calculation here */
 	uint8_t crc_header[11] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	int crc_pos = 0;
 
 	uint16_t audio_sample;
 
-	int ch, sb, blk, bit;	/* channel, subband, block and bit counters */
+	int ch, sb, blk;	/* channel, subband, block and bit counters */
 	int bits[2][8];		/* bits distribution */
 	int levels[2][8];	/* levels are derived from that */
 
@@ -973,8 +1000,6 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 
 	/* Can't fill in crc yet */
 
-	produced = 32;
-
 	crc_header[0] = data[1];
 	crc_header[1] = data[2];
 	crc_pos = 16;
@@ -999,6 +1024,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 		u_int32_t scalefactor_j[2];
 		uint8_t scale_factor_j[2];
 
+		uint8_t joint = 0;
 		frame->joint = 0;
 
 		for (sb = 0; sb < frame->subbands - 1; sb++) {
@@ -1031,6 +1057,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			if ((scalefactor[0][sb] + scalefactor[1][sb]) >
 					(scalefactor_j[0] + scalefactor_j[1]) ) {
 				/* use joint stereo for this subband */
+				joint |= 1 << (frame->subbands - 1 - sb);
 				frame->joint |= 1 << sb;
 				frame->scale_factor[0][sb] = scale_factor_j[0];
 				frame->scale_factor[1][sb] = scale_factor_j[1];
@@ -1045,24 +1072,16 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			}
 		}
 
-		data[4] = 0;
-		for (sb = 0; sb < frame->subbands - 1; sb++)
-			data[4] |= ((frame->joint >> sb) & 0x01) << (frame->subbands - 1 - sb);
-
-		crc_header[crc_pos >> 3] = data[4];
-
-		produced += frame->subbands;
+		PUT_BITS(joint, frame->subbands);
+		crc_header[crc_pos >> 3] = joint;
 		crc_pos += frame->subbands;
 	}
 
 	for (ch = 0; ch < frame->channels; ch++) {
 		for (sb = 0; sb < frame->subbands; sb++) {
-			data[produced >> 3] <<= 4;
+			PUT_BITS(frame->scale_factor[ch][sb] & 0x0F, 4);
 			crc_header[crc_pos >> 3] <<= 4;
-			data[produced >> 3] |= frame->scale_factor[ch][sb] & 0x0F;
 			crc_header[crc_pos >> 3] |= frame->scale_factor[ch][sb] & 0x0F;
-
-			produced += 4;
 			crc_pos += 4;
 		}
 	}
@@ -1088,25 +1107,15 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 						(uint16_t) ((((frame->sb_sample_f[blk][ch][sb]*levels[ch][sb]) >>
 									(frame->scale_factor[ch][sb] + 1)) +
 								levels[ch][sb]) >> 1);
-					audio_sample <<= 16 - bits[ch][sb];
-					for (bit = 0; bit < bits[ch][sb]; bit++) {
-						data[produced >> 3] <<= 1;
-						if (audio_sample & 0x8000)
-							data[produced >> 3] |= 0x1;
-						audio_sample <<= 1;
-						produced++;
-					}
+					PUT_BITS(audio_sample & levels[ch][sb], bits[ch][sb]);
 				}
 			}
 		}
 	}
 
-	/* align the last byte */
-	if (produced % 8) {
-		data[produced >> 3] <<= 8 - (produced % 8);
-	}
+	FLUSH_BITS();
 
-	return (produced + 7) >> 3;
+	return data_ptr - data;
 }
 
 struct sbc_priv {
-- 
1.5.6.5


--Boundary-00=_/GCSJieAcbS+Rv6--
