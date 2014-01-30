Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 04/15] android/client-audio: Add playback suspend/resume
Date: Thu, 30 Jan 2014 12:23:10 +0100
Message-Id: <1391081001-30723-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add audio stream suspending and resuming.

---
 android/client/if-audio.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index cd0a851..985b60c 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -104,6 +104,10 @@ static void *playback_thread(void *data)
 		if (current_state == STATE_STOPPING) {
 			pthread_mutex_unlock(&state_mutex);
 			break;
+		} else if (current_state == STATE_SUSPENDED) {
+				pthread_mutex_unlock(&state_mutex);
+				usleep(500);
+				continue;
 		}
 		pthread_mutex_unlock(&state_mutex);
 
@@ -253,6 +257,35 @@ static void cleanup_p(int argc, const char **argv)
 	if_audio = NULL;
 }
 
+static void suspend_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	pthread_mutex_lock(&state_mutex);
+	if (current_state != STATE_PLAYING) {
+		pthread_mutex_unlock(&state_mutex);
+		return;
+	}
+	current_state = STATE_SUSPENDED;
+	pthread_mutex_unlock(&state_mutex);
+
+	pthread_mutex_lock(&outstream_mutex);
+	stream_out->common.standby(&stream_out->common);
+	pthread_mutex_unlock(&outstream_mutex);
+}
+
+static void resume_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	pthread_mutex_lock(&state_mutex);
+	if (current_state == STATE_SUSPENDED)
+		current_state = STATE_PLAYING;
+	pthread_mutex_unlock(&state_mutex);
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -260,6 +293,8 @@ static struct method methods[] = {
 	STD_METHOD(close_output_stream),
 	STD_METHODH(play, "<path to pcm file>"),
 	STD_METHOD(stop),
+	STD_METHOD(suspend),
+	STD_METHOD(resume),
 	END_METHOD
 };
 
-- 
1.8.5.2

