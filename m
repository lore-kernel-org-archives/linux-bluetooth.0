Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v7 03/10] gdbus: Add g_dbus_proxy_set_property_array
Date: Fri, 21 Mar 2014 16:16:36 -0300
Message-Id: <1395429403-493-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395413930-18292-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new gdbus utility function to allow setting a property
of fixed, and non-fixed values array.
---
 gdbus/client.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gdbus/gdbus.h  |  5 ++++
 2 files changed, 90 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 5193b6c..8f4fe4e 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -727,6 +727,91 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 	return TRUE;
 }
 
+gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
+				const char *name, int type, const void *value,
+				size_t size, GDBusResultFunction function,
+				void *user_data, GDBusDestroyFunction destroy)
+{
+	struct set_property_data *data;
+	GDBusClient *client;
+	DBusMessage *msg;
+	DBusMessageIter iter, variant, array;
+	DBusPendingCall *call;
+	char array_sig[3];
+	char type_sig[2];
+
+	if (!proxy || !name || !value)
+		return FALSE;
+
+	if (!dbus_type_is_basic(type))
+		return FALSE;
+
+	client = proxy->client;
+	if (!client)
+		return FALSE;
+
+	data = g_try_new0(struct set_property_data, 1);
+	if (!data)
+		return FALSE;
+
+	data->function = function;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	msg = dbus_message_new_method_call(client->service_name,
+			proxy->obj_path, DBUS_INTERFACE_PROPERTIES, "Set");
+	if (!msg) {
+		g_free(data);
+		return FALSE;
+	}
+
+	array_sig[0] = DBUS_TYPE_ARRAY;
+	array_sig[1] = (char) type;
+	array_sig[2] = '\0';
+
+	type_sig[0] = (char) type;
+	type_sig[1] = '\0';
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+							&proxy->interface);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+						array_sig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						type_sig, &array);
+
+	if (dbus_type_is_fixed(type))
+		dbus_message_iter_append_fixed_array(&array, type,
+							&value, size);
+	else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
+		size_t i;
+		const char **str = (const char **) value;
+
+		for (i = 0; i < size; i++)
+			dbus_message_iter_append_basic(&array, type, &str[i]);
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+	dbus_message_iter_close_container(&iter, &variant);
+
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
+							&call, -1) == FALSE) {
+		dbus_message_unref(msg);
+		g_free(data);
+		return FALSE;
+	}
+
+	dbus_pending_call_set_notify(call, set_property_reply, data, g_free);
+	dbus_pending_call_unref(call);
+
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
 struct method_call_data {
 	GDBusReturnFunction function;
 	void *user_data;
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8ada200..551c306 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -329,6 +329,11 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 				GDBusResultFunction function, void *user_data,
 				GDBusDestroyFunction destroy);
 
+gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
+				const char *name, int type, const void *value,
+				size_t size, GDBusResultFunction function,
+				void *user_data, GDBusDestroyFunction destroy);
+
 typedef void (* GDBusSetupFunction) (DBusMessageIter *iter, void *user_data);
 typedef void (* GDBusReturnFunction) (DBusMessage *message, void *user_data);
 
-- 
1.8.3.1

