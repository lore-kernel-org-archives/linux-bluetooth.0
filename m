Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 13/16] android/gatt: Move auto_connect_le() up in the file
Date: Tue,  2 Sep 2014 12:09:58 +0200
Message-Id: <1409652601-28689-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move function up in the file. Will be needed by following patches.
---
 android/gatt.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index c614e6a..9b58644 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -594,6 +594,23 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
 	dev->state = state;
 }
 
+static bool auto_connect_le(struct gatt_device *dev)
+{
+	/*  For LE devices use auto connect feature if possible */
+	if (bt_kernel_conn_control())
+		return  bt_auto_connect_add(&dev->bdaddr);
+
+	/* Trigger discovery if not already started */
+	if (!scanning) {
+		if (!bt_le_discovery_start()) {
+			error("gatt: Could not start scan");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static void connection_cleanup(struct gatt_device *device)
 {
 	if (device->watch_id) {
@@ -1825,23 +1842,6 @@ static int connect_bredr(struct gatt_device *dev)
 	return 0;
 }
 
-static bool auto_connect_le(struct gatt_device *dev)
-{
-	/*  For LE devices use auto connect feature if possible */
-	if (bt_kernel_conn_control())
-		return  bt_auto_connect_add(&dev->bdaddr);
-
-	/* Trigger discovery if not already started */
-	if (!scanning) {
-		if (!bt_le_discovery_start()) {
-			error("gatt: Could not start scan");
-			return false;
-		}
-	}
-
-	return true;
-}
-
 static bool trigger_connection(struct app_connection *connection)
 {
 	bool ret;
-- 
1.8.4

