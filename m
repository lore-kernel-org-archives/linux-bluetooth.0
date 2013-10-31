Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 2/5] android/hal: Add support for sending get_remote_services command
Date: Thu, 31 Oct 2013 16:25:49 +0100
Message-ID: <1383233152-15040-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
References: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Change-Id: I99c92d8a3f3d915d1e06ecad2515fcbcbb5b660a
---
 android/hal-bluetooth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a6228d7..4eab869 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -476,12 +476,18 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
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

