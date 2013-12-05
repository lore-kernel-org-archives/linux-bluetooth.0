Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] android/pan: Move logic from HAL layer to daemon
Date: Thu,  5 Dec 2013 11:37:16 +0100
Message-Id: <1386239837-4102-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HAL should contain as little logic as possible, but we should be doing
these checks on daemon side anyway.

---
 android/hal-pan.c |  3 ---
 android/pan.c     | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index 6aaf8af..ec52672 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -74,9 +74,6 @@ static bt_status_t pan_enable(int local_role)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!(local_role == BTPAN_ROLE_PANU || local_role == BTPAN_ROLE_PANNAP))
-		return BT_STATUS_UNSUPPORTED;
-
 	cmd.local_role = local_role;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE,
diff --git a/android/pan.c b/android/pan.c
index fe6ee26..f6e0ca9 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -280,9 +280,21 @@ failed:
 
 static void bt_pan_enable(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_pan_enable *cmd = buf;
+	uint8_t status;
+
+	switch (cmd->local_role) {
+	case HAL_PAN_ROLE_PANU:
+	case HAL_PAN_ROLE_NAP:
+		DBG("Not Implemented");
+		status  = HAL_STATUS_FAILED;
+		break;
+	default:
+		status = HAL_STATUS_UNSUPPORTED;
+		break;
+	}
 
-	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, HAL_STATUS_FAILED);
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
 }
 
 static void bt_pan_get_role(const void *buf, uint16_t len)
-- 
1.8.5

