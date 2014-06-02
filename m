Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/5] android/hal-audio: Allow codec to init on startup
Date: Mon, 2 Jun 2014 13:20:08 +0200
Message-ID: <1401708011-12828-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds optional load/unload methods for codec which can be
used to initialize some static data for codec, e.g. load shared library
which provides encoder. Unlike init/cleanup which are called on stream
open/close these methods are called when audio device is opened/closed
thus most likely only once.

Additional optional 'available' method is provided which is used by HAL
core to check whether given codec is initialized properly and can have
endpoint registered, i.e. codec may only be available if there's .so
with encoder available on filesystem.
---
 android/hal-audio.c | 28 +++++++++++++++++++++++++++-
 android/hal-audio.h |  4 ++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index f15e767..3c62686 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -421,11 +421,19 @@ static int register_endpoints(void)
 	size_t i;
 
 	for (i = 0; i < NUM_CODECS; i++, ep++) {
-		const struct audio_codec *codec = audio_codecs[i]();
+		audio_codec_get_t get_codec = audio_codecs[i];
+		const struct audio_codec *codec = get_codec();
 
 		if (!codec)
 			return AUDIO_STATUS_FAILED;
 
+		/*
+		 * Skip codecs which are unavailable, i.e. were not loaded due
+		 * to missing .so
+		 */
+		if (codec->available && !codec->available())
+			continue;
+
 		ep->id = ipc_open_cmd(codec);
 
 		if (!ep->id)
@@ -1275,11 +1283,20 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 static int audio_close(hw_device_t *device)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)device;
+	size_t i;
 
 	DBG("");
 
 	unregister_endpoints();
 
+	for (i = 0; i < NUM_CODECS; i++) {
+		audio_codec_get_t get_codec = audio_codecs[i];
+		const struct audio_codec *codec = get_codec();
+
+		if (codec->unload)
+			codec->unload();
+	}
+
 	shutdown(listen_sk, SHUT_RDWR);
 	shutdown(audio_sk, SHUT_RDWR);
 
@@ -1419,6 +1436,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 							hw_device_t **device)
 {
 	struct a2dp_audio_dev *a2dp_dev;
+	size_t i;
 	int err;
 
 	DBG("");
@@ -1457,6 +1475,14 @@ static int audio_open(const hw_module_t *module, const char *name,
 	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
 	a2dp_dev->dev.dump = audio_dump;
 
+	for (i = 0; i < NUM_CODECS; i++) {
+		audio_codec_get_t get_codec = audio_codecs[i];
+		const struct audio_codec *codec = get_codec();
+
+		if (codec->load)
+			codec->load();
+	}
+
 	/*
 	 * Note that &a2dp_dev->dev.common is the same pointer as a2dp_dev.
 	 * This results from the structure of following structs:a2dp_audio_dev,
diff --git a/android/hal-audio.h b/android/hal-audio.h
index be71473..a47a7ea 100644
--- a/android/hal-audio.h
+++ b/android/hal-audio.h
@@ -75,6 +75,10 @@ struct audio_codec {
 	uint8_t type;
 	bool use_rtp;
 
+	bool (*load) (void);
+	void (*unload) (void);
+	bool (*available) (void);
+
 	int (*get_presets) (struct audio_preset *preset, size_t *len);
 
 	bool (*init) (struct audio_preset *preset, uint16_t mtu,
-- 
1.9.3

