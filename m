Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 06/28] android/hal-sco: Make use of config parameter
Date: Wed,  4 Jun 2014 17:17:37 +0300
Message-Id: <1401891479-11965-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use config parameter when opening output stream.
---
 android/hal-sco.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index f3ccb0d..292ced2 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -582,7 +582,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 	size_t resample_size;
 	uint16_t mtu;
 
-	DBG("");
+	DBG("config %p device flags 0x%02x", config, devices);
 
 	if (ipc_connect_sco(&fd, &mtu) != SCO_STATUS_SUCCESS) {
 		error("sco: cannot get fd");
@@ -612,10 +612,20 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 	out->stream.write = out_write;
 	out->stream.get_render_position = out_get_render_position;
 
-	/* Configuration for Android */
-	out->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
-	out->cfg.channels = AUDIO_CHANNEL_OUT_STEREO;
-	out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
+	if (config) {
+		DBG("config: rate %u chan mask %x format %d offload %p",
+				config->sample_rate, config->channel_mask,
+				config->format, &config->offload_info);
+
+		out->cfg.format = config->format;
+		out->cfg.channels = config->channel_mask;
+		out->cfg.rate = config->sample_rate;
+	} else {
+		out->cfg.format = AUDIO_STREAM_DEFAULT_FORMAT;
+		out->cfg.channels = AUDIO_CHANNEL_OUT_STEREO;
+		out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
+	}
+
 	out->cfg.frame_num = OUT_STREAM_FRAMES;
 
 	/* we get wrong mtu size for some reason */
-- 
1.8.3.2

