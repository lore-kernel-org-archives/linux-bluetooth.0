Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v6 3/5] android/hid: Fill send data command struct in hal-hidhost
Date: Fri,  8 Nov 2013 15:23:04 +0200
Message-Id: <1383916984-11010-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383916984-11010-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383916984-11010-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index e8570bc..97a1aa0 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -334,7 +334,8 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 {
-	struct hal_cmd_hidhost_send_data cmd;
+	uint8_t buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_hidhost_send_data *cmd = (void *) buf;
 
 	DBG("");
 
@@ -344,10 +345,12 @@ static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 	if (!bd_addr || !data)
 		return BT_STATUS_PARM_INVALID;
 
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+	cmd->len = strlen(data);
+	memcpy(cmd->data, data, cmd->len);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+				sizeof(*cmd) + cmd->len, buf, 0, NULL, NULL);
 }
 
 static bt_status_t init(bthh_callbacks_t *callbacks)
-- 
1.8.3.2

