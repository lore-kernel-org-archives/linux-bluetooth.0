Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 13/14] android/hal-sco: Implement read
Date: Thu, 22 May 2014 15:06:06 +0300
Message-Id: <1400760367-24915-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add read and resampling from 8000 to 44100.
---
 android/hal-sco.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index bf3b6d4..8c40043 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -40,6 +40,7 @@
 
 #define OUT_BUFFER_SIZE			2560
 #define OUT_STREAM_FRAMES		2560
+#define IN_STREAM_FRAMES		/* 5292 */ 5120
 
 #define SOCKET_POLL_TIMEOUT_MS		500
 
@@ -81,6 +82,10 @@ struct sco_stream_in {
 	struct audio_stream_in stream;
 
 	struct sco_audio_config cfg;
+
+	struct resampler_itfe *resampler;
+	int16_t *resample_buf;
+	uint32_t resample_frame_num;
 };
 
 struct sco_dev {
@@ -907,12 +912,109 @@ static int in_set_gain(struct audio_stream_in *stream, float gain)
 	return -ENOSYS;
 }
 
+static bool read_data(struct sco_stream_in *in, char *buffer, size_t bytes)
+{
+	struct pollfd pfd;
+	size_t len, read_bytes = 0;
+
+	pfd.fd = sco_fd;
+	pfd.events = POLLIN | POLLHUP | POLLNVAL;
+
+	while (bytes > read_bytes) {
+		int ret;
+
+		/* poll for reading */
+		if (poll(&pfd, 1, SOCKET_POLL_TIMEOUT_MS) == 0) {
+			DBG("timeout fd %d", sco_fd);
+			return false;
+		}
+
+		if (pfd.revents & (POLLHUP | POLLNVAL)) {
+			error("error fd %d, events 0x%x", sco_fd, pfd.revents);
+			return false;
+		}
+
+		len = bytes - read_bytes > sco_mtu ? sco_mtu :
+							bytes - read_bytes;
+
+		ret = read(sco_fd, buffer + read_bytes, len);
+		if (ret > 0) {
+			read_bytes += ret;
+			DBG("read %d total %zd", ret, read_bytes);
+			continue;
+		}
+
+		if (errno == EAGAIN) {
+			ret = errno;
+			warn("read failed (%d)", ret);
+			continue;
+		}
+
+		if (errno != EINTR) {
+			ret = errno;
+			error("read failed (%d) fd %d bytes %zd", ret, sco_fd,
+									bytes);
+			return false;
+		}
+	}
+
+	DBG("read %zd bytes", read_bytes);
+
+	return true;
+}
+
 static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 								size_t bytes)
 {
-	DBG("");
+	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+	size_t frame_size = audio_stream_frame_size(&stream->common);
+	size_t frame_num = bytes / frame_size;
+	size_t input_frame_num = frame_num;
+	void *read_buf = buffer;
+	size_t total, read_frames;
+	int ret;
 
-	return -ENOSYS;
+	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
+
+	if (!in->resampler && in->cfg.rate != AUDIO_STREAM_SCO_RATE) {
+		error("Cannot find resampler");
+		return -1;
+	}
+
+	if (in->resampler) {
+		input_frame_num = get_resample_frame_num(AUDIO_STREAM_SCO_RATE,
+							in->cfg.rate,
+							frame_num, 0);
+		if (input_frame_num > in->resample_frame_num) {
+			DBG("resize input frames from %zd to %d",
+				input_frame_num, in->resample_frame_num);
+			input_frame_num = in->resample_frame_num;
+		}
+
+		read_buf = in->resample_buf;
+	}
+
+	total = input_frame_num * sizeof(int16_t) * 1;
+
+	if(!read_data(in, read_buf, total))
+		return -1;
+
+	read_frames = input_frame_num;
+
+	ret = in->resampler->resample_from_input(in->resampler,
+							in->resample_buf,
+							&read_frames,
+							(int16_t *) buffer,
+							&frame_num);
+	if (ret) {
+		error("Failed to resample frames: %zd input %zd (%s)",
+				frame_num, input_frame_num, strerror(ret));
+		return -1;
+	}
+
+        DBG("resampler: remain %zd output %zd frames", read_frames, frame_num);
+
+	return bytes;
 }
 
 static uint32_t in_get_input_frames_lost(struct audio_stream_in *stream)
@@ -930,6 +1032,8 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 {
 	struct sco_dev *sco_dev = (struct sco_dev *) dev;
 	struct sco_stream_in *in;
+	int chan_num, ret;
+	size_t resample_size;
 
 	DBG("");
 
@@ -967,10 +1071,48 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 		in->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
 	}
 
+	in->cfg.frame_num = IN_STREAM_FRAMES;
+
+	/* Channel numbers for resampler */
+	chan_num = 1;
+
+	ret = create_resampler(AUDIO_STREAM_SCO_RATE, in->cfg.rate, chan_num,
+						RESAMPLER_QUALITY_DEFAULT, NULL,
+						&in->resampler);
+	if (ret) {
+		error("Failed to create resampler (%s)", strerror(ret));
+		goto failed;
+	}
+
+	in->resample_frame_num = get_resample_frame_num(AUDIO_STREAM_SCO_RATE,
+							in->cfg.rate,
+							in->cfg.frame_num, 0);
+
+	resample_size = sizeof(int16_t) * chan_num * in->resample_frame_num;
+
+	in->resample_buf = malloc(resample_size);
+	if (!in->resample_buf) {
+		error("failed to allocate resample buffer for %d frames",
+							in->resample_frame_num);
+		goto failed;
+	}
+
+	DBG("Resampler: input %d output %d chan %d frames %u size %zd",
+				AUDIO_STREAM_SCO_RATE, in->cfg.rate, chan_num,
+				in->resample_frame_num, resample_size);
+
 	*stream_in = &in->stream;
 	sco_dev->in = in;
 
 	return 0;
+failed:
+	if (in->resampler)
+		release_resampler(in->resampler);
+	free(in);
+	stream_in = NULL;
+	sco_dev->in = NULL;
+
+	return ret;
 }
 
 static void sco_close_input_stream(struct audio_hw_device *dev,
@@ -983,6 +1125,9 @@ static void sco_close_input_stream(struct audio_hw_device *dev,
 
 	close_sco_socket();
 
+	if (in->resampler)
+		release_resampler(in->resampler);
+	free(in->resample_buf);
 	free(in);
 	sco_dev->in = NULL;
 }
-- 
1.8.3.2

