Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 05/21] android/hal-sco: Implement open input stream
Date: Fri, 18 Jul 2014 12:48:04 +0300
Message-Id: <1405676900-17703-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index e476f84..905d6fc 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -75,9 +75,17 @@ struct sco_stream_out {
 	uint32_t resample_frame_num;
 };
 
+struct sco_stream_in {
+	struct audio_stream_in stream;
+
+	struct sco_audio_config cfg;
+	int fd;
+};
+
 struct sco_dev {
 	struct audio_hw_device dev;
 	struct sco_stream_out *out;
+	struct sco_stream_in *in;
 };
 
 /*
@@ -789,23 +797,186 @@ static size_t sco_get_input_buffer_size(const struct audio_hw_device *dev,
 	return -ENOSYS;
 }
 
+static uint32_t in_get_sample_rate(const struct audio_stream *stream)
+{
+	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+
+	DBG("rate %u", in->cfg.rate);
+
+	return in->cfg.rate;
+}
+
+static int in_set_sample_rate(struct audio_stream *stream, uint32_t rate)
+{
+	DBG("rate %u", rate);
+
+	return 0;
+}
+
+static size_t in_get_buffer_size(const struct audio_stream *stream)
+{
+	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+	size_t size = audio_stream_frame_size(&in->stream.common) *
+							in->cfg.frame_num;
+
+	DBG("buf size %zd", size);
+
+	return size;
+}
+
+static uint32_t in_get_channels(const struct audio_stream *stream)
+{
+	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+
+	DBG("channels num: %u", popcount(in->cfg.channels));
+
+	return in->cfg.channels;
+}
+
+static audio_format_t in_get_format(const struct audio_stream *stream)
+{
+	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+
+	DBG("format: %u", in->cfg.format);
+
+	return in->cfg.format;
+}
+
+static int in_set_format(struct audio_stream *stream, audio_format_t format)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int in_standby(struct audio_stream *stream)
+{
+	DBG("");
+
+	return 0;
+}
+
+static int in_dump(const struct audio_stream *stream, int fd)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int in_set_parameters(struct audio_stream *stream, const char *kvpairs)
+{
+	DBG("%s", kvpairs);
+
+	return 0;
+}
+
+static char *in_get_parameters(const struct audio_stream *stream,
+							const char *keys)
+{
+	DBG("");
+
+	return strdup("");
+}
+
+static int in_add_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int in_remove_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static int in_set_gain(struct audio_stream_in *stream, float gain)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
+								size_t bytes)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
+static uint32_t in_get_input_frames_lost(struct audio_stream_in *stream)
+{
+	DBG("");
+
+	return -ENOSYS;
+}
+
 static int sco_open_input_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					struct audio_config *config,
 					struct audio_stream_in **stream_in)
 {
+	struct sco_dev *sco_dev = (struct sco_dev *) dev;
+	struct sco_stream_in *in;
+
 	DBG("");
 
+	in = calloc(1, sizeof(struct sco_stream_in));
+	if (!in)
+		return -ENOMEM;
+
+	in->stream.common.get_sample_rate = in_get_sample_rate;
+	in->stream.common.set_sample_rate = in_set_sample_rate;
+	in->stream.common.get_buffer_size = in_get_buffer_size;
+	in->stream.common.get_channels = in_get_channels;
+	in->stream.common.get_format = in_get_format;
+	in->stream.common.set_format = in_set_format;
+	in->stream.common.standby = in_standby;
+	in->stream.common.dump = in_dump;
+	in->stream.common.set_parameters = in_set_parameters;
+	in->stream.common.get_parameters = in_get_parameters;
+	in->stream.common.add_audio_effect = in_add_audio_effect;
+	in->stream.common.remove_audio_effect = in_remove_audio_effect;
+	in->stream.set_gain = in_set_gain;
+	in->stream.read = in_read;
+	in->stream.get_input_frames_lost = in_get_input_frames_lost;
+
+	if (config) {
+		DBG("config: rate %u chan mask %x format %d offload %p",
+				config->sample_rate, config->channel_mask,
+				config->format, &config->offload_info);
+
+		in->cfg.format = config->format;
+		in->cfg.channels = config->channel_mask;
+		in->cfg.rate = config->sample_rate;
+	} else {
+		in->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
+		in->cfg.channels = AUDIO_CHANNEL_OUT_MONO;
+		in->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
+	}
+
+	*stream_in = &in->stream;
+	sco_dev->in = in;
+
 	return 0;
 }
 
 static void sco_close_input_stream(struct audio_hw_device *dev,
 					struct audio_stream_in *stream_in)
 {
-	DBG("");
+	struct sco_dev *sco_dev = (struct sco_dev *) dev;
+	struct sco_stream_in *in = (struct sco_stream_in *) stream_in;
+
+	DBG("dev %p stream %p fd %d", dev, in, in->fd);
 
-	free(stream_in);
+	free(in);
+	sco_dev->in = NULL;
 }
 
 static int sco_dump(const audio_hw_device_t *device, int fd)
-- 
1.9.1

