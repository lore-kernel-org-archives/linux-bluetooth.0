Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 09/10] android/hal-audio: Add proper SBC encoding
Date: Wed, 22 Jan 2014 11:34:52 +0100
Message-ID: <1390386893-8212-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Input and output stream is configured in a way that each input buffer
can be encoded to exactly one output buffer.

Reading from AudioFlinger is synchronized based on amounts of frames
which were expected to be sent since stream was resumed, i.e. as long
as we sent enough data we can wait for period of single media packet
before we need another buffer from input. Without synchronization
we'd receive next input buffer as soon as we process current one.
---
 android/hal-audio.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 81a452a..ddc6348 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -24,6 +24,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <arpa/inet.h>
 
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
@@ -127,8 +128,22 @@ struct sbc_data {
 
 	struct timespec start;
 	unsigned frames_sent;
+
+	uint16_t seq;
 };
 
+static inline void timespec_diff(struct timespec *a, struct timespec *b,
+					struct timespec *res)
+{
+	res->tv_sec = a->tv_sec - b->tv_sec;
+	res->tv_nsec = a->tv_nsec - b->tv_nsec;
+
+	if (res->tv_nsec < 0) {
+		res->tv_sec--;
+		res->tv_nsec += 1000000000; /* 1sec */
+	}
+}
+
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
 static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 				void **codec_data);
@@ -137,6 +152,8 @@ static int sbc_get_config(void *codec_data,
 					struct audio_input_config *config);
 static size_t sbc_get_buffer_size(void *codec_data);
 static void sbc_resume(void *codec_data);
+static ssize_t sbc_write_data(void *codec_data, const void *buffer,
+					size_t bytes, int fd);
 
 struct audio_codec {
 	uint8_t type;
@@ -151,7 +168,7 @@ struct audio_codec {
 	size_t (*get_buffer_size) (void *codec_data);
 	void (*resume) (void *codec_data);
 	ssize_t (*write_data) (void *codec_data, const void *buffer,
-				size_t bytes);
+				size_t bytes, int fd);
 };
 
 static const struct audio_codec audio_codecs[] = {
@@ -165,6 +182,7 @@ static const struct audio_codec audio_codecs[] = {
 		.get_config = sbc_get_config,
 		.get_buffer_size = sbc_get_buffer_size,
 		.resume = sbc_resume,
+		.write_data = sbc_write_data,
 	}
 };
 
@@ -380,6 +398,80 @@ static void sbc_resume(void *codec_data)
 	sbc_data->frames_sent = 0;
 }
 
+static ssize_t sbc_write_data(void *codec_data, const void *buffer,
+				size_t bytes, int fd)
+{
+	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+	size_t consumed = 0;
+	size_t encoded = 0;
+	struct media_packet *mp = (struct media_packet *) sbc_data->out_buf;
+	size_t free_space = sbc_data->out_buf_size - sizeof(*mp);
+	struct timespec cur;
+	struct timespec diff;
+	unsigned expected_frames;
+	int ret;
+
+	mp->hdr.v = 2;
+	mp->hdr.pt = 1;
+	mp->hdr.sequence_number = htons(sbc_data->seq++);
+	mp->hdr.ssrc = htonl(1);
+	mp->payload.frame_count = 0;
+
+	while (bytes - consumed >= sbc_data->in_frame_len) {
+		ssize_t written = 0;
+
+		ret = sbc_encode(&sbc_data->enc, buffer + consumed,
+					sbc_data->in_frame_len,
+					mp->data + encoded, free_space,
+					&written);
+
+		if (ret < 0) {
+			DBG("failed to encode block");
+			break;
+		}
+
+		mp->payload.frame_count++;
+
+		consumed += ret;
+		encoded += written;
+		free_space -= written;
+	}
+
+	ret = write(fd, mp, sizeof(*mp) + encoded);
+	if (ret < 0) {
+		int err = errno;
+		DBG("error writing data: %d (%s)", err, strerror(err));
+	}
+
+	if (consumed != bytes || free_space != 0) {
+		/* we should encode all input data and fill output buffer
+		 * if we did not, something went wrong but we can't really
+		 * handle this so this is just sanity check
+		 */
+		DBG("some data were not encoded");
+	}
+
+	sbc_data->frames_sent += mp->payload.frame_count;
+
+	clock_gettime(CLOCK_MONOTONIC, &cur);
+	timespec_diff(&cur, &sbc_data->start, &diff);
+	expected_frames = (diff.tv_sec * 1000000 + diff.tv_nsec / 1000) /
+				sbc_data->frame_duration;
+
+	/* AudioFlinger does not seem to provide any *working* API to provide
+	 * data in some interval and will just send another buffer as soon as
+	 * we process current one. To prevent overflowing L2CAP socket, we need
+	 * to introduce some artificial delay here base on how many audio frames
+	 * were sent so far, i.e. if we're not lagging behind audio stream, we
+	 * can sleep for duration of single media packet.
+	 */
+	if (sbc_data->frames_sent >= expected_frames)
+		usleep(sbc_data->frame_duration * mp->payload.frame_count);
+
+	/* we always assume that all data was processed and sent */
+	return bytes;
+}
+
 static void audio_ipc_cleanup(void)
 {
 	if (audio_sk >= 0) {
@@ -712,9 +804,13 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 		return -1;
 	}
 
-	/* TODO: encode data using codec */
+	if (out->ep->fd < 0) {
+		DBG("no transport");
+		return -1;
+	}
 
-	return bytes;
+	return out->ep->codec->write_data(out->ep->codec_data, buffer,
+						bytes, out->ep->fd);
 }
 
 static uint32_t out_get_sample_rate(const struct audio_stream *stream)
-- 
1.8.5.2

