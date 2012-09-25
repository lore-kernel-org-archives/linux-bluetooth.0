Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v8 09/13] heartrate: Process measurement notifications
Date: Tue, 25 Sep 2012 16:27:42 +0200
Message-ID: <1348583267-16816-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds processing of received Heart Rate Measurement
characteristic notifications and sends processed data to registered
watchers.
---
 profiles/heartrate/heartrate.c | 167 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index dda030b..ba1c1fa 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -42,6 +42,13 @@
 #include "heartrate.h"
 
 #define HEART_RATE_MANAGER_INTERFACE	"org.bluez.HeartRateManager"
+#define HEART_RATE_WATCHER_INTERFACE	"org.bluez.HeartRateWatcher"
+
+#define HR_VALUE_FORMAT		0x01
+#define SENSOR_CONTACT_DETECTED	0x02
+#define SENSOR_CONTACT_SUPPORT	0x04
+#define ENERGY_EXP_STATUS	0x08
+#define RR_INTERVAL		0x10
 
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
@@ -54,6 +61,7 @@ struct heartrate {
 	struct heartrate_adapter	*hradapter;
 	GAttrib				*attrib;
 	guint				attioid;
+	guint				attionotid;
 
 	struct att_range		*svc_range;	/* primary svc range */
 
@@ -72,6 +80,17 @@ struct watcher {
 	char				*path;
 };
 
+struct measurement {
+	struct heartrate	*hr;
+	uint16_t		value;
+	gboolean		has_energy;
+	uint16_t		energy;
+	gboolean		has_contact;
+	gboolean		contact;
+	uint16_t		num_interval;
+	uint16_t		*interval;
+};
+
 static GSList *heartrate_adapters = NULL;
 
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
@@ -155,8 +174,10 @@ static void destroy_heartrate(gpointer user_data)
 	if (hr->attioid > 0)
 		btd_device_remove_attio_callback(hr->dev, hr->attioid);
 
-	if (hr->attrib != NULL)
+	if (hr->attrib != NULL) {
+		g_attrib_unregister(hr->attrib, hr->attionotid);
 		g_attrib_unref(hr->attrib);
+	}
 
 	btd_device_unref(hr->dev);
 	g_free(hr->svc_range);
@@ -357,6 +378,142 @@ static void disable_measurement(gpointer data, gpointer user_data)
 							char_write_cb, msg);
 }
 
+static void update_watcher(gpointer data, gpointer user_data)
+{
+	struct watcher *w = data;
+	struct measurement *m = user_data;
+	struct heartrate *hr = m->hr;
+	const gchar *path = device_get_path(hr->dev);
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(w->srv, w->path,
+			HEART_RATE_WATCHER_INTERFACE, "MeasurementReceived");
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
+
+	if (m->has_energy)
+		dict_append_entry(&dict, "Energy", DBUS_TYPE_UINT16,
+								&m->energy);
+
+	if (m->has_contact)
+		dict_append_entry(&dict, "Contact", DBUS_TYPE_BOOLEAN,
+								&m->contact);
+
+	if (m->num_interval > 0)
+		dict_append_array(&dict, "Interval", DBUS_TYPE_UINT16,
+						&m->interval, m->num_interval);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+}
+
+static void process_measurement(struct heartrate *hr, const uint8_t *pdu,
+								uint16_t len)
+{
+	struct measurement m;
+	uint8_t flags;
+
+	flags = *pdu;
+
+	pdu++;
+	len--;
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
+			m.interval[i] = att_get_u16(pdu);
+	}
+
+	if (flags & SENSOR_CONTACT_SUPPORT) {
+		m.has_contact = TRUE;
+		m.contact = !!(flags & SENSOR_CONTACT_DETECTED);
+	}
+
+	/* Notify all registered watchers */
+	m.hr = hr;
+	g_slist_foreach(hr->hradapter->watchers, update_watcher, &m);
+
+	g_free(m.interval);
+}
+
+static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+	uint16_t handle;
+
+	/* should be at least opcode (1b) + handle (2b) */
+	if (len < 3) {
+		error("Invalid PDU received");
+		return;
+	}
+
+	handle = att_get_u16(pdu + 1);
+	if (handle != hr->measurement_val_handle) {
+		error("Unexpected handle: 0x%04x", handle);
+		return;
+	}
+
+	process_measurement(hr, pdu + 3, len - 3);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -365,6 +522,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	hr->attrib = g_attrib_ref(attrib);
 
+	hr->attionotid = g_attrib_register(hr->attrib, ATT_OP_HANDLE_NOTIFY,
+						notify_handler, hr, NULL);
+
 	gatt_discover_char(hr->attrib, hr->svc_range->start, hr->svc_range->end,
 						NULL, discover_char_cb, hr);
 }
@@ -375,6 +535,11 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("");
 
+	if (hr->attionotid > 0) {
+		g_attrib_unregister(hr->attrib, hr->attionotid);
+		hr->attionotid = 0;
+	}
+
 	g_attrib_unref(hr->attrib);
 	hr->attrib = NULL;
 }
-- 
1.7.11.3

