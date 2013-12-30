Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/4] android/hidhost: Move get_report parameter check to daemon
Date: Mon, 30 Dec 2013 23:56:19 +0100
Message-Id: <1388444180-13683-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388444180-13683-1-git-send-email-szymon.janc@gmail.com>
References: <1388444180-13683-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HAL library is to be as simple as possible and parameters values should
be verified by daemon for robustness anyway. Move this check to daemon.
---
 android/hal-hidhost.c | 15 ++-------------
 android/hidhost.c     | 10 ++++++++++
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index b331145..371250a 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -268,19 +268,8 @@ static bt_status_t get_report(bt_bdaddr_t *bd_addr,
 	cmd.id = report_id;
 	cmd.buf_size = buffer_size;
 
-	switch (report_type) {
-	case BTHH_INPUT_REPORT:
-		cmd.type = HAL_HIDHOST_INPUT_REPORT;
-		break;
-	case BTHH_OUTPUT_REPORT:
-		cmd.type = HAL_HIDHOST_OUTPUT_REPORT;
-		break;
-	case BTHH_FEATURE_REPORT:
-		cmd.type = HAL_HIDHOST_FEATURE_REPORT;
-		break;
-	default:
-		return BT_STATUS_PARM_INVALID;
-	}
+	/* type match IPC type */
+	cmd.type = report_type;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_REPORT,
 			sizeof(cmd), &cmd, 0, NULL, NULL);
diff --git a/android/hidhost.c b/android/hidhost.c
index 76e65b8..1cf85b1 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -991,6 +991,16 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 
 	DBG("");
 
+	switch (cmd->type) {
+	case HAL_HIDHOST_INPUT_REPORT:
+	case HAL_HIDHOST_OUTPUT_REPORT:
+	case HAL_HIDHOST_FEATURE_REPORT:
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

