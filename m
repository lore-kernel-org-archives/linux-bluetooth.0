Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 14/14] android/handsfree-client: Implement codec negotiations
Date: Wed, 12 Nov 2014 11:49:37 +0100
Message-Id: <1415789377-20458-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 4338c11..74d1547 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -116,6 +116,7 @@ struct device {
 	struct hfp_hf *hf;
 	uint8_t state;
 
+	uint8_t negotiated_codec;
 	uint32_t features;
 	struct hfp_codec codecs[2];
 
@@ -1034,6 +1035,66 @@ static void binp_cb(struct hfp_context *context, void *user_data)
 					sizeof(*ev) + ev->number_len, ev);
 }
 
+static bool is_codec_supported_localy(struct device *dev, uint8_t codec)
+{
+	int i;
+
+	for (i = 0; i < CODECS_COUNT; i++) {
+		if (dev->codecs[i].type != codec)
+			continue;
+
+		return dev->codecs[i].local_supported;
+	}
+
+	return false;
+}
+
+static void bcs_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	DBG("%d", result);
+}
+
+static void bcs_cb(struct hfp_context *context, void *user_data)
+{
+	struct device *dev = user_data;
+	uint32_t codec;
+	char codecs_string[2 * CODECS_COUNT + 1];
+	char cmd[sizeof(codecs_string) + 7];
+
+	DBG("");
+
+	if (!context) {
+		error("hf-client: incorrect BCS response");
+		return;
+	}
+
+	memset(cmd, 0, sizeof(cmd));
+
+	if (!hfp_context_get_number(context, &codec))
+		goto failed;
+
+	if (!is_codec_supported_localy(dev, codec))
+		goto failed;
+
+	sprintf(cmd, "AT+BCS=%d", codec);
+
+	dev->negotiated_codec = codec;
+
+	goto done;
+
+failed:
+	error("hf-client: Could not get codec");
+
+	strcpy(cmd, "AT+BCS=");
+
+	get_local_codecs_string(dev, codecs_string, sizeof(codecs_string));
+	strcat(cmd, codecs_string);
+
+done:
+	hfp_hf_send_command(dev->hf, bcs_resp, dev, cmd);
+}
+
 static void slc_completed(struct device *dev)
 {
 	int i;
@@ -1064,6 +1125,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
 	hfp_hf_register(dev->hf, binp_cb, "+BINP", dev, NULL);
+	hfp_hf_register(dev->hf, bcs_cb, "+BCS", dev, NULL);
 
 	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
 		info("hf-client: Could not send AT+COPS=3,0");
-- 
1.8.4

