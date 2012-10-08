Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [WORKAROUND BlueZ 3/3] gdbus: Add fallback to PropertyChanged
Date: Mon,  8 Oct 2012 10:11:24 +0200
Message-Id: <1349683884-22251-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
References: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a fallback for PropertyChanged signal when it is not implemented.
---
 gdbus/object.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 8f6cbed..609378c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1587,6 +1587,41 @@ gboolean g_dbus_emit_signal_valist(DBusConnection *connection,
 							name, type, args);
 }
 
+static void fallback_property_changed(struct generic_data *data,
+						struct interface_data *iface,
+						GDBusPropertyTable *p)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, value;
+	const GDBusSignalTable *s;
+
+	for (s = iface->signals; s && s->name; s++) {
+		/* Skip if PropertyChanged is present in the signals */
+		if (g_str_equal(s->name, "PropertyChanged") == 0)
+			return;
+	}
+
+	signal = dbus_message_new_signal(data->path, iface->name,
+							"PropertyChanged");
+	if (signal == NULL) {
+		error("Unable to allocate new %s.PropertyChanged signal",
+								iface->name);
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &p->name);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, p->type,
+								&value);
+
+	p->get(p, &value, iface->user_data);
+
+	dbus_message_iter_close_container(&iter, &value);
+
+	g_dbus_send_message(data->conn, signal);
+}
+
 static void process_properties_from_interface(struct generic_data *data,
 						struct interface_data *iface)
 {
@@ -1624,6 +1659,8 @@ static void process_properties_from_interface(struct generic_data *data,
 			continue;
 
 		append_property(iface, p, &dict);
+
+		fallback_property_changed(data, iface, p);
 	}
 
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.7.11.4

