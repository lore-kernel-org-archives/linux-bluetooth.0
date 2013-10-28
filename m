Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] android/hal-pan: Add implementation of .enable
Date: Mon, 28 Oct 2013 14:09:03 +0200
Message-Id: <1382962146-19587-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
References: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-msg.h | 7 +++++++
 android/hal-pan.c | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index a0a8390..0987eec 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -290,6 +290,13 @@ struct hal_cmd_av_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+/* PAN HAL API */
+
+#define HAL_OP_PAN_ENABLE	0x01
+struct hal_cmd_pan_enable {
+	uint8_t local_role;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 62fec00..8fb2563 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -32,12 +32,17 @@ static bool interface_ready(void)
 
 static bt_status_t pan_enable(int local_role)
 {
+	struct hal_cmd_pan_enable cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.local_role = local_role;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int pan_get_local_role(void)
-- 
1.8.3.1

