Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <szymon.janc@tieto.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/audio: Add wrapper stuct for audio structures
Date: Wed, 8 Jan 2014 14:37:08 +0100
Message-ID: <1389188229-3977-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add wrapping struct for audio_hw_dev and audio_stream_out.
We will need this to keep some more addition info related to a2dp stream
and also hal IPC.

---
 android/hal-audio.c | 109 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 7f4a3f2..bb68648 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -25,6 +25,15 @@
 
 #include "hal-log.h"
 
+struct a2dp_stream_out {
+	struct audio_stream_out stream;
+};
+
+struct a2dp_audio_dev {
+	struct audio_hw_device dev;
+	struct a2dp_stream_out *stream_out;
+};
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
@@ -230,32 +239,37 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out **stream_out)
 
 {
-	struct audio_stream_out *out;
+	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)dev;
+	struct a2dp_stream_out *a2dp_out;
 
-	out = calloc(1, sizeof(struct audio_stream_out));
-	if (!out)
+	a2dp_out = calloc(1, sizeof(struct a2dp_stream_out));
+	if (!a2dp_out)
 		return -ENOMEM;
 
 	DBG("");
 
-	out->common.get_sample_rate = out_get_sample_rate;
-	out->common.set_sample_rate = out_set_sample_rate;
-	out->common.get_buffer_size = out_get_buffer_size;
-	out->common.get_channels = out_get_channels;
-	out->common.get_format = out_get_format;
-	out->common.set_format = out_set_format;
-	out->common.standby = out_standby;
-	out->common.dump = out_dump;
-	out->common.set_parameters = out_set_parameters;
-	out->common.get_parameters = out_get_parameters;
-	out->common.add_audio_effect = out_add_audio_effect;
-	out->common.remove_audio_effect = out_remove_audio_effect;
-	out->get_latency = out_get_latency;
-	out->set_volume = out_set_volume;
-	out->write = out_write;
-	out->get_render_position = out_get_render_position;
-
-	*stream_out = out;
+	a2dp_out->stream.common.get_sample_rate = out_get_sample_rate;
+	a2dp_out->stream.common.set_sample_rate = out_set_sample_rate;
+	a2dp_out->stream.common.get_buffer_size = out_get_buffer_size;
+	a2dp_out->stream.common.get_channels = out_get_channels;
+	a2dp_out->stream.common.get_format = out_get_format;
+	a2dp_out->stream.common.set_format = out_set_format;
+	a2dp_out->stream.common.standby = out_standby;
+	a2dp_out->stream.common.dump = out_dump;
+	a2dp_out->stream.common.set_parameters = out_set_parameters;
+	a2dp_out->stream.common.get_parameters = out_get_parameters;
+	a2dp_out->stream.common.add_audio_effect = out_add_audio_effect;
+	a2dp_out->stream.common.remove_audio_effect = out_remove_audio_effect;
+	a2dp_out->stream.get_latency = out_get_latency;
+	a2dp_out->stream.set_volume = out_set_volume;
+	a2dp_out->stream.write = out_write;
+	a2dp_out->stream.get_render_position = out_get_render_position;
+
+	/* Note that &a2dp_out->stream pointer is same as a2dp_out. This
+	 * results from the structure of a2dp_stream_out struct. We rely on it
+	 * later in the code */
+	*stream_out = &a2dp_out->stream;
+	a2dp_dev->stream_out = a2dp_out;
 
 	return 0;
 }
@@ -264,6 +278,10 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream)
 {
 	DBG("");
+	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)dev;
+
+	free(stream);
+	a2dp_dev->stream_out = NULL;
 }
 
 static int audio_set_parameters(struct audio_hw_device *dev,
@@ -381,7 +399,7 @@ static int audio_close(hw_device_t *device)
 static int audio_open(const hw_module_t *module, const char *name,
 							hw_device_t **device)
 {
-	struct audio_hw_device *audio;
+	struct a2dp_audio_dev *a2dp_dev;
 
 	DBG("");
 
@@ -391,30 +409,33 @@ static int audio_open(const hw_module_t *module, const char *name,
 		return -EINVAL;
 	}
 
-	audio = calloc(1, sizeof(struct audio_hw_device));
-	if (!audio)
+	a2dp_dev = calloc(1, sizeof(struct a2dp_audio_dev));
+	if (!a2dp_dev)
 		return -ENOMEM;
 
-	audio->common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
-	audio->common.module = (struct hw_module_t *) module;
-	audio->common.close = audio_close;
-
-	audio->init_check = audio_init_check;
-	audio->set_voice_volume = audio_set_voice_volume;
-	audio->set_master_volume = audio_set_master_volume;
-	audio->set_mode = audio_set_mode;
-	audio->set_mic_mute = audio_set_mic_mute;
-	audio->get_mic_mute = audio_get_mic_mute;
-	audio->set_parameters = audio_set_parameters;
-	audio->get_parameters = audio_get_parameters;
-	audio->get_input_buffer_size = audio_get_input_buffer_size;
-	audio->open_output_stream = audio_open_output_stream;
-	audio->close_output_stream = audio_close_output_stream;
-	audio->open_input_stream = audio_open_input_stream;
-	audio->close_input_stream = audio_close_input_stream;
-	audio->dump = audio_dump;
-
-	*device = &audio->common;
+	a2dp_dev->dev.common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
+	a2dp_dev->dev.common.module = (struct hw_module_t *) module;
+	a2dp_dev->dev.common.close = audio_close;
+
+	a2dp_dev->dev.init_check = audio_init_check;
+	a2dp_dev->dev.set_voice_volume = audio_set_voice_volume;
+	a2dp_dev->dev.set_master_volume = audio_set_master_volume;
+	a2dp_dev->dev.set_mode = audio_set_mode;
+	a2dp_dev->dev.set_mic_mute = audio_set_mic_mute;
+	a2dp_dev->dev.get_mic_mute = audio_get_mic_mute;
+	a2dp_dev->dev.set_parameters = audio_set_parameters;
+	a2dp_dev->dev.get_parameters = audio_get_parameters;
+	a2dp_dev->dev.get_input_buffer_size = audio_get_input_buffer_size;
+	a2dp_dev->dev.open_output_stream = audio_open_output_stream;
+	a2dp_dev->dev.close_output_stream = audio_close_output_stream;
+	a2dp_dev->dev.open_input_stream = audio_open_input_stream;
+	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
+	a2dp_dev->dev.dump = audio_dump;
+
+	/* Note that &a2dp_dev->dev.common is the same pointer as a2dp_dev.
+	 * This results from the structure of following structs:a2dp_audio_dev,
+	 * audio_hw_device. We will rely on this later in the code.*/
+	*device = &a2dp_dev->dev.common;
 
 	return 0;
 }
-- 
1.8.4

