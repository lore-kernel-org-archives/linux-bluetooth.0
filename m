Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/2] android/gatt: Add DEVICE_CONNECTING state
Date: Thu, 24 Apr 2014 15:01:59 +0200
Message-Id: <1398344519-8994-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398344519-8994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398344519-8994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow us to determine if we scan for other devices to connect
or postpone it until previous connection is handled.
---
 android/gatt.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 76dca5c..2772a61 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -58,6 +58,7 @@ typedef enum {
 	DEVICE_DISCONNECTED = 0,
 	DEVICE_CONNECTION_PENDING,
 	DEVICE_CONNECTABLE,
+	DEVICE_CONNECTING,
 	DEVICE_CONNECTED,
 } gatt_device_state_t;
 
@@ -65,6 +66,7 @@ static const char const *device_state_str[] = {
 	"DISCONNECTED",
 	"CONNECTION PENDING",
 	"CONNECTABLE",
+	"CONNECTING",
 	"CONNECTED",
 };
 
@@ -926,7 +928,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	 * in connect_le()?
 	 */
 	dev = find_device(dev);
-	if (!dev || dev->state != DEVICE_CONNECTABLE) {
+	if (!dev || dev->state != DEVICE_CONNECTING) {
 		error("gatt: Device not on the connect wait queue!?");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
@@ -937,6 +939,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	if (gerr) {
 		error("gatt: connection failed %s", gerr->message);
+		device_set_state(dev, DEVICE_CONNECTION_PENDING);
 		status = GATT_FAILURE;
 		goto reply;
 	}
@@ -944,6 +947,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	attrib = g_attrib_new(io);
 	if (!attrib) {
 		error("gatt: unable to create new GAttrib instance");
+		device_set_state(dev, DEVICE_CONNECTION_PENDING);
 		status = GATT_FAILURE;
 		goto reply;
 	}
@@ -965,7 +969,7 @@ reply:
 		destroy_device(dev);
 
 	/* Check if we should restart scan */
-	if (scanning)
+	if (scanning || find_device_by_state(DEVICE_CONNECTION_PENDING))
 		bt_le_discovery_start(le_device_found_handler);
 
 	/* FIXME: What to do if discovery won't start here. */
@@ -1012,6 +1016,7 @@ static int connect_le(struct gatt_device *dev)
 
 	/* Keep this, so we can cancel the connection */
 	dev->att_io = io;
+	device_set_state(dev, DEVICE_CONNECTING);
 
 	return 0;
 }
@@ -1064,7 +1069,7 @@ reply:
 									status);
 }
 
-static int connect_next_dev(void)
+static void connect_pending_devices(void)
 {
 	struct gatt_device *dev;
 
@@ -1072,18 +1077,18 @@ static int connect_next_dev(void)
 
 	dev = find_device_by_state(DEVICE_CONNECTABLE);
 	if (!dev)
-		return -ENODEV;
+		return;
 
-	return connect_le(dev);
+	/* In case of problem with socket we should retry. */
+	if (connect_le(dev) == -EIO)
+		bt_le_discovery_start(le_device_found_handler);
 }
 
 static void bt_le_discovery_stop_cb(void)
 {
 	DBG("");
 
-	/* Check now if there is any device ready to connect */
-	if (connect_next_dev() < 0)
-		bt_le_discovery_start(le_device_found_handler);
+	connect_pending_devices();
 }
 
 static struct gatt_device *create_device(bdaddr_t *addr)
@@ -1173,14 +1178,17 @@ static bool trigger_connection(struct connection *connection)
 		device_set_state(connection->device, DEVICE_CONNECTION_PENDING);
 		break;
 	case DEVICE_CONNECTED:
+	case DEVICE_CONNECTING:
 		send_client_connect_notify(connection, GATT_SUCCESS);
 		break;
 	default:
 		break;
 	}
 
-	/* after state change trigger discovering */
-	if (!scanning && (connection->device->state == DEVICE_CONNECTION_PENDING))
+	/* after state change - trigger discovering (if ACL is not creating) */
+	if (!scanning && (connection->device->state
+				== DEVICE_CONNECTION_PENDING) &&
+				!find_device_by_state(DEVICE_CONNECTING))
 		if (!bt_le_discovery_start(le_device_found_handler)) {
 			error("gatt: Could not start scan");
 
-- 
1.9.1

