Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/hal: Add support for send av connect command
Date: Fri, 25 Oct 2013 17:52:06 +0200
Message-Id: <1382716327-25283-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to send av connect command
---
 android/hal-av.c  | 10 +++++++---
 android/hal-msg.h |  5 +++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/android/hal-av.c b/android/hal-av.c
index d537e84..239088f 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -17,10 +17,12 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include <string.h>
 
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
+#include "hal-ipc.h"
 
 static const btav_callbacks_t *cbs = NULL;
 
@@ -67,15 +69,17 @@ void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 
 static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
 {
+	struct hal_msg_op_bt_av_connect cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_MSG_OP_BT_AV_CONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2206f47..66486f1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -276,6 +276,11 @@ struct hal_cmd_hid_send_data {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_MSG_OP_BT_AV_CONNECT	0x01
+struct hal_msg_op_bt_av_connect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 
-- 
1.8.4.1

