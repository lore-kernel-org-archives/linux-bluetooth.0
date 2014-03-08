Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/20] android/handsfree: Add support for AT+CHLD command
Date: Sat,  8 Mar 2014 01:19:51 +0100
Message-Id: <1394238004-15691-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a2991b6..76fd82c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -72,6 +72,8 @@
 			HFP_AG_FEAT_VR | HFP_AG_FEAT_REJ_CALL |\
 			HFP_AG_FEAT_ECS | HFP_AG_FEAT_EXT_ERR )
 
+#define HFP_AG_CHLD_STR "0,1,2,3"
+
 /* offsets in indicators table, should be incremented when sending CIEV */
 #define IND_SERVICE	0
 #define IND_CALL	1
@@ -616,12 +618,14 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		device.indicators_enabled = val;
 
-		/* TODO Check for 3-way calling support */
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		if (device.features & HFP_HF_FEAT_3WAY)
+			return;
+
 		register_post_slc_at();
 		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
-
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
@@ -713,9 +717,39 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	struct hal_ev_handsfree_chld ev;
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_number(result, &val) || val > 3)
+			break;
+
+		/* No ECC support */
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		/* value match HAL type */
+		ev.chld = val;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_CHLD, sizeof(ev), &ev);
+
+		return;
+	case HFP_GW_CMD_TYPE_TEST:
+		hfp_gw_send_info(device.gw, "+CHLD=%s", HFP_AG_CHLD_STR);
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		register_post_slc_at();
+		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
-- 
1.8.5.3

