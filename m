Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ 3/3] client: Add MTU and UpdateMTU implementation
Date: Thu, 14 Sep 2017 16:47:46 -0700
Message-Id: <20170914234748.79584-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add MTU in GDBusPropertyTable and UpdateMTU in GDBusMethodTable for Characteristic.
---
 client/gatt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 753038303..22cb5679d 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -98,6 +98,8 @@ static GDBusProxy *notify_proxy;
 static struct io *notify_io;
 static uint16_t notify_mtu;
 
+static uint16_t att_mtu = 300;
+
 static void print_service(struct service *service, const char *description)
 {
 	const char *text;
@@ -1273,6 +1275,15 @@ static gboolean chrc_get_value(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean chrc_get_mtu(const GDBusPropertyTable *property,
+							   DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+	const char * msg = NULL;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, att_mtu);
+	return TRUE;
+}
+
 static gboolean chrc_get_notifying(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1308,6 +1319,7 @@ static const GDBusPropertyTable chrc_properties[] = {
 	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
 	{ "Service", "o", chrc_get_service, NULL, NULL },
 	{ "Value", "ay", chrc_get_value, NULL, NULL },
+	{ "MTU", "q", chrc_get_mtu, NULL, NULL },
 	{ "Notifying", "b", chrc_get_notifying, NULL, NULL },
 	{ "Flags", "as", chrc_get_flags, NULL, NULL },
 	{ }
@@ -1415,6 +1427,18 @@ static DBusMessage *chrc_confirm(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *chrc_update_mtu(DBusConnection *conn, DBusMessage *msg,
+								 void *user_data)
+{
+	struct chrc *chrc = user_data;
+	DBusMessageIter iter;
+	dbus_message_iter_init(msg, &iter);
+
+	dbus_message_iter_get_basic(&iter, &att_mtu);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable chrc_methods[] = {
 	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "value", "ay" }),
@@ -1422,6 +1446,8 @@ static const GDBusMethodTable chrc_methods[] = {
 	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
 						{ "options", "a{sv}" }),
 					NULL, chrc_write_value) },
+	{ GDBUS_ASYNC_METHOD("UpdateMTU", GDBUS_ARGS({ "value", "q" }),
+					NULL, chrc_update_mtu) },
 	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chrc_start_notify) },
 	{ GDBUS_METHOD("StopNotify", NULL, NULL, chrc_stop_notify) },
 	{ GDBUS_METHOD("Confirm", NULL, NULL, chrc_confirm) },
-- 
2.14.1.690.gbb1197296e-goog

