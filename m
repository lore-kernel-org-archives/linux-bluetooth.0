Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Add proper checks for MediaTransport.SetProperty
Date: Mon, 13 Sep 2010 17:15:37 +0300
Message-Id: <1284387337-18822-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/transport.c |  116 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 6d08677..7387818 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -83,12 +83,23 @@ struct media_transport {
 	void			(*get_properties) (
 					struct media_transport *transport,
 					DBusMessageIter *dict);
-	DBusMessage		*(*set_property) (
+	int			(*set_property) (
 					struct media_transport *transport,
-					DBusConnection *conn,
-					DBusMessage *msg);
+					const char *property,
+					DBusMessageIter *value);
 };
 
+static inline DBusMessage *invalid_args(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+}
+
+static inline DBusMessage *error_failed(DBusMessage *msg, const char *desc)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s", desc);
+}
+
 void media_transport_remove(struct media_transport *transport)
 {
 	char *path;
@@ -434,14 +445,10 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 
 	renderer = media_transport_find_renderer(transport, sender);
 	if (renderer != NULL)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".Failed",
-						"Permission denied");
+		return error_failed(msg, strerror(EPERM));
 
 	if (media_transport_acquire(transport, accesstype) == FALSE)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".Failed",
-						"Permission denied");
+		return error_failed(msg, strerror(EPERM));
 
 	renderer = media_renderer_create(transport, msg, accesstype);
 	req = g_new0(struct acquire_request, 1);
@@ -471,9 +478,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
 	renderer = media_transport_find_renderer(transport, sender);
 	if (renderer == NULL)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".Failed",
-						"Permission denied");
+		return error_failed(msg, strerror(EPERM));
 
 	if (g_strcmp0(renderer->accesstype, accesstype) == 0)
 		media_renderer_remove(renderer);
@@ -481,31 +486,98 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 		media_transport_release(transport, accesstype);
 		g_strdelimit(renderer->accesstype, accesstype, ' ');
 	} else
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".Failed",
-						"Permission denied");
+		return error_failed(msg, strerror(EPERM));
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static DBusMessage *set_property_a2dp(struct media_transport *transport,
-					DBusConnection *conn, DBusMessage *msg)
+static int set_property_a2dp(struct media_transport *transport,
+						const char *property,
+						DBusMessageIter *value)
 {
-	return NULL;
+	if (g_strcmp0(property, "Delay") == 0) {
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			return -EINVAL;
+		dbus_message_iter_get_basic(value, &transport->delay);
+
+		/* FIXME: send new delay */
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
-static DBusMessage *set_property_headset(struct media_transport *transport,
-					DBusConnection *conn, DBusMessage *msg)
+static int set_property_headset(struct media_transport *transport,
+						const char *property,
+						DBusMessageIter *value)
 {
-	return NULL;
+	if (g_strcmp0(property, "NREC") == 0) {
+		gboolean nrec;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+			return -EINVAL;
+		dbus_message_iter_get_basic(value, &nrec);
+
+		/* FIXME: set new nrec */
+		return 0;
+	} else if (g_strcmp0(property, "InbandRingtone") == 0) {
+		gboolean inband;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+			return -EINVAL;
+		dbus_message_iter_get_basic(value, &inband);
+
+		/* FIXME: set new inband */
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct media_transport *transport = data;
+	DBusMessageIter iter;
+	DBusMessageIter value;
+	const char *property, *sender;
+	GSList *l;
+	int err;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return invalid_args(msg);
+	dbus_message_iter_recurse(&iter, &value);
+
+	sender = dbus_message_get_sender(msg);
+	err = -EINVAL;
 
-	return transport->set_property(transport, conn, msg);
+	/* Check if sender has acquired the transport */
+	for (l = transport->renderers; l; l = l->next) {
+		struct media_renderer *renderer = l->data;
+
+		if (g_strcmp0(renderer->name, sender) == 0) {
+			err = transport->set_property(transport, property,
+								&value);
+			break;
+		}
+	}
+
+	if (err < 0) {
+		if (err == -EINVAL)
+			return invalid_args(msg);
+		return error_failed(msg, strerror(-err));
+	}
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static void get_properties_a2dp(struct media_transport *transport,
-- 
1.7.1

