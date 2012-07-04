Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 14/28] serial: remove old way to connect to a serial port
Date: Wed,  4 Jul 2012 10:17:33 +0200
Message-Id: <1341389867-30749-15-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Only the fd-passing connect is available now.
---
 doc/serial-api.txt |   32 +--------
 serial/port.c      |  202 +++-------------------------------------------------
 2 files changed, 9 insertions(+), 225 deletions(-)

diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index 42afe3d..9bb0054 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -11,22 +11,7 @@ Service		org.bluez
 Interface	org.bluez.Serial
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		string Connect(string pattern)
-
-			Connects to a specific RFCOMM based service on a
-			remote device and then creates a RFCOMM TTY
-			device for it. The RFCOMM TTY device is returned.
-
-			Possible patterns: UUID 128 bit as string
-					   Profile short names, e.g: spp, dun
-					   RFCOMM channel as string, 1-30
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.ConnectionAttemptFailed
-					 org.bluez.Error.NotSupported
-
-Methods		fd ConnectFD(string pattern) [experimental]
+Methods		fd Connect(string pattern)
 
 			Connects to a specific RFCOMM based service on a
 			remote device and returns a file descriptor to talk
@@ -40,18 +25,3 @@ Methods		fd ConnectFD(string pattern) [experimental]
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.ConnectionAttemptFailed
 					 org.bluez.Error.NotSupported
-
-
-		void Disconnect(string device)
-
-			Disconnect a RFCOMM TTY device that has been
-			created by Connect method.
-
-			To abort a connection attempt in case of errors or
-			timeouts in the client it is fine to call this method.
-
-			In that case one of patterns of the Connect method should
-			be supplied instead of the TTY device.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
diff --git a/serial/port.c b/serial/port.c
index 2422cfe..f2b7184 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -69,8 +69,6 @@ struct serial_port {
 	int16_t		id;		/* RFCOMM device id */
 	uint8_t		channel;	/* RFCOMM channel */
 	char		*uuid;		/* service identification */
-	char		*dev;		/* RFCOMM device name */
-	int		fd;		/* Opened file descriptor */
 	GIOChannel	*io;		/* BtIO channel */
 	guint		listener_id;
 	struct serial_device *device;
@@ -111,9 +109,6 @@ static struct serial_port *find_port(GSList *ports, const char *pattern)
 		if (endptr && *endptr == '\0' && port->channel == channel)
 			return port;
 
-		if (port->dev && !strcmp(port->dev, pattern))
-			return port;
-
 		if (!port->uuid)
 			continue;
 
@@ -130,12 +125,8 @@ static struct serial_port *find_port(GSList *ports, const char *pattern)
 	return NULL;
 }
 
-static int port_release(struct serial_port *port)
+static void port_release(struct serial_port *port)
 {
-	struct rfcomm_dev_req req;
-	int rfcomm_ctl;
-	int err = 0;
-
 	if (port->id < 0) {
 		if (port->io) {
 			g_io_channel_shutdown(port->io, TRUE, NULL);
@@ -145,41 +136,7 @@ static int port_release(struct serial_port *port)
 			bt_cancel_discovery(&port->device->src,
 						&port->device->dst);
 
-		return 0;
 	}
-
-	DBG("Serial port %s released", port->dev);
-
-	rfcomm_ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM);
-	if (rfcomm_ctl < 0)
-		return -errno;
-
-	if (port->fd >= 0) {
-		close(port->fd);
-		port->fd = -1;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.dev_id = port->id;
-
-	/*
-	 * We are hitting a kernel bug inside RFCOMM code when
-	 * RFCOMM_HANGUP_NOW bit is set on request's flags passed to
-	 * ioctl(RFCOMMRELEASEDEV)!
-	 */
-	req.flags = (1 << RFCOMM_HANGUP_NOW);
-
-	if (ioctl(rfcomm_ctl, RFCOMMRELEASEDEV, &req) < 0) {
-		err = -errno;
-		error("Can't release device %s: %s (%d)",
-				port->dev, strerror(-err), -err);
-	}
-
-	g_free(port->dev);
-	port->dev = NULL;
-	port->id = -1;
-	close(rfcomm_ctl);
-	return err;
 }
 
 static void serial_port_free(void *data)
@@ -231,74 +188,12 @@ void port_release_all(void)
 	g_slist_free_full(devices, serial_device_free);
 }
 
-static void open_notify(int fd, int err, struct serial_port *port)
-{
-	struct serial_device *device = port->device;
-	DBusMessage *reply;
-
-	if (err < 0) {
-		/* Max tries exceeded */
-		port_release(port);
-		reply = btd_error_failed(port->msg, strerror(-err));
-	} else {
-		port->fd = fd;
-		reply = g_dbus_create_reply(port->msg,
-				DBUS_TYPE_STRING, &port->dev,
-				DBUS_TYPE_INVALID);
-	}
-
-	/* Reply to the requestor */
-	g_dbus_send_message(device->conn, reply);
-}
-
-static gboolean open_continue(gpointer user_data)
-{
-	struct serial_port *port = user_data;
-	int fd;
-	static int ntries = MAX_OPEN_TRIES;
-
-	if (!port->listener_id)
-		return FALSE; /* Owner exited */
-
-	fd = open(port->dev, O_RDONLY | O_NOCTTY);
-	if (fd < 0) {
-		int err = -errno;
-		error("Could not open %s: %s (%d)",
-				port->dev, strerror(-err), -err);
-		if (!--ntries) {
-			/* Reporting error */
-			open_notify(fd, err, port);
-			ntries = MAX_OPEN_TRIES;
-			return FALSE;
-		}
-		return TRUE;
-	}
-
-	/* Connection succeeded */
-	open_notify(fd, 0, port);
-	return FALSE;
-}
-
-static int port_open(struct serial_port *port)
-{
-	int fd;
-
-	fd = open(port->dev, O_RDONLY | O_NOCTTY);
-	if (fd < 0) {
-		g_timeout_add(OPEN_WAIT, open_continue, port);
-		return -EINPROGRESS;
-	}
-
-	return fd;
-}
-
 static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
 	struct serial_port *port = user_data;
 	struct serial_device *device = port->device;
-	struct rfcomm_dev_req req;
-	int sk, fd;
+	int sk;
 	DBusMessage *reply;
 
 	/* Owner exited? */
@@ -308,60 +203,18 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 	if (conn_err) {
 		error("%s", conn_err->message);
 		reply = btd_error_failed(port->msg, conn_err->message);
-		goto fail;
-	}
-
-	sk = g_io_channel_unix_get_fd(chan);
-
-	if (dbus_message_has_member(port->msg, "ConnectFD")) {
-		reply = g_dbus_create_reply(port->msg, DBUS_TYPE_UNIX_FD, &sk,
-							DBUS_TYPE_INVALID);
 		g_dbus_send_message(device->conn, reply);
-
-		close(sk);
-
-		g_dbus_remove_watch(device->conn, port->listener_id);
-		port->listener_id = 0;
-
-		return;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.dev_id = -1;
-	req.flags = (1 << RFCOMM_REUSE_DLC);
-	bacpy(&req.src, &device->src);
-	bacpy(&req.dst, &device->dst);
-	req.channel = port->channel;
-
-	g_io_channel_unref(port->io);
-	port->io = NULL;
-
-	port->id = ioctl(sk, RFCOMMCREATEDEV, &req);
-	if (port->id < 0) {
-		int err = -errno;
-		error("ioctl(RFCOMMCREATEDEV): %s (%d)", strerror(-err), -err);
-		reply = btd_error_failed(port->msg, strerror(-err));
-		g_io_channel_shutdown(chan, TRUE, NULL);
 		goto fail;
 	}
 
-	port->dev = g_strdup_printf("/dev/rfcomm%d", port->id);
-
-	DBG("Serial port %s created", port->dev);
-
-	g_io_channel_shutdown(chan, TRUE, NULL);
-
-	/* Addressing connect port */
-	fd = port_open(port);
-	if (fd < 0)
-		/* Open in progress: Wait the callback */
-		return;
+	sk = g_io_channel_unix_get_fd(chan);
+	reply = g_dbus_create_reply(port->msg, DBUS_TYPE_UNIX_FD, &sk,
+						DBUS_TYPE_INVALID);
+	g_dbus_send_message(device->conn, reply);
 
-	open_notify(fd, 0, port);
-	return;
+	close(sk);
 
 fail:
-	g_dbus_send_message(device->conn, reply);
 	g_dbus_remove_watch(device->conn, port->listener_id);
 	port->listener_id = 0;
 }
@@ -468,7 +321,6 @@ static struct serial_port *create_port(struct serial_device *device,
 	port->channel = channel;
 	port->device = device;
 	port->id = -1;
-	port->fd = -1;
 
 	device->ports = g_slist_append(device->ports, port);
 
@@ -521,47 +373,10 @@ static DBusMessage *port_connect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *port_disconnect(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct serial_device *device = user_data;
-	struct serial_port *port;
-	const char *dev, *owner, *caller;
-
-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &dev,
-						DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
-
-	port = find_port(device->ports, dev);
-	if (!port)
-		return btd_error_does_not_exist(msg);
-
-	if (!port->listener_id)
-		return btd_error_not_connected(msg);
-
-	owner = dbus_message_get_sender(port->msg);
-	caller = dbus_message_get_sender(msg);
-	if (!g_str_equal(owner, caller))
-		return btd_error_not_authorized(msg);
-
-	port_release(port);
-
-	g_dbus_remove_watch(conn, port->listener_id);
-	port->listener_id = 0;
-
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-}
-
 static const GDBusMethodTable port_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect",
-		GDBUS_ARGS({ "pattern", "s" }),	GDBUS_ARGS({ "tty", "s" }),
-		port_connect) },
-	{ GDBUS_ASYNC_METHOD("ConnectFD",
-		GDBUS_ARGS({ "pattern", "s" }), GDBUS_ARGS({ "fd", "s" }),
+		GDBUS_ARGS({ "pattern", "s" }),	GDBUS_ARGS({ "fd", "s" }),
 		port_connect) },
-	{ GDBUS_METHOD("Disconnect",
-		GDBUS_ARGS({ "device", "s" }), NULL,
-		port_disconnect) },
 	{ }
 };
 
@@ -615,7 +430,6 @@ int port_register(DBusConnection *conn, const char *path, bdaddr_t *src,
 	port->channel = channel;
 	port->device = device;
 	port->id = -1;
-	port->fd = -1;
 
 	device->ports = g_slist_append(device->ports, port);
 
-- 
1.7.10.2

