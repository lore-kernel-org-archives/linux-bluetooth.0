Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] android/hal-sco: Save bd_addr for output stream of Audio SCO HAL
Date: Wed,  5 Nov 2014 10:41:19 +0200
Message-Id: <1415176882-12397-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make use of address field which makes possible to query right SCO fd
from handsfree multi-client code.
---
 android/Android.mk |  3 ++-
 android/hal-sco.c  | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index aefe41c..bfdf03f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -382,7 +382,8 @@ include $(BUILD_SHARED_LIBRARY)
 
 include $(CLEAR_VARS)
 
-LOCAL_SRC_FILES := bluez/android/hal-sco.c
+LOCAL_SRC_FILES := bluez/android/hal-sco.c \
+	bluez/android/hal-utils.c
 
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
diff --git a/android/hal-sco.c b/android/hal-sco.c
index c5b86b0..e84dae0 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -79,6 +79,8 @@ struct sco_stream_out {
 	struct resampler_itfe *resampler;
 	int16_t *resample_buf;
 	uint32_t resample_frame_num;
+
+	bt_bdaddr_t bd_addr;
 };
 
 static void sco_close_socket(void)
@@ -667,6 +669,14 @@ static int sco_open_output_stream_real(struct audio_hw_device *dev,
 	out->stream.write = out_write;
 	out->stream.get_render_position = out_get_render_position;
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	if (address) {
+		DBG("address %s", address);
+
+		str2bt_bdaddr_t(address, &out->bd_addr);
+	}
+#endif
+
 	if (config) {
 		DBG("config: rate %u chan mask %x format %d offload %p",
 				config->sample_rate, config->channel_mask,
-- 
1.9.1

