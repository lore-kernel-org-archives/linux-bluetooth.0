Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] device: Use att_io in device_browse_primary
Date: Wed,  8 Feb 2012 17:35:46 -0300
Message-Id: <1328733349-29731-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
References: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to have the same approach as att_connect function,
device_browse_primary function should save the reference to
GIOChannel at device->att_io. This way, we can properly shut
it down if the browse request is canceled during the connection
attempt.
---
 src/device.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index bd25a27..23ca67b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -179,11 +179,6 @@ static void browse_request_free(struct browse_req *req, gboolean shutdown)
 		g_dbus_remove_watch(req->conn, req->listener_id);
 	if (req->attrib)
 		g_attrib_unref(req->attrib);
-	if (req->io) {
-		if (shutdown)
-			g_io_channel_shutdown(req->io, FALSE, NULL);
-		g_io_channel_unref(req->io);
-	}
 	if (req->msg)
 		dbus_message_unref(req->msg);
 	if (req->conn)
@@ -211,6 +206,12 @@ static void browse_request_cancel(struct browse_req *req)
 
 	bt_cancel_discovery(&src, &device->bdaddr);
 
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+		device->att_io = NULL;
+	}
+
 	device->browse = NULL;
 	browse_request_free(req, TRUE);
 }
@@ -1907,6 +1908,9 @@ static void browse_primary_connect_cb(GIOChannel *io, GError *gerr,
 	struct browse_req *req = device->browse;
 	GAttrib *attrib;
 
+	g_io_channel_unref(device->att_io);
+	device->att_io = NULL;
+
 	if (gerr) {
 		DBusMessage *reply;
 
@@ -1948,7 +1952,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	req->io = bt_io_connect(BT_IO_L2CAP, browse_primary_connect_cb,
+	device->att_io = bt_io_connect(BT_IO_L2CAP, browse_primary_connect_cb,
 				device, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
@@ -1956,7 +1960,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
-	if (req->io == NULL) {
+	if (device->att_io == NULL) {
 		browse_request_free(req, FALSE);
 		return -EIO;
 	}
-- 
1.7.9

