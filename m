Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 14/23] android/hal-sco: Add stream synchronization
Date: Thu, 17 Jul 2014 11:54:14 +0300
Message-Id: <1405587263-19867-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 82 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 05dbddb..79c13dc 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -54,6 +54,9 @@ static pthread_mutex_t sco_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_t ipc_th = 0;
 static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
+static struct sco_stream_in *sco_stream_in = NULL;
+static struct sco_stream_out *sco_stream_out = NULL;
+
 struct sco_audio_config {
 	uint32_t rate;
 	uint32_t channels;
@@ -78,6 +81,18 @@ struct sco_stream_out {
 	uint32_t resample_frame_num;
 };
 
+static void sco_close_socket(void)
+{
+	DBG("sco fd %d", sco_fd);
+
+	if (sco_fd < 0)
+		return;
+
+	shutdown(sco_fd, SHUT_RDWR);
+	close(sco_fd);
+	sco_fd = -1;
+}
+
 struct sco_stream_in {
 	struct audio_stream_in stream;
 
@@ -430,6 +445,9 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 	DBG("write to fd %d bytes %zu", sco_fd, bytes);
 
+	if (sco_fd < 0)
+		return -1;
+
 	if (!out->downmix_buf) {
 		error("sco: downmix buffer not initialized");
 		return -1;
@@ -608,17 +626,22 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 
 	DBG("config %p device flags 0x%02x", config, devices);
 
+	if (sco_stream_out) {
+		DBG("stream_out already open");
+		return -EIO;
+	}
+
 	if (ipc_connect_sco() != SCO_STATUS_SUCCESS) {
 		error("sco: cannot get fd");
 		return -EIO;
 	}
 
-	DBG("got sco fd %d mtu %u", sco_fd, sco_mtu);
-
 	out = calloc(1, sizeof(struct sco_stream_out));
 	if (!out)
 		return -ENOMEM;
 
+	DBG("stream %p sco fd %d mtu %u", out, sco_fd, sco_mtu);
+
 	out->stream.common.get_sample_rate = out_get_sample_rate;
 	out->stream.common.set_sample_rate = out_set_sample_rate;
 	out->stream.common.get_buffer_size = out_get_buffer_size;
@@ -703,6 +726,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 skip_resampler:
 	*stream_out = &out->stream;
 	adev->out = out;
+	sco_stream_out = out;
 
 	return 0;
 failed:
@@ -714,25 +738,11 @@ failed:
 	free(out);
 	stream_out = NULL;
 	adev->out = NULL;
+	sco_stream_out = NULL;
 
 	return ret;
 }
 
-static void close_sco_socket(void)
-{
-	DBG("");
-
-	pthread_mutex_lock(&sco_mutex);
-
-	if (sco_fd >= 0) {
-		shutdown(sco_fd, SHUT_RDWR);
-		close(sco_fd);
-		sco_fd = -1;
-	}
-
-	pthread_mutex_unlock(&sco_mutex);
-}
-
 static void sco_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream_out)
 {
@@ -741,8 +751,6 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 
 	DBG("dev %p stream %p fd %d", dev, out, sco_fd);
 
-	close_sco_socket();
-
 	if (out->resampler) {
 		release_resampler(out->resampler);
 		free(out->resample_buf);
@@ -752,6 +760,15 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 	free(out->downmix_buf);
 	free(out);
 	sco_dev->out = NULL;
+
+	pthread_mutex_lock(&sco_mutex);
+
+	sco_stream_out = NULL;
+
+	if (!sco_stream_in)
+		sco_close_socket();
+
+	pthread_mutex_unlock(&sco_mutex);
 }
 
 static int sco_set_parameters(struct audio_hw_device *dev,
@@ -992,6 +1009,9 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 
 	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
 
+	if (sco_fd < 0)
+		return -1;
+
 	if (!in->resampler && in->cfg.rate != AUDIO_STREAM_SCO_RATE) {
 		error("Cannot find resampler");
 		return -1;
@@ -1053,12 +1073,20 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 	int chan_num, ret;
 	size_t resample_size;
 
-	DBG("");
+	DBG("config %p device flags 0x%02x", config, devices);
+
+	if (sco_stream_in) {
+		DBG("stream_in already open");
+		ret = -EIO;
+		goto failed2;
+	}
 
 	in = calloc(1, sizeof(struct sco_stream_in));
 	if (!in)
 		return -ENOMEM;
 
+	DBG("stream %p sco fd %d mtu %u", in, sco_fd, sco_mtu);
+
 	in->stream.common.get_sample_rate = in_get_sample_rate;
 	in->stream.common.set_sample_rate = in_set_sample_rate;
 	in->stream.common.get_buffer_size = in_get_buffer_size;
@@ -1124,14 +1152,17 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 skip_resampler:
 	*stream_in = &in->stream;
 	sco_dev->in = in;
+	sco_stream_in = in;
 
 	return 0;
 failed:
 	if (in->resampler)
 		release_resampler(in->resampler);
 	free(in);
+failed2:
 	*stream_in = NULL;
 	sco_dev->in = NULL;
+	sco_stream_in = NULL;
 
 	return ret;
 }
@@ -1144,8 +1175,6 @@ static void sco_close_input_stream(struct audio_hw_device *dev,
 
 	DBG("dev %p stream %p fd %d", dev, in, sco_fd);
 
-	close_sco_socket();
-
 	if (in->resampler) {
 		release_resampler(in->resampler);
 		free(in->resample_buf);
@@ -1153,6 +1182,15 @@ static void sco_close_input_stream(struct audio_hw_device *dev,
 
 	free(in);
 	sco_dev->in = NULL;
+
+	pthread_mutex_lock(&sco_mutex);
+
+	sco_stream_in = NULL;
+
+	if (!sco_stream_out)
+		sco_close_socket();
+
+	pthread_mutex_unlock(&sco_mutex);
 }
 
 static int sco_dump(const audio_hw_device_t *device, int fd)
-- 
1.9.1

