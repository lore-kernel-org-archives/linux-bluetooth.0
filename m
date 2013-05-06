Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 09/13] dbus: Add Connect/Disconnect to org.bluez.Service1
Date: Mon,  6 May 2013 10:43:26 +0200
Message-Id: <1367829810-8262-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the control methods to connect or disconnect a specific remote
service, in a similar way that org.bluez.Device1.ConnectProfile()/
.DisconnectProfile() do.
---
 src/service.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index fed8460..0aa8cc4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -108,6 +108,26 @@ static const char *state2dbus(btd_service_state_t state)
 	return NULL;
 }
 
+static void send_dbus_reply(DBusMessage **p, bool state_ok, int err)
+{
+	DBusMessage *msg = *p;
+	DBusMessage *reply;
+
+	if (msg == NULL)
+		return;
+
+	if (state_ok)
+		reply = dbus_message_new_method_return(msg);
+	else if (err < 0)
+		reply = btd_error_failed(msg, strerror(-err));
+	else /* For some reason, the error was not set */
+		reply = btd_error_failed(msg, strerror(EIO));
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(msg);
+	*p = NULL;
+}
+
 static void change_state(struct btd_service *service, btd_service_state_t state,
 									int err)
 {
@@ -140,6 +160,12 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 
 		cb->cb(service, old, state, cb->user_data);
 	}
+
+	send_dbus_reply(&service->connect_msg,
+				state == BTD_SERVICE_STATE_CONNECTED, err);
+
+	send_dbus_reply(&service->disconnect_msg,
+				state == BTD_SERVICE_STATE_DISCONNECTED, err);
 }
 
 struct btd_service *btd_service_ref(struct btd_service *service)
@@ -392,6 +418,52 @@ static gboolean service_get_uuid(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *service_connect(DBusConnection *conn, DBusMessage *msg,
+								void *user_data)
+{
+	struct btd_service *service = user_data;
+	int err;
+
+	if (service->state != BTD_SERVICE_STATE_DISCONNECTED)
+		return btd_error_already_connected(msg);
+
+	if (service->connect_msg != NULL || service->disconnect_msg)
+		return btd_error_busy(msg);
+
+	err = btd_service_connect(service);
+	if (err == -ENOTSUP)
+		return btd_error_not_supported(msg);
+	else if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	service->connect_msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *service_disconnect(DBusConnection *conn, DBusMessage *msg,
+								void *user_data)
+{
+	struct btd_service *service = user_data;
+	int err;
+
+	if (service->state == BTD_SERVICE_STATE_DISCONNECTED)
+		return btd_error_not_connected(msg);
+
+	if (service->disconnect_msg != NULL)
+		return btd_error_busy(msg);
+
+	err = btd_service_disconnect(service);
+	if (err == -ENOTSUP)
+		return btd_error_not_supported(msg);
+	else if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	service->disconnect_msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static gboolean service_get_state(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -405,6 +477,12 @@ static gboolean service_get_state(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static const GDBusMethodTable service_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, service_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, service_disconnect) },
+	{ }
+};
+
 static const GDBusPropertyTable service_properties[] = {
 	{ "Device", "o", service_get_device },
 	{ "UUID", "s", service_get_uuid },
@@ -423,7 +501,8 @@ static int service_register(struct btd_service *service, unsigned int id)
 
 	if (g_dbus_register_interface(dbus_conn,
 					path, SERVICE_INTERFACE,
-					NULL, NULL, service_properties, service,
+					service_methods, NULL,
+					service_properties, service,
 					NULL) == FALSE) {
 		g_free(path);
 		error("Unable to register service interface for %s",
-- 
1.8.1.4

