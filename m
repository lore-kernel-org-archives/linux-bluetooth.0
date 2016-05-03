Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v2] gdbus: Fix the ordering of signals
Date: Tue,  3 May 2016 14:56:27 -0300
Message-Id: <1462298187-21905-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Consider the following example:

/foo
  properties: "A", "B"

/bar
  properties: "C", "D"

If during a given mainloop iteration, property "A" of object '/foo' is
changed, then properties "C" and "D" of '/bar', lastly "B" of '/foo',
the current code will emit the PropertiesChanged signals in following
order: "A", "B", "C", "D".

This may confuse applications that have a dependency on the order of
those signals.

This fixes the ordering, so in the example, the order becomes:
"C", "D", "A", B". This is considered not to be a problem, as
applications may use the flag G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH, so
property changed signals are emitted as soon as possible.

The solution is for each object, to reschedule the signals every time a
signal is emitted.
---
 gdbus/gdbus.h  |  9 +++++++++
 gdbus/object.c | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 69fbc10..e37385f 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -302,6 +302,15 @@ void g_dbus_pending_property_error_valist(GDBusPendingReply id,
 			const char *name, const char *format, va_list args);
 void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
 						const char *format, ...);
+
+/*
+ * Note that when multiple properties for a given object path are changed
+ * in the same mainloop iteration, they will be grouped with the last
+ * property changed. If this behaviour is undesired, use
+ * g_dbus_emit_property_changed_full() with the
+ * G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH flag, causing the signal to ignore
+ * any grouping.
+ */
 void g_dbus_emit_property_changed(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name);
diff --git a/gdbus/object.c b/gdbus/object.c
index a220101..afb4587 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -635,11 +635,19 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
 
 static void add_pending(struct generic_data *data)
 {
-	if (data->process_id > 0)
-		return;
+	guint old_id = data->process_id;
 
 	data->process_id = g_idle_add(process_changes, data);
 
+	if (old_id > 0) {
+		/*
+		 * If the element already had an old idler, remove the old one,
+		 * no need to re-add it to the pending list.
+		 */
+		g_source_remove(old_id);
+		return;
+	}
+
 	pending = g_slist_append(pending, data);
 }
 
-- 
2.8.1

