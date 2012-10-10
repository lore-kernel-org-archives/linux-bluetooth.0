Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 4/5] heartrate: Use the per handle GATT event notifier
Date: Wed, 10 Oct 2012 20:55:56 -0300
Message-Id: <1349913357-25547-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/heartrate/heartrate.c | 287 +++++++++++++++++++++--------------------
 1 file changed, 145 insertions(+), 142 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index d9d6c03..871b74e 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -260,6 +260,150 @@ static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
 	g_free(msg);
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
+
+	/* should be at least opcode (1b) + handle (2b) */
+	if (len < 3) {
+		error("Invalid PDU received");
+		return;
+	}
+
+	process_measurement(hr, pdu + 3, len - 3);
+}
+
+static void ccc_write_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	if (status != 0) {
+		error("Enable measurement failed");
+		return;
+	}
+
+	hr->attionotid = g_attrib_register(hr->attrib, ATT_OP_HANDLE_NOTIFY,
+						hr->measurement_val_handle,
+						notify_handler, hr, NULL);
+}
+
 static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -291,7 +435,6 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 
 		if (uuid == GATT_CLIENT_CHARAC_CFG_UUID) {
 			uint8_t value[2];
-			char *msg;
 
 			hr->measurement_ccc_handle = handle;
 
@@ -299,10 +442,9 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 				break;
 
 			att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-			msg = g_strdup("Enable measurement");
 
 			gatt_write_char(hr->attrib, handle, value,
-					sizeof(value), char_write_cb, msg);
+					sizeof(value), ccc_write_cb, hr);
 
 			break;
 		}
@@ -399,142 +541,6 @@ static void disable_measurement(gpointer data, gpointer user_data)
 							char_write_cb, msg);
 }
 
-static void update_watcher(gpointer data, gpointer user_data)
-{
-	struct watcher *w = data;
-	struct measurement *m = user_data;
-	struct heartrate *hr = m->hr;
-	const gchar *path = device_get_path(hr->dev);
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	DBusMessage *msg;
-
-	msg = dbus_message_new_method_call(w->srv, w->path,
-			HEART_RATE_WATCHER_INTERFACE, "MeasurementReceived");
-	if (msg == NULL)
-		return;
-
-	dbus_message_iter_init_append(msg, &iter);
-
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH , &path);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	dict_append_entry(&dict, "Value", DBUS_TYPE_UINT16, &m->value);
-
-	if (m->has_energy)
-		dict_append_entry(&dict, "Energy", DBUS_TYPE_UINT16,
-								&m->energy);
-
-	if (m->has_contact)
-		dict_append_entry(&dict, "Contact", DBUS_TYPE_BOOLEAN,
-								&m->contact);
-
-	if (m->num_interval > 0)
-		dict_append_array(&dict, "Interval", DBUS_TYPE_UINT16,
-						&m->interval, m->num_interval);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	dbus_message_set_no_reply(msg, TRUE);
-	g_dbus_send_message(btd_get_dbus_connection(), msg);
-}
-
-static void process_measurement(struct heartrate *hr, const uint8_t *pdu,
-								uint16_t len)
-{
-	struct measurement m;
-	uint8_t flags;
-
-	flags = *pdu;
-
-	pdu++;
-	len--;
-
-	memset(&m, 0, sizeof(m));
-
-	if (flags & HR_VALUE_FORMAT) {
-		if (len < 2) {
-			error("Heart Rate Measurement field missing");
-			return;
-		}
-
-		m.value = att_get_u16(pdu);
-		pdu += 2;
-		len -= 2;
-	} else {
-		if (len < 1) {
-			error("Heart Rate Measurement field missing");
-			return;
-		}
-
-		m.value = *pdu;
-		pdu++;
-		len--;
-	}
-
-	if (flags & ENERGY_EXP_STATUS) {
-		if (len < 2) {
-			error("Energy Expended field missing");
-			return;
-		}
-
-		m.has_energy = TRUE;
-		m.energy = att_get_u16(pdu);
-		pdu += 2;
-		len -= 2;
-	}
-
-	if (flags & RR_INTERVAL) {
-		int i;
-
-		if (len == 0 || (len % 2 != 0)) {
-			error("RR-Interval field malformed");
-			return;
-		}
-
-		m.num_interval = len / 2;
-		m.interval = g_new(uint16_t, m.num_interval);
-
-		for (i = 0; i < m.num_interval; pdu += 2, i++)
-			m.interval[i] = att_get_u16(pdu);
-	}
-
-	if (flags & SENSOR_CONTACT_SUPPORT) {
-		m.has_contact = TRUE;
-		m.contact = !!(flags & SENSOR_CONTACT_DETECTED);
-	}
-
-	/* Notify all registered watchers */
-	m.hr = hr;
-	g_slist_foreach(hr->hradapter->watchers, update_watcher, &m);
-
-	g_free(m.interval);
-}
-
-static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
-{
-	struct heartrate *hr = user_data;
-	uint16_t handle;
-
-	/* should be at least opcode (1b) + handle (2b) */
-	if (len < 3) {
-		error("Invalid PDU received");
-		return;
-	}
-
-	handle = att_get_u16(pdu + 1);
-	if (handle != hr->measurement_val_handle) {
-		error("Unexpected handle: 0x%04x", handle);
-		return;
-	}
-
-	process_measurement(hr, pdu + 3, len - 3);
-}
-
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -543,9 +549,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	hr->attrib = g_attrib_ref(attrib);
 
-	hr->attionotid = g_attrib_register(hr->attrib, ATT_OP_HANDLE_NOTIFY,
-				GATTRIB_ALL_HANDLES, notify_handler, hr, NULL);
-
 	gatt_discover_char(hr->attrib, hr->svc_range->start, hr->svc_range->end,
 						NULL, discover_char_cb, hr);
 }
-- 
1.7.12.3

