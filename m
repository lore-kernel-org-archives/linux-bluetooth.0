Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/gatt: Handle device state in connect functions
Date: Thu,  5 Mar 2015 12:57:46 +0100
Message-Id: <1425556666-9868-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425556666-9868-1-git-send-email-szymon.janc@tieto.com>
References: <1425556666-9868-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Depending on kernel connection management support and type of
connection (direct or not) different states are expected after
connect. To make sure device state is correct set it connect
functions.
---
 android/gatt.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7263e31..9c2a280 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -573,6 +573,9 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
 {
 	char bda[18];
 
+	if (dev->state == state)
+		return;
+
 	ba2str(&dev->bdaddr, bda);
 	DBG("gatt: Device %s state changed %s -> %s", bda,
 			device_state_str[dev->state], device_state_str[state]);
@@ -583,17 +586,18 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
 static bool auto_connect_le(struct gatt_device *dev)
 {
 	/*  For LE devices use auto connect feature if possible */
-	if (bt_kernel_conn_control())
-		return bt_auto_connect_add(bt_get_id_addr(&dev->bdaddr, NULL));
-
-	/* Trigger discovery if not already started */
-	if (!scanning) {
-		if (!bt_le_discovery_start()) {
+	if (bt_kernel_conn_control()) {
+		if (!bt_auto_connect_add(bt_get_id_addr(&dev->bdaddr, NULL)))
+			return false;
+	} else {
+		/* Trigger discovery if not already started */
+		if (!scanning && !bt_le_discovery_start()) {
 			error("gatt: Could not start scan");
 			return false;
 		}
 	}
 
+	device_set_state(dev, DEVICE_CONNECT_INIT);
 	return true;
 }
 
@@ -640,12 +644,10 @@ static void connection_cleanup(struct gatt_device *device)
 
 	device_set_state(device, DEVICE_DISCONNECTED);
 
-	if (!queue_isempty(device->autoconnect_apps)) {
+	if (!queue_isempty(device->autoconnect_apps))
 		auto_connect_le(device);
-		device_set_state(device, DEVICE_CONNECT_INIT);
-	} else {
+	else
 		bt_auto_connect_remove(&device->bdaddr);
-	}
 }
 
 static void destroy_gatt_app(void *data)
@@ -1649,6 +1651,8 @@ static int connect_le(struct gatt_device *dev)
 	/* Keep this, so we can cancel the connection */
 	dev->att_io = io;
 
+	device_set_state(dev, DEVICE_CONNECT_READY);
+
 	return 0;
 }
 
@@ -1899,8 +1903,6 @@ static int connect_bredr(struct gatt_device *dev)
 
 static bool trigger_connection(struct app_connection *conn, bool direct)
 {
-	bool ret;
-
 	switch (conn->device->state) {
 	case DEVICE_DISCONNECTED:
 		/*
@@ -1912,26 +1914,18 @@ static bool trigger_connection(struct app_connection *conn, bool direct)
 			return connect_bredr(conn->device) == 0;
 
 		if (direct)
-			ret = connect_le(conn->device) == 0;
-		else
-			ret = auto_connect_le(conn->device);
+			return connect_le(conn->device) == 0;
 
-		if (ret)
-			device_set_state(conn->device, DEVICE_CONNECT_INIT);
-		break;
+		return auto_connect_le(conn->device);
 	case DEVICE_CONNECTED:
 		notify_app_connect_status(conn, GATT_SUCCESS);
-		ret = true;
-		break;
+		return true;
 	case DEVICE_CONNECT_READY:
 	case DEVICE_CONNECT_INIT:
 	default:
 		/* In those cases connection is already triggered. */
-		ret = true;
-		break;
+		return true;
 	}
-
-	return ret;
 }
 
 static void remove_autoconnect_device(struct gatt_device *dev)
-- 
1.9.3

