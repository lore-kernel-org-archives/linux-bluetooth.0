Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 5/5] serial: Add support to Disconnect fd passing connections
Date: Thu, 18 Aug 2011 17:10:03 -0300
Message-Id: <1313698203-13201-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1313698203-13201-4-git-send-email-padovan@profusion.mobi>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
 <1313698203-13201-2-git-send-email-padovan@profusion.mobi>
 <1313698203-13201-3-git-send-email-padovan@profusion.mobi>
 <1313698203-13201-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Disconnect can also be called for connections created with ConnectFD
---
 doc/serial-api.txt |    3 +++
 serial/port.c      |   17 +++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index 635b3ec..5c9ee9d 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -53,5 +53,8 @@ Methods		fd ConnectFD(string pattern)
 			In that case one of patterns of the Connect method should
 			be suplied instead of the TTY device.
 
+			Connection created with Serial.ConnectFD only accept
+			as parameter the same parameters ConnectFD accepts.
+
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
diff --git a/serial/port.c b/serial/port.c
index 784febd..e074cef 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -345,9 +345,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 	bacpy(&req.dst, &device->dst);
 	req.channel = port->channel;
 
-	g_io_channel_unref(port->io);
-	port->io = NULL;
-
 	sk = g_io_channel_unix_get_fd(chan);
 	if (port->fd_passing) {
 		reply = g_dbus_create_reply(port->msg,
@@ -359,6 +356,9 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 		return;
 	}
 
+	g_io_channel_unref(port->io);
+	port->io = NULL;
+
 	port->id = ioctl(sk, RFCOMMCREATEDEV, &req);
 	if (port->id < 0) {
 		int err = -errno;
@@ -590,7 +590,16 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 	if (!g_str_equal(port->sender, caller))
 		return btd_error_not_authorized(msg);
 
-	port_release(port);
+	if (port->fd_passing == TRUE) {
+		int sk = g_io_channel_unix_get_fd(port->io);
+		shutdown(sk, SHUT_RDWR);
+
+		g_io_channel_unref(port->io);
+		port->io = NULL;
+	}
+	else {
+		port_release(port);
+	}
 
 	g_dbus_remove_watch(conn, port->listener_id);
 	port->listener_id = 0;
-- 
1.7.6

