Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/10] android/hal-bluetooth: Add support for get remote device properties cmd
Date: Tue, 19 Nov 2013 16:51:46 +0100
Message-Id: <1384876314-31347-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used to get all properties of remote device.
---
 android/hal-bluetooth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4a09a5c..e2a9ab3 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -520,12 +520,18 @@ static int set_adapter_property(const bt_property_t *property)
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 {
+	struct hal_cmd_get_remote_device_props cmd;
+
 	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, remote_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_GET_REMOTE_DEVICE_PROPS,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
-- 
1.8.4.3

