Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] android/hal-pan: Add implementation of .get_local_role
Date: Mon, 28 Oct 2013 14:09:04 +0200
Message-Id: <1382962146-19587-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
References: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-msg.h |  5 +++++
 android/hal-pan.c | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0987eec..350cec1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -297,6 +297,11 @@ struct hal_cmd_pan_enable {
 	uint8_t local_role;
 } __attribute__((packed));
 
+#define HAL_OP_PAN_GET_ROLE	0x02
+struct hal_rsp_pan_get_role {
+	uint8_t local_role;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 8fb2563..c8dcdec 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -47,12 +47,21 @@ static bt_status_t pan_enable(int local_role)
 
 static int pan_get_local_role(void)
 {
+	struct hal_rsp_pan_get_role rsp;
+	size_t len = sizeof(rsp);
+	bt_status_t status;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BTPAN_ROLE_NONE;
 
-	return BTPAN_ROLE_NONE;
+	status = hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE, 0, NULL,
+							&len, &rsp, NULL);
+	if (status != BT_STATUS_SUCCESS)
+		return BTPAN_ROLE_NONE;
+
+	return rsp.local_role;
 }
 
 static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
-- 
1.8.3.1

