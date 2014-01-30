Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 02/15] android/client-audio: Add open/close output stream
Date: Thu, 30 Jan 2014 12:23:08 +0100
Message-Id: <1391081001-30723-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add opening and closing output stream.

---
 android/client/if-audio.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 203e088..4c1efce 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -19,6 +19,9 @@
 #include "../hal-utils.h"
 
 audio_hw_device_t *if_audio = NULL;
+struct audio_stream_out *stream_out = NULL;
+
+static size_t buffer_size = 0;
 
 static void init_p(int argc, const char **argv)
 {
@@ -34,12 +37,46 @@ static void init_p(int argc, const char **argv)
 	}
 
 	err = audio_hw_device_open(module, &device);
-	if (err)
+	if (err) {
 		haltest_error("audio_hw_device_open returned %d\n", err);
+		return;
+	}
 
 	if_audio = device;
 }
 
+static void open_output_stream_p(int argc, const char **argv)
+{
+	int err;
+
+	RETURN_IF_NULL(if_audio);
+
+	err = if_audio->open_output_stream(if_audio,
+						0,
+						AUDIO_DEVICE_OUT_ALL_A2DP,
+						AUDIO_OUTPUT_FLAG_NONE,
+						NULL,
+						&stream_out);
+	if (err < 0) {
+		haltest_error("open output stream returned %d\n", err);
+		return;
+	}
+
+	buffer_size = stream_out->common.get_buffer_size(&stream_out->common);
+	if (buffer_size == 0)
+		haltest_error("Invalid buffer size received!\n");
+	else
+		haltest_info("Using buffer size: %d\n", buffer_size);
+}
+
+static void close_output_stream_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	if_audio->close_output_stream(if_audio, stream_out);
+}
+
 static void cleanup_p(int argc, const char **argv)
 {
 	int err;
@@ -58,6 +95,8 @@ static void cleanup_p(int argc, const char **argv)
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
+	STD_METHOD(open_output_stream),
+	STD_METHOD(close_output_stream),
 	END_METHOD
 };
 
-- 
1.8.5.2

