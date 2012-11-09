Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 05/15] thermometer: Use dedicated handler for Temperature Measurement
Date: Fri, 9 Nov 2012 09:55:47 +0100
Message-ID: <1352451357-22097-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves Temperature Measurement value indications handler into
separate callback registered for particular handle only.
---
 profiles/thermometer/thermometer.c | 41 +++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 5ed0553..c5fdb94 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -71,6 +71,8 @@ struct thermometer {
 	struct att_range		*svc_range;	/* Thermometer range */
 	guint				attioid;	/* Att watcher id */
 	guint				attindid;	/* Att incications id */
+	/* attio id for Temperature Measurement value indications */
+	guint				attio_measurement_id;
 	/* attio id for Intermediate Temperature value notifications */
 	guint				attio_intermediate_id;
 	GSList				*chars;		/* Characteristics */
@@ -180,6 +182,7 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attindid > 0)
 		g_attrib_unregister(t->attrib, t->attindid);
 
+	g_attrib_unregister(t->attrib, t->attio_measurement_id);
 	g_attrib_unregister(t->attrib, t->attio_intermediate_id);
 
 	if (t->attrib != NULL)
@@ -447,6 +450,29 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 	g_free(m.type);
 }
 
+
+static void measurement_ind_handler(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct thermometer *t = user_data;
+	uint8_t *opdu;
+	uint16_t olen;
+	size_t plen;
+
+	if (len < 3) {
+		DBG("Bad pdu received");
+		return;
+	}
+
+	proc_measurement(t, pdu, len, TRUE);
+
+	opdu = g_attrib_get_buffer(t->attrib, &plen);
+	olen = enc_confirmation(opdu, plen);
+
+	if (olen > 0)
+		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
+}
+
 static void intermediate_notify_handler(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
@@ -679,6 +705,12 @@ static void process_thermometer_char(struct characteristic *ch)
 		t->attio_intermediate_id = g_attrib_register(t->attrib,
 				ATT_OP_HANDLE_NOTIFY, ch->attr.value_handle,
 				intermediate_notify_handler, t, NULL);
+	} else if (g_strcmp0(ch->attr.uuid,
+					TEMPERATURE_MEASUREMENT_UUID) == 0) {
+
+		t->attio_measurement_id = g_attrib_register(t->attrib,
+				ATT_OP_HANDLE_IND, ch->attr.value_handle,
+				measurement_ind_handler, t, NULL);
 	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0) {
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_temp_type_cb, ch);
@@ -1140,9 +1172,7 @@ static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 
 	ch = l->data;
 
-	if (g_strcmp0(ch->attr.uuid, TEMPERATURE_MEASUREMENT_UUID) == 0)
-		proc_measurement(t, pdu, len, TRUE);
-	else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
+	if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
 		proc_measurement_interval(t, pdu, len);
 
 	opdu = g_attrib_get_buffer(t->attrib, &plen);
@@ -1176,6 +1206,11 @@ static void attio_disconnected_cb(gpointer user_data)
 		t->attindid = 0;
 	}
 
+	if (t->attio_measurement_id > 0) {
+		g_attrib_unregister(t->attrib, t->attio_measurement_id);
+		t->attio_measurement_id = 0;
+	}
+
 	if (t->attio_intermediate_id > 0) {
 		g_attrib_unregister(t->attrib, t->attio_intermediate_id);
 		t->attio_intermediate_id = 0;
-- 
1.8.0

