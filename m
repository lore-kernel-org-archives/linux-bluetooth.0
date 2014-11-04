Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 06/47] android/hal-sco: Add support for new Android API
Date: Tue,  4 Nov 2014 10:18:29 +0200
Message-Id: <1415089150-18798-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add new parameters to sco_open_input_stream() and
sco_open_output_stream() for the new API.
---
 android/hal-sco.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 91a3baf..231be33 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -612,12 +612,22 @@ static int out_remove_audio_effect(const struct audio_stream *stream,
 	return -ENOSYS;
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int sco_open_output_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					audio_output_flags_t flags,
+					struct audio_config *config,
+					struct audio_stream_out **stream_out,
+					const char *address)
+#else
 static int sco_open_output_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					audio_output_flags_t flags,
 					struct audio_config *config,
 					struct audio_stream_out **stream_out)
+#endif
 {
 	struct sco_dev *adev = (struct sco_dev *) dev;
 	struct sco_stream_out *out;
@@ -1060,11 +1070,22 @@ static uint32_t in_get_input_frames_lost(struct audio_stream_in *stream)
 	return -ENOSYS;
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int sco_open_input_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					struct audio_config *config,
+					struct audio_stream_in **stream_in,
+					audio_input_flags_t flags,
+					const char *address,
+					audio_source_t source)
+#else
 static int sco_open_input_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
 					struct audio_config *config,
 					struct audio_stream_in **stream_in)
+#endif
 {
 	struct sco_dev *sco_dev = (struct sco_dev *) dev;
 	struct sco_stream_in *in;
-- 
1.9.1

