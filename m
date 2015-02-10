Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/6] android/gatt: Remove device's connection counter
Date: Tue, 10 Feb 2015 13:48:14 +0100
Message-Id: <1423572494-32037-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Originally we used connection counter to determine if device object
is still needed or should be destroyed but we switched to reference
counting quite some time ago and this counter is not needed anymore.
---
 android/gatt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9be750a..cda38ea 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -166,7 +166,6 @@ struct gatt_device {
 	guint ind_id;
 
 	int ref;
-	int conn_cnt;
 
 	struct queue *autoconnect_apps;
 
@@ -913,8 +912,8 @@ static void destroy_connection(void *data)
 	if (conn->timeout_id > 0)
 		g_source_remove(conn->timeout_id);
 
-	conn->device->conn_cnt--;
-	if (conn->device->conn_cnt == 0)
+	if (!queue_find(app_connections, match_connection_by_device,
+							conn->device))
 		connection_cleanup(conn->device);
 
 	queue_destroy(conn->transactions, free);
@@ -1115,7 +1114,6 @@ static struct app_connection *create_connection(struct gatt_device *device,
 	}
 
 	new_conn->device = device_ref(device);
-	new_conn->device->conn_cnt++;
 
 	return new_conn;
 }
@@ -1605,7 +1603,7 @@ reply:
 	 */
 	queue_foreach(dev->autoconnect_apps, create_app_connection, dev);
 
-	if (!dev->conn_cnt) {
+	if (!queue_find(app_connections, match_connection_by_device, dev)) {
 		struct app_connection *conn;
 
 		if (!dev->attrib)
-- 
1.9.1

