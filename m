Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 14/26] audio: Add macros to access MPEG-2,4 AAC codec info
Date: Mon, 26 May 2014 15:16:40 +0200
Message-ID: <1401110212-11526-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides helper macros to get, set and init-in-struct both
frequency and bitrate fields in codec info structs for MPEG-2,4 AAC.
---
 profiles/audio/a2dp-codecs.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index e2e1a77..1106bd2 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -106,6 +106,30 @@
 #define AAC_CHANNELS_1			0x02
 #define AAC_CHANNELS_2			0x01
 
+#define AAC_GET_BITRATE(a) ((a).bitrate1 << 16 | \
+					(a).bitrate2 << 8 | (a).bitrate3)
+#define AAC_GET_FREQUENCY(a) ((a).frequency1 << 4 | (a).frequency2)
+
+#define AAC_SET_BITRATE(a, b) \
+	do { \
+		(a).bitrate1 = (b >> 16) & 0x7f; \
+		(a).bitrate2 = (b >> 8) & 0xff; \
+		(a).bitrate3 = b & 0xff; \
+	} while (0)
+#define AAC_SET_FREQUENCY(a, f) \
+	do { \
+		(a).frequency1 = (f >> 4) & 0xff; \
+		(a).frequency2 = f & 0x0f; \
+	} while (0)
+
+#define AAC_INIT_BITRATE(b) \
+	.bitrate1 = (b >> 16) & 0x7f, \
+	.bitrate2 = (b >> 8) & 0xff, \
+	.bitrate3 = b & 0xff,
+#define AAC_INIT_FREQUENCY(f) \
+	.frequency1 = (f >> 4) & 0xff, \
+	.frequency2 = f & 0x0f,
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 typedef struct {
-- 
1.9.3

