Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 10:30:24 -0600
Message-ID: <CAAbnaHYLqqb2S3vgO_2w+p0jrnPx8jDeHtY9n8Nqvjm-BU9ztg@mail.gmail.com>
Subject: [RFC generichid 3/5]
From: Nathaniel Haggard <natester@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds connect_cb, initiate_keyboard and supporting functions.

 input/generichid.c |  402 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 402 insertions(+), 0 deletions(-)

diff --git a/input/generichid.c b/input/generichid.c
index ec8283d..3a5f073 100644
--- a/input/generichid.c
+++ b/input/generichid.c
@@ -348,18 +348,307 @@ static int sdp_keyboard_service(struct
adapter_data *adapt)
 }


+static void initiate_keyboard(struct keyboard_state *keyboard)
+{
+	keyboard->value[0] = 0xa1;
+	keyboard->value[1] = 0x01;
+
+	memset(&(keyboard->value[2]), 0, HIDP_KEYB_SIZE - 2);
+
+	/*
+	*	first 4 bytes in value are constant
+	*	keys start at index 4
+	*	last_value = 3 means no keys pressed
+	*/
+	keyboard->last_value = 3;
+}
+
+
 static DBusMessage *send_event(DBusConnection *conn,
 		DBusMessage *msg, void *data)
 {
 	return btd_error_failed(msg, "Invalid profile mode");
 }

+static gboolean set_protocol_listener(GIOChannel *chan, GIOCondition condition,
+					gpointer data)
+{
+    unsigned char b;
+    unsigned char ok;
+	struct device_data *dev = data;
+    int fd;
+    int outfd;
+    int err;
+    b = 0;
+    ok = 0;
+
+    fd = g_io_channel_unix_get_fd(chan);
+    err = read(fd, &b, 1);
+    if (err < 0)
+        error("Error %d: failed to read set_protocol/set_idle", err);
+    if ((b == 0x71) || (b == 0x90)) {
+        // set_protocol(report) or set_idle
+        outfd = g_io_channel_unix_get_fd(dev->intr);
+        err = write(outfd, &ok, 1);
+        if (err < 0)
+            error("Error %d: failed to acknowledge
set_protocol/set_idle", err);
+    } else {
+        btd_debug("possibly discarding important protocol traffic %x", b);
+    }
+	return TRUE;
+}
+
+
+static gboolean channel_listener(GIOChannel *chan, GIOCondition condition,
+					gpointer data)
+{
+	struct device_data *dev = data;
+
+	if (dev->intr != NULL) {
+		g_io_channel_unref(dev->intr);
+		dev->intr = NULL;
+	}
+
+	if (dev->ctrl != NULL) {
+		g_io_channel_unref(dev->ctrl);
+		dev->ctrl = NULL;
+	}
+
+	g_dbus_emit_signal(connection,  dev->input_path,
+				GENERIC_INPUT_DEVICE, "Disconnected",
+				DBUS_TYPE_INVALID);
+    btd_debug("Channel listener");
+	return FALSE;
+}
+
+
+static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
+					void *data)
+{
+	unsigned int w;
+	func_ptr reg_interface;
+	struct user_data *info = data;
+	struct adapter_data *adapt = info->adapt;
+	struct device_data *dev = adapt->dev;
+
+	if (conn_err) {
+		error("%s", conn_err->message);
+		goto failed;
+	}
+
+	/* Connect */
+	if (info->func != NULL) {
+		reg_interface = info->func;
+		btd_debug("Registering device");
+
+		if ((*reg_interface)(adapt) < 0)
+			goto failed;
+
+	/* Reconnect */
+	} else {
+		g_dbus_emit_signal(connection,  dev->input_path,
+					GENERIC_INPUT_DEVICE, "Reconnected",
+					DBUS_TYPE_INVALID);
+	}
+
+	adapt->pending = 0;
+
+	w = g_io_add_watch(dev->intr, G_IO_HUP | G_IO_ERR,
+				channel_listener, dev);
+	dev->intr_watch = w;
+
+	g_free(info);
+
+	return;
+
+failed:
+	g_free(info);
+	info = NULL;
+	g_io_channel_unref(dev->intr);
+	dev->intr = NULL;
+
+	if (dev->ctrl != NULL) {
+		g_io_channel_unref(dev->ctrl);
+		dev->ctrl = NULL;
+	}
+}
+
+
+
+static void control_connect_cb(GIOChannel *chan, GError *conn_err,
+					void *data)
+{
+	GIOChannel *io;
+	GError *err;
+	bdaddr_t src;
+	struct user_data *info = data;
+	struct adapter_data *adapt = info->adapt;
+	struct device_data *dev = adapt->dev;
+
+	if (conn_err) {
+		error("%s", conn_err->message);
+		goto failed;
+	}
+
+	adapter_get_address(adapt->adapter, &src);
+
+	io = bt_io_connect(BT_IO_L2CAP, interrupt_connect_cb, data,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &dev->dst,
+				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+				BT_IO_OPT_INVALID);
+
+	if (io == NULL) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	dev->intr = io;
+
+	return;
+
+failed:
+	g_free(info);
+	info = NULL;
+	g_io_channel_unref(dev->ctrl);
+	dev->ctrl = NULL;
+}
+
+
+static DBusMessage *reconnect_device(DBusConnection *conn, DBusMessage *msg,
+					gpointer data)
+{
+}
+
+
+static DBusMessage *disconnect_device(DBusConnection *conn, DBusMessage *msg,
+					gpointer data)
+{
+}
+
+static const GDBusSignalTable ghid_input_device_signals[] = {
+	{ GDBUS_SIGNAL("Reconnected", NULL)	},
+	{ GDBUS_SIGNAL("Disconnected", NULL) },
+	{ }
+};
+
+static const GDBusMethodTable ghid_input_device_methods[] = {
+	{ GDBUS_METHOD("SendEvent", GDBUS_ARGS({"event", "yqy"}), NULL, send_event) },
+	{ GDBUS_METHOD("Reconnect", NULL, NULL, reconnect_device) },
+	{ GDBUS_METHOD("Disconnect", NULL, NULL, disconnect_device)	},
+	{}
+};
+
+
+static void generic_input_device_path(char *path, struct btd_adapter *adapter)
+{
+	char *adapt;
+	strcpy(path, "/org/bluez/input");
+
+	/* adding the adapter name */
+	adapt = strrchr(adapter_get_path(adapter), '/');
+	strcat(path, adapt);
+
+	strcat(path, "/device1");
+}
+
+static int register_input_device(struct adapter_data *adapt)
+{
+	struct device_data *dev = adapt->dev;
+
+	dev->input_path = g_try_new0(char, MAX_PATH_LENGTH);
+	if (dev->input_path == NULL)
+		return -ENOMEM;
+
+	generic_input_device_path(dev->input_path,
+					adapt->adapter);
+
+	initiate_keyboard(&dev->keyboard);
+
+	btd_debug("input path is %s", dev->input_path);
+
+	if (g_dbus_register_interface(connection,
+					dev->input_path,
+					GENERIC_INPUT_DEVICE,
+					ghid_input_device_methods,
+					ghid_input_device_signals, NULL,
+					adapt, NULL) == FALSE) {
+		error("D-Bus failed to register %s interface",
+				GENERIC_INPUT_DEVICE);
+		g_free(dev->input_path);
+		return -1;
+	}

+	g_dbus_emit_signal(connection,  adapter_get_path(adapt->adapter),
+				GENERIC_HID_INTERFACE, "IncomingConnection",
+				DBUS_TYPE_INVALID);
+
+	return 0;
+}

 static DBusMessage *connect_device(DBusConnection *conn, DBusMessage *msg,
 					gpointer data)
 {
+	GError *err = NULL;
+	GIOChannel *io;
+	DBusMessageIter iter;
+	char *str, addr[18];
+	bdaddr_t src;
+	struct adapter_data *adapt = data;
+	struct device_data *dev = adapt->dev;
+	struct user_data *info;
+
+	if (adapt->pending)
+		return btd_error_in_progress(msg);
+
+	if (dev->input_path != NULL)
+		return btd_error_already_connected(msg);
+
+		info = g_try_new(struct user_data, 1);
+
+	if (!dbus_message_iter_init(msg, &iter))
+			return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	if (info == NULL)
+		return btd_error_failed(msg, strerror(-ENOMEM));
+
+	info->adapt = adapt;
+	info->func = register_input_device;
+
+	dbus_message_iter_get_basic(&iter, &str);
+
+	strcpy(addr, str);
+	str2ba(addr, &(dev->dst));
+
+	btd_debug("Request connection to %s", addr);
+
+	adapter_get_address(adapt->adapter, &src);
+
+	io = bt_io_connect(BT_IO_L2CAP, control_connect_cb, info,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &(dev->dst),
+				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+				BT_IO_OPT_INVALID);
+
+	if (err != NULL)
+		error("%s", err->message);
+
+	if (io == NULL) {
+		if (info != NULL)
+			g_free(info);
+
+		return btd_error_failed(msg, "Failed to plug the device");
+	}
+
+	dev->ctrl = io;
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
 }


@@ -398,8 +687,121 @@ static void unregister_interface(const char *path)
 	g_dbus_unregister_interface(connection, path, GENERIC_HID_INTERFACE);
 }

+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+	uint16_t psm;
+	bdaddr_t dst;
+	GError *gerr = NULL;
+	unsigned int w;
+	int ret;
+	struct adapter_data *adapt = data;
+	struct device_data *dev = adapt->dev;
+
+	if (err)
+		btd_debug("%s\n", err->message);
+
+	bt_io_get(chan, BT_IO_L2CAP, &gerr,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_PSM, &psm,
+			BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		btd_debug("Error on PSM %d: %s\n", psm, gerr->message);
+		g_error_free(gerr);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	btd_debug("Accept on PSM %d\n", psm);
+
+	if (psm == 17) {
+		dev->ctrl = g_io_channel_ref(chan);
+		return;
+	}
+
+	dev->intr = g_io_channel_ref(chan);
+
+	if (dev->input_path == NULL) {
+
+		ret = register_input_device(adapt);
+
+		if (ret < 0)
+			goto failed;
+
+		bacpy(&dev->dst, &dst);
+
+	} else {
+		g_dbus_emit_signal(connection,  dev->input_path,
+					GENERIC_INPUT_DEVICE, "Reconnected",
+					DBUS_TYPE_INVALID);
+	}
+
+	w = g_io_add_watch(dev->intr, G_IO_HUP | G_IO_ERR,
+				channel_listener, dev);
+    g_io_add_watch(dev->ctrl, G_IO_IN, set_protocol_listener, dev);
+    btd_debug("Added watch in connect_cb to set_protocol_listener");
+	dev->intr_watch = w;
+	adapt->pending = 0;
+
+	return;
+
+failed:
+	if (dev->intr != NULL) {
+		g_io_channel_shutdown(dev->intr, TRUE, NULL);
+		g_io_channel_unref(dev->intr);
+		dev->intr = NULL;
+	}
+
+	if (dev->ctrl != NULL) {
+		g_io_channel_shutdown(dev->ctrl, TRUE, NULL);
+		g_io_channel_unref(dev->ctrl);
+		dev->ctrl = NULL;
+	}
+}
+
+
 static void confirm_event_cb(GIOChannel *chan, GError *err, gpointer data)
 {
+	uint16_t psm;
+	GError *gerr = NULL;
+	bdaddr_t dst;
+	struct adapter_data *adapt = data;
+	struct device_data *dev = adapt->dev;
+
+	if (err) {
+		error("%s\n", err->message);
+		return;
+	}
+
+	bt_io_get(chan, BT_IO_L2CAP, &gerr,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_PSM, &psm,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s on PSM %d\n", gerr->message, psm);
+		g_error_free(gerr);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	if (dev->input_path != NULL &&
+			(bacmp(&(dev->dst), &dst) != 0 ||
+			dev->intr != NULL)) {
+
+		btd_debug("Incoming request blocked due to existing input device");
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	btd_debug("Incoming connection on PSM number %d", psm);
+
+	if (psm == 17)
+		adapt->pending = 1;
+
+	if (!bt_io_accept(chan, connect_cb, data, NULL, NULL))
+		btd_debug("Can not accept connection on psm %d", psm);
+
 }

 static int adapt_start(struct adapter_data *adapt)
