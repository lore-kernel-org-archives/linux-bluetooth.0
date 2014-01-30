Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 03/15] android/client-audio: Add audio file playback
Date: Thu, 30 Jan 2014 12:23:09 +0100
Message-Id: <1391081001-30723-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds audio file playback capability. Proper 16-bit signed
float stereo PCM file is needed.

---
 android/client/if-audio.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 4c1efce..cd0a851 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -17,11 +17,26 @@
 
 #include "if-main.h"
 #include "../hal-utils.h"
+#include "pthread.h"
+#include "unistd.h"
 
 audio_hw_device_t *if_audio = NULL;
 struct audio_stream_out *stream_out = NULL;
 
 static size_t buffer_size = 0;
+static pthread_t play_thread = 0;
+static pthread_mutex_t outstream_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t state_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+enum state {
+	STATE_STOPPED,
+	STATE_STOPPING,
+	STATE_PLAYING,
+	STATE_SUSPENDED,
+	STATE_MAX
+};
+
+static int current_state = STATE_STOPPED;
 
 static void init_p(int argc, const char **argv)
 {
@@ -45,12 +60,142 @@ static void init_p(int argc, const char **argv)
 	if_audio = device;
 }
 
+static void playthread_cleanup(void *arg)
+{
+	pthread_mutex_lock(&state_mutex);
+	current_state = STATE_STOPPED;
+	pthread_mutex_unlock(&state_mutex);
+
+	haltest_info("Done playing.\n");
+}
+
+static int feed_from_file(short *buffer, void *data)
+{
+	FILE *in = data;
+	return fread(buffer, buffer_size, 1, in);
+}
+
+static void *playback_thread(void *data)
+{
+	int (*filbuff_cb) (short*, void*);
+	short buffer[buffer_size / sizeof(short)];
+	size_t len = 0;
+	size_t w_len = 0;
+	FILE *in = data;
+	void *cb_data = NULL;
+
+	pthread_cleanup_push(playthread_cleanup, NULL);
+
+	/* Use file or fall back to generator */
+	if (in) {
+		filbuff_cb = feed_from_file;
+		cb_data = in;
+	} else {
+		/* TODO: Use generator */
+		goto end;
+	}
+
+	pthread_mutex_lock(&state_mutex);
+	current_state = STATE_PLAYING;
+	pthread_mutex_unlock(&state_mutex);
+
+	do {
+		pthread_mutex_lock(&state_mutex);
+		if (current_state == STATE_STOPPING) {
+			pthread_mutex_unlock(&state_mutex);
+			break;
+		}
+		pthread_mutex_unlock(&state_mutex);
+
+		len = filbuff_cb(buffer, cb_data);
+
+		pthread_mutex_lock(&outstream_mutex);
+		if (!stream_out) {
+			pthread_mutex_unlock(&outstream_mutex);
+			break;
+		}
+
+		w_len = stream_out->write(stream_out, buffer, buffer_size);
+		pthread_mutex_unlock(&outstream_mutex);
+	} while (len && w_len);
+
+	if (in) {
+		fclose(in);
+		in = NULL;
+	}
+end:
+	pthread_cleanup_pop(1);
+	return NULL;
+}
+
+static void play_p(int argc, const char **argv)
+{
+	const char *fname = NULL;
+	FILE *in = NULL;
+
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	if (argc < 3) {
+		haltest_error("Invalid audio file path.\n");
+	} else {
+		fname = argv[2];
+		in = fopen(fname, "r");
+
+		if (in == NULL) {
+			haltest_error("Cannot open file: %s\n", fname);
+			return;
+		}
+		haltest_info("Playing file: %s\n", fname);
+	}
+
+	if (buffer_size == 0) {
+		haltest_error("Invalid buffer size. Was stream_out opened?\n");
+		return;
+	}
+
+	pthread_mutex_lock(&state_mutex);
+	if (current_state != STATE_STOPPED) {
+		haltest_error("Already playing or stream suspended!\n");
+		pthread_mutex_unlock(&state_mutex);
+		return;
+	}
+	pthread_mutex_unlock(&state_mutex);
+
+	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0)
+		haltest_error("Cannot create playback thread!\n");
+}
+
+static void stop_p(int argc, const char **argv)
+{
+	pthread_mutex_lock(&state_mutex);
+	if (current_state == STATE_STOPPED || current_state == STATE_STOPPING) {
+		pthread_mutex_unlock(&state_mutex);
+		return;
+	}
+
+	current_state = STATE_STOPPING;
+	pthread_mutex_unlock(&state_mutex);
+
+	pthread_mutex_lock(&outstream_mutex);
+	stream_out->common.standby(&stream_out->common);
+	pthread_mutex_unlock(&outstream_mutex);
+}
+
 static void open_output_stream_p(int argc, const char **argv)
 {
 	int err;
 
 	RETURN_IF_NULL(if_audio);
 
+	pthread_mutex_lock(&state_mutex);
+	if (current_state == STATE_PLAYING) {
+		haltest_error("Already playing!\n");
+		pthread_mutex_unlock(&state_mutex);
+		return;
+	}
+	pthread_mutex_unlock(&state_mutex);
+
 	err = if_audio->open_output_stream(if_audio,
 						0,
 						AUDIO_DEVICE_OUT_ALL_A2DP,
@@ -74,7 +219,15 @@ static void close_output_stream_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_audio);
 	RETURN_IF_NULL(stream_out);
 
+	stop_p(argc, argv);
+
+	haltest_info("Waiting for playback thread...\n");
+	pthread_join(play_thread, NULL);
+
 	if_audio->close_output_stream(if_audio, stream_out);
+
+	stream_out = NULL;
+	buffer_size = 0;
 }
 
 static void cleanup_p(int argc, const char **argv)
@@ -83,6 +236,14 @@ static void cleanup_p(int argc, const char **argv)
 
 	RETURN_IF_NULL(if_audio);
 
+	pthread_mutex_lock(&state_mutex);
+	if (current_state != STATE_STOPPED) {
+		pthread_mutex_unlock(&state_mutex);
+		close_output_stream_p(0, NULL);
+	} else {
+		pthread_mutex_unlock(&state_mutex);
+	}
+
 	err = audio_hw_device_close(if_audio);
 	if (err < 0) {
 		haltest_error("audio_hw_device_close returned %d\n", err);
@@ -97,6 +258,8 @@ static struct method methods[] = {
 	STD_METHOD(cleanup),
 	STD_METHOD(open_output_stream),
 	STD_METHOD(close_output_stream),
+	STD_METHODH(play, "<path to pcm file>"),
+	STD_METHOD(stop),
 	END_METHOD
 };
 
-- 
1.8.5.2

