Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 2/2] android/gatt: Add DEVICE_CONNECTING state
Date: Sun, 27 Apr 2014 17:04:51 +0200
Message-Id: <1398611091-4048-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398611091-4048-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398611091-4048-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow us to determine if we can scan for other devices to
connect or postpone it until previous connection is handled.
---
 android/gatt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8c5b7e8..1d971fb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -58,13 +58,15 @@ typedef enum {
 	DEVICE_DISCONNECTED = 0,
 	DEVICE_CONNECT_INIT,		/* connection procedure initiated */
 	DEVICE_CONNECT_READY,		/* dev found during LE scan */
-	DEVICE_CONNECTED,		/* connection has been established */
+	DEVICE_CONNECTING,		/* io connection triggered */
+	DEVICE_CONNECTED,		/* io connection has been established */
 } gatt_device_state_t;
 
 static const char const *device_state_str[] = {
 	"DISCONNECTED",
 	"CONNECT INIT",
 	"CONNECT READY",
+	"CONNECTING",
 	"CONNECTED",
 };
 
@@ -953,7 +955,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	uint32_t status;
 	GAttrib *attrib;
 
-	if (dev->state != DEVICE_CONNECT_READY) {
+	if (dev->state != DEVICE_CONNECTING) {
 		error("gatt: Device not in a connecting state!?");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
@@ -993,7 +995,7 @@ reply:
 	device_unref(dev);
 
 	/* Check if we should restart scan */
-	if (scanning)
+	if (scanning || find_device_by_state(DEVICE_CONNECT_INIT))
 		bt_le_discovery_start(le_device_found_handler);
 
 	/* FIXME: What to do if discovery won't start here. */
@@ -1040,6 +1042,7 @@ static int connect_le(struct gatt_device *dev)
 
 	/* Keep this, so we can cancel the connection */
 	dev->att_io = io;
+	device_set_state(dev, DEVICE_CONNECTING);
 
 	return 0;
 }
@@ -1092,7 +1095,7 @@ reply:
 									status);
 }
 
-static int connect_next_dev(void)
+static void connect_pending_devices(void)
 {
 	struct gatt_device *dev;
 
@@ -1100,18 +1103,18 @@ static int connect_next_dev(void)
 
 	dev = find_device_by_state(DEVICE_CONNECT_READY);
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
 
 static struct gatt_device *create_device(const bdaddr_t *addr)
@@ -1201,14 +1204,16 @@ static bool trigger_connection(struct connection *connection)
 		device_set_state(connection->device, DEVICE_CONNECT_INIT);
 		break;
 	case DEVICE_CONNECTED:
+	case DEVICE_CONNECTING:
 		send_client_connect_notify(connection, GATT_SUCCESS);
 		break;
 	default:
 		break;
 	}
 
-	/* after state change trigger discovering */
-	if (!scanning && (connection->device->state == DEVICE_CONNECT_INIT))
+	/* after state change - trigger discovering (if ACL is not creating) */
+	if (!scanning && (connection->device->state == DEVICE_CONNECT_INIT) &&
+				!find_device_by_state(DEVICE_CONNECTING))
 		if (!bt_le_discovery_start(le_device_found_handler)) {
 			error("gatt: Could not start scan");
 
-- 
1.9.1

