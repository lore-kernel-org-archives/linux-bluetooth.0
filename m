Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/gatt: Remove unneeded label from unregister_client
Date: Thu, 10 Apr 2014 20:40:35 +0200
Message-Id: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a7a7204..4a720cc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -506,13 +506,11 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 	if (!cl) {
 		error("gatt: client_if=%d not found", cmd->client_if);
 		status = HAL_STATUS_FAILED;
-		goto failed;
+	} else {
+		destroy_gatt_client(cl);
+		status = HAL_STATUS_SUCCESS;
 	}
 
-	destroy_gatt_client(cl);
-	status = HAL_STATUS_SUCCESS;
-
-failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
-- 
1.8.3.1

