Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/5] android/hal-audio: Add encode_mediapacket function
Date: Fri, 28 Feb 2014 19:01:17 +0100
Message-ID: <1393610480-5775-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves code which encodes data for media packet into single
function. It will simply try to put as much encoded frames as will fit
in provided media packet buffer. This is first step to make common code
responsible for media stream write and synchronizarion instead of codec
abstraction code as it is handled now.
---
 android/hal-audio.c | 102 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 36e8d2e..78889e5 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -129,6 +129,7 @@ struct sbc_data {
 	size_t in_frame_len;
 	size_t in_buf_size;
 
+	size_t out_frame_len;
 	size_t out_buf_size;
 	uint8_t *out_buf;
 
@@ -417,6 +418,7 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	sbc_data->in_frame_len = in_frame_len;
 	sbc_data->in_buf_size = num_frames * in_frame_len;
 
+	sbc_data->out_frame_len = out_frame_len;
 	sbc_data->out_buf_size = hdr_len + num_frames * out_frame_len;
 	sbc_data->out_buf = calloc(1, sbc_data->out_buf_size);
 
@@ -536,75 +538,85 @@ static int write_media_packet(int fd, struct sbc_data *sbc_data,
 	return ret;
 }
 
+static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
+					size_t len, struct media_packet *mp,
+					size_t mp_data_len, size_t *written)
+{
+	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+	size_t consumed = 0;
+	size_t encoded = 0;
+	uint8_t frame_count = 0;
+
+	while (len - consumed >= sbc_data->in_frame_len &&
+			mp_data_len - encoded >= sbc_data->out_frame_len &&
+			frame_count < MAX_FRAMES_IN_PAYLOAD) {
+		ssize_t read;
+		ssize_t written = 0;
+
+		read = sbc_encode(&sbc_data->enc, buffer + consumed,
+				sbc_data->in_frame_len, mp->data + encoded,
+				mp_data_len - encoded, &written);
+
+		if (read < 0) {
+			error("SBC: failed to encode block at frame %d (%zd)",
+							frame_count, read);
+			break;
+		}
+
+		frame_count++;
+		consumed += read;
+		encoded += written;
+	}
+
+	*written = encoded;
+	mp->payload.frame_count = frame_count;
+
+	return consumed;
+}
+
 static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 							size_t bytes, int fd)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
 	size_t consumed = 0;
-	size_t encoded = 0;
 	struct media_packet *mp = (struct media_packet *) sbc_data->out_buf;
 	size_t free_space = sbc_data->out_buf_size - sizeof(*mp);
-	int ret;
-	ssize_t bytes_read;
 
 	mp->hdr.v = 2;
 	mp->hdr.pt = 1;
 	mp->hdr.ssrc = htonl(1);
-	mp->hdr.timestamp = htonl(sbc_data->timestamp);
-	mp->payload.frame_count = 0;
 
-	while (bytes - consumed >= sbc_data->in_frame_len) {
-		ssize_t written = 0;
+	while (consumed < bytes) {
+		size_t written = 0;
+		ssize_t read;
+		int ret;
 
-		bytes_read = sbc_encode(&sbc_data->enc, buffer + consumed,
-					sbc_data->in_frame_len,
-					mp->data + encoded, free_space,
-					&written);
+		read = sbc_encode_mediapacket(codec_data, buffer + consumed,
+						bytes - consumed, mp,
+						free_space,
+						&written);
 
-		if (bytes_read < 0) {
-			error("SBC: failed to encode block (%zd)", bytes_read);
-			break;
+		if (read <= 0) {
+			error("sbc_encode_mediapacket failed (%zd)", read);
+			goto done;
 		}
 
-		mp->payload.frame_count++;
+		consumed += read;
 
-		consumed += bytes_read;
-		encoded += written;
-		free_space -= written;
+		mp->hdr.sequence_number = htons(sbc_data->seq++);
+		mp->hdr.timestamp = htonl(sbc_data->timestamp);
 
 		/* AudioFlinger provides PCM 16bit stereo only, thus sample size
 		 * is always 4 bytes
 		 */
-		sbc_data->timestamp += (bytes_read / 4);
+		sbc_data->timestamp += (read / 4);
 
-		/* write data if we either filled media packed or encoded all
-		 * input data
-		 */
-		if (mp->payload.frame_count == sbc_data->frames_per_packet ||
-				bytes == consumed ||
-				mp->payload.frame_count ==
-							MAX_FRAMES_IN_PAYLOAD) {
-			mp->hdr.sequence_number = htons(sbc_data->seq++);
-
-			ret = write_media_packet(fd, sbc_data, mp, encoded);
-			if (ret < 0)
-				return ret;
-
-			encoded = 0;
-			free_space = sbc_data->out_buf_size - sizeof(*mp);
-			mp->hdr.timestamp = htonl(sbc_data->timestamp);
-			mp->payload.frame_count = 0;
-		}
-	}
-
-	if (consumed != bytes) {
-		/* we should encode all input data
-		 * if we did not, something went wrong but we can't really
-		 * handle this so this is just sanity check
-		 */
-		error("SBC: failed to encode complete input buffer");
+		ret = write_media_packet(fd, sbc_data, mp, written);
+		if (ret < 0)
+			return ret;
 	}
 
+done:
 	/* we always assume that all data was processed and sent */
 	return bytes;
 }
-- 
1.8.5.4

