Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Thu, 11 Dec 2008 22:27:06 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_beXQJfbV0Vrwexs"
Message-Id: <200812112227.07170.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_beXQJfbV0Vrwexs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi All,

Appears that bitstream packing is also one of the most CPU hungry
operations in SBC encoder, which did not get proper attention yet.
Could somebody review this patch and provide feedback/comments?

Benchmarks were done by running the following script:

=2E/sbcenc -s 8 big_buck_bunny_480p_mono.au > /dev/null
=2E/sbcenc -s 8 big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -s 8 -j big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -s 4 big_buck_bunny_480p_mono.au > /dev/null
=2E/sbcenc -s 4 big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -s 4 -j big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -b 128 -s 8 big_buck_bunny_480p_mono.au > /dev/null
=2E/sbcenc -b 128 -s 8 big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -b 128 -s 8 -j big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -b 64 -s 4 big_buck_bunny_480p_mono.au > /dev/null
=2E/sbcenc -b 64 -s 4 big_buck_bunny_480p_stereo.au > /dev/null
=2E/sbcenc -b 64 -s 4 -j big_buck_bunny_480p_stereo.au > /dev/null

Times from ARM device (ARM11):

before patch:
real =A0 =A09m 42.98s
user =A0 =A08m 51.06s
sys =A0 =A0 0m 39.50s

after patch:
real =A0 =A06m 35.55s
user =A0 =A05m 44.09s
sys =A0 =A0 0m 40.43s

Times from x86 PC (Intel Core2):

before patch:
real =A0 =A00m49.437s
user =A0 =A00m45.267s
sys =A0 =A0 0m3.708s

after patch:
real =A0 =A00m27.606s
user =A0 =A00m23.869s
sys =A0 =A0 0m3.656s

=20
Best regards,
Siarhei Siamashka

--Boundary-00=_beXQJfbV0Vrwexs
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-sbc-bitstream-writing-optimization-for-encoder.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-sbc-bitstream-writing-optimization-for-encoder.patch"

>From cec91fe56d834109db6280330085832c79ded6b6 Mon Sep 17 00:00:00 2001
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
index 7072673..9b676e0 100644
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
+					PUT_BITS(audio_sample, bits[ch][sb]);
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


--Boundary-00=_beXQJfbV0Vrwexs--
