Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/20] android/handsfree: Add support for ATA command
Date: Sat,  8 Mar 2014 01:19:56 +0100
Message-Id: <1394238004-15691-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index e7d3975..e88b06a 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -311,7 +311,23 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 {
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_COMMAND:
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_ANSWER, 0, NULL);
+
+		/* Framework is not replying with result for ATA */
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_SET:
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
-- 
1.8.5.3

