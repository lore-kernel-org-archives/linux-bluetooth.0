Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/13] android/handsfree: Pass device pointer when registering AT commands
Date: Wed,  8 Oct 2014 09:12:15 +0200
Message-Id: <1412752343-7001-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 74 ++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index e66fa84..f5b5169 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1064,36 +1064,36 @@ static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void register_post_slc_at(void)
+static void register_post_slc_at(struct hf_device *dev)
 {
-	if (device.hsp) {
-		hfp_gw_register(device.gw, at_cmd_ckpd, "+CKPD", &device, NULL);
-		hfp_gw_register(device.gw, at_cmd_vgs, "+VGS", &device, NULL);
-		hfp_gw_register(device.gw, at_cmd_vgm, "+VGM", &device, NULL);
+	if (dev->hsp) {
+		hfp_gw_register(dev->gw, at_cmd_ckpd, "+CKPD", dev, NULL);
+		hfp_gw_register(dev->gw, at_cmd_vgs, "+VGS", dev, NULL);
+		hfp_gw_register(dev->gw, at_cmd_vgm, "+VGM", dev, NULL);
 		return;
 	}
 
-	hfp_gw_register(device.gw, at_cmd_a, "A", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_d, "D", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_ccwa, "+CCWA", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_chup, "+CHUP", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_clcc, "+CLCC", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_cops, "+COPS", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_cmee, "+CMEE", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_clip, "+CLIP", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_vts, "+VTS", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_cnum, "+CNUM", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bia, "+BIA", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_binp, "+BINP", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bldn, "+BLDN", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bvra, "+BVRA", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_nrec, "+NREC", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_vgs, "+VGS", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_vgm, "+VGM", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bsir, "+BSIR", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_btrh, "+BTRH", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bcc, "+BCC", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bcs, "+BCS", &device, NULL);
+	hfp_gw_register(dev->gw, at_cmd_a, "A", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_d, "D", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_ccwa, "+CCWA", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_chup, "+CHUP", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_clcc, "+CLCC", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_cops, "+COPS", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_cmee, "+CMEE", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_clip, "+CLIP", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_vts, "+VTS", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_cnum, "+CNUM", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bia, "+BIA", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_binp, "+BINP", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bldn, "+BLDN", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bvra, "+BVRA", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_nrec, "+NREC", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_vgs, "+VGS", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_vgm, "+VGM", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bsir, "+BSIR", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_btrh, "+BTRH", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bcc, "+BCC", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bcs, "+BCS", dev, NULL);
 }
 
 static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
@@ -1130,7 +1130,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (dev->features & HFP_HF_FEAT_3WAY)
 			return;
 
-		register_post_slc_at();
+		register_post_slc_at(dev);
 		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1257,7 +1257,7 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_send_info(dev->gw, "+CHLD: (%s)", HFP_AG_CHLD);
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
-		register_post_slc_at();
+		register_post_slc_at(dev);
 		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
@@ -1341,13 +1341,13 @@ failed:
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void register_slc_at(void)
+static void register_slc_at(struct hf_device *dev)
 {
-	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_chld, "+CHLD", &device, NULL);
-	hfp_gw_register(device.gw, at_cmd_bac, "+BAC", &device, NULL);
+	hfp_gw_register(dev->gw, at_cmd_brsf, "+BRSF", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_cind, "+CIND", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_cmer, "+CMER", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_chld, "+CHLD", dev, NULL);
+	hfp_gw_register(dev->gw, at_cmd_bac, "+BAC", dev, NULL);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -1368,17 +1368,17 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
 	hfp_gw_set_close_on_unref(dev->gw, true);
-	hfp_gw_set_command_handler(dev->gw, at_cmd_unknown, NULL, NULL);
+	hfp_gw_set_command_handler(dev->gw, at_cmd_unknown, dev, NULL);
 	hfp_gw_set_disconnect_handler(dev->gw, disconnect_watch, NULL, NULL);
 
 	if (dev->hsp) {
-		register_post_slc_at();
+		register_post_slc_at(dev);
 		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
 		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	}
 
-	register_slc_at();
+	register_slc_at(dev);
 	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
 	return;
 
-- 
1.9.1

