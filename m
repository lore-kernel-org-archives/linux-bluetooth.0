Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/5] avinfo: Replace definitions with a2dp-codecs.h's
Date: Tue, 09 Oct 2012 20:35:45 +0900
Message-id: <1349782548-27923-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
References: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/a2dp-codecs.h |   21 +++++++++-
 tools/avinfo.c      |  113 +++------------------------------------------------
 2 files changed, 25 insertions(+), 109 deletions(-)

diff --git a/audio/a2dp-codecs.h b/audio/a2dp-codecs.h
index 2afafa5..3dc31cb 100644
--- a/audio/a2dp-codecs.h
+++ b/audio/a2dp-codecs.h
@@ -49,6 +49,9 @@
 #define SBC_ALLOCATION_SNR		(1 << 1)
 #define SBC_ALLOCATION_LOUDNESS		1
 
+#define MAX_BITPOOL 64
+#define MIN_BITPOOL 2
+
 #define MPEG_CHANNEL_MODE_MONO		(1 << 3)
 #define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
 #define MPEG_CHANNEL_MODE_STEREO	(1 << 1)
@@ -65,8 +68,22 @@
 #define MPEG_SAMPLING_FREQ_44100	(1 << 1)
 #define MPEG_SAMPLING_FREQ_48000	1
 
-#define MAX_BITPOOL 64
-#define MIN_BITPOOL 2
+#define MPEG_BIT_RATE_VBR		0x8000
+#define MPEG_BIT_RATE_320000		0x4000
+#define MPEG_BIT_RATE_256000		0x2000
+#define MPEG_BIT_RATE_224000		0x1000
+#define MPEG_BIT_RATE_192000		0x0800
+#define MPEG_BIT_RATE_160000		0x0400
+#define MPEG_BIT_RATE_128000		0x0200
+#define MPEG_BIT_RATE_112000		0x0100
+#define MPEG_BIT_RATE_96000		0x0080
+#define MPEG_BIT_RATE_80000		0x0040
+#define MPEG_BIT_RATE_64000		0x0020
+#define MPEG_BIT_RATE_56000		0x0010
+#define MPEG_BIT_RATE_48000		0x0008
+#define MPEG_BIT_RATE_40000		0x0004
+#define MPEG_BIT_RATE_32000		0x0002
+#define MPEG_BIT_RATE_FREE		0x0001
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
diff --git a/tools/avinfo.c b/tools/avinfo.c
index 63b0da6..78a1544 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -39,6 +39,8 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
+#include <a2dp-codecs.h>
+
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
@@ -72,65 +74,6 @@
 #define AVDTP_MEDIA_TYPE_VIDEO		0x01
 #define AVDTP_MEDIA_TYPE_MULTIMEDIA	0x02
 
-#define A2DP_CODEC_SBC			0x00
-#define A2DP_CODEC_MPEG12		0x01
-#define A2DP_CODEC_MPEG24		0x02
-#define A2DP_CODEC_ATRAC		0x03
-
-#define SBC_SAMPLING_FREQ_16000		(1 << 3)
-#define SBC_SAMPLING_FREQ_32000		(1 << 2)
-#define SBC_SAMPLING_FREQ_44100		(1 << 1)
-#define SBC_SAMPLING_FREQ_48000		(1 << 0)
-
-#define SBC_CHANNEL_MODE_MONO		(1 << 3)
-#define SBC_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-#define SBC_CHANNEL_MODE_STEREO		(1 << 1)
-#define SBC_CHANNEL_MODE_JOINT_STEREO	(1 << 0)
-
-#define SBC_BLOCK_LENGTH_4		(1 << 3)
-#define SBC_BLOCK_LENGTH_8		(1 << 2)
-#define SBC_BLOCK_LENGTH_12		(1 << 1)
-#define SBC_BLOCK_LENGTH_16		(1 << 0)
-
-#define SBC_SUBBANDS_4			(1 << 1)
-#define SBC_SUBBANDS_8			(1 << 0)
-
-#define SBC_ALLOCATION_SNR		(1 << 1)
-#define SBC_ALLOCATION_LOUDNESS		(1 << 0)
-
-#define MPEG_CHANNEL_MODE_MONO		(1 << 3)
-#define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-#define MPEG_CHANNEL_MODE_STEREO	(1 << 1)
-#define MPEG_CHANNEL_MODE_JOINT_STEREO	(1 << 0)
-
-#define MPEG_LAYER_MP1			(1 << 2)
-#define MPEG_LAYER_MP2			(1 << 1)
-#define MPEG_LAYER_MP3			(1 << 0)
-
-#define MPEG_SAMPLING_FREQ_16000	(1 << 5)
-#define MPEG_SAMPLING_FREQ_22050	(1 << 4)
-#define MPEG_SAMPLING_FREQ_24000	(1 << 3)
-#define MPEG_SAMPLING_FREQ_32000	(1 << 2)
-#define MPEG_SAMPLING_FREQ_44100	(1 << 1)
-#define MPEG_SAMPLING_FREQ_48000	(1 << 0)
-
-#define MPEG_BIT_RATE_VBR		0x8000
-#define MPEG_BIT_RATE_320000		0x4000
-#define MPEG_BIT_RATE_256000		0x2000
-#define MPEG_BIT_RATE_224000		0x1000
-#define MPEG_BIT_RATE_192000		0x0800
-#define MPEG_BIT_RATE_160000		0x0400
-#define MPEG_BIT_RATE_128000		0x0200
-#define MPEG_BIT_RATE_112000		0x0100
-#define MPEG_BIT_RATE_96000		0x0080
-#define MPEG_BIT_RATE_80000		0x0040
-#define MPEG_BIT_RATE_64000		0x0020
-#define MPEG_BIT_RATE_56000		0x0010
-#define MPEG_BIT_RATE_48000		0x0008
-#define MPEG_BIT_RATE_40000		0x0004
-#define MPEG_BIT_RATE_32000		0x0002
-#define MPEG_BIT_RATE_FREE		0x0001
-
 struct avdtp_service_capability {
 	uint8_t category;
 	uint8_t length;
@@ -169,28 +112,6 @@ struct avdtp_media_codec_capability {
 	uint8_t data[0];
 } __attribute__ ((packed));
 
-struct sbc_codec_cap {
-	struct avdtp_media_codec_capability cap;
-	uint8_t channel_mode:4;
-	uint8_t frequency:4;
-	uint8_t allocation_method:2;
-	uint8_t subbands:2;
-	uint8_t block_length:4;
-	uint8_t min_bitpool;
-	uint8_t max_bitpool;
-} __attribute__ ((packed));
-
-struct mpeg_codec_cap {
-	struct avdtp_media_codec_capability cap;
-	uint8_t channel_mode:4;
-	uint8_t crc:1;
-	uint8_t layer:3;
-	uint8_t frequency:6;
-	uint8_t mpf:1;
-	uint8_t rfa:1;
-	uint16_t bitrate;
-} __attribute__ ((packed));
-
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 struct avdtp_header {
@@ -223,28 +144,6 @@ struct avdtp_media_codec_capability {
 	uint8_t data[0];
 } __attribute__ ((packed));
 
-struct sbc_codec_cap {
-	struct avdtp_media_codec_capability cap;
-	uint8_t frequency:4;
-	uint8_t channel_mode:4;
-	uint8_t block_length:4;
-	uint8_t subbands:2;
-	uint8_t allocation_method:2;
-	uint8_t min_bitpool;
-	uint8_t max_bitpool;
-} __attribute__ ((packed));
-
-struct mpeg_codec_cap {
-	struct avdtp_media_codec_capability cap;
-	uint8_t layer:3;
-	uint8_t crc:1;
-	uint8_t channel_mode:4;
-	uint8_t rfa:1;
-	uint8_t mpf:1;
-	uint8_t frequency:6;
-	uint16_t bitrate;
-} __attribute__ ((packed));
-
 #else
 #error "Unknown byte order"
 #endif
@@ -260,7 +159,7 @@ struct getcap_resp {
 } __attribute__ ((packed));
 
 
-static void print_mpeg12(struct mpeg_codec_cap *mpeg)
+static void print_mpeg12(a2dp_mpeg_t *mpeg)
 {
 	printf("\tMedia Codec: MPEG12\n\t\tChannel Modes: ");
 
@@ -341,7 +240,7 @@ static void print_mpeg12(struct mpeg_codec_cap *mpeg)
 		printf("RFC-2250\n");
 }
 
-static void print_sbc(struct sbc_codec_cap *sbc)
+static void print_sbc(a2dp_sbc_t *sbc)
 {
 	printf("\tMedia Codec: SBC\n\t\tChannel Modes: ");
 
@@ -388,10 +287,10 @@ static void print_media_codec(struct avdtp_media_codec_capability *cap)
 {
 	switch (cap->media_codec_type) {
 	case A2DP_CODEC_SBC:
-		print_sbc((void *) cap);
+		print_sbc((void *) cap->data);
 		break;
 	case A2DP_CODEC_MPEG12:
-		print_mpeg12((void *) cap);
+		print_mpeg12((void *) cap->data);
 		break;
 	default:
 		printf("\tMedia Codec: Unknown\n");
-- 
1.7.9.5

