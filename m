Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/hal-audio: Add support for new Android API
Date: Tue,  4 Nov 2014 16:37:36 +0200
Message-Id: <1415111857-399-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For new Android API add parameter address to audio_open_output_stream()
and audio_open_input_stream().
---
 android/hal-audio.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index e70351e..0e9891d 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1108,13 +1108,13 @@ static int in_remove_audio_effect(const struct audio_stream *stream,
 	return -ENOSYS;
 }
 
-static int audio_open_output_stream(struct audio_hw_device *dev,
+static int audio_open_output_stream_real(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					audio_output_flags_t flags,
 					struct audio_config *config,
-					struct audio_stream_out **stream_out)
-
+					struct audio_stream_out **stream_out,
+					const char *address)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
 	struct a2dp_stream_out *out;
@@ -1171,6 +1171,31 @@ fail:
 	return -EIO;
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static int audio_open_output_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					audio_output_flags_t flags,
+					struct audio_config *config,
+					struct audio_stream_out **stream_out,
+					const char *address)
+{
+	return audio_open_output_stream_real(dev, handle, devices, flags,
+						config, stream_out, address);
+}
+#else
+static int audio_open_output_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					audio_output_flags_t flags,
+					struct audio_config *config,
+					struct audio_stream_out **stream_out)
+{
+	return audio_open_output_stream_real(dev, handle, devices, flags,
+						config, stream_out, NULL);
+}
+#endif
+
 static void audio_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream)
 {
@@ -1252,11 +1277,14 @@ static size_t audio_get_input_buffer_size(const struct audio_hw_device *dev,
 	return -ENOSYS;
 }
 
-static int audio_open_input_stream(struct audio_hw_device *dev,
+static int audio_open_input_stream_real(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					struct audio_config *config,
-					struct audio_stream_in **stream_in)
+					struct audio_stream_in **stream_in,
+					audio_input_flags_t flags,
+					const char *address,
+					audio_source_t source)
 {
 	struct audio_stream_in *in;
 
@@ -1287,6 +1315,32 @@ static int audio_open_input_stream(struct audio_hw_device *dev,
 	return 0;
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static int audio_open_input_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					struct audio_config *config,
+					struct audio_stream_in **stream_in,
+					audio_input_flags_t flags,
+					const char *address,
+					audio_source_t source)
+{
+	return audio_open_input_stream_real(dev, handle, devices, config,
+						stream_in, flags, address,
+						source);
+}
+#else
+static int audio_open_input_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					struct audio_config *config,
+					struct audio_stream_in **stream_in)
+{
+	return audio_open_input_stream_real(dev, handle, devices, config,
+						stream_in, 0, NULL, 0);
+}
+#endif
+
 static void audio_close_input_stream(struct audio_hw_device *dev,
 					struct audio_stream_in *stream_in)
 {
-- 
1.9.1

