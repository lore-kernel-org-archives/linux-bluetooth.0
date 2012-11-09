Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 08/15] thermometer: Remove storage of all discovered characteristics
Date: Fri, 9 Nov 2012 09:55:50 +0100
Message-ID: <1352451357-22097-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes structures used to keep all discovered characteristics
in thermometer structure. Useful values are already stored directly in
this structure.

characteristic structure is now only used as temporary user data when
discovering descriptors for particular characteristic.
---
 profiles/thermometer/thermometer.c | 138 +++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 73 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 462173d..63d9c1e 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -76,7 +76,6 @@ struct thermometer {
 	guint				attio_intermediate_id;
 	/* attio id for Measurement Interval value indications */
 	guint				attio_interval_id;
-	GSList				*chars;		/* Characteristics */
 	gboolean			intermediate;
 	uint8_t				type;
 	uint16_t			interval;
@@ -91,8 +90,8 @@ struct thermometer {
 };
 
 struct characteristic {
-	struct gatt_char	attr;	/* Characteristic */
 	struct thermometer	*t;	/* Thermometer where the char belongs */
+	char			uuid[MAX_LEN_UUID_STR + 1];
 };
 
 struct watcher {
@@ -158,13 +157,6 @@ static void remove_watcher(gpointer user_data)
 	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 }
 
-static void destroy_char(gpointer user_data)
-{
-	struct characteristic *c = user_data;
-
-	g_free(c);
-}
-
 static void destroy_thermometer(gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -179,9 +171,6 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attrib != NULL)
 		g_attrib_unref(t->attrib);
 
-	if (t->chars != NULL)
-		g_slist_free_full(t->chars, destroy_char);
-
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
 	g_free(t);
@@ -549,7 +538,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 	char *msg;
 
 	if (uuid == GATT_CHARAC_VALID_RANGE_UUID) {
-		if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
+		if (g_strcmp0(ch->uuid, MEASUREMENT_INTERVAL_UUID) == 0)
 			gatt_read_char(ch->t->attrib, handle,
 						valid_range_desc_cb, ch->t);
 		return;
@@ -558,7 +547,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 	if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
 		return;
 
-	if (g_strcmp0(ch->attr.uuid, TEMPERATURE_MEASUREMENT_UUID) == 0) {
+	if (g_strcmp0(ch->uuid, TEMPERATURE_MEASUREMENT_UUID) == 0) {
 		ch->t->measurement_ccc_handle = handle;
 
 		if (g_slist_length(ch->t->tadapter->fwatchers) == 0)
@@ -566,8 +555,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 
 		val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
 		msg = g_strdup("Enable Temperature Measurement indication");
-	} else if (g_strcmp0(ch->attr.uuid,
-					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
+	} else if (g_strcmp0(ch->uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
 		ch->t->intermediate_ccc_handle = handle;
 
 		if (g_slist_length(ch->t->tadapter->iwatchers) == 0)
@@ -575,7 +563,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 
 		val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
 		msg = g_strdup("Enable Intermediate Temperature notification");
-	} else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
+	} else if (g_strcmp0(ch->uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
 		val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
 		msg = g_strdup("Enable Measurement Interval indication");
 	} else {
@@ -591,19 +579,19 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	struct att_data_list *list;
+	struct att_data_list *list = NULL;
 	uint8_t format;
 	int i;
 
 	if (status != 0) {
 		error("Discover all characteristic descriptors failed [%s]: %s",
-					ch->attr.uuid, att_ecode2str(status));
-		return;
+					ch->uuid, att_ecode2str(status));
+		goto done;
 	}
 
 	list = dec_find_info_resp(pdu, len, &format);
 	if (list == NULL)
-		return;
+		goto done;
 
 	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
 		goto done;
@@ -620,14 +608,40 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	}
 
 done:
-	att_data_list_free(list);
+	if (list != NULL)
+		att_data_list_free(list);
+	g_free(ch);
+}
+
+static void discover_desc(struct thermometer *t, struct gatt_char *c,
+						struct gatt_char *c_next)
+{
+	struct characteristic *ch;
+	uint16_t start, end;
+
+	start = c->value_handle + 1;
+
+	if (c_next != NULL) {
+		if (start == c_next->handle)
+			return;
+		end = c_next->handle - 1;
+	} else if (c->value_handle != t->svc_range->end) {
+		end = t->svc_range->end;
+	} else {
+		return;
+	}
+
+	ch = g_new0(struct characteristic, 1);
+	ch->t = t;
+	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
+
+	gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
 }
 
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct characteristic *ch = user_data;
-	struct thermometer *t = ch->t;
+	struct thermometer *t = user_data;
 	uint8_t value[TEMPERATURE_TYPE_SIZE];
 	ssize_t vlen;
 
@@ -655,7 +669,7 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct characteristic *ch = user_data;
+	struct thermometer *t = user_data;
 	uint8_t value[MEASUREMENT_INTERVAL_SIZE];
 	uint16_t interval;
 	ssize_t vlen;
@@ -678,38 +692,41 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 	}
 
 	interval = att_get_u16(&value[0]);
-	change_property(ch->t, "Interval", &interval);
+	change_property(t, "Interval", &interval);
 }
 
-static void process_thermometer_char(struct characteristic *ch)
+static void process_thermometer_char(struct thermometer *t,
+				struct gatt_char *c, struct gatt_char *c_next)
 {
-	struct thermometer *t = ch->t;
-
-	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
+	if (g_strcmp0(c->uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
 		gboolean intermediate = TRUE;
-		change_property(ch->t, "Intermediate", &intermediate);
+		change_property(t, "Intermediate", &intermediate);
 
 		t->attio_intermediate_id = g_attrib_register(t->attrib,
-				ATT_OP_HANDLE_NOTIFY, ch->attr.value_handle,
-				intermediate_notify_handler, t, NULL);
-	} else if (g_strcmp0(ch->attr.uuid,
-					TEMPERATURE_MEASUREMENT_UUID) == 0) {
+					ATT_OP_HANDLE_NOTIFY, c->value_handle,
+					intermediate_notify_handler, t, NULL);
+
+		discover_desc(t, c, c_next);
+	} else if (g_strcmp0(c->uuid, TEMPERATURE_MEASUREMENT_UUID) == 0) {
 
 		t->attio_measurement_id = g_attrib_register(t->attrib,
-				ATT_OP_HANDLE_IND, ch->attr.value_handle,
-				measurement_ind_handler, t, NULL);
-	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0) {
-		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
-							read_temp_type_cb, ch);
-	} else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
-		ch->t->interval_val_handle = ch->attr.value_handle;
+					ATT_OP_HANDLE_IND, c->value_handle,
+					measurement_ind_handler, t, NULL);
 
-		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
-							read_interval_cb, ch);
+		discover_desc(t, c, c_next);
+	} else if (g_strcmp0(c->uuid, TEMPERATURE_TYPE_UUID) == 0) {
+		gatt_read_char(t->attrib, c->value_handle,
+							read_temp_type_cb, t);
+	} else if (g_strcmp0(c->uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
+		gatt_read_char(t->attrib, c->value_handle, read_interval_cb, t);
+
+		t->interval_val_handle = c->value_handle;
 
 		t->attio_interval_id = g_attrib_register(t->attrib,
-				ATT_OP_HANDLE_IND, ch->attr.value_handle,
-				interval_ind_handler, t, NULL);
+					ATT_OP_HANDLE_IND, c->value_handle,
+					interval_ind_handler, t, NULL);
+
+		discover_desc(t, c, c_next);
 	}
 }
 
@@ -727,34 +744,9 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *c = l->data;
-		struct characteristic *ch;
-		uint16_t start, end;
-
-		ch = g_new0(struct characteristic, 1);
-		ch->attr.handle = c->handle;
-		ch->attr.properties = c->properties;
-		ch->attr.value_handle = c->value_handle;
-		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
-		ch->t = t;
-
-		t->chars = g_slist_append(t->chars, ch);
-
-		process_thermometer_char(ch);
-
-		start = c->value_handle + 1;
-
-		if (l->next != NULL) {
-			struct gatt_char *c = l->next->data;
-			if (start == c->handle)
-				continue;
-			end = c->handle - 1;
-		} else if (c->value_handle != t->svc_range->end) {
-			end = t->svc_range->end;
-		} else {
-			continue;
-		}
+		struct gatt_char *c_next = (l->next ? l->next->data : NULL);
 
-		gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
+		process_thermometer_char(t, c, c_next);
 	}
 }
 
-- 
1.8.0

