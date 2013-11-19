Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/10] android/hal-bluetooth: Add support for set remote device property cmd
Date: Tue, 19 Nov 2013 16:51:47 +0100
Message-Id: <1384876314-31347-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used to set remote device property of specified type.
---
 android/hal-bluetooth.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index e2a9ab3..b496995 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -558,13 +558,27 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
+	struct hal_cmd_set_remote_device_prop *cmd;
+	uint8_t buf[sizeof(*cmd) + property->len];
+
 	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
-						btproperty2str(property));
+				bt_property_type_t2str(property->type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd = (void *) buf;
+
+	memcpy(cmd->bdaddr, remote_addr, sizeof(cmd->bdaddr));
+
+	/* type match IPC type */
+	cmd->type = property->type;
+	cmd->len = property->len;
+	memcpy(cmd->val, property->val, property->len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_SET_REMOTE_DEVICE_PROP,
+					sizeof(buf), cmd, 0, NULL, NULL);
 }
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
-- 
1.8.4.3

