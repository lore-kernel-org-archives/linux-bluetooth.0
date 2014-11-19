Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 15/15] android/handsfree-client: Implement codec negotiations
Date: Wed, 19 Nov 2014 10:43:48 +0100
Message-Id: <1416390228-28330-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index fbee44e..c3d955e 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -116,6 +116,7 @@ struct device {
 	struct hfp_hf *hf;
 	uint8_t state;
 
+	uint8_t negotiated_codec;
 	uint32_t features;
 	struct hfp_codec codecs[2];
 
@@ -1021,6 +1022,55 @@ static void binp_cb(struct hfp_context *context, void *user_data)
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
+	if (result != HFP_RESULT_OK)
+		error("hf-client: Error on AT+BCS (err=%u)", result);
+}
+
+static void bcs_cb(struct hfp_context *context, void *user_data)
+{
+	struct device *dev = user_data;
+	unsigned int codec;
+	char codecs_string[8];
+
+	DBG("");
+
+	if (!hfp_context_get_number(context, &codec))
+		goto failed;
+
+	if (!is_codec_supported_localy(dev, codec))
+		goto failed;
+
+	dev->negotiated_codec = codec;
+
+	hfp_hf_send_command(dev->hf, bcs_resp, dev, "AT+BCS=%d", codec);
+
+	return;
+
+failed:
+	error("hf-client: Could not get codec");
+
+	get_local_codecs_string(dev, codecs_string, sizeof(codecs_string));
+
+	hfp_hf_send_command(dev->hf, bcs_resp, dev, "AT+BCS=%s", codecs_string);
+}
+
 static void slc_completed(struct device *dev)
 {
 	int i;
@@ -1051,6 +1101,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
 	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
 	hfp_hf_register(dev->hf, binp_cb, "+BINP", dev, NULL);
+	hfp_hf_register(dev->hf, bcs_cb, "+BCS", dev, NULL);
 
 	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
 		info("hf-client: Could not send AT+COPS=3,0");
-- 
1.8.4

