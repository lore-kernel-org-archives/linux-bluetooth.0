Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 16/20] android/handsfree: Add support for AT+CHUP command
Date: Sat,  8 Mar 2014 01:20:00 +0100
Message-Id: <1394238004-15691-17-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 16f079f..c1ae359 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -389,7 +389,23 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 {
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_COMMAND:
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_HANGUP, 0, NULL);
+
+		/* Framework is not replying with result for AT+CHUP */
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_SET:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
-- 
1.8.5.3

