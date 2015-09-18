Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 1/2] gdbus: add method for immediate property update
Date: Fri, 18 Sep 2015 00:46:42 -0700
Message-Id: <1442562403-5176-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_dbus_emit_property_changed doesn't send dbus signal immediately. Instead
it stores changed properties, and schedule signal to be send at
g_iddle_add. Additionally, if this method is called few times for some
property, only last value will be sent in property changed signal.

If remote device sends lots of notifications, they're all scheduled to be
notified using this method. This might result in some notifications being
lost.

This patch adds new method, that can immediately send property changed
signal, instead of sheduling it for nearest iddle moment.
---
 gdbus/gdbus.h  |  3 +++
 gdbus/object.c | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d99c254..28e6d8b 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -300,6 +300,9 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
 void g_dbus_emit_property_changed(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name);
+void g_dbus_emit_property_changed_full(DBusConnection *connection,
+				const char *path, const char *interface,
+				const char *name, gboolean flush);
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 96db516..7a1e749 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1720,9 +1720,9 @@ static void process_property_changes(struct generic_data *data)
 	}
 }
 
-void g_dbus_emit_property_changed(DBusConnection *connection,
+void g_dbus_emit_property_changed_full(DBusConnection *connection,
 				const char *path, const char *interface,
-				const char *name)
+				const char *name, gboolean flush)
 {
 	const GDBusPropertyTable *property;
 	struct generic_data *data;
@@ -1760,7 +1760,17 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
 	iface->pending_prop = g_slist_prepend(iface->pending_prop,
 						(void *) property);
 
-	add_pending(data);
+	if (flush)
+		process_property_changes(data);
+	else
+		add_pending(data);
+}
+
+void g_dbus_emit_property_changed(DBusConnection *connection, const char *path,
+				const char *interface, const char *name)
+{
+	g_dbus_emit_property_changed_full(connection, path, interface, name,
+									FALSE);
 }
 
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
-- 
2.5.0

