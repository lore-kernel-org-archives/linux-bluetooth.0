Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 15/26] audio: Add definitions for aptX
Date: Mon, 26 May 2014 15:16:41 +0200
Message-ID: <1401110212-11526-16-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/a2dp-codecs.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 1106bd2..4d2584d 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -130,6 +130,22 @@
 	.frequency1 = (f >> 4) & 0xff, \
 	.frequency2 = f & 0x0f,
 
+#define APTX_VENDOR_ID			0x0000004f
+#define APTX_CODEC_ID			0x0001
+
+#define APTX_CHANNEL_MODE_MONO		0x01
+#define APTX_CHANNEL_MODE_STEREO	0x02
+
+#define APTX_SAMPLING_FREQ_16000	0x08
+#define APTX_SAMPLING_FREQ_32000	0x04
+#define APTX_SAMPLING_FREQ_44100	0x02
+#define APTX_SAMPLING_FREQ_48000	0x01
+
+typedef struct {
+	uint32_t vendor_id;
+	uint16_t codec_id;
+} __attribute__ ((packed)) a2dp_vendor_codec_t;
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
@@ -164,6 +180,12 @@ typedef struct {
 	uint8_t bitrate3;
 } __attribute__ ((packed)) a2dp_aac_t;
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t channel_mode:4;
+	uint8_t frequency:4;
+} __attribute__ ((packed)) a2dp_aptx_t;
+
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
@@ -198,11 +220,12 @@ typedef struct {
 	uint8_t bitrate3;
 } __attribute__ ((packed)) a2dp_aac_t;
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t frequency:4;
+	uint8_t channel_mode:4;
+} __attribute__ ((packed)) a2dp_aptx_t;
+
 #else
 #error "Unknown byte order"
 #endif
-
-typedef struct {
-	uint32_t vendor_id;
-	uint16_t codec_id;
-} __attribute__ ((packed)) a2dp_vendor_codec_t;
-- 
1.9.3

