Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/10] android/hal-bluetooth: Add support for get remote device property cmd
Date: Tue, 19 Nov 2013 16:51:45 +0100
Message-Id: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used to get remote device property of specifided type.
---
 android/hal-bluetooth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 69c304a..4a09a5c 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -531,13 +531,22 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 						bt_property_type_t type)
 {
+	struct hal_cmd_get_remote_device_prop cmd;
+
 	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
 						bt_property_type_t2str(type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, remote_addr, sizeof(cmd.bdaddr));
+
+	/* type match IPC type */
+	cmd.type = type;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_GET_REMOTE_DEVICE_PROP,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
-- 
1.8.4.3

