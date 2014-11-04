Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 05/47] android/hal-audio: Implement dummy Audio HAL functions
Date: Tue,  4 Nov 2014 10:18:28 +0200
Message-Id: <1415089150-18798-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Enable debug prints and prevent crash.
---
 android/hal-audio.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index d140071..12b1569 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1320,6 +1320,51 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 	return -ENOSYS;
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int set_master_mute(struct audio_hw_device *dev, bool mute)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int get_master_mute(struct audio_hw_device *dev, bool *mute)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int create_audio_patch(struct audio_hw_device *dev,
+					unsigned int num_sources,
+					const struct audio_port_config *sources,
+					unsigned int num_sinks,
+					const struct audio_port_config *sinks,
+					audio_patch_handle_t *handle)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int release_audio_patch(struct audio_hw_device *dev,
+					audio_patch_handle_t handle)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int get_audio_port(struct audio_hw_device *dev, struct audio_port *port)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int set_audio_port_config(struct audio_hw_device *dev,
+					const struct audio_port_config *config)
+{
+	DBG("");
+	return -ENOSYS;
+}
+#endif
+
 static int audio_close(hw_device_t *device)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)device;
@@ -1516,6 +1561,14 @@ static int audio_open(const hw_module_t *module, const char *name,
 	a2dp_dev->dev.open_input_stream = audio_open_input_stream;
 	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
 	a2dp_dev->dev.dump = audio_dump;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	a2dp_dev->dev.set_master_mute = set_master_mute;
+	a2dp_dev->dev.get_master_mute = get_master_mute;
+	a2dp_dev->dev.create_audio_patch = create_audio_patch;
+	a2dp_dev->dev.release_audio_patch = release_audio_patch;
+	a2dp_dev->dev.get_audio_port = get_audio_port;
+	a2dp_dev->dev.set_audio_port_config = set_audio_port_config;
+#endif
 
 	for (i = 0; i < NUM_CODECS; i++) {
 		const struct audio_codec *codec = audio_codecs[i].get_codec();
-- 
1.9.1

