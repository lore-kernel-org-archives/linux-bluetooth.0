Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] android/hal-sco: Save bd_addr for input stream of Audio SCO HAL
Date: Wed,  5 Nov 2014 10:41:20 +0200
Message-Id: <1415176882-12397-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make use of address field which makes possible to query right SCO fd
from handsfree multi-client code.
---
 android/hal-sco.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index e84dae0..442e2d0 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -103,6 +103,8 @@ struct sco_stream_in {
 	struct resampler_itfe *resampler;
 	int16_t *resample_buf;
 	uint32_t resample_frame_num;
+
+	bt_bdaddr_t bd_addr;
 };
 
 struct sco_dev {
@@ -1158,6 +1160,14 @@ static int sco_open_input_stream_real(struct audio_hw_device *dev,
 	in->stream.read = in_read;
 	in->stream.get_input_frames_lost = in_get_input_frames_lost;
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	if (address) {
+		DBG("address %s", address);
+
+		str2bt_bdaddr_t(address, &in->bd_addr);
+	}
+#endif
+
 	if (config) {
 		DBG("config: rate %u chan mask %x format %d offload %p",
 				config->sample_rate, config->channel_mask,
-- 
1.9.1

