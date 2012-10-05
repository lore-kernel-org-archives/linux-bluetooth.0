Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/9] gdbus: Remove connection from g_dbus_remove_watch
Date: Fri,  5 Oct 2012 23:20:42 +0200
Message-Id: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The connection is not really needed since the list of listeners is
global not per connection, besides it is more convenient this way as
only the id is needed.
---
 gdbus/gdbus.h | 2 +-
 gdbus/watch.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a96c97f..065fd6f 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -243,7 +243,7 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
 				const char *interface, const char *member,
 				GDBusSignalFunction function, void *user_data,
 				GDBusDestroyFunction destroy);
-gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
+gboolean g_dbus_remove_watch(guint id);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
 void g_dbus_pending_property_success(DBusConnection *connection,
diff --git a/gdbus/watch.c b/gdbus/watch.c
index 07feb61..00cedae 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -285,7 +285,7 @@ static void filter_data_free(struct filter_data *data)
 		g_free(l->data);
 
 	g_slist_free(data->callbacks);
-	g_dbus_remove_watch(data->connection, data->name_watch);
+	g_dbus_remove_watch(data->name_watch);
 	g_free(data->name);
 	g_free(data->owner);
 	g_free(data->path);
@@ -752,7 +752,7 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
 	return cb->id;
 }
 
-gboolean g_dbus_remove_watch(DBusConnection *connection, guint id)
+gboolean g_dbus_remove_watch(guint id)
 {
 	struct filter_data *data;
 	struct filter_callback *cb;
-- 
1.7.11.4

