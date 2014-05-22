Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 10/14] android/haltest: Add loop command
Date: Thu, 22 May 2014 15:06:03 +0300
Message-Id: <1400760367-24915-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

loop command makes stream_in->read() and then stream_out->write(). At
the moment buffers shall be equal.
---
 android/client/if-sco.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index b4c3506..87e2d79 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -148,6 +148,11 @@ static int feed_from_generator(short *buffer, void *data)
 	return buffer_size;
 }
 
+static int feed_from_in(short *buffer, void *data)
+{
+	return stream_in->read(stream_in, buffer, buffer_size);
+}
+
 static void prepare_sample(void)
 {
 	int x;
@@ -179,8 +184,12 @@ static void *playback_thread(void *data)
 
 	/* Use file or fall back to generator */
 	if (in) {
-		filbuff_cb = feed_from_file;
-		cb_data = in;
+		if (data == stream_in)
+			filbuff_cb = feed_from_in;
+		else {
+			filbuff_cb = feed_from_file;
+			cb_data = in;
+		}
 	} else {
 		prepare_sample();
 		filbuff_cb = feed_from_generator;
@@ -315,6 +324,35 @@ fail:
 		fclose(in);
 }
 
+static void loop_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio_sco);
+	RETURN_IF_NULL(stream_out);
+	RETURN_IF_NULL(stream_in);
+
+	if (!buffer_size || !buffer_size_in) {
+		haltest_error("Invalid buffer sizes. Streams opened\n");
+		return;
+	}
+
+	if (buffer_size != buffer_size_in) {
+		haltest_error("read/write buffers differ, not supported\n");
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
+	if (pthread_create(&play_thread, NULL, playback_thread,
+							stream_in) != 0)
+		haltest_error("Cannot create playback thread!\n");
+}
+
 static void read_p(int argc, const char **argv)
 {
 	RETURN_IF_NULL(if_audio_sco);
@@ -615,6 +653,7 @@ static struct method methods[] = {
 	STD_METHOD(close_input_stream),
 	STD_METHODH(play, "<path to pcm file>"),
 	STD_METHOD(read),
+	STD_METHOD(loop),
 	STD_METHOD(stop),
 	STD_METHOD(suspend),
 	STD_METHOD(resume),
-- 
1.8.3.2

