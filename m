Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/20] android/handsfree: Add support for AT+NREC command
Date: Sat,  8 Mar 2014 01:19:49 +0100
Message-Id: <1394238004-15691-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h   |  2 +-
 android/handsfree.c | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8859454..0abbbe6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1029,7 +1029,7 @@ struct hal_ev_handsfree_dtmf {
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_NREC_STOP		0x00
-#define HAL_HANDSFREE_NREC_STart	0x01
+#define HAL_HANDSFREE_NREC_START	0x01
 
 #define HAL_EV_HANDSFREE_NREC		0x89
 struct hal_ev_handsfree_nrec {
diff --git a/android/handsfree.c b/android/handsfree.c
index b0226e8..31eaabe 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -450,9 +450,37 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	struct hal_ev_handsfree_nrec ev;
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		/* Android HAL defines start and stop parameter for NREC
+		 * callback, but spec allows HF to only disable AG's NREC
+		 * feature for SLC duration. Follow spec here.
+		 */
+		if (!hfp_gw_result_get_number(result, &val) || val != 0)
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		ev.nrec = HAL_HANDSFREE_NREC_STOP;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_NREC, sizeof(ev), &ev);
+
+		/* Framework is not replying with result for AT+NREC */
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
-- 
1.8.5.3

