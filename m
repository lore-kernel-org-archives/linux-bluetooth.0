Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/10] client: Implement AcquireNotify for server
Date: Mon, 18 Sep 2017 15:40:00 +0300
Message-Id: <20170918124001.2617-10-luiz.dentz@gmail.com>
In-Reply-To: <20170918124001.2617-1-luiz.dentz@gmail.com>
References: <20170918124001.2617-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables IO via file descriptors using AcquireNotify if server
implements it.
---
 client/gatt.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 6401fbd1a..1ca1159ad 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -76,6 +76,7 @@ struct chrc {
 	uint8_t *value;
 	uint16_t mtu;
 	struct io *write_io;
+	struct io *notify_io;
 };
 
 struct service {
@@ -1349,6 +1350,33 @@ static gboolean chrc_write_acquired_exists(const GDBusPropertyTable *property,
 	return FALSE;
 }
 
+static gboolean chrc_get_notify_acquired(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+	dbus_bool_t value;
+
+	value = chrc->notify_io ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean chrc_notify_acquired_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct chrc *chrc = data;
+	int i;
+
+	for (i = 0; chrc->flags[i]; i++) {
+		if (!strcmp("notify", chrc->flags[i]))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static const GDBusPropertyTable chrc_properties[] = {
 	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
 	{ "Service", "o", chrc_get_service, NULL, NULL },
@@ -1357,6 +1385,8 @@ static const GDBusPropertyTable chrc_properties[] = {
 	{ "Flags", "as", chrc_get_flags, NULL, NULL },
 	{ "WriteAcquired", "b", chrc_get_write_acquired, NULL,
 					chrc_write_acquired_exists },
+	{ "NotifyAcquired", "b", chrc_get_notify_acquired, NULL,
+					chrc_notify_acquired_exists },
 	{ }
 };
 
@@ -1481,10 +1511,13 @@ static DBusMessage *chrc_create_pipe(struct chrc *chrc, DBusMessage *msg)
 
 	close(pipefd[dir]);
 
-	chrc->write_io = io;
+	if (dir)
+		chrc->write_io = io;
+	else
+		chrc->notify_io = io;
 
-	rl_printf("[" COLORED_CHG "] Attribute %s Write pipe acquired\n",
-							chrc->path);
+	rl_printf("[" COLORED_CHG "] Attribute %s %s pipe acquired\n",
+					chrc->path, dir ? "Write" : "Notify");
 
 	return reply;
 }
@@ -1517,6 +1550,34 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
+static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct chrc *chrc = user_data;
+	DBusMessageIter iter;
+	DBusMessage *reply;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (chrc->notify_io)
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.NotPermitted",
+					NULL);
+
+	if (parse_options(&iter, chrc))
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					NULL);
+
+	reply = chrc_create_pipe(chrc, msg);
+
+	if (chrc->notify_io)
+		g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
+							"NotifyAcquired");
+
+	return reply;
+}
+
 static DBusMessage *chrc_start_notify(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
@@ -1570,6 +1631,8 @@ static const GDBusMethodTable chrc_methods[] = {
 					NULL, chrc_write_value) },
 	{ GDBUS_METHOD("AcquireWrite", GDBUS_ARGS({ "options", "a{sv}" }),
 					NULL, chrc_acquire_write) },
+	{ GDBUS_METHOD("AcquireNotify", GDBUS_ARGS({ "options", "a{sv}" }),
+					NULL, chrc_acquire_notify) },
 	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chrc_start_notify) },
 	{ GDBUS_METHOD("StopNotify", NULL, NULL, chrc_stop_notify) },
 	{ GDBUS_METHOD("Confirm", NULL, NULL, chrc_confirm) },
-- 
2.13.5

