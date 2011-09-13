Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/2] serial: add Serial.ConnectFD()
Date: Tue, 13 Sep 2011 15:16:05 -0300
Message-Id: <1315937765-32168-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315937765-32168-1-git-send-email-padovan@profusion.mobi>
References: <1315937765-32168-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It's similar to Serial.Connect() but returns the actual RFCOMM file
descriptor instead of creating a device in /dev
---
 doc/serial-api.txt |   16 ++++++++++++++++
 serial/port.c      |   25 ++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index 5f9bd5f..98b0ad4 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -26,6 +26,22 @@ Methods		string Connect(string pattern)
 					 org.bluez.Error.ConnectionAttemptFailed
 					 org.bluez.Error.NotSupported
 
+Methods		fd ConnectFD(string pattern) [experimental]
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
index a931ebd..7f5fce1 100644
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
@@ -318,6 +322,21 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 		goto fail;
 	}
 
+	sk = g_io_channel_unix_get_fd(chan);
+
+	if (dbus_message_has_member(port->msg, "ConnectFD")) {
+		reply = g_dbus_create_reply(port->msg, DBUS_TYPE_UNIX_FD, &sk,
+							DBUS_TYPE_INVALID);
+		g_dbus_send_message(device->conn, reply);
+
+		close(sk);
+
+		g_dbus_remove_watch(device->conn, port->listener_id);
+		port->listener_id = 0;
+
+		return;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.dev_id = -1;
 	req.flags = (1 << RFCOMM_REUSE_DLC);
@@ -328,7 +347,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 	g_io_channel_unref(port->io);
 	port->io = NULL;
 
-	sk = g_io_channel_unix_get_fd(chan);
 	port->id = ioctl(sk, RFCOMMCREATEDEV, &req);
 	if (port->id < 0) {
 		int err = -errno;
@@ -474,6 +492,9 @@ static DBusMessage *port_connect(DBusConnection *conn,
 	const char *pattern;
 	int err;
 
+	if (dbus_message_has_member(msg, "ConnectFD") && DBUS_TYPE_UNIX_FD < 0)
+		return btd_error_not_supported(msg);
+
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 						DBUS_TYPE_INVALID) == FALSE)
 		return NULL;
@@ -497,6 +518,7 @@ static DBusMessage *port_connect(DBusConnection *conn,
 						dbus_message_get_sender(msg),
 						port_owner_exited, port,
 						NULL);
+
 	port->msg = dbus_message_ref(msg);
 
 	err = connect_port(port);
@@ -544,6 +566,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 
 static GDBusMethodTable port_methods[] = {
 	{ "Connect",    "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ConnectFD",    "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "s", "",  port_disconnect },
 	{ }
 };
-- 
1.7.6.2

