Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/hal: Add support for start/cancel device discovery commands
Date: Tue, 29 Oct 2013 13:16:52 +0100
Message-Id: <1383049016-23371-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5929fff..aa104ba 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -308,7 +308,9 @@ static int start_discovery(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_START_DISCOVERY, 0, NULL, 0,
+				NULL, NULL);
 }
 
 static int cancel_discovery(void)
@@ -318,7 +320,9 @@ static int cancel_discovery(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_CANCEL_DISCOVERY, 0, NULL, 0,
+				NULL, NULL);
 }
 
 static int create_bond(const bt_bdaddr_t *bd_addr)
-- 
1.8.4.1

