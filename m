Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/5] android/hal-audio: Add open/close_endpoint helpers
Date: Fri, 28 Feb 2014 19:01:16 +0100
Message-ID: <1393610480-5775-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 112 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index e1f3f0d..36e8d2e 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -914,6 +914,67 @@ static void unregister_endpoints(void)
 	}
 }
 
+static int set_blocking(int fd)
+{
+	int flags;
+
+	flags = fcntl(fd, F_GETFL, 0);
+	if (flags < 0) {
+		error("fcntl(F_GETFL): %s (%d)", strerror(errno), errno);
+		return -errno;
+	}
+
+	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		error("fcntl(F_SETFL): %s (%d)", strerror(errno), errno);
+		return -errno;
+	}
+
+	return 0;
+}
+
+static bool open_endpoint(struct audio_endpoint *ep,
+						struct audio_input_config *cfg)
+{
+	struct audio_preset *preset;
+	const struct audio_codec *codec;
+	uint16_t mtu;
+	int fd;
+
+	if (ipc_open_stream_cmd(ep->id, &mtu, &fd, &preset) !=
+							AUDIO_STATUS_SUCCESS)
+		return false;
+
+	if (!preset || fd < 0)
+		return false;
+
+	if (set_blocking(fd) < 0) {
+		free(preset);
+		return false;
+	}
+
+	ep->fd = fd;
+
+	codec = ep->codec;
+	codec->init(preset, mtu, &ep->codec_data);
+	codec->get_config(ep->codec_data, cfg);
+
+	free(preset);
+
+	return true;
+}
+
+static void close_endpoint(struct audio_endpoint *ep)
+{
+	ipc_close_stream_cmd(ep->id);
+	if (ep->fd >= 0) {
+		close(ep->fd);
+		ep->fd = -1;
+	}
+
+	ep->codec->cleanup(ep->codec_data);
+	ep->codec_data = NULL;
+}
+
 static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
 								size_t bytes)
 {
@@ -1260,24 +1321,6 @@ static int in_remove_audio_effect(const struct audio_stream *stream,
 	return -ENOSYS;
 }
 
-static int set_blocking(int fd)
-{
-	int flags;
-
-	flags = fcntl(fd, F_GETFL, 0);
-	if (flags < 0) {
-		error("fcntl(F_GETFL): %s (%d)", strerror(errno), errno);
-		return -errno;
-	}
-
-	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
-		error("fcntl(F_SETFL): %s (%d)", strerror(errno), errno);
-		return -errno;
-	}
-
-	return 0;
-}
-
 static int audio_open_output_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
@@ -1288,10 +1331,6 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
 	struct a2dp_stream_out *out;
-	struct audio_preset *preset;
-	const struct audio_codec *codec;
-	uint16_t mtu;
-	int fd;
 
 	out = calloc(1, sizeof(struct a2dp_stream_out));
 	if (!out)
@@ -1319,29 +1358,12 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	/* TODO: for now we always use endpoint 0 */
 	out->ep = &audio_endpoints[0];
 
-	if (ipc_open_stream_cmd(out->ep->id, &mtu, &fd, &preset) !=
-							AUDIO_STATUS_SUCCESS)
-		goto fail;
-
-	if (!preset || fd < 0)
-		goto fail;
-
-	if (set_blocking(fd) < 0) {
-		free(preset);
+	if (!open_endpoint(out->ep, &out->cfg))
 		goto fail;
-	}
-
-	out->ep->fd = fd;
-	codec = out->ep->codec;
-
-	codec->init(preset, mtu, &out->ep->codec_data);
-	codec->get_config(out->ep->codec_data, &out->cfg);
 
 	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
 					out->cfg.channels, out->cfg.format);
 
-	free(preset);
-
 	if (out->cfg.channels == AUDIO_CHANNEL_OUT_MONO) {
 		out->downmix_buf = malloc(FIXED_BUFFER_SIZE / 2);
 		if (!out->downmix_buf)
@@ -1367,18 +1389,10 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
 	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
-	struct audio_endpoint *ep = a2dp_dev->out->ep;
 
 	DBG("");
 
-	ipc_close_stream_cmd(ep->id);
-	if (ep->fd >= 0) {
-		close(ep->fd);
-		ep->fd = -1;
-	}
-
-	ep->codec->cleanup(ep->codec_data);
-	ep->codec_data = NULL;
+	close_endpoint(a2dp_dev->out->ep);
 
 	free(out->downmix_buf);
 
-- 
1.8.5.4

