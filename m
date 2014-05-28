Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/2] android/gatt: Initialize crypto first
Date: Wed, 28 May 2014 09:48:49 +0200
Message-Id: <1401263330-30680-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the missleading error on crypto setup failure:

02-17 20:19:44.639 I/bluetoothd( 1705): bluetoothd[1706]: gatt: Failed
to allocate memory for queues
---
 android/gatt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9234b46..1f83eaa 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5493,15 +5493,24 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	if (!start_listening_io())
 		return false;
 
+	crypto = bt_crypto_new();
+	if (!crypto) {
+		error("gatt: Failed to setup crypto");
+
+		g_io_channel_unref(listening_io);
+		listening_io = NULL;
+
+		return false;
+	}
+
 	gatt_devices = queue_new();
 	gatt_apps = queue_new();
 	app_connections = queue_new();
 	listen_apps = queue_new();
 	gatt_db = gatt_db_new();
-	crypto = bt_crypto_new();
 
-	if (!gatt_devices || !gatt_apps || !listen_apps ||
-				!app_connections || !gatt_db || !crypto) {
+	if (!gatt_devices || !gatt_apps || !listen_apps || !app_connections ||
+								!gatt_db) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_apps, NULL);
-- 
1.9.3

