Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/20] android/handsfree: Add support for AT+CMEE command
Date: Sat,  8 Mar 2014 01:19:52 +0100
Message-Id: <1394238004-15691-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 76fd82c..f4c78aa 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -107,6 +107,7 @@ static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
 	uint32_t features;
+	bool cmee_enabled;
 	bool indicators_enabled;
 	struct indicator inds[IND_COUNT];
 	bool hsp;
@@ -371,9 +372,28 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		device.cmee_enabled = val;
+
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
@@ -1312,10 +1332,10 @@ static void handle_at_resp(const void *buf, uint16_t len)
 
 	DBG("");
 
-	/* TODO handle +CME ERROR when AT+CMEE support is added */
-
 	if (cmd->response == HAL_HANDSFREE_AT_RESPONSE_OK)
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+	else if (device.cmee_enabled)
+		hfp_gw_send_error(device.gw, cmd->error);
 	else
 		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 
-- 
1.8.5.3

