Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] android/pan: Move logic from HAL to daemon
Date: Thu,  5 Dec 2013 11:37:17 +0100
Message-Id: <1386239837-4102-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HAL should contain as little logic as possible, but we should be doing
these checks on daemon side anyway.

---
 android/hal-pan.c | 14 --------------
 android/pan.c     | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index ec52672..8c0f8d8 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -109,20 +109,6 @@ static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	switch (local_role) {
-	case BTPAN_ROLE_PANNAP:
-		if (remote_role != BTPAN_ROLE_PANU)
-			return BT_STATUS_UNSUPPORTED;
-		break;
-	case BTPAN_ROLE_PANU:
-		if (remote_role != BTPAN_ROLE_PANNAP &&
-						remote_role != BTPAN_ROLE_PANU)
-			return BT_STATUS_UNSUPPORTED;
-		break;
-	default:
-		return BT_STATUS_UNSUPPORTED;
-	}
-
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 	cmd.local_role = local_role;
 	cmd.remote_role = remote_role;
diff --git a/android/pan.c b/android/pan.c
index f6e0ca9..78a1055 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -200,6 +200,25 @@ static void bt_pan_connect(const void *buf, uint16_t len)
 
 	DBG("");
 
+	switch (cmd->local_role) {
+	case HAL_PAN_ROLE_NAP:
+		if (cmd->remote_role != HAL_PAN_ROLE_PANU) {
+			status = HAL_STATUS_UNSUPPORTED;
+			goto failed;
+		}
+		break;
+	case HAL_PAN_ROLE_PANU:
+		if (cmd->remote_role != HAL_PAN_ROLE_NAP &&
+					cmd->remote_role != HAL_PAN_ROLE_PANU) {
+			status = HAL_STATUS_UNSUPPORTED;
+			goto failed;
+		}
+		break;
+	default:
+		status = HAL_STATUS_UNSUPPORTED;
+		goto failed;
+	}
+
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-- 
1.8.5

