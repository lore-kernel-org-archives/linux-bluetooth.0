Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 7/7] android: Add initial code for hidhost set hid information
Date: Wed, 23 Oct 2013 00:41:59 -0700
Message-Id: <1382514120-13152-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the initial code for hidhost .set_info interface
---
 android/hal-hidhost.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 02a3f7d..4842a01 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -87,6 +87,8 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 
 static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 {
+	struct hal_msg_cmd_bt_hid_set_info cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -95,7 +97,18 @@ static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.attr = hid_info.attr_mask;
+	cmd.subclass = hid_info.sub_class;
+	cmd.app_id = hid_info.app_id;
+	cmd.vendor = hid_info.vendor_id;
+	cmd.product = hid_info.product_id;
+	cmd.country = hid_info.ctry_code;
+	cmd.descr_len = hid_info.dl_len;
+	memcpy(cmd.descr, hid_info.dsc_list, cmd.descr_len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_SET_INFO,
+			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
-- 
1.7.9.5

