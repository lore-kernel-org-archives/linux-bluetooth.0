Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] android/hal-audio: Remove DBG from SBC functions
Date: Fri, 24 Jan 2014 17:06:44 +0100
Message-ID: <1390579604-14748-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390579604-14748-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390579604-14748-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are redundant since callers will always print some information
which can be used to see what was actually called so no need to flood
output.
---
 android/hal-audio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 974bedf..8d737ad 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -266,8 +266,6 @@ static int sbc_get_presets(struct audio_preset *preset, size_t *len)
 	uint8_t *ptr = (uint8_t *) preset;
 	size_t preset_size = sizeof(*preset) + sizeof(a2dp_sbc_t);
 
-	DBG("");
-
 	count = sizeof(sbc_presets) / sizeof(sbc_presets[0]);
 
 	for (i = 0; i < count; i++) {
@@ -293,8 +291,6 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
 	a2dp_sbc_t *in = &sbc_data->sbc;
 	sbc_t *out = &sbc_data->enc;
 
-	DBG("");
-
 	sbc_init_a2dp(out, 0L, in, sizeof(*in));
 
 	out->endian = SBC_LE;
@@ -310,8 +306,6 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	size_t out_frame_len;
 	size_t num_frames;
 
-	DBG("");
-
 	if (preset->len != sizeof(a2dp_sbc_t)) {
 		error("SBC: preset size mismatch");
 		return AUDIO_STATUS_FAILED;
@@ -345,8 +339,6 @@ static int sbc_cleanup(void *codec_data)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
 
-	DBG("");
-
 	sbc_finish(&sbc_data->enc);
 	free(sbc_data->out_buf);
 	free(codec_data);
@@ -386,8 +378,6 @@ static size_t sbc_get_buffer_size(void *codec_data)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
 
-	DBG("");
-
 	return sbc_data->in_buf_size;
 }
 
@@ -395,8 +385,6 @@ static size_t sbc_get_mediapacket_duration(void *codec_data)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
 
-	DBG("");
-
 	return sbc_data->frame_duration * sbc_data->frames_per_packet;
 }
 
-- 
1.8.5.2

