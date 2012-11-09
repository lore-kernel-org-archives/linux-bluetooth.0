Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 04/15] thermometer: Use dedicated handler for Intermediate Temperature
Date: Fri, 9 Nov 2012 09:55:46 +0100
Message-ID: <1352451357-22097-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces global notifications handler with one registered only
for Intermediate Temperature value notifications.
---
 profiles/thermometer/thermometer.c | 345 ++++++++++++++++++-------------------
 1 file changed, 168 insertions(+), 177 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index d65fc0d..5ed0553 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -71,7 +71,8 @@ struct thermometer {
 	struct att_range		*svc_range;	/* Thermometer range */
 	guint				attioid;	/* Att watcher id */
 	guint				attindid;	/* Att incications id */
-	guint				attnotid;	/* Att notif id */
+	/* attio id for Intermediate Temperature value notifications */
+	guint				attio_intermediate_id;
 	GSList				*chars;		/* Characteristics */
 	gboolean			intermediate;
 	uint8_t				type;
@@ -179,8 +180,7 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attindid > 0)
 		g_attrib_unregister(t->attrib, t->attindid);
 
-	if (t->attnotid > 0)
-		g_attrib_unregister(t->attrib, t->attnotid);
+	g_attrib_unregister(t->attrib, t->attio_intermediate_id);
 
 	if (t->attrib != NULL)
 		g_attrib_unref(t->attrib);
@@ -304,6 +304,162 @@ static void change_property(struct thermometer *t, const char *name,
 	}
 }
 
+static void update_watcher(gpointer data, gpointer user_data)
+{
+	struct watcher *w = data;
+	struct measurement *m = user_data;
+	const gchar *path = device_get_path(m->t->dev);
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(w->srv, w->path,
+				THERMOMETER_WATCHER_INTERFACE,
+				"MeasurementReceived");
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
+	dict_append_entry(&dict, "Exponent", DBUS_TYPE_INT16, &m->exp);
+	dict_append_entry(&dict, "Mantissa", DBUS_TYPE_INT32, &m->mant);
+	dict_append_entry(&dict, "Unit", DBUS_TYPE_STRING, &m->unit);
+
+	if (m->suptime)
+		dict_append_entry(&dict, "Time", DBUS_TYPE_UINT64, &m->time);
+
+	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &m->type);
+	dict_append_entry(&dict, "Measurement", DBUS_TYPE_STRING, &m->value);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+}
+
+static void recv_measurement(struct thermometer *t, struct measurement *m)
+{
+	GSList *wlist;
+
+	m->t = t;
+
+	if (g_strcmp0(m->value, "intermediate") == 0)
+		wlist = t->tadapter->iwatchers;
+	else
+		wlist = t->tadapter->fwatchers;
+
+	g_slist_foreach(wlist, update_watcher, m);
+}
+
+static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
+						uint16_t len, gboolean final)
+{
+	struct measurement m;
+	const char *type = NULL;
+	uint8_t flags;
+	uint32_t raw;
+
+	/* skip opcode and handle */
+	pdu += 3;
+	len -= 3;
+
+	if (len < 1) {
+		DBG("Mandatory flags are not provided");
+		return;
+	}
+
+	memset(&m, 0, sizeof(m));
+
+	flags = *pdu;
+
+	if (flags & TEMP_UNITS)
+		m.unit = "fahrenheit";
+	else
+		m.unit = "celsius";
+
+	pdu++;
+	len--;
+
+	if (len < 4) {
+		DBG("Mandatory temperature measurement value is not provided");
+		return;
+	}
+
+	raw = att_get_u32(pdu);
+	m.mant = raw & 0x00FFFFFF;
+	m.exp = ((int32_t) raw) >> 24;
+
+	if (m.mant & 0x00800000) {
+		/* convert to C2 negative value */
+		m.mant = m.mant - FLOAT_MAX_MANTISSA;
+	}
+
+	pdu += 4;
+	len -= 4;
+
+	if (flags & TEMP_TIME_STAMP) {
+		struct tm ts;
+		time_t time;
+
+		if (len < 7) {
+			DBG("Time stamp is not provided");
+			return;
+		}
+
+		ts.tm_year = att_get_u16(pdu) - 1900;
+		ts.tm_mon = *(pdu + 2) - 1;
+		ts.tm_mday = *(pdu + 3);
+		ts.tm_hour = *(pdu + 4);
+		ts.tm_min = *(pdu + 5);
+		ts.tm_sec = *(pdu + 6);
+		ts.tm_isdst = -1;
+
+		time = mktime(&ts);
+		m.time = (uint64_t) time;
+		m.suptime = TRUE;
+
+		pdu += 7;
+		len -= 7;
+	}
+
+	if (flags & TEMP_TYPE) {
+		if (len < 1) {
+			DBG("Temperature type is not provided");
+			return;
+		}
+
+		type = temptype2str(*pdu);
+	} else if (t->has_type) {
+		type = temptype2str(t->type);
+	}
+
+	m.type = g_strdup(type);
+	m.value = final ? "final" : "intermediate";
+
+	recv_measurement(t, &m);
+	g_free(m.type);
+}
+
+static void intermediate_notify_handler(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct thermometer *t = user_data;
+
+	if (len < 3) {
+		DBG("Bad pdu received");
+		return;
+	}
+
+	proc_measurement(t, pdu, len, FALSE);
+}
+
 static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -514,10 +670,15 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 
 static void process_thermometer_char(struct characteristic *ch)
 {
+	struct thermometer *t = ch->t;
+
 	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
 		gboolean intermediate = TRUE;
 		change_property(ch->t, "Intermediate", &intermediate);
-		return;
+
+		t->attio_intermediate_id = g_attrib_register(t->attrib,
+				ATT_OP_HANDLE_NOTIFY, ch->attr.value_handle,
+				intermediate_notify_handler, t, NULL);
 	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0) {
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_temp_type_cb, ch);
@@ -941,149 +1102,6 @@ static const GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
-static void update_watcher(gpointer data, gpointer user_data)
-{
-	struct watcher *w = data;
-	struct measurement *m = user_data;
-	const gchar *path = device_get_path(m->t->dev);
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	DBusMessage *msg;
-
-	msg = dbus_message_new_method_call(w->srv, w->path,
-				THERMOMETER_WATCHER_INTERFACE,
-				"MeasurementReceived");
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
-	dict_append_entry(&dict, "Exponent", DBUS_TYPE_INT16, &m->exp);
-	dict_append_entry(&dict, "Mantissa", DBUS_TYPE_INT32, &m->mant);
-	dict_append_entry(&dict, "Unit", DBUS_TYPE_STRING, &m->unit);
-
-	if (m->suptime)
-		dict_append_entry(&dict, "Time", DBUS_TYPE_UINT64, &m->time);
-
-	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &m->type);
-	dict_append_entry(&dict, "Measurement", DBUS_TYPE_STRING, &m->value);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	dbus_message_set_no_reply(msg, TRUE);
-	g_dbus_send_message(btd_get_dbus_connection(), msg);
-}
-
-static void recv_measurement(struct thermometer *t, struct measurement *m)
-{
-	GSList *wlist;
-
-	m->t = t;
-
-	if (g_strcmp0(m->value, "intermediate") == 0)
-		wlist = t->tadapter->iwatchers;
-	else
-		wlist = t->tadapter->fwatchers;
-
-	g_slist_foreach(wlist, update_watcher, m);
-}
-
-static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
-						uint16_t len, gboolean final)
-{
-	struct measurement m;
-	const char *type = NULL;
-	uint8_t flags;
-	uint32_t raw;
-
-	/* skip opcode and handle */
-	pdu += 3;
-	len -= 3;
-
-	if (len < 1) {
-		DBG("Mandatory flags are not provided");
-		return;
-	}
-
-	memset(&m, 0, sizeof(m));
-
-	flags = *pdu;
-
-	if (flags & TEMP_UNITS)
-		m.unit = "fahrenheit";
-	else
-		m.unit = "celsius";
-
-	pdu++;
-	len--;
-
-	if (len < 4) {
-		DBG("Mandatory temperature measurement value is not provided");
-		return;
-	}
-
-	raw = att_get_u32(pdu);
-	m.mant = raw & 0x00FFFFFF;
-	m.exp = ((int32_t) raw) >> 24;
-
-	if (m.mant & 0x00800000) {
-		/* convert to C2 negative value */
-		m.mant = m.mant - FLOAT_MAX_MANTISSA;
-	}
-
-	pdu += 4;
-	len -= 4;
-
-	if (flags & TEMP_TIME_STAMP) {
-		struct tm ts;
-		time_t time;
-
-		if (len < 7) {
-			DBG("Time stamp is not provided");
-			return;
-		}
-
-		ts.tm_year = att_get_u16(pdu) - 1900;
-		ts.tm_mon = *(pdu + 2) - 1;
-		ts.tm_mday = *(pdu + 3);
-		ts.tm_hour = *(pdu + 4);
-		ts.tm_min = *(pdu + 5);
-		ts.tm_sec = *(pdu + 6);
-		ts.tm_isdst = -1;
-
-		time = mktime(&ts);
-		m.time = (uint64_t) time;
-		m.suptime = TRUE;
-
-		pdu += 7;
-		len -= 7;
-	}
-
-	if (flags & TEMP_TYPE) {
-		if (len < 1) {
-			DBG("Temperature type is not provided");
-			return;
-		}
-
-		type = temptype2str(*pdu);
-	} else if (t->has_type) {
-		type = temptype2str(t->type);
-	}
-
-	m.type = g_strdup(type);
-	m.value = final ? "final" : "intermediate";
-
-	recv_measurement(t, &m);
-	g_free(m.type);
-}
-
 static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
 								uint16_t len)
 {
@@ -1134,30 +1152,6 @@ static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void notif_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
-{
-	struct thermometer *t = user_data;
-	const struct characteristic *ch;
-	uint16_t handle;
-	GSList *l;
-
-	if (len < 3) {
-		DBG("Bad pdu received");
-		return;
-	}
-
-	handle = att_get_u16(&pdu[1]);
-	l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
-	if (l == NULL) {
-		DBG("Unexpected handle: 0x%04x", handle);
-		return;
-	}
-
-	ch = l->data;
-	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0)
-		proc_measurement(t, pdu, len, FALSE);
-}
-
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -1167,9 +1161,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
 							GATTRIB_ALL_HANDLES,
 							ind_handler, t, NULL);
-	t->attnotid = g_attrib_register(t->attrib, ATT_OP_HANDLE_NOTIFY,
-							GATTRIB_ALL_HANDLES,
-							notif_handler, t, NULL);
 	gatt_discover_char(t->attrib, t->svc_range->start, t->svc_range->end,
 					NULL, configure_thermometer_cb, t);
 }
@@ -1185,9 +1176,9 @@ static void attio_disconnected_cb(gpointer user_data)
 		t->attindid = 0;
 	}
 
-	if (t->attnotid > 0) {
-		g_attrib_unregister(t->attrib, t->attnotid);
-		t->attnotid = 0;
+	if (t->attio_intermediate_id > 0) {
+		g_attrib_unregister(t->attrib, t->attio_intermediate_id);
+		t->attio_intermediate_id = 0;
 	}
 
 	g_attrib_unref(t->attrib);
-- 
1.8.0

