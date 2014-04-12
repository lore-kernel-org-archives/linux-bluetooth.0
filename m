Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Fix memory leak
Date: Sat, 12 Apr 2014 23:48:58 +0200
Message-Id: <1397339338-29264-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It happens on daemon exit when connection is up.

295 (104 direct, 191 indirect) bytes in 1 blocks are definitely lost in
loss record 140 of 148
==25132==    at 0x4C2B6CD: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==25132==    by 0x4E7FBBD: g_try_malloc0 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25132==    by 0x437BF9: g_attrib_new (gattrib.c:495)
==25132==    by 0x42F45F: connect_cb (gatt.c:845)
==25132==    by 0x439DBA: connect_cb (btio.c:232)
==25132==    by 0x4E79D12: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25132==    by 0x4E7A05F: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25132==    by 0x4E7A459: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
==25132==    by 0x4044FD: main (main.c:531)

This patch moves function connection_cleanup up in the file as this is
needed by destroy_device
---
 android/gatt.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 243e02f..abec46b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -388,6 +388,27 @@ static void unregister_notification(void *data)
 							notification->ind_id);
 }
 
+static void connection_cleanup(struct gatt_device *device)
+{
+	if (device->watch_id) {
+		g_source_remove(device->watch_id);
+		device->watch_id = 0;
+	}
+
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+		device->att_io = NULL;
+	}
+
+	if (device->attrib) {
+		GAttrib *attrib = device->attrib;
+		device->attrib = NULL;
+		g_attrib_cancel_all(attrib);
+		g_attrib_unref(attrib);
+	}
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -395,6 +416,9 @@ static void destroy_device(void *data)
 	if (!dev)
 		return;
 
+	if (dev->conn_id)
+		connection_cleanup(dev);
+
 	queue_destroy(dev->clients, NULL);
 	queue_destroy(dev->services, destroy_service);
 	free(dev);
@@ -654,27 +678,6 @@ done:
 	send_client_all_primary(gatt_status, dev->services, dev->conn_id);
 }
 
-static void connection_cleanup(struct gatt_device *device)
-{
-	if (device->watch_id) {
-		g_source_remove(device->watch_id);
-		device->watch_id = 0;
-	}
-
-	if (device->att_io) {
-		g_io_channel_shutdown(device->att_io, FALSE, NULL);
-		g_io_channel_unref(device->att_io);
-		device->att_io = NULL;
-	}
-
-	if (device->attrib) {
-		GAttrib *attrib = device->attrib;
-		device->attrib = NULL;
-		g_attrib_cancel_all(attrib);
-		g_attrib_unref(attrib);
-	}
-}
-
 static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
 								int32_t status)
 {
-- 
1.8.4

