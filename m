Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3] android/hal-audio: Add simple downmix to mono
Date: Tue, 4 Feb 2014 14:38:45 +0100
Message-ID: <1391521125-2465-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds simple downmix support from stereo to mono in order to
support mono channel mode as it's mandatory for SBC codec. It uses
simple (L+R)/2 calculation which should be good enough.
---
 android/hal-audio.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index efdf823..f90265b 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -36,9 +36,12 @@
 #include "hal-log.h"
 #include "hal-msg.h"
 #include "../profiles/audio/a2dp-codecs.h"
+#include "../src/shared/util.h"
 
 #define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
 
+#define FIXED_BUFFER_SIZE (20 * 512)
+
 #define MAX_FRAMES_IN_PAYLOAD 15
 
 static const uint8_t a2dp_src_uuid[] = {
@@ -220,6 +223,8 @@ struct a2dp_stream_out {
 	struct audio_endpoint *ep;
 	enum a2dp_state_t audio_state;
 	struct audio_input_config cfg;
+
+	uint8_t *downmix_buf;
 };
 
 struct a2dp_audio_dev {
@@ -230,7 +235,8 @@ struct a2dp_audio_dev {
 static const a2dp_sbc_t sbc_presets[] = {
 	{
 		.frequency = SBC_SAMPLING_FREQ_44100 | SBC_SAMPLING_FREQ_48000,
-		.channel_mode = SBC_CHANNEL_MODE_DUAL_CHANNEL |
+		.channel_mode = SBC_CHANNEL_MODE_MONO |
+				SBC_CHANNEL_MODE_DUAL_CHANNEL |
 				SBC_CHANNEL_MODE_STEREO |
 				SBC_CHANNEL_MODE_JOINT_STEREO,
 		.subbands = SBC_SUBBANDS_4 | SBC_SUBBANDS_8,
@@ -826,6 +832,21 @@ static void unregister_endpoints(void)
 	}
 }
 
+static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
+								size_t bytes)
+{
+	const int16_t *input = (const void *) buffer;
+	int16_t *output = (void *) out->downmix_buf;
+	size_t i;
+
+	for (i = 0; i < bytes / 2; i++) {
+		int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
+		int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));
+
+		put_unaligned(cpu_to_le16((l + r) / 2), &output[i]);
+	}
+}
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
@@ -853,6 +874,18 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 		return -1;
 	}
 
+	if (out->cfg.channels == AUDIO_CHANNEL_OUT_MONO) {
+		if (!out->downmix_buf) {
+			error("audio: downmix buffer not initialized");
+			return -1;
+		}
+
+		downmix_to_mono(out, buffer, bytes);
+
+		return out->ep->codec->write_data(out->ep->codec_data,
+				out->downmix_buf, bytes / 2, out->ep->fd) * 2;
+	}
+
 	return out->ep->codec->write_data(out->ep->codec_data, buffer,
 							bytes, out->ep->fd);
 }
@@ -890,16 +923,18 @@ static size_t out_get_buffer_size(const struct audio_stream *stream)
 	 * use magic value here and out_write code takes care of splitting
 	 * input buffer into multiple media packets.
 	 */
-	return 20 * 512;
+	return FIXED_BUFFER_SIZE;
 }
 
 static uint32_t out_get_channels(const struct audio_stream *stream)
 {
-	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
-
 	DBG("");
 
-	return out->cfg.channels;
+	/* AudioFlinger can only provide stereo stream, so we return it here and
+	 * later we'll downmix this to mono in case codec requires it
+	 */
+
+	return AUDIO_CHANNEL_OUT_STEREO;
 }
 
 static audio_format_t out_get_format(const struct audio_stream *stream)
@@ -1212,6 +1247,12 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 
 	free(preset);
 
+	if (out->cfg.channels == AUDIO_CHANNEL_OUT_MONO) {
+		out->downmix_buf = malloc(FIXED_BUFFER_SIZE / 2);
+		if (!out->downmix_buf)
+			goto fail;
+	}
+
 	*stream_out = &out->stream;
 	a2dp_dev->out = out;
 
@@ -1230,6 +1271,7 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
 	struct audio_endpoint *ep = a2dp_dev->out->ep;
 
 	DBG("");
@@ -1243,6 +1285,8 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 	ep->codec->cleanup(ep->codec_data);
 	ep->codec_data = NULL;
 
+	free(out->downmix_buf);
+
 	free(stream);
 	a2dp_dev->out = NULL;
 }
-- 
1.8.5.3

