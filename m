Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/6] Implement DisableIntermediateMeasurement D-Bus method
Date: Thu, 10 Nov 2011 12:37:01 +0100
Message-Id: <1320925022-21891-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1320925022-21891-5-git-send-email-sancane@gmail.com>
References: <1320925022-21891-1-git-send-email-sancane@gmail.com>
 <1320925022-21891-2-git-send-email-sancane@gmail.com>
 <1320925022-21891-3-git-send-email-sancane@gmail.com>
 <1320925022-21891-4-git-send-email-sancane@gmail.com>
 <1320925022-21891-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   63 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 49e6372..0663b3c 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -647,6 +647,44 @@ static void disable_final_measurement(struct thermometer *t)
 	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
+static void disable_intermediate_measurement(struct thermometer *t)
+{
+	struct characteristic *ch;
+	struct descriptor *desc;
+	bt_uuid_t btuuid;
+	uint8_t atval[2];
+	gchar *msg;
+
+	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
+	if (ch == NULL) {
+		DBG("Intermediate measurement characteristic not found");
+		return;
+	}
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	desc = get_descriptor(ch, &btuuid);
+	if (desc == NULL) {
+		DBG("Client characteristic configuration descriptor not found");
+		return;
+	}
+
+	atval[0] = 0x00;
+	atval[1] = 0x00;
+	msg = g_strdup("Disable intermediate measurement");
+	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
+}
+
+static void remove_int_watcher(struct thermometer *t, struct watcher *w)
+{
+	if (!g_slist_find(t->iwatchers, w))
+		return;
+
+	t->iwatchers = g_slist_remove(t->iwatchers, w);
+
+	if (g_slist_length(t->iwatchers) == 0)
+		disable_intermediate_measurement(t);
+}
+
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
@@ -654,6 +692,8 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 
 	DBG("Thermometer watcher %s disconnected", watcher->path);
 
+	remove_int_watcher(t, watcher);
+
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
 	watcher->id = 0;
 
@@ -731,6 +771,8 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 
 	DBG("Thermometer watcher %s unregistered", path);
 
+	remove_int_watcher(t, watcher);
+
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
 	destroy_watcher(watcher);
 
@@ -775,9 +817,24 @@ static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	/* TODO: */
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
-						"Function not implemented.");
+	const gchar *sender = dbus_message_get_sender(msg);
+	struct thermometer *t = data;
+	struct watcher *watcher;
+	gchar *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(t->iwatchers, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	DBG("Intermediate measurement %s unregistered", path);
+
+	remove_int_watcher(t, watcher);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static GDBusMethodTable thermometer_methods[] = {
-- 
1.7.7.3

