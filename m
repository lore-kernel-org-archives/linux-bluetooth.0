Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/5] android/handsfree-client: Send AT+BCC to start codec negotiation
Date: Fri, 28 Nov 2014 10:37:24 +0100
Message-Id: <1417167445-29099-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch we start codec negotation on audio connect if both sides
does support it.

This patch also moves codec_negotiation_supported functions up in the
file
---
 android/handsfree-client.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index fd68d78..9818a47 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -312,9 +312,26 @@ static void set_audio_state(struct device *dev, uint8_t state)
 				HAL_EV_HF_CLIENT_AUDIO_STATE, sizeof(ev), &ev);
 }
 
+static void bcc_cb(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	if (result != HFP_RESULT_OK)
+		set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED);
+}
+
+static bool codec_negotiation_supported(struct device *dev)
+{
+	return (dev->features & HFP_AG_FEAT_CODEC) &&
+			(hfp_hf_features & HFP_HF_FEAT_CODEC);
+}
+
 static bool connect_sco(struct device *dev)
 {
-	/* TODO: handle codec negotiation */
+	if (codec_negotiation_supported(dev))
+		return hfp_hf_send_command(dev->hf, bcc_cb, dev,
+								"AT+BCC");
 
 	return bt_sco_connect(sco, &dev->bdaddr, BT_VOICE_CVSD_16BIT);
 }
@@ -383,7 +400,6 @@ static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
 	struct hal_ev_hf_client_command_complete ev;
 
 	DBG("");
-
 	memset(&ev, 0, sizeof(ev));
 
 	switch (result) {
@@ -1653,12 +1669,6 @@ static void slc_brsf_cb(struct hfp_context *context, void *user_data)
 		dev->features = feat;
 }
 
-static bool codec_negotiation_supported(struct device *dev)
-{
-	return (dev->features & HFP_AG_FEAT_CODEC) &&
-			(hfp_hf_features & HFP_HF_FEAT_CODEC);
-}
-
 static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
-- 
1.8.4

