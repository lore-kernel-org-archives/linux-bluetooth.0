Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 07/11] android/hid: Rename virtual unplug define and struct
Date: Fri,  8 Nov 2013 00:10:16 +0200
Message-Id: <1383862220-29968-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Renaming virtual unplug define and strcut name from VP to more
meaning full.
---
 android/hal-hidhost.c | 5 +++--
 android/hal-msg.h     | 4 ++--
 android/hidhost.c     | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 1617a16..dbdf176 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -141,7 +141,7 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t virtual_unplug(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_hidhost_vp cmd;
+	struct hal_cmd_hidhost_virtual_unplug cmd;
 
 	DBG("");
 
@@ -153,7 +153,8 @@ static bt_status_t virtual_unplug(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_VP,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_VIRTUAL_UNPLUG,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 05c9de0..3ad9af6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -242,8 +242,8 @@ struct hal_cmd_hidhost_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_HIDHOST_VP			0x03
-struct hal_cmd_hidhost_vp {
+#define HAL_OP_HIDHOST_VIRTUAL_UNPLUG		0x03
+struct hal_cmd_hidhost_virtual_unplug {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
diff --git a/android/hidhost.c b/android/hidhost.c
index 4b12318..b7ec6ff 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -741,7 +741,7 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_vp *cmd,
+static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 								uint16_t len)
 {
 	DBG("Not Implemented");
@@ -942,7 +942,7 @@ void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	case HAL_OP_HIDHOST_DISCONNECT:
 		status = bt_hid_disconnect(buf, len);
 		break;
-	case HAL_OP_HIDHOST_VP:
+	case HAL_OP_HIDHOST_VIRTUAL_UNPLUG:
 		status = bt_hid_virtual_unplug(buf, len);
 		break;
 	case HAL_OP_HIDHOST_SET_INFO:
-- 
1.8.3.2

