Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] control: Expose internal connection API
Date: Wed, 21 Nov 2012 14:10:17 +0200
Message-Id: <1353499818-10153-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
References: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Separate the D-Bus code from the internal connection handling code,
exposing an internal API in case some internal codepath/plugin is
interested in using it.
---
 profiles/audio/control.c | 118 ++++++++++++++++++++++++++++++++++++-----------
 profiles/audio/control.h |   4 ++
 2 files changed, 96 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 1620128..b2bfb0a 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -61,12 +61,28 @@
 
 static unsigned int avctp_id = 0;
 
+struct pending_request {
+	audio_device_cb cb;
+	void *data;
+	unsigned int id;
+};
+
 struct control {
 	struct avctp *session;
 	gboolean target;
-	DBusMessage *connect;
+	struct pending_request *connect;
 };
 
+static void pending_request_free(struct audio_device *dev,
+					struct pending_request *pending,
+					int err)
+{
+	if (pending->cb)
+		pending->cb(dev, err, pending->data);
+
+	g_free(pending);
+}
+
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
@@ -79,11 +95,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		control->session = NULL;
 
 		if (control->connect) {
-			DBusMessage *reply = btd_error_failed(control->connect,
-							"Unable to connect");
-
-			g_dbus_send_message(btd_get_dbus_connection(), reply);
-			dbus_message_unref(control->connect);
+			pending_request_free(dev, control->connect, -EIO);
 			control->connect = NULL;
 		}
 
@@ -105,9 +117,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		break;
 	case AVCTP_STATE_CONNECTED:
 		if (control->connect) {
-			g_dbus_send_reply(conn, control->connect,
-							DBUS_TYPE_INVALID);
-			dbus_message_unref(control->connect);
+			pending_request_free(dev, control->connect, 0);
 			control->connect = NULL;
 		}
 
@@ -143,41 +153,97 @@ static DBusMessage *control_is_connected(DBusConnection *conn,
 	return reply;
 }
 
-static DBusMessage *control_connect(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+int control_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 {
-	struct audio_device *device = data;
-	struct control *control = device->control;
+	struct control *control = dev->control;
+	struct pending_request *pending;
 
 	if (control->session)
-		return btd_error_already_connected(msg);
+		return -EALREADY;
 
 	if (!control->target)
-		return btd_error_not_supported(msg);
+		return -ENOTSUP;
 
 	if (control->connect)
-		return btd_error_in_progress(msg);
+		return -EINPROGRESS;
 
-	control->session = avctp_connect(&device->src, &device->dst);
+	control->session = avctp_connect(&dev->src, &dev->dst);
 	if (!control->session)
-		return btd_error_failed(msg, "Unable to connect");
+		return -EIO;
 
-	control->connect = dbus_message_ref(msg);
+	pending = g_new0(struct pending_request, 1);
+	pending->cb = cb;
+	pending->data = data;
+	control->connect = pending;
 
-	return NULL;
+	return 0;
 }
 
-static DBusMessage *control_disconnect(DBusConnection *conn, DBusMessage *msg,
+static void generic_cb(struct audio_device *dev, int err, void *data)
+{
+	DBusMessage *msg = data;
+	DBusMessage *reply;
+
+	if (err < 0) {
+		reply = btd_error_failed(msg, strerror(-err));
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(msg);
+		return;
+	}
+
+	g_dbus_send_reply(btd_get_dbus_connection(), msg, DBUS_TYPE_INVALID);
+
+	dbus_message_unref(msg);
+}
+
+static DBusMessage *connect_control(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct audio_device *device = data;
-	struct control *control = device->control;
+	int err;
+
+	err = control_connect(device, generic_cb, msg);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+int control_disconnect(struct audio_device *dev, audio_device_cb cb,
+								void *data)
+{
+	struct control *control = dev->control;
 
 	if (!control->session)
-		return btd_error_not_connected(msg);
+		return -ENOTCONN;
+
+	/* cancel pending connect */
+	if (control->connect) {
+		pending_request_free(dev, control->connect, -ECANCELED);
+		control->connect = NULL;
+	}
 
 	avctp_disconnect(control->session);
 
+	if (cb)
+		cb(dev, 0, data);
+
+	return 0;
+
+}
+
+static DBusMessage *disconnect_control(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct audio_device *device = data;
+	int err;
+
+	err = control_disconnect(device, NULL, NULL);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -259,8 +325,8 @@ static const GDBusMethodTable control_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("IsConnected",
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, control_connect) },
-	{ GDBUS_METHOD("Disconnect", NULL, NULL, control_disconnect) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, connect_control) },
+	{ GDBUS_METHOD("Disconnect", NULL, NULL, disconnect_control) },
 	{ GDBUS_METHOD("Play", NULL, NULL, control_play) },
 	{ GDBUS_METHOD("Pause", NULL, NULL, control_pause) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, control_stop) },
@@ -294,7 +360,7 @@ static void path_unregister(void *data)
 		avctp_disconnect(control->session);
 
 	if (control->connect)
-		dbus_message_unref(control->connect);
+		pending_request_free(dev, control->connect, -ECANCELED);
 
 	g_free(control);
 	dev->control = NULL;
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 5f4f728..800a151 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -28,3 +28,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids);
 void control_update(struct control *control, GSList *uuids);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
+
+int control_connect(struct audio_device *dev, audio_device_cb cb, void *data);
+int control_disconnect(struct audio_device *dev, audio_device_cb cb,
+								void *data);
-- 
1.7.11.7

