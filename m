Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v6 1/5] android/hid: Fill send data command struct in hal-hidhost
Date: Fri,  8 Nov 2013 15:23:03 +0200
Message-Id: <1383916984-11010-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 18 ++++++++++--------
 android/hal-msg.h     |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 94f7e01..e8570bc 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -298,7 +299,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						char *report)
 {
-	struct hal_cmd_hidhost_set_report cmd;
+	uint8_t buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_hidhost_set_report *cmd = (void *) buf;
 
 	DBG("");
 
@@ -308,26 +310,26 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 	if (!bd_addr || !report)
 		return BT_STATUS_PARM_INVALID;
 
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-	cmd.len = strlen(report);
-	memcpy(cmd.data, report, cmd.len);
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
 		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
-				sizeof(cmd), &cmd, 0, NULL, NULL);
+				sizeof(*cmd) + cmd->len, buf, 0, NULL, NULL);
 }
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4af86de..4c7d344 100644
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

