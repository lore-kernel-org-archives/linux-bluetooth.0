Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [WORKAROUND BlueZ 1/3] gdbus: Add fallback to GetProperties
Date: Mon,  8 Oct 2012 10:11:22 +0200
Message-Id: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a fallback for GetProperties method when it is not
implemented.
---
This set of patches are workarounds to old properties interface to be able to
test new code until other components are ported.

 gdbus/object.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 66431de..e7a4cc3 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1004,6 +1004,31 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 	g_free(data);
 }
 
+static DBusMessage *get_properties(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct interface_data *iface = user_data;
+	DBusMessageIter iter;
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(message);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	append_properties(iface, &iter);
+
+	return reply;
+}
+
+static const GDBusMethodTable fallback_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ }
+};
+
 static DBusHandlerResult generic_message(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -1036,6 +1061,23 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 							iface->user_data);
 	}
 
+	for (method = fallback_methods; method &&
+			method->name && method->function; method++) {
+		if (dbus_message_is_method_call(message, iface->name,
+							method->name) == FALSE)
+			continue;
+
+		if (g_dbus_args_have_signature(method->in_args,
+							message) == FALSE)
+			continue;
+
+		if (check_privilege(connection, message, method,
+							iface) == TRUE)
+			return DBUS_HANDLER_RESULT_HANDLED;
+
+		return process_message(connection, message, method, iface);
+	}
+
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-- 
1.7.11.4

