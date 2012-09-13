Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 13/17] heartrate: Process Heart Rate Measurement characteristics
Date: Thu, 13 Sep 2012 14:13:17 +0200
Message-ID: <1347538401-6417-14-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change-Id: Ic64336c084891ad63b67fe900663a7835c1f78fb
---
 profiles/heartrate/heartrate.c | 193 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index dec09d0..0031e4d 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -42,11 +42,18 @@
 #include "log.h"
 
 #define HEART_RATE_MANAGER_IFACE "org.bluez.HeartRateManager"
+#define HEART_RATE_WATCHER_IFACE "org.bluez.HeartRateWatcher"
 
 #define MIN_NOTIFICATION_LEN 3  /* 1-byte opcode + 2-byte handle */
 
 #define SENSOR_LOCATION_SIZE 1
 
+#define HR_VALUE_FORMAT		0x01
+#define SENSOR_CONTACT_SUPPORT	0x02
+#define SENSOR_CONTACT_DETECTED	0x04
+#define ENERGY_EXP_STATUS	0x08
+#define RR_INTERVAL		0x10
+
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;
@@ -78,6 +85,18 @@ struct descriptor {
 	bt_uuid_t		uuid;
 };
 
+struct measurement {
+	struct heartrate_device	*hrdev;
+	uint16_t		value;
+	gboolean		has_energy;
+	uint16_t		energy;
+	gboolean		has_contact;
+	gboolean		contact;
+	uint16_t		num_interval;
+	uint16_t		*interval;
+	char			*location;
+};
+
 struct watcher {
 	struct heartrate_adapter	*hr;
 	guint				id;
@@ -85,6 +104,25 @@ struct watcher {
 	char				*path;
 };
 
+static const char *location_type[] = {
+	"Other",
+	"Chest",
+	"Wrist",
+	"Finger",
+	"Hand",
+	"Earlobe",
+	"Foot"
+};
+
+static const gchar *location2str(uint8_t value)
+{
+	 if (value < G_N_ELEMENTS(location_type))
+		return location_type[value];
+
+	error("Location type %d reserved for future use", value);
+	return NULL;
+}
+
 static GSList *heartrate_adapters = NULL;
 
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
@@ -125,6 +163,14 @@ static gint cmp_descriptor(gconstpointer a, gconstpointer b)
 	return bt_uuid_cmp(&desc->uuid, uuid);
 }
 
+static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const uint16_t *handle = b;
+
+	return ch->attr.value_handle - *handle;
+}
+
 static gint cmp_watcher(gconstpointer a, gconstpointer b)
 {
 	const struct watcher *watcher = a;
@@ -556,12 +602,159 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 	}
 }
 
+static void update_watcher(gpointer data, gpointer user_data)
+{
+	struct watcher *w = data;
+	struct measurement *m = user_data;
+	struct heartrate_device *hrdev = m->hrdev;
+	const gchar *path = device_get_path(hrdev->dev);
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(w->srv, w->path,
+						HEART_RATE_WATCHER_IFACE,
+						"MeasurementReceived");
+	if (msg == NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH , &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Value", DBUS_TYPE_UINT16, &m->value);
+	if (m->has_energy)
+		dict_append_entry(&dict, "Energy", DBUS_TYPE_UINT16, &m->energy);
+	if (m->has_contact)
+		dict_append_entry(&dict, "Contact", DBUS_TYPE_BOOLEAN, &m->contact);
+	dict_append_entry(&dict, "Location", DBUS_TYPE_STRING, &m->location);
+
+	if (m->num_interval > 0)
+		dict_append_array(&dict, "Interval", DBUS_TYPE_UINT16,
+						&m->interval, m->num_interval);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(get_dbus_connection(), msg);
+}
+
+static void recv_measurement(struct heartrate_device *hrdev,
+							struct measurement *m)
+{
+	GSList *wlist = hrdev->hr->watchers;
+
+	m->hrdev = hrdev;
+
+	g_slist_foreach(wlist, update_watcher, m);
+}
+
+static void proc_measurement(struct heartrate_device *hrdev,
+					const uint8_t *pdu, uint16_t len)
+{
+	struct measurement m;
+	uint8_t flags;
+
+	if (len < 4) {
+		error("Mandatory flags are not provided");
+		return;
+	}
+
+	flags = pdu[3];
+
+	pdu += 4;
+	len -= 4;
+
+	memset(&m, 0, sizeof(m));
+
+	if (flags & HR_VALUE_FORMAT) {
+		if (len < 2) {
+			error("Heart Rate Measurement field missing");
+			return;
+		}
+
+		m.value = att_get_u16(pdu);
+		pdu += 2;
+		len -= 2;
+	} else {
+		if (len < 1) {
+			error("Heart Rate Measurement field missing");
+			return;
+		}
+
+		m.value = *pdu;
+		pdu++;
+		len--;
+	}
+
+	if (flags & ENERGY_EXP_STATUS) {
+		if (len < 2) {
+			error("Energy Expended field missing");
+			return;
+		}
+
+		m.has_energy = TRUE;
+		m.energy = att_get_u16(pdu);
+		pdu += 2;
+		len -= 2;
+	}
+
+	if (flags & RR_INTERVAL) {
+		int i;
+
+		if (len == 0 || (len % 2 != 0)) {
+			error("RR-Interval field malformed");
+			return;
+		}
+
+		m.num_interval = len / 2;
+		m.interval = g_new(uint16_t, m.num_interval);
+
+		for (i = 0; i < m.num_interval; pdu += 2, i++)
+				m.interval[i] = att_get_u16(pdu);
+	}
+
+	if (flags & SENSOR_CONTACT_SUPPORT) {
+		m.has_contact = TRUE;
+		m.contact = !!(flags & SENSOR_CONTACT_DETECTED);
+	}
+
+	if (hrdev->has_location)
+		m.location = g_strdup(location2str(hrdev->location));
+
+	recv_measurement(hrdev, &m);
+
+	g_free(m.interval);
+	g_free(m.location);
+}
+
 static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
+	struct heartrate_device *hrdev = user_data;
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
+	l = g_slist_find_custom(hrdev->chars, &handle, cmp_char_val_handle);
+	if (l == NULL) {
+		error("Unexpected handle: 0x%04x", handle);
+		return;
+	}
+
+	ch = l->data;
+	if (g_strcmp0(ch->attr.uuid, HEART_RATE_MEASUREMENT_UUID) == 0)
+		proc_measurement(hrdev, pdu, len);
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-- 
1.7.11.3

