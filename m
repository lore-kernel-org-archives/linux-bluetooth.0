Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android: Add initial code for hidhost connect and disconnect
Date: Tue, 22 Oct 2013 05:16:16 -0700
Message-Id: <1382444176-9105-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 8c47e27..d68ee6c 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -17,12 +17,17 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include <string.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_hh.h>
 
 #include "hal-log.h"
 #include "hal.h"
+#include "hal-msg.h"
+#include "hal-ipc.h"
+
+#define BT_DEVICE_ADDRESS_LENGTH	6
 
 bthh_callbacks_t *bt_hh_cbacks;
 
@@ -33,6 +38,8 @@ static bool interface_ready(void)
 
 static bt_status_t bt_hidhost_connect(bt_bdaddr_t *bd_addr)
 {
+	struct hal_msg_cmd_bt_hid_connect cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -41,11 +48,22 @@ static bt_status_t bt_hidhost_connect(bt_bdaddr_t *bd_addr)
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, BT_DEVICE_ADDRESS_LENGTH);
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_CONNECT,
+					sizeof(cmd), &cmd,
+					0, NULL, NULL) < 0) {
+		error("Failed to connect hid device");
+		return BT_STATUS_FAIL;
+	}
+
+	return BT_STATUS_SUCCESS;
 }
 
 static bt_status_t bt_hidhost_disconnect(bt_bdaddr_t *bd_addr)
 {
+	struct hal_msg_cmd_bt_hid_disconnect cmd;
+
 	DBG("");
 
 	if (!interface_ready())
@@ -54,7 +72,16 @@ static bt_status_t bt_hidhost_disconnect(bt_bdaddr_t *bd_addr)
 	if (!bd_addr)
 		return BT_STATUS_PARM_INVALID;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, BT_DEVICE_ADDRESS_LENGTH);
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_DISCONNECT,
+					sizeof(cmd), &cmd,
+					0, NULL, NULL) < 0) {
+		error("Failed to disconnect hid device");
+		return BT_STATUS_FAIL;
+	}
+
+	return BT_STATUS_SUCCESS;
 }
 
 static bt_status_t bt_hidhost_virtual_unplug(bt_bdaddr_t *bd_addr)
@@ -158,14 +185,20 @@ static bt_status_t bt_hidhost_send_data(bt_bdaddr_t *bd_addr, char *data)
 
 static bt_status_t bt_hidhost_init(bthh_callbacks_t *callbacks)
 {
+	struct hal_msg_cmd_register_module cmd;
 	DBG("");
 
 	/* store reference to user callbacks */
 	bt_hh_cbacks = callbacks;
 
-	/* TODO: start HID Host thread */
+	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
 
-	/* TODO: enable service */
+	if (hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
+		error("Failed to register 'hidhost'' service");
+
+		return BT_STATUS_FAIL;
+	}
 
 	return BT_STATUS_SUCCESS;
 }
@@ -177,10 +210,6 @@ static void bt_hidhost_cleanup(void)
 	if (!interface_ready())
 		return;
 
-	/* TODO: disable service */
-
-	/* TODO: stop HID Host thread */
-
 	bt_hh_cbacks = NULL;
 }
 
-- 
1.7.9.5

