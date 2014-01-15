Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 08/10] android/hal-audio: Handle audio preset from stream
Date: Wed, 15 Jan 2014 10:59:55 +0100
Message-ID: <1389779996-9749-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of audio preset received after stream is
opened. Preset is used to initialize codec and then to set input
configuration so audio subsystem can write data in a format that
codec can handle later.
---
 android/hal-audio.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 6 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 224c3d1..640a32c 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -51,7 +51,15 @@ struct audio_input_config {
 	audio_format_t format;
 };
 
+struct codec_sbc_data {
+	a2dp_sbc_t sbc;
+};
+
 static int codec_sbc_get_presets(struct audio_preset *preset, size_t *len);
+static int codec_sbc_init(struct audio_preset *preset, void **codec_data);
+static int codec_sbc_cleanup(void *codec_data);
+static int codec_sbc_get_config(void *codec_data,
+					struct audio_input_config *config);
 
 struct audio_codec {
 	uint8_t type;
@@ -71,6 +79,10 @@ static const struct audio_codec audio_codecs[] = {
 		.type = A2DP_CODEC_SBC,
 
 		.get_presets = codec_sbc_get_presets,
+
+		.init = codec_sbc_init,
+		.cleanup = codec_sbc_cleanup,
+		.get_config = codec_sbc_get_config,
 	}
 };
 
@@ -99,6 +111,7 @@ struct a2dp_stream_out {
 
 	struct audio_endpoint *ep;
 	enum a2dp_state_t audio_state;
+	struct audio_input_config cfg;
 };
 
 struct a2dp_audio_dev {
@@ -171,6 +184,64 @@ static int codec_sbc_get_presets(struct audio_preset *preset, size_t *len)
 	return i;
 }
 
+static int codec_sbc_init(struct audio_preset *preset, void **codec_data)
+{
+	struct codec_sbc_data *sbc_data;
+
+	DBG("");
+
+	if (preset->len != sizeof(a2dp_sbc_t)) {
+		DBG("preset size mismatch");
+		return AUDIO_STATUS_FAILED;
+	}
+
+	sbc_data = calloc(sizeof(struct codec_sbc_data), 1);
+
+	memcpy(&sbc_data->sbc, preset->data, preset->len);
+
+	*codec_data = sbc_data;
+
+	return AUDIO_STATUS_SUCCESS;
+}
+
+static int codec_sbc_cleanup(void *codec_data)
+{
+	DBG("");
+
+	free(codec_data);
+
+	return AUDIO_STATUS_SUCCESS;
+}
+
+static int codec_sbc_get_config(void *codec_data,
+					struct audio_input_config *config)
+{
+	struct codec_sbc_data *sbc_data = (struct codec_sbc_data *) codec_data;
+
+	switch (sbc_data->sbc.frequency) {
+	case SBC_SAMPLING_FREQ_16000:
+		config->rate = 16000;
+		break;
+	case SBC_SAMPLING_FREQ_32000:
+		config->rate = 32000;
+		break;
+	case SBC_SAMPLING_FREQ_44100:
+		config->rate = 44100;
+		break;
+	case SBC_SAMPLING_FREQ_48000:
+		config->rate = 48000;
+		break;
+	default:
+		return AUDIO_STATUS_FAILED;
+	}
+	config->channels = sbc_data->sbc.channel_mode == SBC_CHANNEL_MODE_MONO ?
+				AUDIO_CHANNEL_OUT_MONO :
+				AUDIO_CHANNEL_OUT_STEREO;
+	config->format = AUDIO_FORMAT_PCM_16_BIT;
+
+	return AUDIO_STATUS_SUCCESS;
+}
+
 static void audio_ipc_cleanup(void)
 {
 	if (audio_sk >= 0) {
@@ -507,14 +578,25 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 static uint32_t out_get_sample_rate(const struct audio_stream *stream)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
 	DBG("");
-	return -ENOSYS;
+
+	return out->cfg.rate;
 }
 
 static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
 	DBG("");
-	return -ENOSYS;
+
+	if (rate != out->cfg.rate) {
+		DBG("cannot set sample rate to %d", rate);
+		return -1;
+	}
+
+	return 0;
 }
 
 static size_t out_get_buffer_size(const struct audio_stream *stream)
@@ -525,14 +607,20 @@ static size_t out_get_buffer_size(const struct audio_stream *stream)
 
 static uint32_t out_get_channels(const struct audio_stream *stream)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
 	DBG("");
-	return -ENOSYS;
+
+	return out->cfg.channels;
 }
 
 static audio_format_t out_get_format(const struct audio_stream *stream)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
 	DBG("");
-	return -ENOSYS;
+
+	return out->cfg.format;
 }
 
 static int out_set_format(struct audio_stream *stream, audio_format_t format)
@@ -758,6 +846,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
 	struct a2dp_stream_out *out;
 	struct audio_preset *preset;
+	const struct audio_codec *codec;
 
 	out = calloc(1, sizeof(struct a2dp_stream_out));
 	if (!out)
@@ -791,7 +880,13 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	if (!preset)
 		goto fail;
 
-	/* TODO: initialize codec using received audio_preset */
+	codec = out->ep->codec;
+
+	codec->init(preset, &out->ep->codec_data);
+	codec->get_config(out->ep->codec_data, &out->cfg);
+
+	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
+			out->cfg.channels, out->cfg.format);
 
 	free(preset);
 
@@ -818,7 +913,8 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 
 	ipc_close_stream_cmd(ep->id);
 
-	/* TODO: cleanup codec */
+	ep->codec->cleanup(ep->codec_data);
+	ep->codec_data = NULL;
 
 	free(stream);
 	a2dp_dev->out = NULL;
-- 
1.8.5.2

