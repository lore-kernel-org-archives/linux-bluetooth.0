Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/5] android: Add initial code for hidhost send data
Date: Tue, 22 Oct 2013 11:49:52 -0700
Message-Id: <1382467793-4709-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382467793-4709-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the initial code for hidhost .send_data interface
---
 android/hal-hidhost.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 5a4614d..a0349b2 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -261,6 +261,8 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 
 static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
 {
+	struct hal_msg_cmd_bt_hid_send_data cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -269,7 +271,15 @@ static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
 	if (!bd_addr || !data)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_SEND_DATA,
+			sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
+		error("Failed to send data to hid devie");
+		return BT_STATUS_FAIL;
+	}
+
+	return BT_STATUS_SUCCESS;
 }
 
 static bt_status_t hh_init(bthh_callbacks_t *callbacks)
-- 
1.7.9.5

