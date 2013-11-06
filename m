Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/6] android/hid: Fill send data structure variables in hal-hidhost
Date: Wed,  6 Nov 2013 13:48:45 +0200
Message-Id: <1383738528-14550-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f1a2223..22a5d15 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -330,6 +330,8 @@ static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
 		return BT_STATUS_PARM_INVALID;
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.len = strlen(data);
+	memcpy(cmd.data, data, cmd.len);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_SEND_DATA,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
-- 
1.8.1.2

