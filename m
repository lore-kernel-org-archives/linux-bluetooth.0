Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/7] android: Add initial code for hidhost get and set protocol
Date: Wed, 23 Oct 2013 00:41:56 -0700
Message-Id: <1382514120-13152-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the initial code for hidhost .get_protocol and .set_protocol
interfaces
---
 android/hal-hidhost.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index c6ac42f..f289f7f 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -101,6 +101,8 @@ static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocolMode)
 {
+	struct hal_msg_cmd_bt_hid_get_protocol cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -109,12 +111,30 @@ static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
+				HAL_MSG_OP_BT_HID_GET_PROTOCOL,
+				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocolMode)
 {
+	struct hal_msg_cmd_bt_hid_set_protocol cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -123,7 +143,23 @@ static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
+				HAL_MSG_OP_BT_HID_SET_PROTOCOL,
+				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
-- 
1.7.9.5

