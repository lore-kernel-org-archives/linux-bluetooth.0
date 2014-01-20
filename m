Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 6/9] android/hal-audio: Add resume to codec callbacks
Date: Mon, 20 Jan 2014 15:59:00 +0100
Message-ID: <1390229943-29609-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Once stream is resumed it may be required to reset some state of codec,
i.e. in case of SBC we need to reset monotonic clock and frames count
which are used for synchronization.
---
 android/hal-audio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 22dff53..adceab8 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -124,6 +124,9 @@ struct sbc_data {
 	uint8_t *out_buf;
 
 	unsigned frame_duration;
+
+	struct timespec start;
+	unsigned frames_sent;
 };
 
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
@@ -132,6 +135,7 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data,
 					struct audio_input_config *config);
+static void sbc_resume(void *codec_data);
 
 struct audio_codec {
 	uint8_t type;
@@ -143,6 +147,7 @@ struct audio_codec {
 	int (*cleanup) (void *codec_data);
 	int (*get_config) (void *codec_data,
 					struct audio_input_config *config);
+	void (*resume) (void *codec_data);
 	ssize_t (*write_data) (void *codec_data, const void *buffer,
 				size_t bytes);
 };
@@ -156,6 +161,7 @@ static const struct audio_codec audio_codecs[] = {
 		.init = sbc_codec_init,
 		.cleanup = sbc_cleanup,
 		.get_config = sbc_get_config,
+		.resume = sbc_resume,
 	}
 };
 
@@ -351,6 +357,17 @@ static int sbc_get_config(void *codec_data,
 	return AUDIO_STATUS_SUCCESS;
 }
 
+static void sbc_resume(void *codec_data)
+{
+	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+
+	DBG("");
+
+	clock_gettime(CLOCK_MONOTONIC, &sbc_data->start);
+
+	sbc_data->frames_sent = 0;
+}
+
 static void audio_ipc_cleanup(void)
 {
 	if (audio_sk >= 0) {
@@ -673,6 +690,8 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 		if (ipc_resume_stream_cmd(out->ep->id) != AUDIO_STATUS_SUCCESS)
 			return -1;
 
+		out->ep->codec->resume(out->ep->codec_data);
+
 		out->audio_state = AUDIO_A2DP_STATE_STARTED;
 	}
 
-- 
1.8.5.2

