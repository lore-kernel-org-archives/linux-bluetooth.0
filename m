Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 09/13] android/gatt: Rename app unregister function
Date: Fri,  6 Jun 2014 15:46:22 +0200
Message-Id: <1402062386-4632-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Its used for client and server apps unregistering
---
 android/gatt.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7d22901..558b203 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1423,7 +1423,7 @@ static bool trigger_connection(struct app_connection *connection)
 	return true;
 }
 
-static uint8_t unregister_client(int client_if)
+static uint8_t unregister_app(int client_if)
 {
 	struct gatt_app *cl;
 
@@ -1434,10 +1434,7 @@ static uint8_t unregister_client(int client_if)
 		return HAL_STATUS_FAILED;
 	}
 
-	/*
-	 * Check if there is any connect request or connected device
-	 * for this client. If so, remove this client from those lists.
-	 */
+	/* Destroy app connections with proper notifications for this app. */
 	app_disconnect_devices(cl);
 	destroy_gatt_app(cl);
 
@@ -1451,7 +1448,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	status = unregister_client(cmd->client_if);
+	status = unregister_app(cmd->client_if);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
@@ -3577,7 +3574,7 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 			else
 				status = HAL_STATUS_FAILED;
 		} else {
-			status = unregister_client(test_client_if);
+			status = unregister_app(test_client_if);
 			test_client_if = 0;
 		}
 		break;
@@ -3643,7 +3640,7 @@ static void handle_server_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	status = unregister_client(cmd->server_if);
+	status = unregister_app(cmd->server_if);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_UNREGISTER, status);
-- 
2.0.0

