Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH v2 09/13] heartrate: Process measurements
Date: Mon, 13 Aug 2012 17:08:13 +0200
Message-ID: <1344870497-6929-10-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable or disable measurement while watcher is registered
or unregistered. Process measurement data when notification
is received and update watcher.

---
 profiles/heartrate/heartrate.c |  318 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index e88d4bc..587438b 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -46,6 +46,12 @@
 
 #define SENSOR_LOCATION_SIZE 1
 
+#define HR_VALUE_FORMAT	0x01
+#define SENSOR_SUPPORTED	0x02
+#define CONTACT_DETECTED	0x04
+#define ENERGY_EXP_STATUS	0x08
+#define RR_INTERVAL		0x10
+
 struct heartrate {
 	struct btd_device	*dev;  /*Device reference*/
 	DBusConnection		*conn; /*DBus conn*/
@@ -78,8 +84,38 @@ struct watcher {
 	char			*path;
 };
 
+struct measurement {
+	gboolean	u16_val_fmt; /*Heart Rate Value Format*/
+	uint16_t	value;
+	uint16_t	energy;
+	gboolean	energy_sup; /*Energy Status Supported*/
+	gboolean	contact;
+	char		*location;
+	gboolean	interval_sup; /*RR-Interval Supported*/
+	GSList		*interval;
+};
+
+const char *location_type[] = {
+	"Other",
+	"Chest",
+	"Wrist",
+	"Finger",
+	"Hand",
+	"Earlobe",
+	"Foot"
+};
+
 static GSList *hr_servers = NULL;
 
+static const gchar *location2str(uint8_t value)
+{
+	 if (value < G_N_ELEMENTS(location_type))
+		return location_type[value];
+
+	error("Location type %d reserved for future use", value);
+	return NULL;
+}
+
 static gint cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct heartrate *hr = a;
@@ -91,6 +127,30 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
+static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const uint16_t *handle = b;
+
+	return ch->attr.value_handle - *handle;
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
@@ -153,6 +213,78 @@ static void heartrate_destroy(gpointer user_data)
 	g_free(hr);
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
+static void measurement_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
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
+	uint16_t val;
+	char *msg;
+
+	if (hr->attrib == NULL)
+		return;
+
+	ch = get_characteristic(hr, HEART_RATE_MEASUREMENT_UUID);
+	if (ch == NULL) {
+		DBG("Temperature measurement characteristic not found");
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
+	val = enable ? GATT_CLIENT_CHARAC_CFG_NOTIF_BIT : 0x0000;
+
+	msg = enable ? g_strdup("Enable measurement") :
+				g_strdup("Disable measurement");
+
+	att_put_u16(val, atval);
+
+	gatt_write_char(hr->attrib, desc->handle, atval, 2,
+							measurement_cb, msg);
+
+}
+
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
@@ -162,6 +294,9 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 
 	hr->watchers = g_slist_remove(hr->watchers, watcher);
 	g_dbus_remove_watch(watcher->hr->conn, watcher->id);
+
+	if (g_slist_length(hr->watchers) == 0)
+		measurement_toggle(hr, FALSE);
 }
 
 static struct watcher *watcher_find(GSList *list, const char *sender,
@@ -208,6 +343,9 @@ static DBusMessage *watcher_register(DBusConnection *conn, DBusMessage *msg,
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
 						watcher, watcher_destroy);
 
+	if (g_slist_length(hr->watchers) == 0)
+		measurement_toggle(hr, TRUE);
+
 	hr->watchers = g_slist_prepend(hr->watchers, watcher);
 
 	return dbus_message_new_method_return(msg);
@@ -234,6 +372,9 @@ static DBusMessage *watcher_unregister(DBusConnection *conn, DBusMessage *msg,
 	hr->watchers = g_slist_remove(hr->watchers, watcher);
 	g_dbus_remove_watch(watcher->hr->conn, watcher->id);
 
+	if (g_slist_length(hr->watchers) == 0)
+		measurement_toggle(hr, FALSE);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -393,12 +534,189 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 	}
 }
 
+static void update_watcher(gpointer data, gpointer user_data)
+{
+	struct watcher *w = data;
+	struct measurement *m = user_data;
+	DBusConnection *conn = w->hr->conn;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *msg;
+	GSList *l;
+	uint16_t *interval;
+	guint n_elem;
+	guint i;
+
+	msg = dbus_message_new_method_call(w->srv, w->path,
+				"org.bluez.HeartRateWatcher",
+				"MeasurementReceived");
+	if (msg == NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Value", DBUS_TYPE_UINT16, &m->value);
+	dict_append_entry(&dict, "Energy", DBUS_TYPE_UINT16, &m->energy);
+	dict_append_entry(&dict, "Contact", DBUS_TYPE_BOOLEAN, &m->contact);
+	dict_append_entry(&dict, "Location", DBUS_TYPE_STRING, &m->location);
+
+	n_elem = g_slist_length(m->interval);
+
+	interval = g_new(uint16_t, n_elem);
+
+	if (interval != NULL) {
+
+		for (i = 0, l = m->interval; l; l = l->next, i++)
+			interval[i] =  GPOINTER_TO_UINT(l->data);
+
+		dict_append_array(&dict, "Interval", DBUS_TYPE_UINT16,
+							&interval, n_elem);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(conn, msg);
+
+	if (interval != NULL)
+		g_free(interval);
+}
+
+static void recv_measurement(struct heartrate *hr, struct measurement *m)
+{
+	GSList *wlist = hr->watchers;
+
+	g_slist_foreach(wlist, update_watcher, m);
+}
+
+static void get_flags(struct measurement *m, uint8_t pdu)
+{
+	uint8_t flags = pdu;
+
+	if (flags & HR_VALUE_FORMAT)
+		m->u16_val_fmt = TRUE;  /*value format set to uint16*/
+
+	if ((flags & SENSOR_SUPPORTED) && (flags & CONTACT_DETECTED))
+		m->contact = TRUE;
+
+	if (flags & ENERGY_EXP_STATUS)
+		m->energy_sup = TRUE;
+
+	if (flags & RR_INTERVAL)
+		m->interval_sup = TRUE;
+}
+
+static void proc_measurement(struct heartrate *hr, const uint8_t *pdu,
+						uint16_t len)
+{
+	struct measurement m;
+	const char *loc;
+	gint pdu_idx;
+	gint min_pdu_len;
+
+	if (len < 4) {
+		error("Mandatory flags are not provided");
+		return;
+	}
+
+	memset(&m, 0, sizeof(struct measurement));
+
+	get_flags(&m, pdu[3]);
+
+	pdu_idx = 4;
+	min_pdu_len = len - 4;
+
+	if (m.u16_val_fmt) {
+
+		if (min_pdu_len < 2) {
+			error("Heart Rate measurement value is not provided");
+			return;
+		}
+
+		m.value = att_get_u16(&pdu[pdu_idx]);
+		pdu_idx += 2;
+		min_pdu_len -= 2;
+	} else {
+
+		if (min_pdu_len < 1) {
+			error("Heart Rate measurement value is not provided");
+			return;
+		}
+
+		m.value = pdu[pdu_idx];
+		pdu_idx++;
+		min_pdu_len--;
+	}
+
+	if (m.energy_sup) {
+
+		if (min_pdu_len < 2) {
+			error("Can't get Energy Expended field");
+			return;
+		}
+
+		m.energy = att_get_u16(&pdu[pdu_idx]);
+		pdu_idx += 2;
+		min_pdu_len -= 2;
+	}
+
+	if (m.interval_sup) {
+		gint i;
+
+		if (min_pdu_len < 0) {
+			error("Can't get RR-interval");
+			return;
+		}
+
+		for (i = len - pdu_idx; i > 0; i--) {
+			uint16_t val = att_get_u16(&pdu[pdu_idx++]);
+			m.interval = g_slist_append(m.interval,
+						GUINT_TO_POINTER(val));
+		}
+	}
+
+	if (hr->has_location) {
+		loc = location2str(hr->location);
+		m.location =  g_strdup(loc);
+	} else {
+		m.location = NULL;
+	}
+
+	recv_measurement(hr, &m);
+
+	g_free(m.location);
+
+	if (m.interval != NULL)
+		g_slist_free(m.interval);
+}
+
 static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
+	struct heartrate *hr = user_data;
+	const struct characteristic *ch;
+	uint16_t handle;
+	GSList *l;
+
 	if (len < MIN_NOTIFICATION_LEN) {
 		error("Bad pdu received");
 		return;
 	}
+
+	handle = att_get_u16(&pdu[1]);
+	l = g_slist_find_custom(hr->chars, &handle, cmp_char_val_handle);
+	if (l == NULL) {
+		error("Unexpected handle: 0x%04x", handle);
+		return;
+	}
+
+	ch = l->data;
+	if (g_strcmp0(ch->attr.uuid, HEART_RATE_MEASUREMENT_UUID) == 0)
+		proc_measurement(hr, pdu, len);
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-- 
1.7.9.5

