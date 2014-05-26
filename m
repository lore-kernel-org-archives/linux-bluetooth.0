Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 04/26] android/hal-audio: Fix media_packet definition
Date: Mon, 26 May 2014 15:16:30 +0200
Message-ID: <1401110212-11526-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rtp_payload field in media_packet is specific for SBC codec thus it
should be moved to SBC codec implementation and removed from generic
structs.
---
 android/hal-audio-sbc.c | 40 +++++++++++++++++++++++++++++++++++++---
 android/hal-audio.h     | 17 -----------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index a16cf73..8366978 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -30,6 +30,37 @@
 #define SBC_QUALITY_MIN_BITPOOL	33
 #define SBC_QUALITY_STEP	5
 
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct rtp_payload {
+	unsigned frame_count:4;
+	unsigned rfa0:1;
+	unsigned is_last_fragment:1;
+	unsigned is_first_fragment:1;
+	unsigned is_fragmented:1;
+} __attribute__ ((packed));
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct rtp_payload {
+	unsigned is_fragmented:1;
+	unsigned is_first_fragment:1;
+	unsigned is_last_fragment:1;
+	unsigned rfa0:1;
+	unsigned frame_count:4;
+} __attribute__ ((packed));
+
+#else
+#error "Unknown byte order"
+#endif
+
+struct media_packet_sbc {
+	struct media_packet hdr;
+	struct rtp_payload payload;
+	uint8_t data[0];
+};
+
 struct sbc_data {
 	a2dp_sbc_t sbc;
 
@@ -306,10 +337,13 @@ static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 					size_t mp_data_len, size_t *written)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+	struct media_packet_sbc *mp_sbc = (struct media_packet_sbc *) mp;
 	size_t consumed = 0;
 	size_t encoded = 0;
 	uint8_t frame_count = 0;
 
+	mp_data_len -= sizeof(mp_sbc->payload);
+
 	while (len - consumed >= sbc_data->in_frame_len &&
 			mp_data_len - encoded >= sbc_data->out_frame_len &&
 			frame_count < MAX_FRAMES_IN_PAYLOAD) {
@@ -317,7 +351,7 @@ static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 		ssize_t written = 0;
 
 		read = sbc_encode(&sbc_data->enc, buffer + consumed,
-				sbc_data->in_frame_len, mp->data + encoded,
+				sbc_data->in_frame_len, mp_sbc->data + encoded,
 				mp_data_len - encoded, &written);
 
 		if (read < 0) {
@@ -331,8 +365,8 @@ static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 		encoded += written;
 	}
 
-	*written = encoded;
-	mp->payload.frame_count = frame_count;
+	*written = encoded + sizeof(mp_sbc->payload);
+	mp_sbc->payload.frame_count = frame_count;
 
 	return consumed;
 }
diff --git a/android/hal-audio.h b/android/hal-audio.h
index cc1a81c..dc1a812 100644
--- a/android/hal-audio.h
+++ b/android/hal-audio.h
@@ -35,14 +35,6 @@ struct rtp_header {
 	uint32_t csrc[0];
 } __attribute__ ((packed));
 
-struct rtp_payload {
-	unsigned frame_count:4;
-	unsigned rfa0:1;
-	unsigned is_last_fragment:1;
-	unsigned is_first_fragment:1;
-	unsigned is_fragmented:1;
-} __attribute__ ((packed));
-
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 struct rtp_header {
@@ -60,21 +52,12 @@ struct rtp_header {
 	uint32_t csrc[0];
 } __attribute__ ((packed));
 
-struct rtp_payload {
-	unsigned is_fragmented:1;
-	unsigned is_first_fragment:1;
-	unsigned is_last_fragment:1;
-	unsigned rfa0:1;
-	unsigned frame_count:4;
-} __attribute__ ((packed));
-
 #else
 #error "Unknown byte order"
 #endif
 
 struct media_packet {
 	struct rtp_header hdr;
-	struct rtp_payload payload;
 	uint8_t data[0];
 };
 
-- 
1.9.3

