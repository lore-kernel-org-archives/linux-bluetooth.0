Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 4/9] android/hal-audio: Initialize SBC encoder
Date: Mon, 20 Jan 2014 15:58:58 +0100
Message-ID: <1390229943-29609-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index f53dba0..8e932ef 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -32,6 +32,7 @@
 #include "hal-log.h"
 #include "hal-msg.h"
 #include "../profiles/audio/a2dp-codecs.h"
+#include <sbc/sbc.h>
 
 static const uint8_t a2dp_src_uuid[] = {
 		0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
@@ -53,6 +54,8 @@ struct audio_input_config {
 
 struct sbc_data {
 	a2dp_sbc_t sbc;
+
+	sbc_t enc;
 };
 
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
@@ -184,6 +187,19 @@ static int sbc_get_presets(struct audio_preset *preset, size_t *len)
 	return i;
 }
 
+static void sbc_init_encoder(struct sbc_data *sbc_data)
+{
+	a2dp_sbc_t *in = &sbc_data->sbc;
+	sbc_t *out = &sbc_data->enc;
+
+	DBG("");
+
+	sbc_init_a2dp(out, 0L, in);
+
+	out->endian = SBC_LE;
+	out->bitpool = in->max_bitpool;
+}
+
 static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
 {
 	struct sbc_data *sbc_data;
@@ -199,6 +215,8 @@ static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
 
 	memcpy(&sbc_data->sbc, preset->data, preset->len);
 
+	sbc_init_encoder(sbc_data);
+
 	*codec_data = sbc_data;
 
 	return AUDIO_STATUS_SUCCESS;
@@ -206,8 +224,11 @@ static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
 
 static int sbc_cleanup(void *codec_data)
 {
+	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
+
 	DBG("");
 
+	sbc_finish(&sbc_data->enc);
 	free(codec_data);
 
 	return AUDIO_STATUS_SUCCESS;
-- 
1.8.5.2

