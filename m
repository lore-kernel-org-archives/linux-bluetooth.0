Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 1/5] android/hid: Fix set seport ipc cmd preparation
Date: Fri,  8 Nov 2013 12:24:27 +0200
Message-Id: <1383906271-23554-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now report data is not fixed array. Allocate proper memory
and send ipc cmd.
---
 android/hal-hidhost.c | 29 ++++++++++++++++++++---------
 android/hal-msg.h     |  2 +-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 34f9f77..ce3dcd7 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -297,7 +298,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						char *report)
 {
-	struct hal_cmd_hidhost_set_report cmd;
+	struct hal_cmd_hidhost_set_report *cmd;
+	int cmd_len, status;
 
 	DBG("");
 
@@ -307,26 +309,35 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
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
index 851875e..7ba2e00 100644
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
-- 
1.8.3.2

