Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/6] android/gatt: Remove reduntant comparison
Date: Tue, 10 Feb 2015 13:48:13 +0100
Message-Id: <1423572494-32037-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is not needed as we only have one type or the other.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7b924af..9be750a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -881,7 +881,7 @@ static void notify_app_connect_status(struct app_connection *conn,
 
 	if (conn->app->type == GATT_CLIENT)
 		send_client_connect_status_notify(conn, status);
-	else if (conn->app->type == GATT_SERVER)
+	else
 		send_server_connection_state_notify(conn, !status);
 }
 
-- 
1.9.1

