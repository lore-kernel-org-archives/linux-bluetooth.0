Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/5] android/gatt: Factor out unregistering client into helper function
Date: Mon, 26 May 2014 23:53:25 +0200
Message-Id: <1401141208-26912-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
References: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be also used by test interface.
---
 android/gatt.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0acb4b6..8b0082e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1360,28 +1360,35 @@ static bool trigger_connection(struct app_connection *connection)
 	return true;
 }
 
+static uint8_t unregister_client(int client_if)
+{
+	struct gatt_app *cl;
+
+	cl = queue_remove_if(gatt_apps, match_app_by_id, INT_TO_PTR(client_if));
+	if (!cl) {
+		error("gatt: client_if=%d not found", client_if);
+
+		return HAL_STATUS_FAILED;
+	}
+
+	/*
+	 * Check if there is any connect request or connected device
+	 * for this client. If so, remove this client from those lists.
+	 */
+	app_disconnect_devices(cl);
+	destroy_gatt_app(cl);
+
+	return HAL_STATUS_SUCCESS;
+}
+
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
 	uint8_t status;
-	struct gatt_app *cl;
 
 	DBG("");
 
-	cl = queue_remove_if(gatt_apps, match_app_by_id,
-						INT_TO_PTR(cmd->client_if));
-	if (!cl) {
-		error("gatt: client_if=%d not found", cmd->client_if);
-		status = HAL_STATUS_FAILED;
-	} else {
-		/*
-		 * Check if there is any connect request or connected device
-		 * for this client. If so, remove this client from those lists.
-		 */
-		app_disconnect_devices(cl);
-		destroy_gatt_app(cl);
-		status = HAL_STATUS_SUCCESS;
-	}
+	status = unregister_client(cmd->client_if);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
-- 
2.0.0.rc4

