Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Coding style fixes
Date: Sat, 17 Jan 2009 20:40:10 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KYicJ2h7RX6LKpC"
Message-Id: <200901172040.10674.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_KYicJ2h7RX6LKpC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This should make those who are pedantic about coding style a bit more happy ;)

And seriously, having "do { } while(0)" for a multiline macro is a must.


Best regards,
Siarhei Siamashka

--Boundary-00=_KYicJ2h7RX6LKpC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-Coding-style-fixes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Coding-style-fixes.patch"

>From 7b078025b1b69b6e4f88cfc85d928247dc6adecc Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Sat, 17 Jan 2009 20:30:40 +0200
Subject: [PATCH] Coding style fixes

---
 sbc/sbc.c |   53 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 0699ae0..827b731 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -690,23 +690,31 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 
 /* Supplementary bitstream writing macros for 'sbc_pack_frame' */
 
-#define PUT_BITS(v, n)\
-	bits_cache = (v) | (bits_cache << (n));\
-	bits_count += (n);\
-	if (bits_count >= 16) {\
-		bits_count -= 8;\
-		*data_ptr++ = (uint8_t) (bits_cache >> bits_count);\
-		bits_count -= 8;\
-		*data_ptr++ = (uint8_t) (bits_cache >> bits_count);\
-	}\
-
-#define FLUSH_BITS()\
-	while (bits_count >= 8) {\
-		bits_count -= 8;\
-		*data_ptr++ = (uint8_t) (bits_cache >> bits_count);\
-	}\
-	if (bits_count > 0)\
-	    *data_ptr++ = (uint8_t) (bits_cache << (8 - bits_count));\
+#define PUT_BITS(data_ptr, bits_cache, bits_count, v, n)		\
+	do {								\
+		bits_cache = (v) | (bits_cache << (n));			\
+		bits_count += (n);					\
+		if (bits_count >= 16) {					\
+			bits_count -= 8;				\
+			*data_ptr++ = (uint8_t)				\
+				(bits_cache >> bits_count);		\
+			bits_count -= 8;				\
+			*data_ptr++ = (uint8_t)				\
+				(bits_cache >> bits_count);		\
+		}							\
+	} while (0)
+
+#define FLUSH_BITS(data_ptr, bits_cache, bits_count)			\
+	do {								\
+		while (bits_count >= 8) {				\
+			bits_count -= 8;				\
+			*data_ptr++ = (uint8_t)				\
+				(bits_cache >> bits_count);		\
+		}							\
+		if (bits_count > 0)					\
+			*data_ptr++ = (uint8_t)				\
+				(bits_cache << (8 - bits_count));	\
+	} while (0)
 
 /*
  * Packs the SBC frame from frame into the memory at data. At most len
@@ -849,14 +857,16 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			}
 		}
 
-		PUT_BITS(joint, frame->subbands);
+		PUT_BITS(data_ptr, bits_cache, bits_count,
+			joint, frame->subbands);
 		crc_header[crc_pos >> 3] = joint;
 		crc_pos += frame->subbands;
 	}
 
 	for (ch = 0; ch < frame->channels; ch++) {
 		for (sb = 0; sb < frame->subbands; sb++) {
-			PUT_BITS(frame->scale_factor[ch][sb] & 0x0F, 4);
+			PUT_BITS(data_ptr, bits_cache, bits_count,
+				frame->scale_factor[ch][sb] & 0x0F, 4);
 			crc_header[crc_pos >> 3] <<= 4;
 			crc_header[crc_pos >> 3] |= frame->scale_factor[ch][sb] & 0x0F;
 			crc_pos += 4;
@@ -893,12 +903,13 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 					(sb_sample_delta[ch][sb] +
 					frame->sb_sample_f[blk][ch][sb])) >> 32;
 
-				PUT_BITS(audio_sample, bits[ch][sb]);
+				PUT_BITS(data_ptr, bits_cache, bits_count,
+					audio_sample, bits[ch][sb]);
 			}
 		}
 	}
 
-	FLUSH_BITS();
+	FLUSH_BITS(data_ptr, bits_cache, bits_count);
 
 	return data_ptr - data;
 }
-- 
1.5.6.5


--Boundary-00=_KYicJ2h7RX6LKpC--
