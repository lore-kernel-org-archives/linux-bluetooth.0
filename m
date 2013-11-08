Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 3/5] android/hid: Fill send data command struct in hal-hidhost
Date: Fri,  8 Nov 2013 12:24:29 +0200
Message-Id: <1383906271-23554-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index ce3dcd7..ec120ed 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -342,7 +342,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 {
-	struct hal_cmd_hidhost_send_data cmd;
+	struct hal_cmd_hidhost_send_data *cmd;
+	int cmd_len, status;
 
 	DBG("");
 
@@ -352,10 +353,19 @@ static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 	if (!bd_addr || !data)
 		return BT_STATUS_PARM_INVALID;
 
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd_len = sizeof(*cmd) + sizeof(struct hal_cmd_hidhost_send_data)
+							+ 1 + strlen(data);
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+	cmd = malloc(cmd_len);
+	memset(cmd, 0, cmd_len);
+	memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+	cmd->len = strlen(data);
+	memcpy(cmd->data, data, cmd->len);
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
+						cmd_len, cmd, 0, NULL, NULL);
+	free(cmd);
+	return status;
 }
 
 static bt_status_t init(bthh_callbacks_t *callbacks)
-- 
1.8.3.2

