Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android/hal: Add support for send av disconnect command
Date: Fri, 25 Oct 2013 17:52:07 +0200
Message-Id: <1382716327-25283-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to send av disconnect command
---
 android/hal-av.c  | 8 +++++---
 android/hal-msg.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/android/hal-av.c b/android/hal-av.c
index 239088f..483dcf1 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -84,15 +84,17 @@ static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
 {
+	struct hal_msg_op_bt_av_disconnect cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_MSG_OP_BT_AV_DISCONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t av_init(btav_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 66486f1..193ecae 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -281,6 +281,11 @@ struct hal_msg_op_bt_av_connect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_MSG_OP_BT_AV_DISCONNECT	0x02
+struct hal_msg_op_bt_av_disconnect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 
-- 
1.8.4.1

