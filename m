Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 02/12] android/hal-audio-hsp: Add open_output_stream()
Date: Thu,  8 May 2014 11:01:33 +0300
Message-Id: <1399536103-19052-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function adds audio_open_output_stream() and sets dummy callbacks.
---
 android/hal-sco.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 3 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index c7ba504..bc7d987 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -25,22 +25,195 @@
 
 #include "hal-log.h"
 
+#define AUDIO_STREAM_DEFAULT_RATE	44100
+#define AUDIO_STREAM_DEFAULT_FORMAT	AUDIO_FORMAT_PCM_16_BIT
+
+#define OUT_BUFFER_SIZE			2560
+
+struct hsp_audio_config {
+	uint32_t rate;
+	uint32_t channels;
+	audio_format_t format;
+};
+
+struct hsp_stream_out {
+	struct audio_stream_out stream;
+	struct hsp_audio_config cfg;
+};
+
 struct hsp_audio_dev {
 	struct audio_hw_device dev;
-	struct a2dp_stream_out *out;
+	struct hsp_stream_out *out;
 };
 
+/* Audio stream functions */
+
+static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
+								size_t bytes)
+{
+	/* write data */
+
+	return bytes;
+}
+
+static uint32_t out_get_sample_rate(const struct audio_stream *stream)
+{
+	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
+
+	DBG("rate %u", out->cfg.rate);
+
+	return out->cfg.rate;
+}
+
+static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
+{
+	DBG("rate %u", rate);
+
+	return 0;
+}
+
+static size_t out_get_buffer_size(const struct audio_stream *stream)
+{
+	DBG("buf size %u", OUT_BUFFER_SIZE);
+
+	return OUT_BUFFER_SIZE;
+}
+
+static uint32_t out_get_channels(const struct audio_stream *stream)
+{
+	DBG("");
+
+	/* AudioFlinger can only provide stereo stream, so we return it here and
+	 * later we'll downmix this to mono in case codec requires it
+	 */
+	return AUDIO_CHANNEL_OUT_STEREO;
+}
+
+static audio_format_t out_get_format(const struct audio_stream *stream)
+{
+	struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
+
+	DBG("");
+
+	return out->cfg.format;
+}
+
+static int out_set_format(struct audio_stream *stream, audio_format_t format)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int out_standby(struct audio_stream *stream)
+{
+	DBG("");
+
+	return 0;
+}
+
+static int out_dump(const struct audio_stream *stream, int fd)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int out_set_parameters(struct audio_stream *stream, const char *kvpairs)
+{
+	DBG("%s", kvpairs);
+
+	return 0;
+}
+
+static char *out_get_parameters(const struct audio_stream *stream,
+							const char *keys)
+{
+	DBG("");
+
+	return strdup("");
+}
+
+static uint32_t out_get_latency(const struct audio_stream_out *stream)
+{
+	DBG("");
+
+	return 0;
+}
+
+static int out_set_volume(struct audio_stream_out *stream, float left,
+								float right)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int out_get_render_position(const struct audio_stream_out *stream,
+							uint32_t *dsp_frames)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int out_add_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int out_remove_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
 static int audio_open_output_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					audio_output_flags_t flags,
 					struct audio_config *config,
 					struct audio_stream_out **stream_out)
-
 {
+	struct hsp_audio_dev *adev = (struct hsp_audio_dev *) dev;
+	struct hsp_stream_out *out;
+
 	DBG("");
 
-	return -EINVAL;
+	out = calloc(1, sizeof(struct hsp_stream_out));
+	if (!out)
+		return -ENOMEM;
+
+	out->stream.common.get_sample_rate = out_get_sample_rate;
+	out->stream.common.set_sample_rate = out_set_sample_rate;
+	out->stream.common.get_buffer_size = out_get_buffer_size;
+	out->stream.common.get_channels = out_get_channels;
+	out->stream.common.get_format = out_get_format;
+	out->stream.common.set_format = out_set_format;
+	out->stream.common.standby = out_standby;
+	out->stream.common.dump = out_dump;
+	out->stream.common.set_parameters = out_set_parameters;
+	out->stream.common.get_parameters = out_get_parameters;
+	out->stream.common.add_audio_effect = out_add_audio_effect;
+	out->stream.common.remove_audio_effect = out_remove_audio_effect;
+	out->stream.get_latency = out_get_latency;
+	out->stream.set_volume = out_set_volume;
+	out->stream.write = out_write;
+	out->stream.get_render_position = out_get_render_position;
+
+	out->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
+	out->cfg.channels = AUDIO_CHANNEL_OUT_MONO;
+	out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
+
+	*stream_out = &out->stream;
+	adev->out = out;
+
+	return 0;
 }
 
 static void audio_close_output_stream(struct audio_hw_device *dev,
-- 
1.8.3.2

