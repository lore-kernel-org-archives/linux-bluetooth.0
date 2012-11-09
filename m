Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 06/15] thermometer: Use dedicated handler for Measurement Interval
Date: Fri, 9 Nov 2012 09:55:48 +0100
Message-ID: <1352451357-22097-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces global indications handler with one registered only
for Measurement Interval value indications.
---
 profiles/thermometer/thermometer.c | 104 +++++++++++++------------------------
 1 file changed, 36 insertions(+), 68 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index c5fdb94..b01ac7a 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -70,11 +70,12 @@ struct thermometer {
 	GAttrib				*attrib;	/* GATT connection */
 	struct att_range		*svc_range;	/* Thermometer range */
 	guint				attioid;	/* Att watcher id */
-	guint				attindid;	/* Att incications id */
 	/* attio id for Temperature Measurement value indications */
 	guint				attio_measurement_id;
 	/* attio id for Intermediate Temperature value notifications */
 	guint				attio_intermediate_id;
+	/* attio id for Measurement Interval value indications */
+	guint				attio_interval_id;
 	GSList				*chars;		/* Characteristics */
 	gboolean			intermediate;
 	uint8_t				type;
@@ -179,11 +180,9 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attioid > 0)
 		btd_device_remove_attio_callback(t->dev, t->attioid);
 
-	if (t->attindid > 0)
-		g_attrib_unregister(t->attrib, t->attindid);
-
 	g_attrib_unregister(t->attrib, t->attio_measurement_id);
 	g_attrib_unregister(t->attrib, t->attio_intermediate_id);
+	g_attrib_unregister(t->attrib, t->attio_interval_id);
 
 	if (t->attrib != NULL)
 		g_attrib_unref(t->attrib);
@@ -244,14 +243,6 @@ static gint cmp_watcher(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
-static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
-{
-	const struct characteristic *ch = a;
-	const uint16_t *handle = b;
-
-	return ch->attr.value_handle - *handle;
-}
-
 static struct thermometer_adapter *
 find_thermometer_adapter(struct btd_adapter *adapter)
 {
@@ -486,6 +477,30 @@ static void intermediate_notify_handler(const uint8_t *pdu, uint16_t len,
 	proc_measurement(t, pdu, len, FALSE);
 }
 
+static void interval_ind_handler(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct thermometer *t = user_data;
+	uint16_t interval;
+	uint8_t *opdu;
+	uint16_t olen;
+	size_t plen;
+
+	if (len < 5) {
+		DBG("Bad pdu received");
+		return;
+	}
+
+	interval = att_get_u16(pdu + 3);
+	change_property(t, "Interval", &interval);
+
+	opdu = g_attrib_get_buffer(t->attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
+
+	if (olen > 0)
+		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
+}
+
 static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -719,6 +734,10 @@ static void process_thermometer_char(struct characteristic *ch)
 
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_interval_cb, ch);
+
+		t->attio_interval_id = g_attrib_register(t->attrib,
+				ATT_OP_HANDLE_IND, ch->attr.value_handle,
+				interval_ind_handler, t, NULL);
 	}
 }
 
@@ -1134,63 +1153,12 @@ static const GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
-static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
-								uint16_t len)
-{
-	uint16_t interval;
-
-	if (len < 5) {
-		DBG("Measurement interval value is not provided");
-		return;
-	}
-
-	interval = att_get_u16(&pdu[3]);
-
-	change_property(t, "Interval", &interval);
-}
-
-static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
-{
-	struct thermometer *t = user_data;
-	const struct characteristic *ch;
-	uint8_t *opdu;
-	uint16_t handle, olen;
-	GSList *l;
-	size_t plen;
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
-
-	if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
-		proc_measurement_interval(t, pdu, len);
-
-	opdu = g_attrib_get_buffer(t->attrib, &plen);
-	olen = enc_confirmation(opdu, plen);
-
-	if (olen > 0)
-		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
-}
-
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct thermometer *t = user_data;
 
 	t->attrib = g_attrib_ref(attrib);
 
-	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
-							GATTRIB_ALL_HANDLES,
-							ind_handler, t, NULL);
 	gatt_discover_char(t->attrib, t->svc_range->start, t->svc_range->end,
 					NULL, configure_thermometer_cb, t);
 }
@@ -1201,11 +1169,6 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("GATT Disconnected");
 
-	if (t->attindid > 0) {
-		g_attrib_unregister(t->attrib, t->attindid);
-		t->attindid = 0;
-	}
-
 	if (t->attio_measurement_id > 0) {
 		g_attrib_unregister(t->attrib, t->attio_measurement_id);
 		t->attio_measurement_id = 0;
@@ -1216,6 +1179,11 @@ static void attio_disconnected_cb(gpointer user_data)
 		t->attio_intermediate_id = 0;
 	}
 
+	if (t->attio_interval_id > 0) {
+		g_attrib_unregister(t->attrib, t->attio_interval_id);
+		t->attio_interval_id = 0;
+	}
+
 	g_attrib_unref(t->attrib);
 	t->attrib = NULL;
 }
-- 
1.8.0

