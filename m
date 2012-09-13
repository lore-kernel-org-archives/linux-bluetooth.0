Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v5 09/17] heartrate: Enable measurement when watchers are registered
Date: Thu, 13 Sep 2012 16:31:43 +0200
Message-ID: <1347546711-19961-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will enable measurement notification when first watcher is
registered or when device is connected and watcher is already registered.

Measurement will be disabled when last watcher is unregistered.

---
 profiles/heartrate/heartrate.c | 129 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index a223fe0..9d29ee0 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -101,6 +101,22 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static gint cmp_char_uuid(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const char *uuid = b;
+
+	return g_strcmp0(ch->attr.uuid, uuid);
+}
+
+static gint cmp_descriptor(gconstpointer a, gconstpointer b)
+{
+	const struct descriptor *desc = a;
+	const bt_uuid_t *uuid = b;
+
+	return bt_uuid_cmp(&desc->uuid, uuid);
+}
+
 static gint cmp_watcher(gconstpointer a, gconstpointer b)
 {
 	const struct watcher *watcher = a;
@@ -181,6 +197,91 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hra);
 }
 
+static struct characteristic *get_characteristic(struct heartrate *hr,
+							const char *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(hr->chars, uuid, cmp_char_uuid);
+	if (l == NULL)
+		return NULL;
+
+	return l->data;
+}
+
+static struct descriptor *get_descriptor(struct characteristic *ch,
+							const bt_uuid_t *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(ch->desc, uuid, cmp_descriptor);
+	if (l == NULL)
+		return NULL;
+
+	return l->data;
+}
+
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
+static void measurement_toggle(struct heartrate *hr, gboolean enable)
+{
+	struct characteristic *ch;
+	struct descriptor *desc;
+	bt_uuid_t btuuid;
+	uint8_t atval[2];
+	char *msg;
+
+	if (hr->attrib == NULL)
+		return;
+
+	ch = get_characteristic(hr, HEART_RATE_MEASUREMENT_UUID);
+	if (ch == NULL) {
+		DBG("Heart Rate Measurement characteristic not found");
+		return;
+	}
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	desc = get_descriptor(ch, &btuuid);
+	if (desc == NULL) {
+		DBG("Client Characteristic Configuration descriptor not found");
+		return;
+	}
+
+	if (enable) {
+		att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, atval);
+		msg = g_strdup("Enable measurement");
+	} else {
+		att_put_u16(0x0000, atval);
+		msg = g_strdup("Disable measurement");
+	}
+
+	gatt_write_char(hr->attrib, desc->handle, atval, 2, char_write_cb, msg);
+
+}
+
+static void measurement_enable(gpointer data, gpointer user_data)
+{
+	struct heartrate *hr = data;
+
+	measurement_toggle(hr, TRUE);
+}
+
+static void measurement_disable(gpointer data, gpointer user_data)
+{
+	struct heartrate *hr = data;
+
+	measurement_toggle(hr, FALSE);
+}
+
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
@@ -190,6 +291,9 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 
 	hr->watchers = g_slist_remove(hr->watchers, watcher);
 	g_dbus_remove_watch(conn, watcher->id);
+
+	if (g_slist_length(hr->watchers) == 0)
+		g_slist_foreach(hr->devices, measurement_disable, 0);
 }
 
 static struct watcher *find_watcher(GSList *list, const char *sender,
@@ -236,6 +340,9 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
 						watcher, destroy_watcher);
 
+	if (g_slist_length(hra->watchers) == 0)
+		g_slist_foreach(hra->devices, measurement_enable, 0);
+
 	hra->watchers = g_slist_prepend(hra->watchers, watcher);
 
 	return dbus_message_new_method_return(msg);
@@ -262,6 +369,9 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	hr->watchers = g_slist_remove(hr->watchers, watcher);
 	g_dbus_remove_watch(get_dbus_connection(), watcher->id);
 
+	if (g_slist_length(hr->watchers) == 0)
+		g_slist_foreach(hr->devices, measurement_disable, 0);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -291,9 +401,26 @@ static void process_heartrate_desc(struct descriptor *desc)
 
 	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
-	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0)
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		uint8_t atval[2];
+		char *msg;
+
+		if (g_strcmp0(ch->attr.uuid, HEART_RATE_MEASUREMENT_UUID) != 0)
+			goto done;
+
+		if (g_slist_length(ch->hr->hra->watchers) == 0)
+			return;
+
+		att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, atval);
+		msg = g_strdup("Enable measurement");
+
+		gatt_write_char(ch->hr->attrib, desc->handle,
+					atval, 2, char_write_cb, msg);
+
 		return;
+	}
 
+done:
 	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
 	DBG("Ignored descriptor %s in characteristic %s", uuidstr,
 							ch->attr.uuid);
-- 
1.7.11.3

