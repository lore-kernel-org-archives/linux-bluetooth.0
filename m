Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/5] serial: add Serial.ConnectFD()
Date: Thu, 18 Aug 2011 17:09:59 -0300
Message-Id: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It's similar to Serial.Connect() but returns the actual RFCOMM file
descriptor instead of creating a device in /dev
---
 doc/serial-api.txt |   16 ++++++++++++++++
 serial/port.c      |   36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index 5f9bd5f..635b3ec 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -26,6 +26,22 @@ Methods		string Connect(string pattern)
 					 org.bluez.Error.ConnectionAttemptFailed
 					 org.bluez.Error.NotSupported
 
+Methods		fd ConnectFD(string pattern)
+
+			Connects to a specific RFCOMM based service on a
+			remote device and returns a file descriptor to talk
+			 with this device.
+
+			Possible patterns: UUID 128 bit as string
+					   Profile short names, e.g: spp, dun
+					   RFCOMM channel as string, 1-30
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.ConnectionAttemptFailed
+					 org.bluez.Error.NotSupported
+
+
 		void Disconnect(string device)
 
 			Disconnect a RFCOMM TTY device that has been
diff --git a/serial/port.c b/serial/port.c
index d011084..e359716 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -63,6 +63,10 @@
 #define MAX_OPEN_TRIES		5
 #define OPEN_WAIT		300	/* ms. udev node creation retry wait */
 
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
 struct serial_device {
 	DBusConnection	*conn;		/* for name listener handling */
 	bdaddr_t	src;		/* Source (local) address */
@@ -80,6 +84,7 @@ struct serial_port {
 	int		fd;		/* Opened file descriptor */
 	GIOChannel	*io;		/* BtIO channel */
 	guint		listener_id;
+	gboolean	fd_passing;
 	struct serial_device *device;
 };
 
@@ -329,6 +334,14 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 	port->io = NULL;
 
 	sk = g_io_channel_unix_get_fd(chan);
+	if (port->fd_passing) {
+		reply = g_dbus_create_reply(port->msg,
+				DBUS_TYPE_UNIX_FD, &sk,
+				DBUS_TYPE_INVALID);
+		g_dbus_send_message(device->conn, reply);
+		return;
+	}
+
 	port->id = ioctl(sk, RFCOMMCREATEDEV, &req);
 	if (port->id < 0) {
 		int err = -errno;
@@ -468,8 +481,8 @@ static struct serial_port *create_port(struct serial_device *device,
 	return port;
 }
 
-static DBusMessage *port_connect(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
+static DBusMessage *_port_connect(DBusConnection *conn, DBusMessage *msg,
+					void *user_data, gboolean fd)
 {
 	struct serial_device *device = user_data;
 	struct serial_port *port;
@@ -501,6 +514,9 @@ static DBusMessage *port_connect(DBusConnection *conn,
 						NULL);
 	port->msg = dbus_message_ref(msg);
 
+	if (fd)
+		port->fd_passing = TRUE;
+
 	err = connect_port(port);
 	if (err < 0) {
 		error("%s", strerror(-err));
@@ -513,6 +529,21 @@ static DBusMessage *port_connect(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *port_connect(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return _port_connect(conn, msg, user_data, FALSE);
+}
+
+static DBusMessage *port_connect_fd(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return btd_error_not_supported(msg);
+
+	return _port_connect(conn, msg, user_data, TRUE);
+}
+
 static DBusMessage *port_disconnect(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -546,6 +577,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 
 static GDBusMethodTable port_methods[] = {
 	{ "Connect",    "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ConnectFD",    "s", "h", port_connect_fd, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "s", "",  port_disconnect },
 	{ }
 };
-- 
1.7.6

