Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/7] android: Add initial code for hidhost get and set report
Date: Wed, 23 Oct 2013 00:41:57 -0700
Message-Id: <1382514120-13152-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the initial code for hidhost .get_report and .set_report
interfaces
---
 android/hal-hidhost.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f289f7f..22045f1 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -167,6 +167,8 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 						uint8_t reportId,
 						int bufferSize)
 {
+	struct hal_msg_cmd_bt_hid_get_report cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -175,13 +177,31 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.id = reportId;
+
+	switch (reportType) {
+	case BTHH_INPUT_REPORT:
+		cmd.type = HAL_MSG_BT_HID_INPUT_REPORT;
+		break;
+	case BTHH_OUTPUT_REPORT:
+		cmd.type = HAL_MSG_BT_HID_OUTPUT_REPORT;
+		break;
+	case BTHH_FEATURE_REPORT:
+		cmd.type = HAL_MSG_BT_HID_FEATURE_REPORT;
+		break;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_GET_REPORT,
+			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t reportType,
 						char *report)
 {
+	struct hal_msg_cmd_bt_hid_set_report cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -190,7 +210,22 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 	if (!bd_addr || !report)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	switch (reportType) {
+	case BTHH_INPUT_REPORT:
+		cmd.type = HAL_MSG_BT_HID_INPUT_REPORT;
+		break;
+	case BTHH_OUTPUT_REPORT:
+		cmd.type = HAL_MSG_BT_HID_OUTPUT_REPORT;
+		break;
+	case BTHH_FEATURE_REPORT:
+		cmd.type = HAL_MSG_BT_HID_FEATURE_REPORT;
+		break;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_SET_REPORT,
+			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
-- 
1.7.9.5

