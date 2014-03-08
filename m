Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/20] android/handsfree: Add support for ATD command
Date: Sat,  8 Mar 2014 01:19:58 +0100
Message-Id: <1394238004-15691-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 8a5a6cf..ad033be 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -335,9 +335,41 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	char buf[IPC_MTU];
+	struct hal_ev_handsfree_dial *ev = (void*) buf;
+	int cnt;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_unquoted_string(result,
+						(char *) ev->number, 255))
+			break;
+
+		ev->number_len = strlen((char *) ev->number);
+
+		if (ev->number[ev->number_len - 1] != ';')
+			break;
+
+		if (ev->number[0] == '>')
+			cnt = strspn((char *) ev->number + 1, "0123456789") + 1;
+		else
+			cnt = strspn((char *) ev->number, "0123456789ABC*#+");
+
+		if (cnt != ev->number_len - 1)
+			break;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_DIAL,
+					sizeof(*ev) + ev->number_len, ev);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
@@ -460,7 +492,8 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);}
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+}
 
 static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
-- 
1.8.5.3

