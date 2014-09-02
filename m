Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 12/16] android/gatt: Extract trigger le connection to new function
Date: Tue,  2 Sep 2014 12:09:57 +0200
Message-Id: <1409652601-28689-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be needed in reconnect scenario
---
 android/gatt.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 94a65cb..c614e6a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1825,15 +1825,19 @@ static int connect_bredr(struct gatt_device *dev)
 	return 0;
 }
 
-static bool auto_connect(struct gatt_device *dev)
+static bool auto_connect_le(struct gatt_device *dev)
 {
-	bool err;
-
-	err = bt_auto_connect_add(&dev->bdaddr);
-	if (!err)
-		return false;
+	/*  For LE devices use auto connect feature if possible */
+	if (bt_kernel_conn_control())
+		return  bt_auto_connect_add(&dev->bdaddr);
 
-	device_set_state(dev, DEVICE_CONNECT_INIT);
+	/* Trigger discovery if not already started */
+	if (!scanning) {
+		if (!bt_le_discovery_start()) {
+			error("gatt: Could not start scan");
+			return false;
+		}
+	}
 
 	return true;
 }
@@ -1852,24 +1856,11 @@ static bool trigger_connection(struct app_connection *connection)
 								BDADDR_BREDR)
 			return connect_bredr(connection->device) == 0;
 
-		/*
-		 * For LE devices use auto connect feature if possible
-		 * Note: Connection state is handled inside auto_connect() func
-		 */
-		if (bt_kernel_conn_control())
-			return auto_connect(connection->device);
-
-		/* Trigger discovery if not already started */
-		if (!scanning) {
-			if (!bt_le_discovery_start()) {
-				error("gatt: Could not start scan");
-				ret = false;
-				break;
-			}
-		}
-
-		ret = true;
-		device_set_state(connection->device, DEVICE_CONNECT_INIT);
+		/* For LE use auto connect feature */
+		ret = auto_connect_le(connection->device);
+		if (ret)
+			device_set_state(connection->device,
+							DEVICE_CONNECT_INIT);
 		break;
 	case DEVICE_CONNECTED:
 		send_app_connect_notify(connection, GATT_SUCCESS);
-- 
1.8.4

