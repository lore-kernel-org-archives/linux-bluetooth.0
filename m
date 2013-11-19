Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/10] android/hal-bluetooth: Add support for get remote service record cmd
Date: Tue, 19 Nov 2013 16:51:48 +0100
Message-Id: <1384876314-31347-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index b496995..c74a9b3 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -583,12 +583,19 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 {
+	struct hal_cmd_get_remote_service_rec cmd;
+
 	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, remote_addr, sizeof(cmd.bdaddr));
+	memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_GET_REMOTE_SERVICE_REC,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
-- 
1.8.4.3

