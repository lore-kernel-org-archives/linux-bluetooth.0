Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/13] android/handsfree: Pass device pointer to codec handling functions
Date: Wed,  8 Oct 2014 09:12:16 +0200
Message-Id: <1412752343-7001-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index f5b5169..7c8020c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -865,7 +865,7 @@ static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
-static void select_codec(uint8_t codec_type)
+static void select_codec(struct hf_device *dev, uint8_t codec_type)
 {
 	uint8_t type = CODEC_ID_CVSD;
 	int i;
@@ -876,20 +876,20 @@ static void select_codec(uint8_t codec_type)
 	}
 
 	for (i = CODECS_COUNT - 1; i >= CVSD_OFFSET; i--) {
-		if (!device.codecs[i].local_supported)
+		if (!dev->codecs[i].local_supported)
 			continue;
 
-		if (!device.codecs[i].remote_supported)
+		if (!dev->codecs[i].remote_supported)
 			continue;
 
-		type = device.codecs[i].type;
+		type = dev->codecs[i].type;
 		break;
 	}
 
 done:
-	device.proposed_codec = type;
+	dev->proposed_codec = type;
 
-	hfp_gw_send_info(device.gw, "+BCS: %u", type);
+	hfp_gw_send_info(dev->gw, "+BCS: %u", type);
 }
 
 static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -906,7 +906,7 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		/* If other failed, try connecting with CVSD */
 		if (device.negotiated_codec != CODEC_ID_CVSD) {
 			info("handsfree: trying fallback with CVSD");
-			select_codec(CODEC_ID_CVSD);
+			select_codec(&device, CODEC_ID_CVSD);
 		}
 
 		return;
@@ -975,7 +975,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		/* we haven't negotiated codec, start selection */
 		if (!dev->negotiated_codec) {
-			select_codec(0);
+			select_codec(dev, 0);
 			return;
 		}
 		/*
@@ -983,7 +983,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		 * CVSD codec, try connect CVSD
 		 */
 		if (!connect_sco() && dev->negotiated_codec != CODEC_ID_CVSD)
-			select_codec(CODEC_ID_CVSD);
+			select_codec(dev, CODEC_ID_CVSD);
 
 		return;
 	case HFP_GW_CMD_TYPE_READ:
@@ -1268,13 +1268,13 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static struct hfp_codec *find_codec_by_type(uint8_t type)
+static struct hfp_codec *find_codec_by_type(struct hf_device *dev, uint8_t type)
 {
 	int i;
 
 	for (i = 0; i < CODECS_COUNT; i++)
-		if (type == device.codecs[i].type)
-			return &device.codecs[i];
+		if (type == dev->codecs[i].type)
+			return &dev->codecs[i];
 
 	return NULL;
 }
@@ -1319,7 +1319,7 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			if (!hfp_gw_result_get_number(result, &val))
 				goto failed;
 
-			codec = find_codec_by_type(val);
+			codec = find_codec_by_type(dev, val);
 			if (!codec)
 				continue;
 
@@ -1329,7 +1329,7 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		if (dev->proposed_codec)
-			select_codec(0);
+			select_codec(dev, 0);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
@@ -1699,7 +1699,7 @@ static bool connect_audio(void)
 
 	/* we haven't negotiated codec, start selection */
 	if ((device.features & HFP_HF_FEAT_CODEC) && !device.negotiated_codec) {
-		select_codec(0);
+		select_codec(&device, 0);
 		return true;
 	}
 
-- 
1.9.1

