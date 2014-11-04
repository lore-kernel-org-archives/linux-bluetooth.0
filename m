Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 16/47] android/client: Support new API for Audio HAL
Date: Tue,  4 Nov 2014 10:18:39 +0200
Message-Id: <1415089150-18798-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for new parameter in open_output_stream().
---
 android/client/if-audio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index f3f87fb..41604d9 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -60,7 +60,9 @@ SINTMAP(audio_channel_mask_t, -1, "(AUDIO_CHANNEL_INVALID)")
 	DELEMENT(AUDIO_CHANNEL_OUT_MONO),
 	DELEMENT(AUDIO_CHANNEL_OUT_STEREO),
 	DELEMENT(AUDIO_CHANNEL_OUT_QUAD),
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	DELEMENT(AUDIO_CHANNEL_OUT_SURROUND),
+#endif
 	DELEMENT(AUDIO_CHANNEL_OUT_5POINT1),
 	DELEMENT(AUDIO_CHANNEL_OUT_7POINT1),
 	DELEMENT(AUDIO_CHANNEL_OUT_ALL),
@@ -305,12 +307,21 @@ static void open_output_stream_p(int argc, const char **argv)
 	}
 	pthread_mutex_unlock(&state_mutex);
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
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

