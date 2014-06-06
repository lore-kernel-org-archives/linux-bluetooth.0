Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 13/13] android/gatt: Postpone disconnect notifications sent to server apps
Date: Fri,  6 Jun 2014 15:46:26 +0200
Message-Id: <1402062386-4632-14-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluedroid postpones server app disconnection callbacks until last
connection owner has disconnected instead of sending it when server app
calls disconnect.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9607416..678d1b2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3725,7 +3725,7 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
 	conn = find_connection_by_id(cmd->conn_id);
-	if (conn && conn->app->type == APP_SERVER)
+	if (conn && conn->owner && conn->app->type == APP_SERVER)
 		trigger_disconnection(conn);
 
 	status = HAL_STATUS_SUCCESS;
-- 
2.0.0

