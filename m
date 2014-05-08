Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/12] android/audio: Add downmix support to audio SCO HAL
Date: Thu,  8 May 2014 11:01:41 +0300
Message-Id: <1399536103-19052-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 669389c..d55d34d 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -28,6 +28,7 @@
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
 
+#include "../src/shared/util.h"
 #include "sco-msg.h"
 #include "ipc-common.h"
 #include "hal-log.h"
@@ -36,6 +37,7 @@
 #define AUDIO_STREAM_DEFAULT_FORMAT	AUDIO_FORMAT_PCM_16_BIT
 
 #define OUT_BUFFER_SIZE			2560
+#define OUT_STREAM_FRAMES		2560
 
 static int listen_sk = -1;
 static int audio_sk = -1;
@@ -46,6 +48,7 @@ static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 struct hsp_audio_config {
 	uint32_t rate;
 	uint32_t channels;
+	uint32_t frame_num;
 	uint16_t mtu;
 	audio_format_t format;
 };
@@ -55,6 +58,8 @@ struct hsp_stream_out {
 
 	struct hsp_audio_config cfg;
 	int fd;
+
+	uint8_t *downmix_buf;
 };
 
 struct hsp_audio_dev {
@@ -233,15 +238,35 @@ static int ipc_connect_sco(int *fd, uint16_t *mtu)
 
 /* Audio stream functions */
 
+static void downmix_to_mono(struct hsp_stream_out *out, const uint8_t *buffer,
+							size_t frame_num)
+{
+	const int16_t *input = (const void *) buffer;
+	int16_t *output = (void *) out->downmix_buf;
+	size_t i;
+
+	for (i = 0; i < frame_num; i++) {
+		int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
+		int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));
+
+		put_unaligned(cpu_to_le16((l + r) >> 1), &output[i]);
+	}
+}
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
 	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
-
-	/* write data */
+	size_t frame_num = bytes / audio_stream_frame_size(&out->stream.common);
 
 	DBG("write to fd %d bytes %zu", out->fd, bytes);
 
+	if (!out->downmix_buf) {
+		error("audio: downmix buffer not initialized");
+		return -1;
+	}
+
+	downmix_to_mono(out, buffer, frame_num);
 	return bytes;
 }
 
@@ -263,9 +288,13 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 
 static size_t out_get_buffer_size(const struct audio_stream *stream)
 {
-	DBG("buf size %u", OUT_BUFFER_SIZE);
+	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
+	size_t size = audio_stream_frame_size(&out->stream.common) *
+							out->cfg.frame_num;
+
+	DBG("buf size %zd", size);
 
-	return OUT_BUFFER_SIZE;
+	return size;
 }
 
 static uint32_t out_get_channels(const struct audio_stream *stream)
@@ -407,8 +436,16 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	out->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
 	out->cfg.channels = AUDIO_CHANNEL_OUT_MONO;
 	out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
+	out->cfg.frame_num = OUT_STREAM_FRAMES;
 	out->cfg.mtu = mtu;
 
+	out->downmix_buf = malloc(out_get_buffer_size(&out->stream.common));
+	if (!out->downmix_buf) {
+		free(out);
+		return -ENOMEM;
+	}
+
+	DBG("size %zd", out_get_buffer_size(&out->stream.common));
 	*stream_out = &out->stream;
 	adev->out = out;
 	out->fd = fd;
@@ -420,6 +457,7 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream_out)
 {
 	struct hsp_audio_dev *hsp_dev = (struct hsp_audio_dev *) dev;
+	struct hsp_stream_out *out = (struct hsp_stream_out *) stream_out;
 
 	DBG("dev %p stream %p fd %d", dev, stream_out, hsp_dev->out->fd);
 
@@ -428,7 +466,8 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 		hsp_dev->out->fd = -1;
 	}
 
-	free(stream_out);
+	free(out->downmix_buf);
+	free(out);
 	hsp_dev->out = NULL;
 }
 
-- 
1.8.3.2

