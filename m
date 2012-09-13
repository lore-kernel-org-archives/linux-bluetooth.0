Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 09/17] heartrate: Enable measurement when watchers are registered
Date: Thu, 13 Sep 2012 14:13:13 +0200
Message-ID: <1347538401-6417-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will enable measurement notification when first watcher is
registered or when device is connected and watcher is already registered.

Measurement will be disabled when last watcher is unregistered.

Change-Id: I1490ee9a76cd17201a3612f597f1fa12f85a6cbb
---
 profiles/heartrate/heartrate.c | 130 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 861428a..97d3c17 100644
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
@@ -181,6 +197,92 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hr);
 }
 
+static struct characteristic *
+get_characteristic(struct heartrate_device *hrdev, const char *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(hrdev->chars, uuid, cmp_char_uuid);
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
+static void measurement_toggle(struct heartrate_device *hrdev, gboolean enable)
+{
+	struct characteristic *ch;
+	struct descriptor *desc;
+	bt_uuid_t btuuid;
+	uint8_t atval[2];
+	char *msg;
+
+	if (hrdev->attrib == NULL)
+		return;
+
+	ch = get_characteristic(hrdev, HEART_RATE_MEASUREMENT_UUID);
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
+	gatt_write_char(hrdev->attrib, desc->handle, atval,
+							2, char_write_cb, msg);
+
+}
+
+static void measurement_enable(gpointer data, gpointer user_data)
+{
+	struct heartrate_device *hrdev = data;
+
+	measurement_toggle(hrdev, TRUE);
+}
+
+static void measurement_disable(gpointer data, gpointer user_data)
+{
+	struct heartrate_device *hrdev = data;
+
+	measurement_toggle(hrdev, FALSE);
+}
+
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
@@ -190,6 +292,9 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 
 	hr->watchers = g_slist_remove(hr->watchers, watcher);
 	g_dbus_remove_watch(conn, watcher->id);
+
+	if (g_slist_length(hr->watchers) == 0)
+		g_slist_foreach(hr->devices, measurement_disable, 0);
 }
 
 static struct watcher *find_watcher(GSList *list, const char *sender,
@@ -236,6 +341,9 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
 						watcher, destroy_watcher);
 
+	if (g_slist_length(hr->watchers) == 0)
+		g_slist_foreach(hr->devices, measurement_enable, 0);
+
 	hr->watchers = g_slist_prepend(hr->watchers, watcher);
 
 	return dbus_message_new_method_return(msg);
@@ -262,6 +370,9 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	hr->watchers = g_slist_remove(hr->watchers, watcher);
 	g_dbus_remove_watch(get_dbus_connection(), watcher->id);
 
+	if (g_slist_length(hr->watchers) == 0)
+		g_slist_foreach(hr->devices, measurement_disable, 0);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -291,9 +402,26 @@ static void process_heartrate_desc(struct descriptor *desc)
 
 	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
-	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0)
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		uint8_t atval[2];
+		char *msg;
+
+		if (g_strcmp0(ch->attr.uuid, HEART_RATE_MEASUREMENT_UUID) != 0)
+			goto done;
+
+		if (g_slist_length(ch->hrdev->hr->watchers) == 0)
+			return;
+
+		att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, atval);
+		msg = g_strdup("Enable measurement");
+
+		gatt_write_char(ch->hrdev->attrib, desc->handle,
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

