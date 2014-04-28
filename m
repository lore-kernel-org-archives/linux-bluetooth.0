Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/3] android/gatt: Add DEVICE_CONNECTING state
Date: Mon, 28 Apr 2014 15:17:48 +0200
Message-Id: <1398691070-25530-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow us to determine if we can scan for other devices to
connect or postpone it until previous connection is handled.
---
 android/gatt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b224c28..b533661 100644
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
@@ -1207,8 +1210,9 @@ static bool trigger_connection(struct connection *connection)
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

