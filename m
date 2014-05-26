Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 24/26] android/hal-audio-aptx: Add initial support for aptX codec
Date: Mon, 26 May 2014 15:16:50 +0200
Message-ID: <1401110212-11526-25-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for aptX codec. Since this is proprietary codec
it requires to obtain license form vendor (CSR) in order to use it.
Also shared library which provices encoder implementation is required
since this implementation only wraps it into audio HAL.
---
 android/Android.mk       |   2 +
 android/Makefile.am      |   1 +
 android/hal-audio-aptx.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-audio.c      |   1 +
 android/hal-audio.h      |   1 +
 5 files changed, 201 insertions(+)
 create mode 100644 android/hal-audio-aptx.c

diff --git a/android/Android.mk b/android/Android.mk
index afd6e9c..e9a6c92 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -256,6 +256,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	bluez/android/hal-audio.c \
 	bluez/android/hal-audio-sbc.c \
+	bluez/android/hal-audio-aptx.c \
 
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
@@ -267,6 +268,7 @@ LOCAL_SHARED_LIBRARIES := \
 	libsbc \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_LDFLAGS := -ldl
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
diff --git a/android/Makefile.am b/android/Makefile.am
index 6891cbc..c26680f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -169,6 +169,7 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hal-audio.h \
 					android/hal-audio.c \
 					android/hal-audio-sbc.c \
+					android/hal-audio-aptx.c \
 					android/cutils/properties.h \
 					android/hardware/audio.h \
 					android/hardware/audio_effect.h \
diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
new file mode 100644
index 0000000..1cf8afc
--- /dev/null
+++ b/android/hal-audio-aptx.c
@@ -0,0 +1,196 @@
+/*
+ * Copyright (C) 2014 Tieto Poland
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <malloc.h>
+#include <dlfcn.h>
+
+#include <cutils/properties.h>
+
+#include "audio-msg.h"
+#include "hal-audio.h"
+#include "hal-log.h"
+#include "../src/shared/util.h"
+#include "../profiles/audio/a2dp-codecs.h"
+
+struct aptx_data {
+	a2dp_aptx_t aptx;
+
+	void *enc;
+};
+
+static const a2dp_aptx_t aptx_presets[] = {
+	{
+		.info = {
+			.vendor_id = APTX_VENDOR_ID,
+			.codec_id = APTX_CODEC_ID,
+		},
+		.frequency = APTX_SAMPLING_FREQ_44100 |
+						APTX_SAMPLING_FREQ_48000,
+		.channel_mode = APTX_CHANNEL_MODE_STEREO,
+	},
+	{
+		.info = {
+			.vendor_id = APTX_VENDOR_ID,
+			.codec_id = APTX_CODEC_ID,
+		},
+		.frequency = APTX_SAMPLING_FREQ_48000,
+		.channel_mode = APTX_CHANNEL_MODE_STEREO,
+	},
+	{
+		.info = {
+			.vendor_id = APTX_VENDOR_ID,
+			.codec_id = APTX_CODEC_ID,
+		},
+		.frequency = APTX_SAMPLING_FREQ_44100,
+		.channel_mode = APTX_CHANNEL_MODE_STEREO,
+	},
+};
+
+static bool aptx_load(void)
+{
+	/* TODO: load aptX codec library */
+	return false;
+}
+
+static void aptx_unload(void)
+{
+	/* TODO: unload aptX codec library */
+}
+
+static int aptx_get_presets(struct audio_preset *preset, size_t *len)
+{
+	int i;
+	int count;
+	size_t new_len = 0;
+	uint8_t *ptr = (uint8_t *) preset;
+	size_t preset_size = sizeof(*preset) + sizeof(a2dp_aptx_t);
+
+	DBG("");
+
+	count = sizeof(aptx_presets) / sizeof(aptx_presets[0]);
+
+	for (i = 0; i < count; i++) {
+		preset = (struct audio_preset *) ptr;
+
+		if (new_len + preset_size > *len)
+			break;
+
+		preset->len = sizeof(a2dp_aptx_t);
+		memcpy(preset->data, &aptx_presets[i], preset->len);
+
+		new_len += preset_size;
+		ptr += preset_size;
+	}
+
+	*len = new_len;
+
+	return i;
+}
+
+static bool aptx_codec_init(struct audio_preset *preset, uint16_t payload_len,
+							void **codec_data)
+{
+	struct aptx_data *aptx_data;
+
+	DBG("");
+
+	if (preset->len != sizeof(a2dp_aptx_t)) {
+		error("APTX: preset size mismatch");
+		return false;
+	}
+
+	aptx_data = new0(struct aptx_data, 1);
+	if (!aptx_data)
+		return false;
+
+	memcpy(&aptx_data->aptx, preset->data, preset->len);
+
+	/* TODO: initialize encoder */
+
+	*codec_data = aptx_data;
+
+	return true;
+}
+
+static bool aptx_cleanup(void *codec_data)
+{
+	struct aptx_data *aptx_data = (struct aptx_data *) codec_data;
+
+	free(aptx_data->enc);
+	free(codec_data);
+
+	return true;
+}
+
+static bool aptx_get_config(void *codec_data, struct audio_input_config *config)
+{
+	struct aptx_data *aptx_data = (struct aptx_data *) codec_data;
+
+	config->rate = aptx_data->aptx.frequency & APTX_SAMPLING_FREQ_48000 ?
+								48000 : 44100;
+	config->channels = AUDIO_CHANNEL_OUT_STEREO;
+	config->format = AUDIO_FORMAT_PCM_16_BIT;
+
+	return true;
+}
+
+static size_t aptx_get_buffer_size(void *codec_data)
+{
+	/* TODO: return actual value */
+	return 0;
+}
+
+static size_t aptx_get_mediapacket_duration(void *codec_data)
+{
+	/* TODO: return actual value */
+	return 0;
+}
+
+static ssize_t aptx_encode_mediapacket(void *codec_data, const uint8_t *buffer,
+					size_t len, struct media_packet *mp,
+					size_t mp_data_len, size_t *written)
+{
+	/* TODO: add encoding */
+
+	return len;
+}
+
+static const struct audio_codec codec = {
+	.type = A2DP_CODEC_VENDOR,
+	.use_rtp = false,
+
+	.load = aptx_load,
+	.unload = aptx_unload,
+
+	.get_presets = aptx_get_presets,
+
+	.init = aptx_codec_init,
+	.cleanup = aptx_cleanup,
+	.get_config = aptx_get_config,
+	.get_buffer_size = aptx_get_buffer_size,
+	.get_mediapacket_duration = aptx_get_mediapacket_duration,
+	.encode_mediapacket = aptx_encode_mediapacket,
+	.update_qos = NULL,
+};
+
+const struct audio_codec *codec_aptx(void)
+{
+	return &codec;
+}
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 1ab4b01..9f73ce4 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -102,6 +102,7 @@ static const struct audio_codec_info {
 	const struct audio_codec * (*get) (void);
 } audio_codecs[] = {
 		{ "sbc",	codec_sbc },
+		{ "aptx",	codec_aptx },
 };
 
 #define NUM_CODECS (sizeof(audio_codecs) / sizeof(audio_codecs[0]))
diff --git a/android/hal-audio.h b/android/hal-audio.h
index decbdd8..2b47412 100644
--- a/android/hal-audio.h
+++ b/android/hal-audio.h
@@ -99,3 +99,4 @@ struct audio_codec {
 typedef const struct audio_codec * (*audio_codec_get_t) (void);
 
 const struct audio_codec *codec_sbc(void);
+const struct audio_codec *codec_aptx(void);
-- 
1.9.3

