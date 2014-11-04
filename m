Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 04/47] android/hal-audio: Add support for new Android API
Date: Tue,  4 Nov 2014 10:18:27 +0200
Message-Id: <1415089150-18798-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For new Android API add parameter address to audio_open_output_stream()
and audio_open_input_stream().
---
 android/hal-audio.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index e70351e..d140071 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1108,13 +1108,22 @@ static int in_remove_audio_effect(const struct audio_stream *stream,
 	return -ENOSYS;
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int audio_open_output_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					audio_output_flags_t flags,
+					struct audio_config *config,
+					struct audio_stream_out **stream_out,
+					const char *address)
+#else
 static int audio_open_output_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					audio_output_flags_t flags,
 					struct audio_config *config,
 					struct audio_stream_out **stream_out)
-
+#endif
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
 	struct a2dp_stream_out *out;
@@ -1252,11 +1261,22 @@ static size_t audio_get_input_buffer_size(const struct audio_hw_device *dev,
 	return -ENOSYS;
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int audio_open_input_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					struct audio_config *config,
+					struct audio_stream_in **stream_in,
+					audio_input_flags_t flags,
+					const char *address,
+					audio_source_t source)
+#else
 static int audio_open_input_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					struct audio_config *config,
 					struct audio_stream_in **stream_in)
+#endif
 {
 	struct audio_stream_in *in;
 
-- 
1.9.1

