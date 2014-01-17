Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 7/9] android/hal-audio: Return proper buffer size to AudioFlinger
Date: Fri, 17 Jan 2014 16:40:11 +0100
Message-ID: <1389973213-30251-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index aeb6ea4..f2cb12a 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -82,6 +82,7 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data,
 					struct audio_input_config *config);
+static size_t sbc_get_buffer_size(void *codec_data);
 static void sbc_resume(void *codec_data);
 
 struct audio_codec {
@@ -94,6 +95,7 @@ struct audio_codec {
 	int (*cleanup) (void *codec_data);
 	int (*get_config) (void *codec_data,
 					struct audio_input_config *config);
+	size_t (*get_buffer_size) (void *codec_data);
 	void (*resume) (void *codec_data);
 	ssize_t (*write_data) (void *codec_data, const void *buffer,
 				size_t bytes);
@@ -108,6 +110,7 @@ static const struct audio_codec audio_codecs[] = {
 		.init = sbc_codec_init,
 		.cleanup = sbc_cleanup,
 		.get_config = sbc_get_config,
+		.get_buffer_size = sbc_get_buffer_size,
 		.resume = sbc_resume,
 	}
 };
@@ -355,6 +358,15 @@ static int sbc_get_config(void *codec_data,
 	return AUDIO_STATUS_SUCCESS;
 }
 
+static size_t sbc_get_buffer_size(void *codec_data)
+{
+	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+
+	DBG("");
+
+	return sbc_data->in_buf_size;
+}
+
 static void sbc_resume(void *codec_data)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
@@ -728,8 +740,11 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 
 static size_t out_get_buffer_size(const struct audio_stream *stream)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
 	DBG("");
-	return 20 * 512;
+
+	return out->ep->codec->get_buffer_size(out->ep->codec_data);
 }
 
 static uint32_t out_get_channels(const struct audio_stream *stream)
-- 
1.8.5.2

