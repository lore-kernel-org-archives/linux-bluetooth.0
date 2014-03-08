Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/20] android/handsfree: Add support for AT+VTS command
Date: Sat,  8 Mar 2014 01:19:55 +0100
Message-Id: <1394238004-15691-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 123cff0..e7d3975 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -411,12 +411,40 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	struct hal_ev_handsfree_dtmf ev;
+	char str[2];
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_unquoted_string(result, str, 2))
+			break;
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
-}
+		if (!((str[0] >= '0' && str[0] <='9') ||
+				(str[0] >= 'A' && str[0] <= 'D') ||
+				str[0] == '*' || str[0] == '#'))
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		ev.tone = str[0];
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_DTMF, sizeof(ev), &ev);
+
+		/* Framework is not replying with result for AT+VTS */
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);}
 
 static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
-- 
1.8.5.3

