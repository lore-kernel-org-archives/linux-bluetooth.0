Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/5] android: Add initial code for hidhost virtual unplug
Date: Tue, 22 Oct 2013 11:49:49 -0700
Message-Id: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds initial code for hidhost .virtual_unplug interface
---
 android/hal-hidhost.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f941f2f..523ce6d 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -79,6 +79,8 @@ static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 {
+	struct hal_msg_cmd_bt_hid_vp cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -87,7 +89,13 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_VP,
+			sizeof(cmd), &cmd, 0, NULL, NULL) < 0)
+		return BT_STATUS_FAIL;
+
+	return BT_STATUS_SUCCESS;
 }
 
 static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
-- 
1.7.9.5

