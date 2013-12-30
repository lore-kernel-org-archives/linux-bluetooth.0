Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/4] android/hidhost: Move set_report parameter check to daemon
Date: Mon, 30 Dec 2013 23:56:20 +0100
Message-Id: <1388444180-13683-4-git-send-email-szymon.janc@gmail.com>
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
index 371250a..fd3ad2d 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -294,19 +294,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 	cmd->len = strlen(report);
 	memcpy(cmd->data, report, cmd->len);
 
-	switch (report_type) {
-	case BTHH_INPUT_REPORT:
-		cmd->type = HAL_HIDHOST_INPUT_REPORT;
-		break;
-	case BTHH_OUTPUT_REPORT:
-		cmd->type = HAL_HIDHOST_OUTPUT_REPORT;
-		break;
-	case BTHH_FEATURE_REPORT:
-		cmd->type = HAL_HIDHOST_FEATURE_REPORT;
-		break;
-	default:
-		return BT_STATUS_PARM_INVALID;
-	}
+	/* type match IPC type */
+	cmd->type = report_type;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
 				sizeof(*cmd) + cmd->len, buf, 0, NULL, NULL);
diff --git a/android/hidhost.c b/android/hidhost.c
index 1cf85b1..aed9899 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1064,6 +1064,16 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 		return;
 	}
 
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

