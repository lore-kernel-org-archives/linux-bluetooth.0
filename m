Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 25/28] android/haltest: Refactor stop and closing streams
Date: Wed,  4 Jun 2014 17:17:56 +0300
Message-Id: <1401891479-11965-25-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sco.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index b7377f4..6983f4e 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -455,6 +455,9 @@ static void read_p(int argc, const char **argv)
 
 static void stop_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_audio_sco);
+	RETURN_IF_NULL(play_thread);
+
 	pthread_mutex_lock(&state_mutex);
 	if (current_state == STATE_STOPPED || current_state == STATE_STOPPING) {
 		pthread_mutex_unlock(&state_mutex);
@@ -464,6 +467,9 @@ static void stop_p(int argc, const char **argv)
 	current_state = STATE_STOPPING;
 	pthread_mutex_unlock(&state_mutex);
 
+	pthread_join(play_thread, NULL);
+	play_thread = 0;
+
 	pthread_mutex_lock(&outstream_mutex);
 	stream_out->common.standby(&stream_out->common);
 	pthread_mutex_unlock(&outstream_mutex);
@@ -522,10 +528,8 @@ static void close_output_stream_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_audio_sco);
 	RETURN_IF_NULL(stream_out);
 
-	stop_p(argc, argv);
-
-	haltest_info("Waiting for playback thread...\n");
-	pthread_join(play_thread, NULL);
+	if (play_thread)
+		stop_p(argc, argv);
 
 	if_audio_sco->close_output_stream(if_audio_sco, stream_out);
 
@@ -583,10 +587,8 @@ static void close_input_stream_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_audio_sco);
 	RETURN_IF_NULL(stream_in);
 
-	stop_p(argc, argv);
-
-	haltest_info("Waiting for playback thread...\n");
-	pthread_join(play_thread, NULL);
+	if (play_thread)
+		stop_p(argc, argv);
 
 	if_audio_sco->close_input_stream(if_audio_sco, stream_in);
 
-- 
1.8.3.2

