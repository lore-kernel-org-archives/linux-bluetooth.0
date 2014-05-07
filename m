Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/10] android/audio: Use resampler interface to resample SCO
Date: Wed,  7 May 2014 11:45:25 +0300
Message-Id: <1399452326-25009-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399452326-25009-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399452326-25009-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Resample Android audio from 44100 to 8000.
---
 android/hal-audio-hsp.c | 112 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio-hsp.c b/android/hal-audio-hsp.c
index 5497003..7fe9ece 100644
--- a/android/hal-audio-hsp.c
+++ b/android/hal-audio-hsp.c
@@ -27,6 +27,7 @@
 
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
+#include <audio_utils/resampler.h>
 
 #include "../src/shared/util.h"
 
@@ -35,6 +36,7 @@
 #include "hal-log.h"
 
 #define AUDIO_STREAM_DEFAULT_RATE	44100
+#define AUDIO_STREAM_SCO_RATE		8000
 #define AUDIO_STREAM_DEFAULT_FORMAT	AUDIO_FORMAT_PCM_16_BIT
 
 #define OUT_BUFFER_SIZE			2560
@@ -61,6 +63,10 @@ struct hsp_stream_out {
 	int fd;
 
 	uint8_t *downmix_buf;
+
+	struct resampler_itfe *resampler;
+	int16_t *resample_buf;
+	uint32_t resample_frame_num;
 };
 
 struct hsp_audio_dev {
@@ -68,6 +74,22 @@ struct hsp_audio_dev {
 	struct hsp_stream_out *out;
 };
 
+/*
+ * return the minimum frame numbers from resampling between BT stack's rate
+ * and audio flinger's. For output stream, 'output' shall be true, otherwise
+ * false for input streams at audio flinger side.
+ */
+static size_t get_resample_frame_num(uint32_t sco_rate, uint32_t rate,
+						size_t frame_num, bool output)
+{
+	size_t resample_frames_num = frame_num * sco_rate / rate + output;
+
+	DBG("resampler: sco_rate %d frame_num %zd rate %d resample frames %zd",
+				sco_rate, frame_num, rate, resample_frames_num);
+
+	return resample_frames_num;
+}
+
 /* Audio IPC functions */
 
 static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
@@ -259,6 +281,9 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 {
 	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
 	size_t frame_num = bytes / audio_stream_frame_size(&out->stream.common);
+	size_t output_frame_num = frame_num;
+	void *send_buf = out->downmix_buf;
+	size_t total;
 
 	DBG("write to fd %d bytes %zu", out->fd, bytes);
 
@@ -268,6 +293,34 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 	}
 
 	downmix_to_mono(out, buffer, frame_num);
+
+	if (out->resampler) {
+		int ret;
+
+		/* limit resampler's output within what resample buf can hold */
+		output_frame_num = out->resample_frame_num;
+
+		ret = out->resampler->resample_from_input(out->resampler,
+								send_buf,
+								&frame_num,
+								out->resample_buf,
+								&output_frame_num);
+		if (ret) {
+			error("Failed to resample frames: %zd input %zd (%s)",
+				frame_num, output_frame_num, strerror(ret));
+			return -1;
+		}
+
+		send_buf = out->resample_buf;
+
+		DBG("Resampled: frame_num %zd, output_frame_num %zd", 
+						frame_num, output_frame_num);
+	}
+
+	total = output_frame_num * sizeof(int16_t) * 1;
+
+	DBG("total %zd", total);
+
 	return bytes;
 }
 
@@ -300,19 +353,18 @@ static size_t out_get_buffer_size(const struct audio_stream *stream)
 
 static uint32_t out_get_channels(const struct audio_stream *stream)
 {
-	DBG("");
+	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
 
-	/* AudioFlinger can only provide stereo stream, so we return it here and
-	 * later we'll downmix this to mono in case codec requires it
-	 */
-	return AUDIO_CHANNEL_OUT_STEREO;
+	DBG("channels num: %u", popcount(out->cfg.channels));
+
+	return out->cfg.channels;
 }
 
 static audio_format_t out_get_format(const struct audio_stream *stream)
 {
 	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
 
-	DBG("");
+	DBG("format: %u", out->cfg.format);
 
 	return out->cfg.format;
 }
@@ -402,6 +454,8 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	struct hsp_audio_dev *adev = (struct hsp_audio_dev *) dev;
 	struct hsp_stream_out *out;
 	int fd = -1;
+	int chan_num, ret;
+	size_t resample_size;
 	uint16_t mtu;
 
 	DBG("");
@@ -434,8 +488,9 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	out->stream.write = out_write;
 	out->stream.get_render_position = out_get_render_position;
 
+	/* Configuration for Android */
 	out->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
-	out->cfg.channels = AUDIO_CHANNEL_OUT_MONO;
+	out->cfg.channels = AUDIO_CHANNEL_OUT_STEREO;
 	out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
 	out->cfg.frame_num = OUT_STREAM_FRAMES;
 	out->cfg.mtu = mtu;
@@ -447,11 +502,54 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	}
 
 	DBG("size %zd", out_get_buffer_size(&out->stream.common));
+
+	/* Channel numbers for resampler */
+	chan_num = 1;
+
+	ret = create_resampler(out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num,
+						RESAMPLER_QUALITY_DEFAULT, NULL,
+						&out->resampler);
+	if (ret) {
+		error("Failed to create resampler (%s)", strerror(ret));
+		goto failed;
+	}
+
+	DBG("Created resampler: input rate [%d] output rate [%d] channels [%d]",
+				out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num);
+
+	out->resample_frame_num = get_resample_frame_num(AUDIO_STREAM_SCO_RATE,
+							out->cfg.rate,
+							out->cfg.frame_num, 1);
+
+	if (!out->resample_frame_num) {
+		error("frame num is too small to resample, discard it");
+		goto failed;
+	}
+
+	resample_size = sizeof(int16_t) * chan_num * out->resample_frame_num;
+
+	out->resample_buf = malloc(resample_size);
+	if (!out->resample_buf) {
+		error("failed to allocate resample buffer for %u frames",
+						out->resample_frame_num);
+		goto failed;
+	}
+
+	DBG("resampler: frame num %u buf size %zd bytes", 
+					out->resample_frame_num, resample_size);
+
 	*stream_out = &out->stream;
 	adev->out = out;
 	out->fd = fd;
 
 	return 0;
+failed:
+	free(out->downmix_buf);
+	free(out);
+	stream_out = NULL;
+	adev->out = NULL;
+
+	return ret;
 }
 
 static void audio_close_output_stream(struct audio_hw_device *dev,
-- 
1.8.3.2

