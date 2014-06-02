Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 2/5] android/hal-audio: Allow codec to init on startup
Date: Mon, 2 Jun 2014 18:37:48 +0200
Message-ID: <1401727071-28731-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401727071-28731-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401727071-28731-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds optional load/unload methods for codec which can be
used to initialize some static data for codec, e.g. load shared library
which provides encoder. Unlike init/cleanup which are called on stream
open/close these methods are called when audio device is opened/closed
thus most likely only once.

Codecs which are loaded properly (or do not have load callback) are
added to separate queue and used later to register endpoints.
---
 android/Android.mk  |  2 ++
 android/hal-audio.c | 77 ++++++++++++++++++++++++++++++++++++++++++-----------
 android/hal-audio.h |  3 +++
 3 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index de909d6..e479bab 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -255,10 +255,12 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
+	bluez/src/shared/queue.c \
 	bluez/android/hal-audio.c \
 	bluez/android/hal-audio-sbc.c \
 
 LOCAL_C_INCLUDES = \
+	$(LOCAL_PATH)/bluez \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
 	$(call include-path-for, sbc) \
diff --git a/android/hal-audio.c b/android/hal-audio.c
index f15e767..a7cda8a 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -35,7 +35,8 @@
 #include "hal-log.h"
 #include "hal-msg.h"
 #include "hal-audio.h"
-#include "../src/shared/util.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
 
@@ -104,6 +105,8 @@ static const audio_codec_get_t audio_codecs[] = {
 
 #define MAX_AUDIO_ENDPOINTS NUM_CODECS
 
+static struct queue *loaded_codecs;
+
 struct audio_endpoint {
 	uint8_t id;
 	const struct audio_codec *codec;
@@ -415,28 +418,46 @@ static int ipc_suspend_stream_cmd(uint8_t endpoint_id)
 	return result;
 }
 
-static int register_endpoints(void)
+struct register_state {
+	struct audio_endpoint *ep;
+	bool error;
+};
+
+static void register_endpoint(void *data, void *user_data)
 {
-	struct audio_endpoint *ep = &audio_endpoints[0];
-	size_t i;
+	struct audio_codec *codec = data;
+	struct register_state *state = user_data;
+	struct audio_endpoint *ep = state->ep;
 
-	for (i = 0; i < NUM_CODECS; i++, ep++) {
-		const struct audio_codec *codec = audio_codecs[i]();
+	/* don't even try to register more endpoints if one failed */
+	if (state->error)
+		return;
 
-		if (!codec)
-			return AUDIO_STATUS_FAILED;
+	ep->id = ipc_open_cmd(codec);
 
-		ep->id = ipc_open_cmd(codec);
+	if (!ep->id) {
+		state->error = true;
+		error("Failed to register endpoint");
+		return;
+	}
 
-		if (!ep->id)
-			return AUDIO_STATUS_FAILED;
+	ep->codec = codec;
+	ep->codec_data = NULL;
+	ep->fd = -1;
 
-		ep->codec = codec;
-		ep->codec_data = NULL;
-		ep->fd = -1;
-	}
+	state->ep++;
+}
 
-	return AUDIO_STATUS_SUCCESS;
+static int register_endpoints(void)
+{
+	struct register_state state;
+
+	state.ep = &audio_endpoints[0];
+	state.error = false;
+
+	queue_foreach(loaded_codecs, register_endpoint, &state);
+
+	return state.error ? AUDIO_STATUS_FAILED : AUDIO_STATUS_SUCCESS;
 }
 
 static void unregister_endpoints(void)
@@ -1272,6 +1293,14 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 	return -ENOSYS;
 }
 
+static void unload_codec(void *data)
+{
+	struct audio_codec *codec = data;
+
+	if (codec->unload)
+		codec->unload();
+}
+
 static int audio_close(hw_device_t *device)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)device;
@@ -1280,6 +1309,9 @@ static int audio_close(hw_device_t *device)
 
 	unregister_endpoints();
 
+	queue_destroy(loaded_codecs, unload_codec);
+	loaded_codecs = NULL;
+
 	shutdown(listen_sk, SHUT_RDWR);
 	shutdown(audio_sk, SHUT_RDWR);
 
@@ -1419,6 +1451,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 							hw_device_t **device)
 {
 	struct a2dp_audio_dev *a2dp_dev;
+	size_t i;
 	int err;
 
 	DBG("");
@@ -1457,6 +1490,18 @@ static int audio_open(const hw_module_t *module, const char *name,
 	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
 	a2dp_dev->dev.dump = audio_dump;
 
+	loaded_codecs = queue_new();
+
+	for (i = 0; i < NUM_CODECS; i++) {
+		audio_codec_get_t get_codec = audio_codecs[i];
+		const struct audio_codec *codec = get_codec();
+
+		if (codec->load && !codec->load())
+			continue;
+
+		queue_push_tail(loaded_codecs, (void *) codec);
+	}
+
 	/*
 	 * Note that &a2dp_dev->dev.common is the same pointer as a2dp_dev.
 	 * This results from the structure of following structs:a2dp_audio_dev,
diff --git a/android/hal-audio.h b/android/hal-audio.h
index be71473..decbdd8 100644
--- a/android/hal-audio.h
+++ b/android/hal-audio.h
@@ -75,6 +75,9 @@ struct audio_codec {
 	uint8_t type;
 	bool use_rtp;
 
+	bool (*load) (void);
+	void (*unload) (void);
+
 	int (*get_presets) (struct audio_preset *preset, size_t *len);
 
 	bool (*init) (struct audio_preset *preset, uint16_t mtu,
-- 
1.9.3

