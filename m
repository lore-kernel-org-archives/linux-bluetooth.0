Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] android/hal-pan: Add implementation of .disconnect
Date: Mon, 28 Oct 2013 14:09:06 +0200
Message-Id: <1382962146-19587-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
References: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-msg.h | 5 +++++
 android/hal-pan.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 65f60dc..bba031c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -309,6 +309,11 @@ struct hal_cmd_pan_connect {
 	uint8_t remote_role;
 } __attribute__((packed));
 
+#define HAL_OP_PAN_DISCONNECT	0x04
+struct hal_cmd_pan_disconnect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 3e23eb5..cacc6c0 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -85,15 +85,17 @@ static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 
 static bt_status_t pan_disconnect(const bt_bdaddr_t *bd_addr)
 {
+	struct hal_cmd_pan_disconnect cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
-- 
1.8.3.1

