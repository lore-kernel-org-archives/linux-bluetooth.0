Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 10/13] android/gatt: Factor out device disconn. part from app disconn.
Date: Fri,  6 Jun 2014 15:46:23 +0200
Message-Id: <1402062386-4632-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device disconnection will be needed to cleanup incomming connections
when acting as server.
---
 android/gatt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 558b203..4bc4f35 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -843,20 +843,22 @@ static void device_unref(struct gatt_device *device)
 	destroy_device(device);
 }
 
+static void disconnect_device(struct gatt_device *dev)
+{
+	dev->conn_cnt--;
+	if (dev->conn_cnt == 0)
+		connection_cleanup(dev);
+
+	device_unref(dev);
+}
+
 static void destroy_app_connection(void *data)
 {
 	struct app_connection *conn = data;
 
-	if (!queue_find(gatt_devices, match_by_value, conn->device))
-		goto cleanup;
-
-	conn->device->conn_cnt--;
-	if (conn->device->conn_cnt == 0)
-		connection_cleanup(conn->device);
+	disconnect_device(conn->device);
 
-cleanup:
 	queue_destroy(conn->transactions, free);
-	device_unref(conn->device);
 	free(conn);
 }
 
-- 
2.0.0

