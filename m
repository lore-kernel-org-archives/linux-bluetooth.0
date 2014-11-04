Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 17/47] android/client: Support new API for SCO HAL
Date: Tue,  4 Nov 2014 10:18:40 +0200
Message-Id: <1415089150-18798-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for new parameters in open_output_stream() and
open_inut_stream().
---
 android/client/if-sco.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index e7197b2..96dc083 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -62,7 +62,9 @@ SINTMAP(audio_channel_mask_t, -1, "(AUDIO_CHANNEL_INVALID)")
 	DELEMENT(AUDIO_CHANNEL_OUT_MONO),
 	DELEMENT(AUDIO_CHANNEL_OUT_STEREO),
 	DELEMENT(AUDIO_CHANNEL_OUT_QUAD),
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	DELEMENT(AUDIO_CHANNEL_OUT_SURROUND),
+#endif
 	DELEMENT(AUDIO_CHANNEL_OUT_5POINT1),
 	DELEMENT(AUDIO_CHANNEL_OUT_7POINT1),
 	DELEMENT(AUDIO_CHANNEL_OUT_ALL),
@@ -509,12 +511,21 @@ static void open_output_stream_p(int argc, const char **argv)
 		config->format = AUDIO_FORMAT_PCM_16_BIT;
 	}
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	err = if_audio_sco->open_output_stream(if_audio_sco,
+						0,
+						AUDIO_DEVICE_OUT_ALL_SCO,
+						AUDIO_OUTPUT_FLAG_NONE,
+						config,
+						&stream_out, NULL);
+#else
 	err = if_audio_sco->open_output_stream(if_audio_sco,
 						0,
 						AUDIO_DEVICE_OUT_ALL_SCO,
 						AUDIO_OUTPUT_FLAG_NONE,
 						config,
 						&stream_out);
+#endif
 	if (err < 0) {
 		haltest_error("open output stream returned %d\n", err);
 		goto failed;
@@ -572,11 +583,19 @@ static void open_input_stream_p(int argc, const char **argv)
 		config->format = AUDIO_FORMAT_PCM_16_BIT;
 	}
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	err = if_audio_sco->open_input_stream(if_audio_sco,
+						0,
+						AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET,
+						config,
+						&stream_in, 0, NULL, 0);
+#else
 	err = if_audio_sco->open_input_stream(if_audio_sco,
 						0,
 						AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET,
 						config,
 						&stream_in);
+#endif
 	if (err < 0) {
 		haltest_error("open output stream returned %d\n", err);
 		goto failed;
-- 
1.9.1

