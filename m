Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/hal-audio: Remove use of shared queue code
Date: Fri, 26 Sep 2014 15:42:15 +0200
Message-Id: <1411738938-29524-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
References: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk  |  1 -
 android/Makefile.am |  3 +--
 android/hal-audio.c | 56 +++++++++++++++++++++++++++++------------------------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 30ba719..065ae1e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -347,7 +347,6 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	bluez/src/shared/queue.c \
 	bluez/android/hal-audio.c \
 	bluez/android/hal-audio-sbc.c \
 	bluez/android/hal-audio-aptx.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 0ffc196..5a8a452 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -186,8 +186,7 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/system/audio.h
 android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 					@SBC_CFLAGS@
-android_audio_a2dp_default_la_LIBADD = lib/libbluetooth-internal.la \
-					src/libshared-mainloop.la @SBC_LIBS@
+android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
 android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined -pthread -lrt
 
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 66dc46a..1bbc073 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -36,7 +36,6 @@
 #include "hal-msg.h"
 #include "hal-audio.h"
 #include "src/shared/util.h"
-#include "src/shared/queue.h"
 
 #define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
 
@@ -97,17 +96,18 @@ extern int clock_nanosleep(clockid_t clock_id, int flags,
 					struct timespec *remain);
 #endif
 
-static const audio_codec_get_t audio_codecs[] = {
-		codec_aptx,
-		codec_sbc,
+static struct {
+	const audio_codec_get_t get_codec;
+	bool loaded;
+} audio_codecs[] = {
+		{ .get_codec = codec_aptx, .loaded = false },
+		{ .get_codec = codec_sbc, .loaded = false },
 };
 
 #define NUM_CODECS (sizeof(audio_codecs) / sizeof(audio_codecs[0]))
 
 #define MAX_AUDIO_ENDPOINTS NUM_CODECS
 
-static struct queue *loaded_codecs;
-
 struct audio_endpoint {
 	uint8_t id;
 	const struct audio_codec *codec;
@@ -423,10 +423,9 @@ struct register_state {
 	bool error;
 };
 
-static void register_endpoint(void *data, void *user_data)
+static void register_endpoint(const struct audio_codec *codec,
+						struct register_state *state)
 {
-	struct audio_codec *codec = data;
-	struct register_state *state = user_data;
 	struct audio_endpoint *ep = state->ep;
 
 	/* don't even try to register more endpoints if one failed */
@@ -451,11 +450,19 @@ static void register_endpoint(void *data, void *user_data)
 static int register_endpoints(void)
 {
 	struct register_state state;
+	unsigned int i;
 
 	state.ep = &audio_endpoints[0];
 	state.error = false;
 
-	queue_foreach(loaded_codecs, register_endpoint, &state);
+	for (i = 0; i < NUM_CODECS; i++) {
+		const struct audio_codec *codec = audio_codecs[i].get_codec();
+
+		if (!audio_codecs[i].loaded)
+			continue;
+
+		register_endpoint(codec, &state);
+	}
 
 	return state.error ? AUDIO_STATUS_FAILED : AUDIO_STATUS_SUCCESS;
 }
@@ -1293,24 +1300,26 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 	return -ENOSYS;
 }
 
-static void unload_codec(void *data)
-{
-	struct audio_codec *codec = data;
-
-	if (codec->unload)
-		codec->unload();
-}
-
 static int audio_close(hw_device_t *device)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)device;
+	unsigned int i;
 
 	DBG("");
 
 	unregister_endpoints();
 
-	queue_destroy(loaded_codecs, unload_codec);
-	loaded_codecs = NULL;
+	for (i = 0; i < NUM_CODECS; i++) {
+		const struct audio_codec *codec = audio_codecs[i].get_codec();
+
+		if (!audio_codecs[i].loaded)
+			continue;
+
+		if (codec->unload)
+			codec->unload();
+
+		audio_codecs[i].loaded = false;
+	}
 
 	shutdown(listen_sk, SHUT_RDWR);
 	shutdown(audio_sk, SHUT_RDWR);
@@ -1488,16 +1497,13 @@ static int audio_open(const hw_module_t *module, const char *name,
 	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
 	a2dp_dev->dev.dump = audio_dump;
 
-	loaded_codecs = queue_new();
-
 	for (i = 0; i < NUM_CODECS; i++) {
-		audio_codec_get_t get_codec = audio_codecs[i];
-		const struct audio_codec *codec = get_codec();
+		const struct audio_codec *codec = audio_codecs[i].get_codec();
 
 		if (codec->load && !codec->load())
 			continue;
 
-		queue_push_tail(loaded_codecs, (void *) codec);
+		audio_codecs[i].loaded = true;
 	}
 
 	/*
-- 
1.9.1

