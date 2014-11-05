Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/client: Support new API for Audio HAL
Date: Wed,  5 Nov 2014 14:41:48 +0200
Message-Id: <1415191313-12810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for new parameter in open_output_stream().
---
 android/client/if-audio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index f3f87fb..65e2f2f 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -60,7 +60,14 @@ SINTMAP(audio_channel_mask_t, -1, "(AUDIO_CHANNEL_INVALID)")
 	DELEMENT(AUDIO_CHANNEL_OUT_MONO),
 	DELEMENT(AUDIO_CHANNEL_OUT_STEREO),
 	DELEMENT(AUDIO_CHANNEL_OUT_QUAD),
+#if ANDROID_VERSION < PLATFORM_VER(5, 0, 0)
 	DELEMENT(AUDIO_CHANNEL_OUT_SURROUND),
+#else
+	DELEMENT(AUDIO_CHANNEL_OUT_QUAD_BACK),
+	DELEMENT(AUDIO_CHANNEL_OUT_QUAD_SIDE),
+	DELEMENT(AUDIO_CHANNEL_OUT_5POINT1_BACK),
+	DELEMENT(AUDIO_CHANNEL_OUT_5POINT1_SIDE),
+#endif
 	DELEMENT(AUDIO_CHANNEL_OUT_5POINT1),
 	DELEMENT(AUDIO_CHANNEL_OUT_7POINT1),
 	DELEMENT(AUDIO_CHANNEL_OUT_ALL),
@@ -305,12 +312,21 @@ static void open_output_stream_p(int argc, const char **argv)
 	}
 	pthread_mutex_unlock(&state_mutex);
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	err = if_audio->open_output_stream(if_audio,
+						0,
+						AUDIO_DEVICE_OUT_ALL_A2DP,
+						AUDIO_OUTPUT_FLAG_NONE,
+						NULL,
+						&stream_out, NULL);
+#else
 	err = if_audio->open_output_stream(if_audio,
 						0,
 						AUDIO_DEVICE_OUT_ALL_A2DP,
 						AUDIO_OUTPUT_FLAG_NONE,
 						NULL,
 						&stream_out);
+#endif
 	if (err < 0) {
 		haltest_error("open output stream returned %d\n", err);
 		return;
-- 
1.9.1

