Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 6/6] android/hal-audio: Add RTP timestamps
Date: Mon, 3 Feb 2014 17:55:49 +0100
Message-ID: <1391446549-31455-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 6439880..efdf823 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -133,6 +133,7 @@ struct sbc_data {
 
 	struct timespec start;
 	unsigned frames_sent;
+	uint32_t timestamp;
 
 	uint16_t seq;
 };
@@ -404,6 +405,7 @@ static void sbc_resume(void *codec_data)
 	clock_gettime(CLOCK_MONOTONIC, &sbc_data->start);
 
 	sbc_data->frames_sent = 0;
+	sbc_data->timestamp = 0;
 }
 
 static int write_media_packet(int fd, struct sbc_data *sbc_data,
@@ -455,31 +457,38 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 	struct media_packet *mp = (struct media_packet *) sbc_data->out_buf;
 	size_t free_space = sbc_data->out_buf_size - sizeof(*mp);
 	int ret;
+	ssize_t bytes_read;
 
 	mp->hdr.v = 2;
 	mp->hdr.pt = 1;
 	mp->hdr.ssrc = htonl(1);
+	mp->hdr.timestamp = htonl(sbc_data->timestamp);
 	mp->payload.frame_count = 0;
 
 	while (bytes - consumed >= sbc_data->in_frame_len) {
 		ssize_t written = 0;
 
-		ret = sbc_encode(&sbc_data->enc, buffer + consumed,
+		bytes_read = sbc_encode(&sbc_data->enc, buffer + consumed,
 					sbc_data->in_frame_len,
 					mp->data + encoded, free_space,
 					&written);
 
-		if (ret < 0) {
-			error("SBC: failed to encode block (%d)", ret);
+		if (bytes_read < 0) {
+			error("SBC: failed to encode block (%zd)", bytes_read);
 			break;
 		}
 
 		mp->payload.frame_count++;
 
-		consumed += ret;
+		consumed += bytes_read;
 		encoded += written;
 		free_space -= written;
 
+		/* AudioFlinger provides PCM 16bit stereo only, thus sample size
+		 * is always 4 bytes
+		 */
+		sbc_data->timestamp += (bytes_read / 4);
+
 		/* write data if we either filled media packed or encoded all
 		 * input data
 		 */
@@ -495,6 +504,7 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 
 			encoded = 0;
 			free_space = sbc_data->out_buf_size - sizeof(*mp);
+			mp->hdr.timestamp = htonl(sbc_data->timestamp);
 			mp->payload.frame_count = 0;
 		}
 	}
-- 
1.8.5.3

