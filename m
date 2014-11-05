Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] android/hal-sco: Implement dummy SCO HAL functions
Date: Wed,  5 Nov 2014 10:41:18 +0200
Message-Id: <1415176882-12397-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Prevent from crash and print debug statements.
---
 android/hal-sco.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index ca3022e..c5b86b0 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1271,6 +1271,51 @@ static int sco_dump(const audio_hw_device_t *device, int fd)
 	return 0;
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
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
 static int sco_close(hw_device_t *device)
 {
 	DBG("");
@@ -1424,6 +1469,14 @@ static int sco_open(const hw_module_t *module, const char *name,
 	dev->dev.open_input_stream = sco_open_input_stream;
 	dev->dev.close_input_stream = sco_close_input_stream;
 	dev->dev.dump = sco_dump;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	dev->dev.set_master_mute = set_master_mute;
+	dev->dev.get_master_mute = get_master_mute;
+	dev->dev.create_audio_patch = create_audio_patch;
+	dev->dev.release_audio_patch = release_audio_patch;
+	dev->dev.get_audio_port = get_audio_port;
+	dev->dev.set_audio_port_config = set_audio_port_config;
+#endif
 
 	*device = &dev->dev.common;
 
-- 
1.9.1

