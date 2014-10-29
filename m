Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/handsfree: Add helper to check codec negotiation support
Date: Thu, 30 Oct 2014 00:07:32 +0100
Message-Id: <1414624053-24250-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds helper to test if codec negotiation is supported.

This patch fixes also logic behind that. So far we assumed that codec
negotiation is there if HFP HF does support it, even HFP AG does not
support it. It cause a problem with e.g. SLC creation in scenario where
HFP AG is not supporting codec negoctiation. In such a case we
incorrectly reply with ERROR on AT+CIND? because we incorretly expected
AT+BAC before that command. Issue found on UPF.
---
 android/handsfree.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 356dbe0..595919a 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -938,6 +938,12 @@ done:
 	hfp_gw_send_info(dev->gw, "+BCS: %u", type);
 }
 
+static bool codec_negotiation_supported(struct hf_device *dev)
+{
+	return (dev->features & HFP_HF_FEAT_CODEC) &&
+			(hfp_ag_features & HFP_AG_FEAT_CODEC);
+}
+
 static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hf_device *dev = user_data;
@@ -947,7 +953,7 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 		set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
-		if (!(dev->features & HFP_HF_FEAT_CODEC))
+		if (!codec_negotiation_supported(dev))
 			return;
 
 		/* If other failed, try connecting with CVSD */
@@ -977,7 +983,7 @@ static bool connect_sco(struct hf_device *dev)
 	if (dev->sco)
 		return false;
 
-	if (!(dev->features & HFP_HF_FEAT_CODEC))
+	if (!codec_negotiation_supported(dev))
 		voice_settings = 0;
 	else if (dev->negotiated_codec != CODEC_ID_CVSD)
 		voice_settings = BT_VOICE_TRANSPARENT;
@@ -1012,7 +1018,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (!(dev->features & HFP_HF_FEAT_CODEC))
+		if (!codec_negotiation_supported(dev))
 			break;
 
 		if (hfp_gw_result_has_next(result))
@@ -1204,7 +1210,7 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		 * If device supports Codec Negotiation, AT+BAC should be
 		 * received first
 		 */
-		if ((dev->features & HFP_HF_FEAT_CODEC) &&
+		if (codec_negotiation_supported(dev) &&
 				!dev->codecs[CVSD_OFFSET].remote_supported)
 			break;
 
@@ -1336,7 +1342,7 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!(dev->features & HFP_HF_FEAT_CODEC))
+		if (!codec_negotiation_supported(dev))
 			goto failed;
 
 		/* set codecs to defaults */
@@ -1765,7 +1771,7 @@ static bool connect_audio(struct hf_device *dev)
 		return false;
 
 	/* we haven't negotiated codec, start selection */
-	if ((dev->features & HFP_HF_FEAT_CODEC) && !dev->negotiated_codec) {
+	if (codec_negotiation_supported(dev) && !dev->negotiated_codec) {
 		select_codec(dev, 0);
 		return true;
 	}
-- 
1.8.4

