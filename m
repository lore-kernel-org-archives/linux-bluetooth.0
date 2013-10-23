Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/7] android: Return right from hal_ipc_cmd call in hal hid connect
Date: Wed, 23 Oct 2013 00:41:53 -0700
Message-Id: <1382514120-13152-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Do not print any error message and return from hal_ipc_cmd call in hal
hid connect
---
 android/hal-hidhost.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f941f2f..f7d8cbf 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -45,13 +45,8 @@ static bt_status_t hh_connect(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	if (hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_CONNECT,
-			sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
-		error("Failed to connect hid device");
-		return BT_STATUS_FAIL;
-	}
-
-	return BT_STATUS_SUCCESS;
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_MSG_OP_BT_HID_CONNECT,
+			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
-- 
1.7.9.5

