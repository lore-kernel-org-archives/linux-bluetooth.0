Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v8 08/13] heartrate: Add support to enable notifications
Date: Tue, 25 Sep 2012 16:27:41 +0200
Message-ID: <1348583267-16816-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to enable notifications for Heart Rate Measurement
characteristic value. Notifications are enabled automatically when at
least one watcher is registered and disabled otherwise.
---
 profiles/heartrate/heartrate.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index b07a343..dda030b 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -207,6 +207,17 @@ static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
 	hr->location = value;
 }
 
+static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	char *msg = user_data;
+
+	if (status != 0)
+		error("%s failed", msg);
+
+	g_free(msg);
+}
+
 static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -237,7 +248,20 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 		uuid = att_get_u16(value + 2);
 
 		if (uuid == GATT_CLIENT_CHARAC_CFG_UUID) {
+			uint8_t value[2];
+			char *msg;
+
 			hr->measurement_ccc_handle = handle;
+
+			if (g_slist_length(hr->hradapter->watchers) == 0)
+				break;
+
+			att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+			msg = g_strdup("Enable measurement");
+
+			gatt_write_char(hr->attrib, handle, value,
+					sizeof(value), char_write_cb, msg);
+
 			break;
 		}
 	}
@@ -299,6 +323,40 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 	}
 }
 
+static void enable_measurement(gpointer data, gpointer user_data)
+{
+	struct heartrate *hr = data;
+	uint16_t handle = hr->measurement_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (hr->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	msg = g_strdup("Enable measurement");
+
+	gatt_write_char(hr->attrib, handle, value, sizeof(value),
+							char_write_cb, msg);
+}
+
+static void disable_measurement(gpointer data, gpointer user_data)
+{
+	struct heartrate *hr = data;
+	uint16_t handle = hr->measurement_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (hr->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(0x0000, value);
+	msg = g_strdup("Disable measurement");
+
+	gatt_write_char(hr->attrib, handle, value, sizeof(value),
+							char_write_cb, msg);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -330,6 +388,9 @@ static void watcher_exit_cb(DBusConnection *conn, void *user_data)
 
 	hradapter->watchers = g_slist_remove(hradapter->watchers, watcher);
 	g_dbus_remove_watch(conn, watcher->id);
+
+	if (g_slist_length(hradapter->watchers) == 0)
+		g_slist_foreach(hradapter->devices, disable_measurement, 0);
 }
 
 static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
@@ -355,6 +416,9 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 	watcher->srv = g_strdup(sender);
 	watcher->path = g_strdup(path);
 
+	if (g_slist_length(hradapter->watchers) == 0)
+		g_slist_foreach(hradapter->devices, enable_measurement, 0);
+
 	hradapter->watchers = g_slist_prepend(hradapter->watchers, watcher);
 
 	DBG("heartrate watcher [%s] registered", path);
@@ -381,6 +445,9 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	hradapter->watchers = g_slist_remove(hradapter->watchers, watcher);
 	g_dbus_remove_watch(conn, watcher->id);
 
+	if (g_slist_length(hradapter->watchers) == 0)
+		g_slist_foreach(hradapter->devices, disable_measurement, 0);
+
 	DBG("heartrate watcher [%s] unregistered", path);
 
 	return dbus_message_new_method_return(msg);
-- 
1.7.11.3

