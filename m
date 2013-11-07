Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 03/11] android/hid: Fix set report data format
Date: Fri,  8 Nov 2013 00:10:12 +0200
Message-Id: <1383862220-29968-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data is in ascii format from HAL. Convert it to hex and send it to
hid device.
---
 android/hal-hidhost.c | 29 ++++++++++++++++++++---------
 android/hal-msg.h     |  2 +-
 android/hidhost.c     |  8 +++++---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 3c147e8..6fe4c52 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -285,7 +286,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						char *report)
 {
-	struct hal_cmd_hidhost_set_report cmd;
+	struct hal_cmd_hidhost_set_report *cmd;
+	int cmd_len, status;
 
 	DBG("");
 
@@ -295,26 +297,35 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 	if (!bd_addr || !report)
 		return BT_STATUS_PARM_INVALID;
 
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-	cmd.len = strlen(report);
-	memcpy(cmd.data, report, cmd.len);
+	cmd_len = sizeof(*cmd) + sizeof(struct hal_cmd_hidhost_set_report)
+							+ 1 + strlen(report);
+
+	cmd = malloc(cmd_len);
+	memset(cmd, 0, cmd_len);
+	memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+	cmd->len = strlen(report);
+	memcpy(cmd->data, report, cmd->len);
 
 	switch (report_type) {
 	case BTHH_INPUT_REPORT:
-		cmd.type = HAL_HIDHOST_INPUT_REPORT;
+		cmd->type = HAL_HIDHOST_INPUT_REPORT;
 		break;
 	case BTHH_OUTPUT_REPORT:
-		cmd.type = HAL_HIDHOST_OUTPUT_REPORT;
+		cmd->type = HAL_HIDHOST_OUTPUT_REPORT;
 		break;
 	case BTHH_FEATURE_REPORT:
-		cmd.type = HAL_HIDHOST_FEATURE_REPORT;
+		cmd->type = HAL_HIDHOST_FEATURE_REPORT;
 		break;
 	default:
+		free(cmd);
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
-				sizeof(cmd), &cmd, 0, NULL, NULL);
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
+						cmd_len, cmd, 0, NULL, NULL);
+	free(cmd);
+
+	return status;
 }
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7045c8c..08a159e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -293,7 +293,7 @@ struct hal_cmd_hidhost_set_report {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
 	uint16_t len;
-	uint8_t  data[670];
+	uint8_t  data[0];
 } __attribute__((packed));
 
 #define HAL_OP_HIDHOST_SEND_DATA		0x09
diff --git a/android/hidhost.c b/android/hidhost.c
index c7b4114..4b12318 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -900,18 +900,20 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 		return HAL_STATUS_FAILED;
 
 	dev = l->data;
-	req_size = 1 + cmd->len;
+	/* Report data coming from HAL is in ascii format, so convert
+	 * it to hex and calculate length according to it. */
+	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
 	if (!req)
 		return HAL_STATUS_NOMEM;
 
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
-	memcpy(req + 1, cmd->data, req_size - 1);
+	ascii2hex(cmd->data, cmd->len, (req + 1));
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
 	if (write(fd, req, req_size) < 0) {
-		error("error while querying device protocol");
+		error("error while sending report");
 		g_free(req);
 		return HAL_STATUS_FAILED;
 	}
-- 
1.8.3.2

