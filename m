Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 16/32] android/haltest: Implement read to file
Date: Fri,  4 Jul 2014 16:47:01 +0300
Message-Id: <1404481637-900-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Reads data from stream_in and write to specified file.
---
 android/Android.mk      |  3 +++
 android/client/if-sco.c | 68 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 667af14..0e319eb 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -174,6 +174,9 @@ LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
 
+LOCAL_C_INCLUDES += \
+	$(LOCAL_PATH)/bluez/android \
+
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := libhardware
diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 39c3e3a..06ac6e8 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -15,6 +15,8 @@
  *
  */
 
+#include "../src/shared/util.h"
+
 #include "if-main.h"
 #include "../hal-utils.h"
 #include "pthread.h"
@@ -239,12 +241,29 @@ static void *playback_thread(void *data)
 	return NULL;
 }
 
+static void write_stereo_pcm16(char *buffer, size_t len, FILE *out)
+{
+	const int16_t *input = (const void *) buffer;
+	int16_t sample[2];
+	size_t i;
+
+	for (i = 0; i < len / 2; i++) {
+		int16_t mono = get_unaligned(&input[i]);
+
+		put_unaligned(mono, &sample[0]);
+		put_unaligned(mono, &sample[1]);
+
+		fwrite(sample, sizeof(sample), 1, out);
+	}
+}
+
 static void *read_thread(void *data)
 {
 	int (*filbuff_cb) (short*, void*) = feed_from_in;
-	short buffer[buffer_size / sizeof(short)];
+	short buffer[buffer_size_in / sizeof(short)];
 	size_t len = 0;
 	void *cb_data = NULL;
+	FILE *out = data;
 
 	pthread_mutex_lock(&state_mutex);
 	current_state = STATE_PLAYING;
@@ -266,9 +285,18 @@ static void *read_thread(void *data)
 		pthread_mutex_unlock(&state_mutex);
 
 		len = filbuff_cb(buffer, cb_data);
-		haltest_info("len %zd\n", len);
+
+		haltest_info("Read %zd bytes\n", len);
+
+		if (out) {
+			write_stereo_pcm16((char *) buffer, len, out);
+			haltest_info("Written %zd bytes\n", len * 2);
+		}
 	} while (len);
 
+	if (out)
+		fclose(out);
+
 	pthread_mutex_lock(&state_mutex);
 	current_state = STATE_STOPPED;
 	pthread_mutex_unlock(&state_mutex);
@@ -355,14 +383,12 @@ static void loop_p(int argc, const char **argv)
 
 static void read_p(int argc, const char **argv)
 {
+	const char *fname = NULL;
+	FILE *out = NULL;
+
 	RETURN_IF_NULL(if_audio_sco);
 	RETURN_IF_NULL(stream_in);
 
-	if (!buffer_size_in) {
-		haltest_error("Invalid buffer sizes. Streams opened\n");
-		return;
-	}
-
 	pthread_mutex_lock(&state_mutex);
 	if (current_state != STATE_STOPPED) {
 		haltest_error("Already playing or stream suspended!\n");
@@ -371,10 +397,32 @@ static void read_p(int argc, const char **argv)
 	}
 	pthread_mutex_unlock(&state_mutex);
 
-	if (pthread_create(&play_thread, NULL, read_thread,
-							stream_in) != 0)
-		haltest_error("Cannot create playback thread!\n");
+	if (argc < 3) {
+		haltest_error("Invalid audio file path.\n");
+		haltest_info("Using read and through away\n");
+	} else {
+		fname = argv[2];
+		out = fopen(fname, "w");
+		if (!out) {
+			haltest_error("Cannot open file: %s\n", fname);
+			return;
+		}
 
+		haltest_info("Reading to file: %s\n", fname);
+	}
+
+	if (!buffer_size_in) {
+		haltest_error("Invalid buffer size.\n");
+		goto failed;
+	}
+
+	if (pthread_create(&play_thread, NULL, read_thread, out) != 0) {
+		haltest_error("Cannot create playback thread!\n");
+		goto failed;
+	}
+failed:
+	if (out)
+		fclose(out);
 }
 
 static void stop_p(int argc, const char **argv)
-- 
1.9.1

