Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] android/hal: Add support for start/cancel device discovery commands
Date: Wed, 30 Oct 2013 11:00:27 +0100
Message-Id: <1383127232-25147-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index ffaf8da..9d1c3f7 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -353,7 +353,9 @@ static int start_discovery(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_START_DISCOVERY, 0, NULL, 0,
+				NULL, NULL);
 }
 
 static int cancel_discovery(void)
@@ -363,7 +365,9 @@ static int cancel_discovery(void)
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

