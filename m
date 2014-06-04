Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 18/28] android/haltest: Add sample rate parameter when opening audio streams
Date: Wed,  4 Jun 2014 17:17:49 +0300
Message-Id: <1401891479-11965-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Opening input/output audio streams makes use of config with sample rate.
---
 android/client/if-sco.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index b5fa926..555c6f9 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -442,10 +442,21 @@ static void stop_p(int argc, const char **argv)
 
 static void open_output_stream_p(int argc, const char **argv)
 {
+	struct audio_config *config;
 	int err;
 
 	RETURN_IF_NULL(if_audio_sco);
 
+	if (argc < 3) {
+		haltest_info("No sampling rate specified. Use default conf\n");
+		config = NULL;
+	} else {
+		config = calloc(1, sizeof(struct audio_config));
+		config->sample_rate = atoi(argv[2]);
+		config->channel_mask = AUDIO_CHANNEL_OUT_STEREO;
+		config->format = AUDIO_FORMAT_PCM_16_BIT;
+	}
+
 	pthread_mutex_lock(&state_mutex);
 	if (current_state == STATE_PLAYING) {
 		haltest_error("Already playing!\n");
@@ -458,11 +469,11 @@ static void open_output_stream_p(int argc, const char **argv)
 						0,
 						AUDIO_DEVICE_OUT_ALL_SCO,
 						AUDIO_OUTPUT_FLAG_NONE,
-						NULL,
+						config,
 						&stream_out);
 	if (err < 0) {
 		haltest_error("open output stream returned %d\n", err);
-		return;
+		goto failed;
 	}
 
 	buffer_size = stream_out->common.get_buffer_size(&stream_out->common);
@@ -470,6 +481,9 @@ static void open_output_stream_p(int argc, const char **argv)
 		haltest_error("Invalid buffer size received!\n");
 	else
 		haltest_info("Using buffer size: %zu\n", buffer_size);
+failed:
+	if (config)
+		free(config);
 }
 
 static void close_output_stream_p(int argc, const char **argv)
@@ -490,10 +504,21 @@ static void close_output_stream_p(int argc, const char **argv)
 
 static void open_input_stream_p(int argc, const char **argv)
 {
+	struct audio_config *config;
 	int err;
 
 	RETURN_IF_NULL(if_audio_sco);
 
+	if (argc < 3) {
+		haltest_info("No sampling rate specified. Use default conf\n");
+		config = NULL;
+	} else {
+		config = calloc(1, sizeof(struct audio_config));
+		config->sample_rate = atoi(argv[2]);
+		config->channel_mask = AUDIO_CHANNEL_OUT_MONO;
+		config->format = AUDIO_FORMAT_PCM_16_BIT;
+	}
+
 	pthread_mutex_lock(&state_mutex);
 	if (current_state == STATE_PLAYING) {
 		haltest_error("Already playing!\n");
@@ -505,11 +530,11 @@ static void open_input_stream_p(int argc, const char **argv)
 	err = if_audio_sco->open_input_stream(if_audio_sco,
 						0,
 						AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET,
-						NULL,
+						config,
 						&stream_in);
 	if (err < 0) {
 		haltest_error("open output stream returned %d\n", err);
-		return;
+		goto failed;
 	}
 
 	buffer_size_in = stream_in->common.get_buffer_size(&stream_in->common);
@@ -517,6 +542,9 @@ static void open_input_stream_p(int argc, const char **argv)
 		haltest_error("Invalid buffer size received!\n");
 	else
 		haltest_info("Using buffer size: %zu\n", buffer_size_in);
+failed:
+	if (config)
+		free(config);
 }
 
 static void close_input_stream_p(int argc, const char **argv)
@@ -693,8 +721,8 @@ static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
 	STD_METHOD(open_output_stream),
-	STD_METHOD(close_output_stream),
-	STD_METHOD(open_input_stream),
+	STD_METHODH(close_output_stream, "sample_rate"),
+	STD_METHODH(open_input_stream, "sampling rate"),
 	STD_METHOD(close_input_stream),
 	STD_METHODH(play, "<path to pcm file>"),
 	STD_METHOD(read),
-- 
1.8.3.2

