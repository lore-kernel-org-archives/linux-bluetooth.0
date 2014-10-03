Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Fix adding duplicate connection for server apps
Date: Fri,  3 Oct 2014 12:42:09 +0200
Message-Id: <1412332929-14595-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces the usage of unsafe function for adding app connections
with the one that is almost the same but first it checks if no
duplicate entry is added to the list.

This fixes connection callback being sent twice for server app when it
initiates the connection, and removes duplicated code.
---
 android/gatt.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b4a2554..dbe067f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6193,17 +6193,6 @@ done:
 									NULL);
 }
 
-static void create_listen_connections(void *data, void *user_data)
-{
-	struct gatt_device *dev = user_data;
-	int32_t id = PTR_TO_INT(data);
-	struct gatt_app *app;
-
-	app = find_app_by_id(id);
-	if (app)
-		create_connection(dev, app);
-}
-
 static void connect_confirm(GIOChannel *io, void *user_data)
 {
 	struct gatt_device *dev;
@@ -6252,7 +6241,7 @@ static void connect_confirm(GIOChannel *io, void *user_data)
 		goto drop;
 	}
 
-	queue_foreach(listen_apps, create_listen_connections, dev);
+	queue_foreach(listen_apps, create_app_connection, dev);
 	device_set_state(dev, DEVICE_CONNECT_READY);
 
 	return;
-- 
1.9.1

