Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 10/10] android/hal-audio: Return proper latency for stream
Date: Wed, 22 Jan 2014 11:34:53 +0100
Message-ID: <1390386893-8212-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements get_latency() for output stream properly by
returning some meaningful value, i.e. calculated duration of single
media packet increased by fixed A2DP playback latency. This is the
same as PulseAudio does.
---
 android/hal-audio.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index ddc6348..9fe46d6 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -35,6 +35,8 @@
 #include "../profiles/audio/a2dp-codecs.h"
 #include <sbc/sbc.h>
 
+#define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
+
 static const uint8_t a2dp_src_uuid[] = {
 		0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
 		0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
@@ -125,6 +127,7 @@ struct sbc_data {
 	uint8_t *out_buf;
 
 	unsigned frame_duration;
+	unsigned frames_per_packet;
 
 	struct timespec start;
 	unsigned frames_sent;
@@ -151,6 +154,7 @@ static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data,
 					struct audio_input_config *config);
 static size_t sbc_get_buffer_size(void *codec_data);
+static size_t sbc_get_mediapacket_duration(void *codec_data);
 static void sbc_resume(void *codec_data);
 static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 					size_t bytes, int fd);
@@ -166,6 +170,7 @@ struct audio_codec {
 	int (*get_config) (void *codec_data,
 					struct audio_input_config *config);
 	size_t (*get_buffer_size) (void *codec_data);
+	size_t (*get_mediapacket_duration) (void *codec_data);
 	void (*resume) (void *codec_data);
 	ssize_t (*write_data) (void *codec_data, const void *buffer,
 				size_t bytes, int fd);
@@ -181,6 +186,7 @@ static const struct audio_codec audio_codecs[] = {
 		.cleanup = sbc_cleanup,
 		.get_config = sbc_get_config,
 		.get_buffer_size = sbc_get_buffer_size,
+		.get_mediapacket_duration = sbc_get_mediapacket_duration,
 		.resume = sbc_resume,
 		.write_data = sbc_write_data,
 	}
@@ -330,6 +336,7 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	sbc_data->out_buf = calloc(1, sbc_data->out_buf_size);
 
 	sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
+	sbc_data->frames_per_packet = num_frames;
 
 	*codec_data = sbc_data;
 
@@ -387,6 +394,15 @@ static size_t sbc_get_buffer_size(void *codec_data)
 	return sbc_data->in_buf_size;
 }
 
+static size_t sbc_get_mediapacket_duration(void *codec_data)
+{
+	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+
+	DBG("");
+
+	return sbc_data->frame_duration * sbc_data->frames_per_packet;
+}
+
 static void sbc_resume(void *codec_data)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
@@ -948,8 +964,15 @@ static char *out_get_parameters(const struct audio_stream *stream,
 
 static uint32_t out_get_latency(const struct audio_stream_out *stream)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+	struct audio_endpoint *ep = out->ep;
+	size_t pkt_duration;
+
 	DBG("");
-	return 0;
+
+	pkt_duration = ep->codec->get_mediapacket_duration(ep->codec_data);
+
+	return FIXED_A2DP_PLAYBACK_LATENCY_MS + pkt_duration / 1000;
 }
 
 static int out_set_volume(struct audio_stream_out *stream, float left,
-- 
1.8.5.2

