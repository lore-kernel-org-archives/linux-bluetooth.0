Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/4] android/hidhost: Move set_protocol parameter check to daemon
Date: Mon, 30 Dec 2013 23:56:18 +0100
Message-Id: <1388444180-13683-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388444180-13683-1-git-send-email-szymon.janc@gmail.com>
References: <1388444180-13683-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HAL library is to be as simple as possible and parameters values should
be verified by daemon for robustness anyway. Move this check to daemon.
---
 android/hal-hidhost.c | 12 ++----------
 android/hidhost.c     |  9 +++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 5d05f9b..b331145 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -241,16 +241,8 @@ static bt_status_t set_protocol(bt_bdaddr_t *bd_addr,
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	switch (protocol_mode) {
-	case BTHH_REPORT_MODE:
-		cmd.mode = HAL_HIDHOST_REPORT_PROTOCOL;
-		break;
-	case BTHH_BOOT_MODE:
-		cmd.mode = HAL_HIDHOST_BOOT_PROTOCOL;
-		break;
-	default:
-		return BT_STATUS_PARM_INVALID;
-	}
+	/* type match IPC type */
+	cmd.mode = protocol_mode;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
 				HAL_OP_HIDHOST_SET_PROTOCOL,
diff --git a/android/hidhost.c b/android/hidhost.c
index 4635e53..76e65b8 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -935,6 +935,15 @@ static void bt_hid_set_protocol(const void *buf, uint16_t len)
 
 	DBG("");
 
+	switch (cmd->mode) {
+	case HAL_HIDHOST_REPORT_PROTOCOL:
+	case HAL_HIDHOST_BOOT_PROTOCOL:
+		break;
+	default:
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
+
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-- 
1.8.5.2

