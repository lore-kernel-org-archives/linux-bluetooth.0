Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 11/28] android/haltest: Add read command.
Date: Wed,  4 Jun 2014 17:17:42 +0300
Message-Id: <1401891479-11965-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Read command makes stream_in->read() call to Audio HAL.
---
 android/client/if-sco.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index c71d0b4..b4c3506 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -230,6 +230,45 @@ static void *playback_thread(void *data)
 	return NULL;
 }
 
+static void *read_thread(void *data)
+{
+	int (*filbuff_cb) (short*, void*) = feed_from_in;
+	short buffer[buffer_size / sizeof(short)];
+	size_t len = 0;
+	void *cb_data = NULL;
+
+	pthread_mutex_lock(&state_mutex);
+	current_state = STATE_PLAYING;
+	pthread_mutex_unlock(&state_mutex);
+
+	do {
+		pthread_mutex_lock(&state_mutex);
+
+		if (current_state == STATE_STOPPING) {
+			haltest_info("Detected stopping\n");
+			pthread_mutex_unlock(&state_mutex);
+			break;
+		} else if (current_state == STATE_SUSPENDED) {
+			pthread_mutex_unlock(&state_mutex);
+			usleep(500);
+			continue;
+		}
+
+		pthread_mutex_unlock(&state_mutex);
+
+		len = filbuff_cb(buffer, cb_data);
+		haltest_info("len %zd\n", len);
+	} while (len);
+
+	pthread_mutex_lock(&state_mutex);
+	current_state = STATE_STOPPED;
+	pthread_mutex_unlock(&state_mutex);
+
+	haltest_info("Done reading.\n");
+
+	return NULL;
+}
+
 static void play_p(int argc, const char **argv)
 {
 	const char *fname = NULL;
@@ -276,6 +315,30 @@ fail:
 		fclose(in);
 }
 
+static void read_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio_sco);
+	RETURN_IF_NULL(stream_in);
+
+	if (!buffer_size_in) {
+		haltest_error("Invalid buffer sizes. Streams opened\n");
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
+	if (pthread_create(&play_thread, NULL, read_thread,
+							stream_in) != 0)
+		haltest_error("Cannot create playback thread!\n");
+
+}
+
 static void stop_p(int argc, const char **argv)
 {
 	pthread_mutex_lock(&state_mutex);
@@ -551,6 +614,7 @@ static struct method methods[] = {
 	STD_METHOD(open_input_stream),
 	STD_METHOD(close_input_stream),
 	STD_METHODH(play, "<path to pcm file>"),
+	STD_METHOD(read),
 	STD_METHOD(stop),
 	STD_METHOD(suspend),
 	STD_METHOD(resume),
-- 
1.8.3.2

