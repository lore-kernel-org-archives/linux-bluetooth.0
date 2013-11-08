Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 3/5] android/hid: Fill send data command struct in hal-hidhost
Date: Fri,  8 Nov 2013 14:08:49 +0200
Message-Id: <1383912531-1306-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index a0df7ce..e4a15c0 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -335,7 +335,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 {
-	struct hal_cmd_hidhost_send_data cmd;
+	uint8_t buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_hidhost_send_data *cmd = (void *) buf;
 
 	DBG("");
 
@@ -345,10 +346,13 @@ static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 	if (!bd_addr || !data)
 		return BT_STATUS_PARM_INVALID;
 
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	memset(cmd, 0, sizeof(buf));
+	memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+	cmd->len = strlen(data);
+	memcpy(cmd->data, data, cmd->len);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(buf), buf, 0, NULL, NULL);
 }
 
 static bt_status_t init(bthh_callbacks_t *callbacks)
-- 
1.8.3.2

