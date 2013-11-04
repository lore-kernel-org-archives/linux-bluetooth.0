Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv3 1/4] android/hal: Send get_remote_services cmd
Date: Mon, 4 Nov 2013 09:06:47 +0100
Message-ID: <1383552410-2220-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 7334d24..88c7b99 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -515,12 +515,18 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
+	struct hal_cmd_get_remote_services cmd;
+
 	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, remote_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_SERVICES, sizeof(cmd), &cmd, 0,
+			NULL, NULL);
 }
 
 static int start_discovery(void)
-- 
1.8.4.1

