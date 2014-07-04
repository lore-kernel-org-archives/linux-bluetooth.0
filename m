Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 25/32] android/haltest: Refactor stop and closing streams
Date: Fri,  4 Jul 2014 16:47:10 +0300
Message-Id: <1404481637-900-26-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sco.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 0e27a9d..456c529 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -458,6 +458,9 @@ failed:
 
 static void stop_p(int argc, const char **argv)
 {
+	RETURN_IF_NULL(if_audio_sco);
+	RETURN_IF_NULL(play_thread);
+
 	pthread_mutex_lock(&state_mutex);
 	if (current_state == STATE_STOPPED || current_state == STATE_STOPPING) {
 		pthread_mutex_unlock(&state_mutex);
@@ -467,6 +470,9 @@ static void stop_p(int argc, const char **argv)
 	current_state = STATE_STOPPING;
 	pthread_mutex_unlock(&state_mutex);
 
+	pthread_join(play_thread, NULL);
+	play_thread = 0;
+
 	pthread_mutex_lock(&outstream_mutex);
 	stream_out->common.standby(&stream_out->common);
 	pthread_mutex_unlock(&outstream_mutex);
@@ -528,10 +534,8 @@ static void close_output_stream_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_audio_sco);
 	RETURN_IF_NULL(stream_out);
 
-	stop_p(argc, argv);
-
-	haltest_info("Waiting for playback thread...\n");
-	pthread_join(play_thread, NULL);
+	if (play_thread)
+		stop_p(argc, argv);
 
 	if_audio_sco->close_output_stream(if_audio_sco, stream_out);
 
@@ -592,10 +596,8 @@ static void close_input_stream_p(int argc, const char **argv)
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
1.9.1

