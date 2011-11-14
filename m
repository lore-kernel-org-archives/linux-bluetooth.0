Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/6] Implement EnableIntermediateMeasurement D-Bus method
Date: Mon, 14 Nov 2011 13:11:18 +0100
Message-Id: <1321272680-16286-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1321272680-16286-4-git-send-email-sancane@gmail.com>
References: <1321272680-16286-1-git-send-email-sancane@gmail.com>
 <1321272680-16286-2-git-send-email-sancane@gmail.com>
 <1321272680-16286-3-git-send-email-sancane@gmail.com>
 <1321272680-16286-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   74 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index b35c3aa..64b6aa6 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -63,6 +63,7 @@ struct thermometer {
 	guint			attindid;	/* Att incications id */
 	GSList			*chars;		/* Characteristics */
 	GSList			*fwatchers;     /* Final measurements */
+	GSList			*iwatchers;     /* Intermediate measurements */
 	gboolean		intermediate;
 	guint8			type;
 	guint16			interval;
@@ -558,7 +559,7 @@ static struct descriptor *get_descriptor(struct characteristic *ch,
 	return l->data;
 }
 
-static void final_measurement_cb(guint8 status, const guint8 *pdu,
+static void measurement_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
 	gchar *msg = user_data;
@@ -593,8 +594,34 @@ static void enable_final_measurement(struct thermometer *t)
 	atval[0] = 0x02;
 	atval[1] = 0x00;
 	msg = g_strdup("Enable final measurement");
-	gatt_write_char(t->attrib, desc->handle, atval, 2,
-						final_measurement_cb, msg);
+	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
+}
+
+static void enable_intermediate_measurement(struct thermometer *t)
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
+	atval[0] = 0x01;
+	atval[1] = 0x00;
+	msg = g_strdup("Enable intermediate measurement");
+	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
 static void disable_final_measurement(struct thermometer *t)
@@ -621,8 +648,7 @@ static void disable_final_measurement(struct thermometer *t)
 	atval[0] = 0x00;
 	atval[1] = 0x00;
 	msg = g_strdup("Disable final measurement");
-	gatt_write_char(t->attrib, desc->handle, atval, 2,
-						final_measurement_cb, msg);
+	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
 }
 
 static void watcher_exit(DBusConnection *conn, void *user_data)
@@ -639,7 +665,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 		disable_final_measurement(t);
 }
 
-static struct watcher *find_watcher(struct thermometer *t, const gchar *sender,
+static struct watcher *find_watcher(GSList *list, const gchar *sender,
 							const gchar *path)
 {
 	struct watcher *match;
@@ -649,7 +675,7 @@ static struct watcher *find_watcher(struct thermometer *t, const gchar *sender,
 	match->srv = g_strdup(sender);
 	match->path = g_strdup(path);
 
-	l = g_slist_find_custom(t->fwatchers, match, cmp_watcher);
+	l = g_slist_find_custom(list, match, cmp_watcher);
 	destroy_watcher(match);
 
 	if (l != NULL)
@@ -670,7 +696,7 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	watcher = find_watcher(t, sender, path);
+	watcher = find_watcher(t->fwatchers, sender, path);
 	if (watcher != NULL)
 		return btd_error_already_exists(msg);
 
@@ -703,7 +729,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	watcher = find_watcher(t, sender, path);
+	watcher = find_watcher(t->fwatchers, sender, path);
 	if (watcher == NULL)
 		return btd_error_does_not_exist(msg);
 
@@ -721,9 +747,33 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
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
+	if (!t->intermediate)
+		return btd_error_not_supported(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(t->fwatchers, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	if (find_watcher(t->iwatchers, sender, path))
+		return btd_error_already_exists(msg);
+
+	DBG("Intermediate measurement watcher %s registered", path);
+
+	if (g_slist_length(t->iwatchers) == 0)
+		enable_intermediate_measurement(t);
+
+	t->iwatchers = g_slist_prepend(t->iwatchers, watcher);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.7.3

