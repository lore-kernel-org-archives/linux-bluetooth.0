Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] serial: Fix error handling in connect_port()
Date: Fri, 18 Nov 2011 08:11:47 -0400
Message-Id: <1321618307-11456-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If available, provide a more useful D-Bus error message instead of just
the POSIX error. Also remove a bogus use of errno.
---
 serial/port.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index 3b36d44..cbf06c5 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -438,7 +438,7 @@ failed:
 	g_dbus_send_message(device->conn, reply);
 }
 
-static int connect_port(struct serial_port *port)
+static int connect_port(struct serial_port *port, GError **gerr)
 {
 	struct serial_device *device = port->device;
 	uuid_t uuid;
@@ -458,15 +458,15 @@ static int connect_port(struct serial_port *port)
 
 connect:
 	port->io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, port,
-				NULL, NULL,
+				NULL, gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &device->src,
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
 				BT_IO_OPT_INVALID);
-	if (port->io)
-		return 0;
+	if (port->io == NULL)
+		return -EIO;
 
-	return -errno;
+	return 0;
 }
 
 static struct serial_port *create_port(struct serial_device *device,
@@ -492,6 +492,7 @@ static DBusMessage *port_connect(DBusConnection *conn,
 	struct serial_device *device = user_data;
 	struct serial_port *port;
 	const char *pattern;
+	GError *gerr = NULL;
 	int err;
 
 	if (dbus_message_has_member(msg, "ConnectFD") && DBUS_TYPE_UNIX_FD < 0)
@@ -523,13 +524,23 @@ static DBusMessage *port_connect(DBusConnection *conn,
 
 	port->msg = dbus_message_ref(msg);
 
-	err = connect_port(port);
+	err = connect_port(port, &gerr);
 	if (err < 0) {
-		error("%s", strerror(-err));
+		DBusMessage *reply;
+
+		if (gerr == NULL) {
+			error("%s", strerror(-err));
+			reply = btd_error_failed(msg, strerror(-err));
+		} else {
+			error("%s", gerr->message);
+			reply = btd_error_failed(msg, gerr->message);
+			g_error_free(gerr);
+		}
+
 		g_dbus_remove_watch(conn, port->listener_id);
 		port->listener_id = 0;
 
-		return btd_error_failed(msg, strerror(-err));
+		return reply;
 	}
 
 	return NULL;
-- 
1.7.0.4

