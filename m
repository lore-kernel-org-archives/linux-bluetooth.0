Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 13/26] audio: Add definitions for MPEG-2,4 AAC codec
Date: Mon, 26 May 2014 15:16:39 +0200
Message-ID: <1401110212-11526-14-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

frequency and bitrate bit-fields are splitted into separate bytes since
they span across byte-boundary and cannot be set easily on LE arch
anyway.
---
 profiles/audio/a2dp-codecs.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 0f44b10..e2e1a77 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -85,6 +85,27 @@
 #define MPEG_BIT_RATE_32000		0x0002
 #define MPEG_BIT_RATE_FREE		0x0001
 
+#define AAC_OBJECT_TYPE_MPEG2_AAC_LC	0x80
+#define AAC_OBJECT_TYPE_MPEG4_AAC_LC	0x40
+#define AAC_OBJECT_TYPE_MPEG4_AAC_LTP	0x20
+#define AAC_OBJECT_TYPE_MPEG4_AAC_SCA	0x10
+
+#define AAC_SAMPLING_FREQ_8000		0x0800
+#define AAC_SAMPLING_FREQ_11025		0x0400
+#define AAC_SAMPLING_FREQ_12000		0x0200
+#define AAC_SAMPLING_FREQ_16000		0x0100
+#define AAC_SAMPLING_FREQ_22050		0x0080
+#define AAC_SAMPLING_FREQ_24000		0x0040
+#define AAC_SAMPLING_FREQ_32000		0x0020
+#define AAC_SAMPLING_FREQ_44100		0x0010
+#define AAC_SAMPLING_FREQ_48000		0x0008
+#define AAC_SAMPLING_FREQ_64000		0x0004
+#define AAC_SAMPLING_FREQ_88200		0x0002
+#define AAC_SAMPLING_FREQ_96000		0x0001
+
+#define AAC_CHANNELS_1			0x02
+#define AAC_CHANNELS_2			0x01
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
@@ -107,6 +128,18 @@ typedef struct {
 	uint16_t bitrate;
 } __attribute__ ((packed)) a2dp_mpeg_t;
 
+typedef struct {
+	uint8_t object_type;
+	uint8_t frequency1;
+	uint8_t rfa:2;
+	uint8_t channels:2;
+	uint8_t frequency2:4;
+	uint8_t bitrate1:7;
+	uint8_t vbr:1;
+	uint8_t bitrate2;
+	uint8_t bitrate3;
+} __attribute__ ((packed)) a2dp_aac_t;
+
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 typedef struct {
@@ -129,6 +162,18 @@ typedef struct {
 	uint16_t bitrate;
 } __attribute__ ((packed)) a2dp_mpeg_t;
 
+typedef struct {
+	uint8_t object_type;
+	uint8_t frequency1;
+	uint8_t frequency2:4;
+	uint8_t channels:2;
+	uint8_t rfa:2;
+	uint8_t vbr:1;
+	uint8_t bitrate1:7;
+	uint8_t bitrate2;
+	uint8_t bitrate3;
+} __attribute__ ((packed)) a2dp_aac_t;
+
 #else
 #error "Unknown byte order"
 #endif
-- 
1.9.3

