Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/5] android: Add initial code for hidhost get and set protocol
Date: Tue, 22 Oct 2013 11:49:50 -0700
Message-Id: <1382467793-4709-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the initial code for hidhost .get_protocol and .set_protocol
interfaces
---
 android/hal-hidhost.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 523ce6d..506d721 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -114,6 +114,8 @@ static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocolMode)
 {
+	struct hal_msg_cmd_bt_hid_get_protocol cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -122,12 +124,34 @@ static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	switch (protocolMode) {
+	case BTHH_REPORT_MODE:
+		cmd.mode = HAL_MSG_BT_HID_REPORT_PROTOCOL;
+		break;
+	case BTHH_BOOT_MODE:
+		cmd.mode = HAL_MSG_BT_HID_BOOT_PROTOCOL;
+		break;
+	case BTHH_UNSUPPORTED_MODE:
+		cmd.mode = HAL_MSG_BT_HID_UNSUPPORTED_PROTOCOL;
+		break;
+	}
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_GET_PROTOCOL,
+			sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
+		error("Failed to get hid device protocol");
+		return BT_STATUS_FAIL;
+	}
+
+	return BT_STATUS_SUCCESS;
 }
 
 static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocolMode)
 {
+	struct hal_msg_cmd_bt_hid_set_protocol cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -136,7 +160,27 @@ static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	switch (protocolMode) {
+	case BTHH_REPORT_MODE:
+		cmd.mode = HAL_MSG_BT_HID_REPORT_PROTOCOL;
+		break;
+	case BTHH_BOOT_MODE:
+		cmd.mode = HAL_MSG_BT_HID_BOOT_PROTOCOL;
+		break;
+	case BTHH_UNSUPPORTED_MODE:
+		cmd.mode = HAL_MSG_BT_HID_UNSUPPORTED_PROTOCOL;
+		break;
+	}
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_SET_PROTOCOL,
+			sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
+		error("Failed to set hid device protocol");
+		return BT_STATUS_FAIL;
+	}
+
+	return BT_STATUS_SUCCESS;
 }
 
 static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
-- 
1.7.9.5

