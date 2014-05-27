Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/6] android/gatt: Initialize crypto first
Date: Tue, 27 May 2014 12:15:33 +0200
Message-Id: <1401185734-23672-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the missleading error on crypto setup failure:

02-17 20:19:44.639 I/bluetoothd( 1705): bluetoothd[1706]: gatt: Failed
to allocate memory for queues
---
 android/gatt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index dab9781..a8f072f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5491,15 +5491,20 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	if (!start_listening_io())
 		return false;
 
+	crypto = bt_crypto_new();
+	if (!crypto) {
+		error("gatt: Failed to setup crypto.");
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

