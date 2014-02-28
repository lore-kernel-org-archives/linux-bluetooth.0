Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/5] android/hal-audio: Write and sync in common code
Date: Fri, 28 Feb 2014 19:01:18 +0100
Message-ID: <1393610480-5775-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There's no need for codec abstraction to take care of writing and
synchronizing actual media stream since this is something that common
code can do regardless of codec used.

Data are synchronized based on number of samples consumed from input
stream instead of frames encoded to output stream which is also more
reliable since it's not affected by encoder errors.
---
 android/hal-audio.c | 188 +++++++++++++++++++++++++---------------------------
 1 file changed, 91 insertions(+), 97 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 78889e5..b4d78ca 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -130,17 +130,9 @@ struct sbc_data {
 	size_t in_buf_size;
 
 	size_t out_frame_len;
-	size_t out_buf_size;
-	uint8_t *out_buf;
 
 	unsigned frame_duration;
 	unsigned frames_per_packet;
-
-	struct timespec start;
-	unsigned frames_sent;
-	uint32_t timestamp;
-
-	uint16_t seq;
 };
 
 static inline void timespec_diff(struct timespec *a, struct timespec *b,
@@ -162,9 +154,9 @@ static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data, struct audio_input_config *config);
 static size_t sbc_get_buffer_size(void *codec_data);
 static size_t sbc_get_mediapacket_duration(void *codec_data);
-static void sbc_resume(void *codec_data);
-static ssize_t sbc_write_data(void *codec_data, const void *buffer,
-							size_t bytes, int fd);
+static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
+					size_t len, struct media_packet *mp,
+					size_t mp_data_len, size_t *written);
 
 struct audio_codec {
 	uint8_t type;
@@ -178,9 +170,9 @@ struct audio_codec {
 					struct audio_input_config *config);
 	size_t (*get_buffer_size) (void *codec_data);
 	size_t (*get_mediapacket_duration) (void *codec_data);
-	void (*resume) (void *codec_data);
-	ssize_t (*write_data) (void *codec_data, const void *buffer,
-							size_t bytes, int fd);
+	ssize_t (*encode_mediapacket) (void *codec_data, const uint8_t *buffer,
+					size_t len, struct media_packet *mp,
+					size_t mp_data_len, size_t *written);
 };
 
 static const struct audio_codec audio_codecs[] = {
@@ -194,8 +186,7 @@ static const struct audio_codec audio_codecs[] = {
 		.get_config = sbc_get_config,
 		.get_buffer_size = sbc_get_buffer_size,
 		.get_mediapacket_duration = sbc_get_mediapacket_duration,
-		.resume = sbc_resume,
-		.write_data = sbc_write_data,
+		.encode_mediapacket = sbc_encode_mediapacket,
 	}
 };
 
@@ -208,6 +199,13 @@ struct audio_endpoint {
 	const struct audio_codec *codec;
 	void *codec_data;
 	int fd;
+
+	struct media_packet *mp;
+	size_t mp_data_len;
+
+	uint16_t seq;
+	uint32_t samples;
+	struct timespec start;
 };
 
 static struct audio_endpoint audio_endpoints[MAX_AUDIO_ENDPOINTS];
@@ -419,8 +417,6 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	sbc_data->in_buf_size = num_frames * in_frame_len;
 
 	sbc_data->out_frame_len = out_frame_len;
-	sbc_data->out_buf_size = hdr_len + num_frames * out_frame_len;
-	sbc_data->out_buf = calloc(1, sbc_data->out_buf_size);
 
 	sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
 	sbc_data->frames_per_packet = num_frames;
@@ -438,7 +434,6 @@ static int sbc_cleanup(void *codec_data)
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
 
 	sbc_finish(&sbc_data->enc);
-	free(sbc_data->out_buf);
 	free(codec_data);
 
 	return AUDIO_STATUS_SUCCESS;
@@ -486,28 +481,18 @@ static size_t sbc_get_mediapacket_duration(void *codec_data)
 	return sbc_data->frame_duration * sbc_data->frames_per_packet;
 }
 
-static void sbc_resume(void *codec_data)
-{
-	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
-
-	DBG("");
-
-	clock_gettime(CLOCK_MONOTONIC, &sbc_data->start);
-
-	sbc_data->frames_sent = 0;
-	sbc_data->timestamp = 0;
-}
-
-static int write_media_packet(int fd, struct sbc_data *sbc_data,
-				struct media_packet *mp, size_t data_len)
+static int write_media_packet(struct a2dp_stream_out *out, size_t mp_data_len,
+							uint32_t input_samples)
 {
+	struct audio_endpoint *ep = out->ep;
+	struct media_packet *mp = ep->mp;
 	struct timespec cur;
 	struct timespec diff;
-	unsigned expected_frames;
+	uint32_t expected_samples;
 	int ret;
 
 	while (true) {
-		ret = write(fd, mp, sizeof(*mp) + data_len);
+		ret = write(ep->fd, mp, sizeof(*mp) + mp_data_len);
 		if (ret >= 0)
 			break;
 
@@ -515,12 +500,10 @@ static int write_media_packet(int fd, struct sbc_data *sbc_data,
 			return -errno;
 	}
 
-	sbc_data->frames_sent += mp->payload.frame_count;
-
 	clock_gettime(CLOCK_MONOTONIC, &cur);
-	timespec_diff(&cur, &sbc_data->start, &diff);
-	expected_frames = (diff.tv_sec * 1000000 + diff.tv_nsec / 1000) /
-						sbc_data->frame_duration;
+	timespec_diff(&cur, &ep->start, &diff);
+	expected_samples = (diff.tv_sec * 1000000ll + diff.tv_nsec / 1000ll) *
+						out->cfg.rate / 1000000ll;
 
 	/* AudioFlinger does not seem to provide any *working*
 	 * API to provide data in some interval and will just
@@ -531,9 +514,8 @@ static int write_media_packet(int fd, struct sbc_data *sbc_data,
 	 * lagging behind audio stream, we can sleep for
 	 * duration of single media packet.
 	 */
-	if (sbc_data->frames_sent >= expected_frames)
-		usleep(sbc_data->frame_duration *
-				mp->payload.frame_count);
+	if (ep->samples >= expected_samples)
+		usleep(input_samples * 1000000 / out->cfg.rate);
 
 	return ret;
 }
@@ -574,53 +556,6 @@ static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 	return consumed;
 }
 
-static ssize_t sbc_write_data(void *codec_data, const void *buffer,
-							size_t bytes, int fd)
-{
-	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
-	size_t consumed = 0;
-	struct media_packet *mp = (struct media_packet *) sbc_data->out_buf;
-	size_t free_space = sbc_data->out_buf_size - sizeof(*mp);
-
-	mp->hdr.v = 2;
-	mp->hdr.pt = 1;
-	mp->hdr.ssrc = htonl(1);
-
-	while (consumed < bytes) {
-		size_t written = 0;
-		ssize_t read;
-		int ret;
-
-		read = sbc_encode_mediapacket(codec_data, buffer + consumed,
-						bytes - consumed, mp,
-						free_space,
-						&written);
-
-		if (read <= 0) {
-			error("sbc_encode_mediapacket failed (%zd)", read);
-			goto done;
-		}
-
-		consumed += read;
-
-		mp->hdr.sequence_number = htons(sbc_data->seq++);
-		mp->hdr.timestamp = htonl(sbc_data->timestamp);
-
-		/* AudioFlinger provides PCM 16bit stereo only, thus sample size
-		 * is always 4 bytes
-		 */
-		sbc_data->timestamp += (read / 4);
-
-		ret = write_media_packet(fd, sbc_data, mp, written);
-		if (ret < 0)
-			return ret;
-	}
-
-done:
-	/* we always assume that all data was processed and sent */
-	return bytes;
-}
-
 static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			void *param, size_t *rsp_len, void *rsp, int *fd)
 {
@@ -970,6 +905,13 @@ static bool open_endpoint(struct audio_endpoint *ep,
 	codec->init(preset, mtu, &ep->codec_data);
 	codec->get_config(ep->codec_data, cfg);
 
+	ep->mp = calloc(mtu, 1);
+	ep->mp->hdr.v = 2;
+	ep->mp->hdr.pt = 1;
+	ep->mp->hdr.ssrc = htonl(1);
+
+	ep->mp_data_len = mtu - sizeof(*ep->mp);
+
 	free(preset);
 
 	return true;
@@ -983,6 +925,8 @@ static void close_endpoint(struct audio_endpoint *ep)
 		ep->fd = -1;
 	}
 
+	free(ep->mp);
+
 	ep->codec->cleanup(ep->codec_data);
 	ep->codec_data = NULL;
 }
@@ -1002,10 +946,59 @@ static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
 	}
 }
 
+static bool write_data(struct a2dp_stream_out *out, const void *buffer,
+								size_t bytes)
+{
+	struct audio_endpoint *ep = out->ep;
+	struct media_packet *mp = (struct media_packet *) ep->mp;
+	size_t free_space = ep->mp_data_len;
+	size_t consumed = 0;
+
+	while (consumed < bytes) {
+		size_t written = 0;
+		ssize_t read;
+		uint32_t samples;
+		int ret;
+
+		read = ep->codec->encode_mediapacket(ep->codec_data,
+							buffer + consumed,
+							bytes - consumed, mp,
+							free_space, &written);
+
+		/* This is non-fatal and we can just assume buffer was processed
+		 * properly and wait for next one.
+		 */
+		if (read <= 0)
+			goto done;
+
+		consumed += read;
+
+		mp->hdr.sequence_number = htons(ep->seq++);
+		mp->hdr.timestamp = htonl(ep->samples);
+
+		/* AudioFlinger provides 16bit PCM, so sample size is 2 bytes
+		 * multipled by number of channels. Number of channels is simply
+		 * number of bits set in channels mask.
+		 */
+		samples = read / (2 * popcount(out->cfg.channels));
+		ep->samples += samples;
+
+		ret = write_media_packet(out, written, samples);
+		if (ret < 0)
+			return false;
+	}
+
+done:
+	return true;
+}
+
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
 	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+	const void *in_buf = buffer;
+	size_t in_len = bytes;
 
 	/* just return in case we're closing */
 	if (out->audio_state == AUDIO_A2DP_STATE_NONE)
@@ -1018,7 +1011,8 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 		if (ipc_resume_stream_cmd(out->ep->id) != AUDIO_STATUS_SUCCESS)
 			return -1;
 
-		out->ep->codec->resume(out->ep->codec_data);
+		clock_gettime(CLOCK_MONOTONIC, &out->ep->start);
+		out->ep->samples = 0;
 
 		out->audio_state = AUDIO_A2DP_STATE_STARTED;
 	}
@@ -1048,14 +1042,14 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 		downmix_to_mono(out, buffer, bytes);
 
-		return out->ep->codec->write_data(out->ep->codec_data,
-							out->downmix_buf,
-							bytes / 2,
-							out->ep->fd) * 2;
+		in_buf = out->downmix_buf;
+		in_len = bytes / 2;
 	}
 
-	return out->ep->codec->write_data(out->ep->codec_data, buffer,
-							bytes, out->ep->fd);
+	if (!write_data(out, in_buf, in_len))
+		return -1;
+
+	return bytes;
 }
 
 static uint32_t out_get_sample_rate(const struct audio_stream *stream)
-- 
1.8.5.4

