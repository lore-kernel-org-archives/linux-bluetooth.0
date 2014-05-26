Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 22/26] android/a2dp: Add support to check MPEG-2,4 AAC caps
Date: Mon, 26 May 2014 15:16:48 +0200
Message-ID: <1401110212-11526-23-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 0b586a8..a65c94d 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -327,6 +327,52 @@ static int sbc_check_config(void *caps, uint8_t caps_len, void *conf,
 	return 0;
 }
 
+static int mpeg24_check_config(void *caps, uint8_t caps_len, void *conf,
+							uint8_t conf_len)
+{
+	a2dp_aac_t *cap, *config;
+
+	if (conf_len != caps_len || conf_len != sizeof(a2dp_aac_t)) {
+		error("AAC: Invalid configuration size (%u)", conf_len);
+		return -EINVAL;
+	}
+
+	cap = caps;
+	config = conf;
+
+	if (!(cap->object_type & config->object_type)) {
+		error("AAC: Unsupported object type (%u) by endpoint",
+							config->object_type);
+		return -EINVAL;
+	}
+
+	if (!(AAC_GET_FREQUENCY(*cap) & AAC_GET_FREQUENCY(*config))) {
+		error("AAC: Unsupported frequency (%u) by endpoint",
+						AAC_GET_FREQUENCY(*config));
+		return -EINVAL;
+	}
+
+	if (!(cap->channels & config->channels)) {
+		error("AAC: Unsupported channels (%u) by endpoint",
+							config->channels);
+		return -EINVAL;
+	}
+
+	/* VBR support in SNK is mandatory but let's make sure we don't try to
+	 * have VBR on remote which for some reason does not support it
+	 */
+	if (!cap->vbr && config->vbr) {
+		error("AAC: Unsupported VBR (%u) by endpoint",
+							config->vbr);
+		return -EINVAL;
+	}
+
+	if (AAC_GET_BITRATE(*cap) < AAC_GET_BITRATE(*config))
+		return -ERANGE;
+
+	return 0;
+}
+
 static int check_capabilities(struct a2dp_preset *preset,
 				struct avdtp_media_codec_capability *codec,
 				uint8_t codec_len)
@@ -336,6 +382,9 @@ static int check_capabilities(struct a2dp_preset *preset,
 	case A2DP_CODEC_SBC:
 		return sbc_check_config(codec->data, codec_len, preset->data,
 								preset->len);
+	case A2DP_CODEC_MPEG24:
+		return mpeg24_check_config(codec->data, codec_len, preset->data,
+								preset->len);
 	default:
 		return -EINVAL;
 	}
@@ -360,6 +409,26 @@ static struct a2dp_preset *sbc_select_range(void *caps, uint8_t caps_len,
 	return p;
 }
 
+static struct a2dp_preset *mpeg24_select_range(void *caps, uint8_t caps_len,
+						void *conf, uint8_t conf_len)
+{
+	struct a2dp_preset *p;
+	a2dp_aac_t *cap, *config;
+	uint32_t bitrate;
+
+	cap = caps;
+	config = conf;
+
+	bitrate = MIN(AAC_GET_BITRATE(*cap), AAC_GET_BITRATE(*config));
+	AAC_SET_BITRATE(*config, bitrate);
+
+	p = g_new0(struct a2dp_preset, 1);
+	p->len = conf_len;
+	p->data = g_memdup(conf, p->len);
+
+	return p;
+}
+
 static struct a2dp_preset *select_preset_range(struct a2dp_preset *preset,
 				struct avdtp_media_codec_capability *codec,
 				uint8_t codec_len)
@@ -369,6 +438,9 @@ static struct a2dp_preset *select_preset_range(struct a2dp_preset *preset,
 	case A2DP_CODEC_SBC:
 		return sbc_select_range(codec->data, codec_len, preset->data,
 								preset->len);
+	case A2DP_CODEC_MPEG24:
+		return mpeg24_select_range(codec->data, codec_len, preset->data,
+								preset->len);
 	default:
 		return NULL;
 	}
-- 
1.9.3

