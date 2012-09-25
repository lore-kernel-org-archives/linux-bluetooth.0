Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 03/14] thermometer: Move watcher logic to adapter interface
Date: Tue, 25 Sep 2012 16:52:32 +0200
Message-ID: <1348584763-22824-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves watcher related methods to ThermometerManager interface
so watchers can be registered per-adapter instead of per-device.

Final measurement notifications are now enabled on all devices connected
to given adapter when first watcher is registered and disabled when last
watcher is unregistered.

Intermediate measurement notifications are enabled for all devices
connected to given adapter which support this feature.
---
 profiles/thermometer/thermometer.c | 134 +++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 64 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index f2568c9..4eb67a7 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -59,6 +59,8 @@
 struct thermometer_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;
+	GSList			*fwatchers;	/* Final measurements */
+	GSList			*iwatchers;	/* Intermediate measurements */
 };
 
 struct thermometer {
@@ -70,8 +72,6 @@ struct thermometer {
 	guint				attindid;	/* Att incications id */
 	guint				attnotid;	/* Att notif id */
 	GSList				*chars;		/* Characteristics */
-	GSList				*fwatchers;     /* Final measurements */
-	GSList				*iwatchers;     /* Intermediate meas  */
 	gboolean			intermediate;
 	uint8_t				type;
 	uint16_t			interval;
@@ -94,10 +94,10 @@ struct descriptor {
 };
 
 struct watcher {
-	struct thermometer	*t;
-	guint			id;
-	char			*srv;
-	char			*path;
+	struct thermometer_adapter	*tadapter;
+	guint				id;
+	char				*srv;
+	char				*path;
 };
 
 struct measurement {
@@ -182,9 +182,6 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->chars != NULL)
 		g_slist_free_full(t->chars, destroy_char);
 
-	if (t->fwatchers != NULL)
-		g_slist_free_full(t->fwatchers, remove_watcher);
-
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
 	g_free(t);
@@ -197,6 +194,9 @@ static void destroy_thermometer_adapter(gpointer user_data)
 	if (tadapter->devices != NULL)
 		g_slist_free_full(tadapter->devices, destroy_thermometer);
 
+	if (tadapter->fwatchers != NULL)
+		g_slist_free_full(tadapter->fwatchers, remove_watcher);
+
 	g_free(tadapter);
 }
 
@@ -400,7 +400,7 @@ static void process_thermometer_desc(struct descriptor *desc)
 
 		if (g_strcmp0(ch->attr.uuid,
 					TEMPERATURE_MEASUREMENT_UUID) == 0) {
-			if (g_slist_length(ch->t->fwatchers) == 0)
+			if (g_slist_length(ch->t->tadapter->fwatchers) == 0)
 				return;
 
 			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
@@ -408,7 +408,7 @@ static void process_thermometer_desc(struct descriptor *desc)
 								"indication");
 		} else if (g_strcmp0(ch->attr.uuid,
 					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
-			if (g_slist_length(ch->t->iwatchers) == 0)
+			if (g_slist_length(ch->t->tadapter->iwatchers) == 0)
 				return;
 
 			val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
@@ -718,8 +718,9 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	return write_attr_interval(t, msg, value);
 }
 
-static void enable_final_measurement(struct thermometer *t)
+static void enable_final_measurement(gpointer data, gpointer user_data)
 {
+	struct thermometer *t = data;
 	struct characteristic *ch;
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
@@ -748,15 +749,16 @@ static void enable_final_measurement(struct thermometer *t)
 	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
-static void enable_intermediate_measurement(struct thermometer *t)
+static void enable_intermediate_measurement(gpointer data, gpointer user_data)
 {
+	struct thermometer *t = data;
 	struct characteristic *ch;
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
 	uint8_t atval[2];
 	char *msg;
 
-	if (t->attrib == NULL)
+	if (t->attrib == NULL || !t->intermediate)
 		return;
 
 	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
@@ -778,8 +780,9 @@ static void enable_intermediate_measurement(struct thermometer *t)
 	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
-static void disable_final_measurement(struct thermometer *t)
+static void disable_final_measurement(gpointer data, gpointer user_data)
 {
+	struct thermometer *t = data;
 	struct characteristic *ch;
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
@@ -808,8 +811,9 @@ static void disable_final_measurement(struct thermometer *t)
 	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
-static void disable_intermediate_measurement(struct thermometer *t)
+static void disable_intermediate_measurement(gpointer data, gpointer user_data)
 {
+	struct thermometer *t = data;
 	struct characteristic *ch;
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
@@ -838,31 +842,34 @@ static void disable_intermediate_measurement(struct thermometer *t)
 	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
-static void remove_int_watcher(struct thermometer *t, struct watcher *w)
+static void remove_int_watcher(struct thermometer_adapter *tadapter,
+							struct watcher *w)
 {
-	if (!g_slist_find(t->iwatchers, w))
+	if (!g_slist_find(tadapter->iwatchers, w))
 		return;
 
-	t->iwatchers = g_slist_remove(t->iwatchers, w);
+	tadapter->iwatchers = g_slist_remove(tadapter->iwatchers, w);
 
-	if (g_slist_length(t->iwatchers) == 0)
-		disable_intermediate_measurement(t);
+	if (g_slist_length(tadapter->iwatchers) == 0)
+		g_slist_foreach(tadapter->devices,
+					disable_intermediate_measurement, 0);
 }
 
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
-	struct thermometer *t = watcher->t;
+	struct thermometer_adapter *tadapter = watcher->tadapter;
 
 	DBG("Thermometer watcher %s disconnected", watcher->path);
 
-	remove_int_watcher(t, watcher);
+	remove_int_watcher(tadapter, watcher);
 
-	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
+	tadapter->fwatchers = g_slist_remove(tadapter->fwatchers, watcher);
 	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 
-	if (g_slist_length(t->fwatchers) == 0)
-		disable_final_measurement(t);
+	if (g_slist_length(tadapter->fwatchers) == 0)
+		g_slist_foreach(tadapter->devices,
+					disable_final_measurement, 0);
 }
 
 static struct watcher *find_watcher(GSList *list, const char *sender,
@@ -888,7 +895,7 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
-	struct thermometer *t = data;
+	struct thermometer_adapter *tadapter = data;
 	struct watcher *watcher;
 	char *path;
 
@@ -896,7 +903,7 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	watcher = find_watcher(t->fwatchers, sender, path);
+	watcher = find_watcher(tadapter->fwatchers, sender, path);
 	if (watcher != NULL)
 		return btd_error_already_exists(msg);
 
@@ -905,14 +912,14 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 	watcher = g_new0(struct watcher, 1);
 	watcher->srv = g_strdup(sender);
 	watcher->path = g_strdup(path);
-	watcher->t = t;
+	watcher->tadapter = tadapter;
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
 						watcher, destroy_watcher);
 
-	if (g_slist_length(t->fwatchers) == 0)
-		enable_final_measurement(t);
+	if (g_slist_length(tadapter->fwatchers) == 0)
+		g_slist_foreach(tadapter->devices, enable_final_measurement, 0);
 
-	t->fwatchers = g_slist_prepend(t->fwatchers, watcher);
+	tadapter->fwatchers = g_slist_prepend(tadapter->fwatchers, watcher);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -921,7 +928,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
-	struct thermometer *t = data;
+	struct thermometer_adapter *tadapter = data;
 	struct watcher *watcher;
 	char *path;
 
@@ -929,19 +936,20 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	watcher = find_watcher(t->fwatchers, sender, path);
+	watcher = find_watcher(tadapter->fwatchers, sender, path);
 	if (watcher == NULL)
 		return btd_error_does_not_exist(msg);
 
 	DBG("Thermometer watcher %s unregistered", path);
 
-	remove_int_watcher(t, watcher);
+	remove_int_watcher(tadapter, watcher);
 
-	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
+	tadapter->fwatchers = g_slist_remove(tadapter->fwatchers, watcher);
 	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 
-	if (g_slist_length(t->fwatchers) == 0)
-		disable_final_measurement(t);
+	if (g_slist_length(tadapter->fwatchers) == 0)
+		g_slist_foreach(tadapter->devices,
+					disable_final_measurement, 0);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -950,30 +958,28 @@ static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
-	struct thermometer *t = data;
+	struct thermometer_adapter *ta = data;
 	struct watcher *watcher;
 	char *path;
 
-	if (!t->intermediate)
-		return btd_error_not_supported(msg);
-
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	watcher = find_watcher(t->fwatchers, sender, path);
+	watcher = find_watcher(ta->fwatchers, sender, path);
 	if (watcher == NULL)
 		return btd_error_does_not_exist(msg);
 
-	if (find_watcher(t->iwatchers, sender, path))
+	if (find_watcher(ta->iwatchers, sender, path))
 		return btd_error_already_exists(msg);
 
 	DBG("Intermediate measurement watcher %s registered", path);
 
-	if (g_slist_length(t->iwatchers) == 0)
-		enable_intermediate_measurement(t);
+	if (g_slist_length(ta->iwatchers) == 0)
+		g_slist_foreach(ta->devices,
+					enable_intermediate_measurement, 0);
 
-	t->iwatchers = g_slist_prepend(t->iwatchers, watcher);
+	ta->iwatchers = g_slist_prepend(ta->iwatchers, watcher);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -982,7 +988,7 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
-	struct thermometer *t = data;
+	struct thermometer_adapter *ta = data;
 	struct watcher *watcher;
 	char *path;
 
@@ -990,13 +996,13 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	watcher = find_watcher(t->iwatchers, sender, path);
+	watcher = find_watcher(ta->iwatchers, sender, path);
 	if (watcher == NULL)
 		return btd_error_does_not_exist(msg);
 
 	DBG("Intermediate measurement %s unregistered", path);
 
-	remove_int_watcher(t, watcher);
+	remove_int_watcher(ta, watcher);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1008,18 +1014,6 @@ static const GDBusMethodTable thermometer_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
-	{ GDBUS_METHOD("RegisterWatcher",
-			GDBUS_ARGS({ "agent", "o" }), NULL,
-			register_watcher) },
-	{ GDBUS_METHOD("UnregisterWatcher",
-			GDBUS_ARGS({ "agent", "o" }), NULL,
-			unregister_watcher) },
-	{ GDBUS_METHOD("EnableIntermediateMeasurement",
-			GDBUS_ARGS({ "agent", "o" }), NULL,
-			enable_intermediate) },
-	{ GDBUS_METHOD("DisableIntermediateMeasurement",
-			GDBUS_ARGS({ "agent", "o" }), NULL,
-			disable_intermediate) },
 	{ }
 };
 
@@ -1071,9 +1065,9 @@ static void recv_measurement(struct thermometer *t, struct measurement *m)
 	GSList *wlist;
 
 	if (g_strcmp0(m->value, "Intermediate") == 0)
-		wlist = t->iwatchers;
+		wlist = t->tadapter->iwatchers;
 	else
-		wlist = t->fwatchers;
+		wlist = t->tadapter->fwatchers;
 
 	g_slist_foreach(wlist, update_watcher, m);
 }
@@ -1333,6 +1327,18 @@ void thermometer_unregister(struct btd_device *device)
 }
 
 static const GDBusMethodTable thermometer_manager_methods[] = {
+	{ GDBUS_METHOD("RegisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			register_watcher) },
+	{ GDBUS_METHOD("UnregisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_watcher) },
+	{ GDBUS_METHOD("EnableIntermediateMeasurement",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			enable_intermediate) },
+	{ GDBUS_METHOD("DisableIntermediateMeasurement",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			disable_intermediate) },
 	{ }
 };
 
-- 
1.7.11.3

