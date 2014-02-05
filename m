Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/haltest: Close file in case of error
Date: Wed,  5 Feb 2014 17:44:02 +0200
Message-Id: <1391615042-22677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-audio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 66f8364..bb8f51b 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -258,6 +258,7 @@ static void play_p(int argc, const char **argv)
 
 	if (buffer_size == 0) {
 		haltest_error("Invalid buffer size. Was stream_out opened?\n");
+		fclose(in);
 		return;
 	}
 
@@ -265,12 +266,15 @@ static void play_p(int argc, const char **argv)
 	if (current_state != STATE_STOPPED) {
 		haltest_error("Already playing or stream suspended!\n");
 		pthread_mutex_unlock(&state_mutex);
+		fclose(in);
 		return;
 	}
 	pthread_mutex_unlock(&state_mutex);
 
-	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0)
+	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0) {
 		haltest_error("Cannot create playback thread!\n");
+		fclose(in);
+	}
 }
 
 static void stop_p(int argc, const char **argv)
-- 
1.8.3.2

