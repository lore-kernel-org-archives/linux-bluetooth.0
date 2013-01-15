Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] gdbus: Add a way to get the sender of a DBus Property Set message
Date: Tue, 15 Jan 2013 18:28:41 -0300
Message-Id: <1358285321-8444-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases, it is needed to check if the sender of a Set message
is allowed to make an operation.

This adds a way for users of GDBus to do simple checks like this.
---
 gdbus/gdbus.h  |  2 ++
 gdbus/object.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 6f5a012..fbd313d 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -293,6 +293,8 @@ void g_dbus_pending_property_error_valist(GDBusPendingReply id,
 			const char *name, const char *format, va_list args);
 void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
 						const char *format, ...);
+const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet id);
+
 void g_dbus_emit_property_changed(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name);
diff --git a/gdbus/object.c b/gdbus/object.c
index 1a54b3f..c1fc91e 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -498,6 +498,20 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
 	va_end(args);
 }
 
+const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet id)
+{
+	GSList *l;
+
+	for (l = pending_property_set; l != NULL; l = l->next) {
+		struct property_data *propdata = l->data;
+
+		if (propdata->id == id)
+			return dbus_message_get_sender(propdata->message);
+	}
+
+	return NULL;
+}
+
 static void reset_parent(gpointer data, gpointer user_data)
 {
 	struct generic_data *child = data;
-- 
1.8.1

