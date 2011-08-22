Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/2] serial: Add support to Disconnect fd passing connections
Date: Mon, 22 Aug 2011 14:19:45 -0300
Message-Id: <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Disconnect can also be called for connections created with ConnectFD
---
 doc/serial-api.txt |    3 +++
 serial/port.c      |   14 ++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index 98b0ad4..09a4c0d 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -53,5 +53,8 @@ Methods		fd ConnectFD(string pattern) [experimental]
 			In that case one of patterns of the Connect method should
 			be suplied instead of the TTY device.
 
+			Connection created with Serial.ConnectFD only accept
+			as parameter the same parameters ConnectFD accepts.
+
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
diff --git a/serial/port.c b/serial/port.c
index e359716..0c3d171 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -148,8 +148,11 @@ static int port_release(struct serial_port *port)
 	int rfcomm_ctl;
 	int err = 0;
 
-	if (port->id < 0) {
+	if (port->id < 0 || port->fd_passing == TRUE) {
 		if (port->io) {
+			int sk = g_io_channel_unix_get_fd(port->io);
+			shutdown(sk, SHUT_RDWR);
+
 			g_io_channel_shutdown(port->io, TRUE, NULL);
 			g_io_channel_unref(port->io);
 			port->io = NULL;
@@ -157,6 +160,9 @@ static int port_release(struct serial_port *port)
 			bt_cancel_discovery(&port->device->src,
 						&port->device->dst);
 
+		port->fd_passing = FALSE;
+		port->id = 1;
+
 		return 0;
 	}
 
@@ -330,9 +336,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 	bacpy(&req.dst, &device->dst);
 	req.channel = port->channel;
 
-	g_io_channel_unref(port->io);
-	port->io = NULL;
-
 	sk = g_io_channel_unix_get_fd(chan);
 	if (port->fd_passing) {
 		reply = g_dbus_create_reply(port->msg,
@@ -342,6 +345,9 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 		return;
 	}
 
+	g_io_channel_unref(port->io);
+	port->io = NULL;
+
 	port->id = ioctl(sk, RFCOMMCREATEDEV, &req);
 	if (port->id < 0) {
 		int err = -errno;
-- 
1.7.6

