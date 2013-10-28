Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] android/hal-pan: Add implementation of .connect
Date: Mon, 28 Oct 2013 14:09:05 +0200
Message-Id: <1382962146-19587-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
References: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-msg.h |  7 +++++++
 android/hal-pan.c | 11 ++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 350cec1..65f60dc 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -302,6 +302,13 @@ struct hal_rsp_pan_get_role {
 	uint8_t local_role;
 } __attribute__((packed));
 
+#define HAL_OP_PAN_CONNECT	0x03
+struct hal_cmd_pan_connect {
+	uint8_t bdaddr[6];
+	uint8_t local_role;
+	uint8_t remote_role;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 
diff --git a/android/hal-pan.c b/android/hal-pan.c
index c8dcdec..3e23eb5 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -17,6 +17,7 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include <string.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -67,15 +68,19 @@ static int pan_get_local_role(void)
 static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 					int remote_role)
 {
+	struct hal_cmd_pan_connect cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.local_role = local_role;
+	cmd.remote_role = remote_role;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t pan_disconnect(const bt_bdaddr_t *bd_addr)
-- 
1.8.3.1

