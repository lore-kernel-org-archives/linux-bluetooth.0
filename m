Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 08/14] android/haltest: Add open/close input stream commands
Date: Thu, 22 May 2014 15:06:01 +0300
Message-Id: <1400760367-24915-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sco.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index b7f5a80..c71d0b4 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -23,8 +23,10 @@
 
 audio_hw_device_t *if_audio_sco = NULL;
 static struct audio_stream_out *stream_out = NULL;
+static struct audio_stream_in *stream_in = NULL;
 
 static size_t buffer_size = 0;
+static size_t buffer_size_in = 0;
 static pthread_t play_thread = 0;
 static pthread_mutex_t outstream_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t state_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -340,6 +342,53 @@ static void close_output_stream_p(int argc, const char **argv)
 	buffer_size = 0;
 }
 
+static void open_input_stream_p(int argc, const char **argv)
+{
+	int err;
+
+	RETURN_IF_NULL(if_audio_sco);
+
+	pthread_mutex_lock(&state_mutex);
+	if (current_state == STATE_PLAYING) {
+		haltest_error("Already playing!\n");
+		pthread_mutex_unlock(&state_mutex);
+		return;
+	}
+	pthread_mutex_unlock(&state_mutex);
+
+	err = if_audio_sco->open_input_stream(if_audio_sco,
+						0,
+						AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET,
+						NULL,
+						&stream_in);
+	if (err < 0) {
+		haltest_error("open output stream returned %d\n", err);
+		return;
+	}
+
+	buffer_size_in = stream_in->common.get_buffer_size(&stream_in->common);
+	if (buffer_size_in == 0)
+		haltest_error("Invalid buffer size received!\n");
+	else
+		haltest_info("Using buffer size: %zu\n", buffer_size_in);
+}
+
+static void close_input_stream_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio_sco);
+	RETURN_IF_NULL(stream_in);
+
+	stop_p(argc, argv);
+
+	haltest_info("Waiting for playback thread...\n");
+	pthread_join(play_thread, NULL);
+
+	if_audio_sco->close_input_stream(if_audio_sco, stream_in);
+
+	stream_in = NULL;
+	buffer_size_in = 0;
+}
+
 static void cleanup_p(int argc, const char **argv)
 {
 	int err;
@@ -499,6 +548,8 @@ static struct method methods[] = {
 	STD_METHOD(cleanup),
 	STD_METHOD(open_output_stream),
 	STD_METHOD(close_output_stream),
+	STD_METHOD(open_input_stream),
+	STD_METHOD(close_input_stream),
 	STD_METHODH(play, "<path to pcm file>"),
 	STD_METHOD(stop),
 	STD_METHOD(suspend),
-- 
1.8.3.2

