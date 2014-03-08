Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 15/20] android/handsfree: Add support for AT+BLDN command
Date: Sat,  8 Mar 2014 01:19:59 +0100
Message-Id: <1394238004-15691-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index ad033be..16f079f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -531,11 +531,26 @@ static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	struct hal_ev_handsfree_dial ev;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_COMMAND:
+		if (hfp_gw_result_has_next(result))
+			break;
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+		ev.number_len = 0;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_DIAL, sizeof(ev), &ev);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_SET:
+		break;
+	}
 }
 
 static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-- 
1.8.5.3

