Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 2/5] android/hal: Send get_remote_services cmd
Date: Mon, 4 Nov 2013 08:30:31 +0100
Message-ID: <1383550234-14790-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5fb8846..9022fc2 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -505,12 +505,18 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
+	struct hal_cmd_get_remote_services cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, remote_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_GET_REMOTE_SERVICES, sizeof(cmd),
+						&cmd, 0, NULL, NULL);
 }
 
 static int start_discovery(void)
-- 
1.8.4.1

