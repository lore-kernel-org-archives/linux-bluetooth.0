Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 12/13] android/gatt: Verify client and server disconnect callers
Date: Fri,  6 Jun 2014 15:46:25 +0200
Message-Id: <1402062386-4632-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This checks if connection with provided ID actually belongs to the
client or server apps. Previously server_disconnect could be called with
clients connection ID and vice versa.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9c2f3ba..9607416 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1587,7 +1587,7 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
 	conn = find_connection_by_id(cmd->conn_id);
-	if (conn)
+	if (conn && conn->app->type == APP_CLIENT)
 		trigger_disconnection(conn);
 
 	status = HAL_STATUS_SUCCESS;
@@ -3725,7 +3725,7 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
 	conn = find_connection_by_id(cmd->conn_id);
-	if (conn)
+	if (conn && conn->app->type == APP_SERVER)
 		trigger_disconnection(conn);
 
 	status = HAL_STATUS_SUCCESS;
-- 
2.0.0

