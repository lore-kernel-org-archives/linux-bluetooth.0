Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 09/28] android/hal-sco: Use global sco file descriptor
Date: Wed,  4 Jun 2014 17:17:40 +0300
Message-Id: <1401891479-11965-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android may open input/output stream independently so we use global sco
file descriptor and mutexes.
---
 android/hal-sco.c | 85 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index e905d6b..31c93b4 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -46,6 +46,10 @@
 static int listen_sk = -1;
 static int ipc_sk = -1;
 
+static int sco_fd = -1;
+static uint16_t sco_mtu = 0;
+static pthread_mutex_t sco_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 static pthread_t ipc_th = 0;
 static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
@@ -53,7 +57,6 @@ struct sco_audio_config {
 	uint32_t rate;
 	uint32_t channels;
 	uint32_t frame_num;
-	uint16_t mtu;
 	audio_format_t format;
 };
 
@@ -61,7 +64,6 @@ struct sco_stream_out {
 	struct audio_stream_out stream;
 
 	struct sco_audio_config cfg;
-	int fd;
 
 	uint8_t *downmix_buf;
 	uint8_t *cache;
@@ -79,7 +81,6 @@ struct sco_stream_in {
 	struct audio_stream_in stream;
 
 	struct sco_audio_config cfg;
-	int fd;
 };
 
 struct sco_dev {
@@ -257,18 +258,25 @@ failed:
 	return SCO_STATUS_FAILED;
 }
 
-static int ipc_connect_sco(int *fd, uint16_t *mtu)
+static int ipc_connect_sco(void)
 {
 	struct sco_rsp_connect rsp;
 	size_t rsp_len = sizeof(rsp);
-	int ret;
+	int ret = SCO_STATUS_SUCCESS;
 
 	DBG("");
 
-	ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_CONNECT, 0, NULL, &rsp_len,
-								&rsp, fd);
+	pthread_mutex_lock(&sco_mutex);
+
+	if (sco_fd < 0) {
+		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_CONNECT, 0, NULL,
+						&rsp_len, &rsp, &sco_fd);
+
+		/* Sometimes mtu returned is wrong */
+		sco_mtu = /* rsp.mtu */ 48;
+	}
 
-	*mtu = rsp.mtu;
+	pthread_mutex_unlock(&sco_mutex);
 
 	return ret;
 }
@@ -311,28 +319,27 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 	struct pollfd pfd;
 	size_t len, written = 0;
 	int ret;
-	uint16_t mtu = out->cfg.mtu;
 	uint8_t *p;
 	uint64_t audio_sent_us, audio_passed_us;
 
-	pfd.fd = out->fd;
-	pfd.events = POLLOUT | POLLIN | POLLHUP | POLLNVAL;
+	pfd.fd = sco_fd;
+	pfd.events = POLLOUT | POLLHUP | POLLNVAL;
 
 	while (bytes > written) {
 		struct timespec now;
 
 		/* poll for sending */
 		if (poll(&pfd, 1, SOCKET_POLL_TIMEOUT_MS) == 0) {
-			DBG("timeout fd %d", out->fd);
+			DBG("timeout fd %d", sco_fd);
 			return false;
 		}
 
 		if (pfd.revents & (POLLHUP | POLLNVAL)) {
-			error("error fd %d, events 0x%x", out->fd, pfd.revents);
+			error("error fd %d, events 0x%x", sco_fd, pfd.revents);
 			return false;
 		}
 
-		len = bytes - written > mtu ? mtu : bytes - written;
+		len = bytes - written > sco_mtu ? sco_mtu : bytes - written;
 
 		clock_gettime(CLOCK_REALTIME, &now);
 		/* Mark start of the stream */
@@ -357,11 +364,11 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 		if (out->cache_len) {
 			DBG("First packet cache_len %zd", out->cache_len);
 			memcpy(out->cache + out->cache_len, buffer,
-							mtu - out->cache_len);
+						sco_mtu - out->cache_len);
 			p = out->cache;
 		}
 
-		if (bytes - written >= mtu)
+		if (bytes - written >= sco_mtu)
 			p = (void *) buffer + written;
 		else {
 			memcpy(out->cache, buffer + written, bytes - written);
@@ -371,10 +378,10 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 			continue;
 		}
 
-		ret = write(out->fd, p, len);
+		ret = write(sco_fd, p, len);
 		if (ret > 0) {
 			if (out->cache_len) {
-				written = mtu - out->cache_len;
+				written = sco_mtu - out->cache_len;
 				out->cache_len = 0;
 			} else
 				written += ret;
@@ -394,7 +401,7 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 
 		if (errno != EINTR) {
 			ret = errno;
-			error("write failed (%d) fd %d bytes %zd", ret, out->fd,
+			error("write failed (%d) fd %d bytes %zd", ret, sco_fd,
 									bytes);
 			return false;
 		}
@@ -414,7 +421,7 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 	void *send_buf = out->downmix_buf;
 	size_t total;
 
-	DBG("write to fd %d bytes %zu", out->fd, bytes);
+	DBG("write to fd %d bytes %zu", sco_fd, bytes);
 
 	if (!out->downmix_buf) {
 		error("sco: downmix buffer not initialized");
@@ -585,19 +592,17 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 {
 	struct sco_dev *adev = (struct sco_dev *) dev;
 	struct sco_stream_out *out;
-	int fd = -1;
 	int chan_num, ret;
 	size_t resample_size;
-	uint16_t mtu;
 
 	DBG("config %p device flags 0x%02x", config, devices);
 
-	if (ipc_connect_sco(&fd, &mtu) != SCO_STATUS_SUCCESS) {
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS) {
 		error("sco: cannot get fd");
 		return -EIO;
 	}
 
-	DBG("got sco fd %d mtu %u", fd, mtu);
+	DBG("got sco fd %d mtu %u", sco_fd, sco_mtu);
 
 	out = calloc(1, sizeof(struct sco_stream_out));
 	if (!out)
@@ -636,16 +641,13 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 
 	out->cfg.frame_num = OUT_STREAM_FRAMES;
 
-	/* we get wrong mtu size for some reason */
-	out->cfg.mtu = /* mtu */ 48;
-
 	out->downmix_buf = malloc(out_get_buffer_size(&out->stream.common));
 	if (!out->downmix_buf) {
 		free(out);
 		return -ENOMEM;
 	}
 
-	out->cache = malloc(out->cfg.mtu);
+	out->cache = malloc(sco_mtu);
 	if (!out->cache) {
 		free(out->downmix_buf);
 		free(out);
@@ -691,7 +693,6 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 
 	*stream_out = &out->stream;
 	adev->out = out;
-	out->fd = fd;
 
 	return 0;
 failed:
@@ -707,18 +708,30 @@ failed:
 	return ret;
 }
 
+static void close_sco_socket(void)
+{
+	DBG("");
+
+	pthread_mutex_lock(&sco_mutex);
+
+	if (sco_fd >= 0) {
+		shutdown(sco_fd, SHUT_RDWR);
+		close(sco_fd);
+		sco_fd = -1;
+	}
+
+	pthread_mutex_unlock(&sco_mutex);
+}
+
 static void sco_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream_out)
 {
 	struct sco_dev *sco_dev = (struct sco_dev *) dev;
 	struct sco_stream_out *out = (struct sco_stream_out *) stream_out;
 
-	DBG("dev %p stream %p fd %d", dev, out, sco_dev->out->fd);
+	DBG("dev %p stream %p fd %d", dev, out, sco_fd);
 
-	if (out && out->fd >= 0) {
-		close(out->fd);
-		out->fd = -1;
-	}
+	close_sco_socket();
 
 	if (out->resampler)
 		release_resampler(out->resampler);
@@ -971,7 +984,9 @@ static void sco_close_input_stream(struct audio_hw_device *dev,
 	struct sco_dev *sco_dev = (struct sco_dev *) dev;
 	struct sco_stream_in *in = (struct sco_stream_in *) stream_in;
 
-	DBG("dev %p stream %p fd %d", dev, in, in->fd);
+	DBG("dev %p stream %p fd %d", dev, in, sco_fd);
+
+	close_sco_socket();
 
 	free(in);
 	sco_dev->in = NULL;
-- 
1.8.3.2

