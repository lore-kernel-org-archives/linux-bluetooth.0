Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 14/15] android/client-audio: Add sine generator as fallback
Date: Thu, 30 Jan 2014 12:23:20 +0100
Message-Id: <1391081001-30723-15-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When no audio file path is provided use sine generator.

---
 android/Makefile.am       |  2 +-
 android/client/if-audio.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index e065c0c..322210c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -99,7 +99,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
 
-android_haltest_LDFLAGS = -pthread -ldl
+android_haltest_LDFLAGS = -pthread -ldl -lm
 
 noinst_PROGRAMS += android/android-tester
 
diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index b481461..66f8364 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -19,6 +19,7 @@
 #include "../hal-utils.h"
 #include "pthread.h"
 #include "unistd.h"
+#include <math.h>
 
 audio_hw_device_t *if_audio = NULL;
 struct audio_stream_out *stream_out = NULL;
@@ -89,6 +90,10 @@ ENDMAP
 
 static int current_state = STATE_STOPPED;
 
+#define SAMPLERATE 44100
+static short sample[SAMPLERATE];
+static uint16_t sample_pos;
+
 static void init_p(int argc, const char **argv)
 {
 	int err;
@@ -126,6 +131,50 @@ static int feed_from_file(short *buffer, void *data)
 	return fread(buffer, buffer_size, 1, in);
 }
 
+static int feed_from_generator(short *buffer, void *data)
+{
+	size_t i = 0;
+	float volume = 0.5;
+	float *freq = data;
+	float f = 1;
+
+	if (freq)
+		f = *freq;
+
+	/* buffer_size is in bytes but we are using buffer of shorts (2 bytes)*/
+	for (i = 0; i < buffer_size / sizeof(*buffer) - 1;) {
+		if (sample_pos >= SAMPLERATE)
+			sample_pos = sample_pos % SAMPLERATE;
+
+		/* Use the same sample for both channels */
+		buffer[i++] = sample[sample_pos] * volume;
+		buffer[i++] = sample[sample_pos] * volume;
+
+		sample_pos += f;
+	}
+
+	return buffer_size;
+}
+
+static void prepare_sample(void)
+{
+	int x;
+	double s;
+
+	haltest_info("Preparing audio sample...\n");
+
+	for (x = 0; x < SAMPLERATE; x++) {
+		/* prepare sinusoidal 1Hz sample */
+		s = (2.0 * 3.14159) * ((double)x / SAMPLERATE);
+		s = sin(s);
+
+		/* remap <-1, 1> to signed 16bit PCM range */
+		sample[x] = s * 32767;
+	}
+
+	sample_pos = 0;
+}
+
 static void *playback_thread(void *data)
 {
 	int (*filbuff_cb) (short*, void*);
@@ -134,6 +183,7 @@ static void *playback_thread(void *data)
 	size_t w_len = 0;
 	FILE *in = data;
 	void *cb_data = NULL;
+	float freq = 440.0;
 
 	pthread_cleanup_push(playthread_cleanup, NULL);
 
@@ -142,8 +192,9 @@ static void *playback_thread(void *data)
 		filbuff_cb = feed_from_file;
 		cb_data = in;
 	} else {
-		/* TODO: Use generator */
-		goto end;
+		prepare_sample();
+		filbuff_cb = feed_from_generator;
+		cb_data = &freq;
 	}
 
 	pthread_mutex_lock(&state_mutex);
@@ -178,7 +229,7 @@ static void *playback_thread(void *data)
 		fclose(in);
 		in = NULL;
 	}
-end:
+
 	pthread_cleanup_pop(1);
 	return NULL;
 }
@@ -193,6 +244,7 @@ static void play_p(int argc, const char **argv)
 
 	if (argc < 3) {
 		haltest_error("Invalid audio file path.\n");
+		haltest_info("Using sound generator.\n");
 	} else {
 		fname = argv[2];
 		in = fopen(fname, "r");
-- 
1.8.5.2

