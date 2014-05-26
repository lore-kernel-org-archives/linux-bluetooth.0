Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 10/26] android/hal-audio: Add load/unload methods for codec
Date: Mon, 26 May 2014 15:16:36 +0200
Message-ID: <1401110212-11526-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds optional load/unload methods for codec which can be
used to initialize some static data for codec, e.g. load shared library
which provides encoder. Unlike init/cleanup which are called on stream
open/close these methods are called when audio device is opened/closed
thus most likely only once.
---
 android/hal-audio.c | 16 ++++++++++++++++
 android/hal-audio.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index e6015f2..416a3ad 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1334,11 +1334,19 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 static int audio_close(hw_device_t *device)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)device;
+	size_t i;
 
 	DBG("");
 
 	unregister_endpoints();
 
+	for (i = 0; i < NUM_CODECS; i++) {
+		const struct audio_codec *codec = audio_codecs[i].get();
+
+		if (codec->unload)
+			codec->unload();
+	}
+
 	shutdown(listen_sk, SHUT_RDWR);
 	shutdown(audio_sk, SHUT_RDWR);
 
@@ -1478,6 +1486,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 							hw_device_t **device)
 {
 	struct a2dp_audio_dev *a2dp_dev;
+	size_t i;
 	int err;
 
 	DBG("");
@@ -1516,6 +1525,13 @@ static int audio_open(const hw_module_t *module, const char *name,
 	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
 	a2dp_dev->dev.dump = audio_dump;
 
+	for (i = 0; i < NUM_CODECS; i++) {
+		const struct audio_codec *codec = audio_codecs[i].get();
+
+		if (codec->load)
+			codec->load();
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

