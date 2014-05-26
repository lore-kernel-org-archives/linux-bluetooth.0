Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 23/26] android/a2dp: Add support to check aptX capabilities
Date: Mon, 26 May 2014 15:16:49 +0200
Message-ID: <1401110212-11526-24-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index a65c94d..f825cce 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -373,10 +373,40 @@ static int mpeg24_check_config(void *caps, uint8_t caps_len, void *conf,
 	return 0;
 }
 
+static int aptx_check_config(void *caps, uint8_t caps_len, void *conf,
+							uint8_t conf_len)
+{
+	a2dp_aptx_t *cap, *config;
+
+	if (conf_len != caps_len || conf_len != sizeof(a2dp_aptx_t)) {
+		error("APTX: Invalid configuration size (%u)", conf_len);
+		return -EINVAL;
+	}
+
+	cap = caps;
+	config = conf;
+
+	if (!(cap->frequency & config->frequency)) {
+		error("APTX: Unsupported frequenct (%u) by endpoint",
+							config->frequency);
+		return -EINVAL;
+	}
+
+	if (!(cap->channel_mode & config->channel_mode)) {
+		error("AAC: Unsupported channel mode (%u) by endpoint",
+							config->channel_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int check_capabilities(struct a2dp_preset *preset,
 				struct avdtp_media_codec_capability *codec,
 				uint8_t codec_len)
 {
+	a2dp_vendor_codec_t *vndcodec;
+
 	/* Codec specific */
 	switch (codec->media_codec_type) {
 	case A2DP_CODEC_SBC:
@@ -385,6 +415,13 @@ static int check_capabilities(struct a2dp_preset *preset,
 	case A2DP_CODEC_MPEG24:
 		return mpeg24_check_config(codec->data, codec_len, preset->data,
 								preset->len);
+	case A2DP_CODEC_VENDOR:
+		vndcodec = (void *) codec->data;
+		if (btohl(vndcodec->vendor_id) == APTX_VENDOR_ID &&
+				btohs(vndcodec->codec_id) == APTX_CODEC_ID)
+			return aptx_check_config(codec->data, codec_len,
+						preset->data, preset->len);
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
-- 
1.9.3

