Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/6] android/hid: Rename virtual unplug define and struct
Date: Wed,  6 Nov 2013 13:48:46 +0200
Message-Id: <1383738528-14550-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Renaming virtual unplug define and strcut name from VP to more
meaning full.
---
 android/hal-hidhost.c | 4 ++--
 android/hal-msg.h     | 4 ++--
 android/hid.c         | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 22a5d15..b24e74e 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -140,7 +140,7 @@ static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_hid_vp cmd;
+	struct hal_cmd_hid_virtual_unplug cmd;
 
 	DBG("");
 
@@ -152,7 +152,7 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_VP,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_VIRTUAL_UNPLUG,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index eb145a5..59e4f78 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -242,8 +242,8 @@ struct hal_cmd_hid_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_HID_VP			0x03
-struct hal_cmd_hid_vp {
+#define HAL_OP_HID_VIRTUAL_UNPLUG	0x03
+struct hal_cmd_hid_virtual_unplug {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
diff --git a/android/hid.c b/android/hid.c
index c38c4c1..77dc81d 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -740,7 +740,8 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hid_vp *cmd, uint16_t len)
+static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hid_virtual_unplug *cmd,
+								uint16_t len)
 {
 	DBG("Not Implemented");
 
@@ -938,7 +939,7 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 	case HAL_OP_HID_DISCONNECT:
 		status = bt_hid_disconnect(buf, len);
 		break;
-	case HAL_OP_HID_VP:
+	case HAL_OP_HID_VIRTUAL_UNPLUG:
 		status = bt_hid_virtual_unplug(buf, len);
 		break;
 	case HAL_OP_HID_SET_INFO:
-- 
1.8.1.2

