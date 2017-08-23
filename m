Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH v3 3/3] client: Add Confirm implementation
Date: Wed, 23 Aug 2017 14:16:50 -0700
Message-Id: <20170823211650.88947-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Confirm implementation when indication is received.
---
 client/gatt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index bd6e6b0af..ca84479d7 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1405,6 +1405,14 @@ static DBusMessage *chrc_stop_notify(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *chrc_indication_conf(DBusConnection *conn,
+							DBusMessage *msg, void *user_data)
+{
+	struct chrc *chrc = user_data;
+	rl_printf("Attribute %s indication confirm received", chrc->path);
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable chrc_methods[] = {
 	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "value", "ay" }),
@@ -1414,6 +1422,7 @@ static const GDBusMethodTable chrc_methods[] = {
 					NULL, chrc_write_value) },
 	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chrc_start_notify) },
 	{ GDBUS_METHOD("StopNotify", NULL, NULL, chrc_stop_notify) },
+	{ GDBUS_METHOD("Confirm", NULL, NULL, chrc_indication_conf) },
 	{ }
 };
 
-- 
2.14.1.342.g6490525c54-goog

