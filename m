Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/7] android: Add initial code for hidhost virtual unplug
Date: Wed, 23 Oct 2013 00:41:55 -0700
Message-Id: <1382514120-13152-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds initial code for hidhost .virtual_unplug interface
---
 android/hal-hidhost.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 1f54bc4..c6ac42f 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -69,6 +69,8 @@ static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 {
+	struct hal_msg_cmd_bt_hid_vp cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -77,7 +79,10 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_VP,
+			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
-- 
1.7.9.5

