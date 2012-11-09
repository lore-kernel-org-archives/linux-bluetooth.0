Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 07/15] thermometer: Remove descriptor structure
Date: Fri, 9 Nov 2012 09:55:49 +0100
Message-ID: <1352451357-22097-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes descriptor structure which is now redundant since
useful data are now kept directly in thermometer structure.
---
 profiles/thermometer/thermometer.c | 114 ++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 71 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index b01ac7a..462173d 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -92,16 +92,9 @@ struct thermometer {
 
 struct characteristic {
 	struct gatt_char	attr;	/* Characteristic */
-	GSList			*desc;	/* Descriptors */
 	struct thermometer	*t;	/* Thermometer where the char belongs */
 };
 
-struct descriptor {
-	struct characteristic	*ch;
-	uint16_t		handle;
-	bt_uuid_t		uuid;
-};
-
 struct watcher {
 	struct thermometer_adapter	*tadapter;
 	guint				id;
@@ -169,7 +162,6 @@ static void destroy_char(gpointer user_data)
 {
 	struct characteristic *c = user_data;
 
-	g_slist_free_full(c->desc, g_free);
 	g_free(c);
 }
 
@@ -504,7 +496,7 @@ static void interval_ind_handler(const uint8_t *pdu, uint16_t len,
 static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct descriptor *desc = user_data;
+	struct thermometer *t = user_data;
 	uint8_t value[VALID_RANGE_DESC_SIZE];
 	uint16_t max, min;
 	ssize_t vlen;
@@ -534,8 +526,8 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	change_property(desc->ch->t, "Maximum", &max);
-	change_property(desc->ch->t, "Minimum", &min);
+	change_property(t, "Maximum", &max);
+	change_property(t, "Minimum", &min);
 }
 
 static void write_ccc_cb(guint8 status, const guint8 *pdu,
@@ -549,67 +541,50 @@ static void write_ccc_cb(guint8 status, const guint8 *pdu,
 	g_free(msg);
 }
 
-static void process_thermometer_desc(struct descriptor *desc)
+static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
+								uint16_t handle)
 {
-	struct characteristic *ch = desc->ch;
-	char uuidstr[MAX_LEN_UUID_STR];
-	bt_uuid_t btuuid;
+	uint8_t atval[2];
+	uint16_t val;
+	char *msg;
 
-	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	if (uuid == GATT_CHARAC_VALID_RANGE_UUID) {
+		if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
+			gatt_read_char(ch->t->attrib, handle,
+						valid_range_desc_cb, ch->t);
+		return;
+	}
 
-	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
-		uint8_t atval[2];
-		uint16_t val;
-		char *msg;
+	if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
+		return;
 
-		if (g_strcmp0(ch->attr.uuid,
-					TEMPERATURE_MEASUREMENT_UUID) == 0) {
-			desc->ch->t->measurement_ccc_handle = desc->handle;
+	if (g_strcmp0(ch->attr.uuid, TEMPERATURE_MEASUREMENT_UUID) == 0) {
+		ch->t->measurement_ccc_handle = handle;
 
-			if (g_slist_length(ch->t->tadapter->fwatchers) == 0)
-				return;
+		if (g_slist_length(ch->t->tadapter->fwatchers) == 0)
+			return;
 
-			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
-			msg = g_strdup("Enable Temperature Measurement "
-								"indication");
-		} else if (g_strcmp0(ch->attr.uuid,
+		val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
+		msg = g_strdup("Enable Temperature Measurement indication");
+	} else if (g_strcmp0(ch->attr.uuid,
 					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
-			desc->ch->t->intermediate_ccc_handle = desc->handle;
-
-			if (g_slist_length(ch->t->tadapter->iwatchers) == 0)
-				return;
-
-			val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
-			msg = g_strdup("Enable Intermediate Temperature "
-								"notification");
-		} else if (g_strcmp0(ch->attr.uuid,
-					MEASUREMENT_INTERVAL_UUID) == 0) {
-			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
-			msg = g_strdup("Enable Measurement Interval "
-								"indication");
-		} else {
-			goto done;
-		}
+		ch->t->intermediate_ccc_handle = handle;
 
-		att_put_u16(val, atval);
-		gatt_write_char(ch->t->attrib, desc->handle, atval, 2,
-							write_ccc_cb, msg);
-		return;
-	}
-
-	bt_uuid16_create(&btuuid, GATT_CHARAC_VALID_RANGE_UUID);
+		if (g_slist_length(ch->t->tadapter->iwatchers) == 0)
+			return;
 
-	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 && g_strcmp0(ch->attr.uuid,
-					MEASUREMENT_INTERVAL_UUID) == 0) {
-		gatt_read_char(ch->t->attrib, desc->handle, valid_range_desc_cb,
-									desc);
+		val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
+		msg = g_strdup("Enable Intermediate Temperature notification");
+	} else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
+		val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
+		msg = g_strdup("Enable Measurement Interval indication");
+	} else {
 		return;
 	}
 
-done:
-	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
-	DBG("Ignored descriptor %s in characteristic %s", uuidstr,
-								ch->attr.uuid);
+	att_put_u16(val, atval);
+	gatt_write_char(ch->t->attrib, handle, atval, sizeof(atval),
+							write_ccc_cb, msg);
 }
 
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
@@ -630,24 +605,21 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	if (list == NULL)
 		return;
 
+	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
+		goto done;
+
 	for (i = 0; i < list->num; i++) {
-		struct descriptor *desc;
 		uint8_t *value;
+		uint16_t handle, uuid;
 
 		value = list->data[i];
-		desc = g_new0(struct descriptor, 1);
-		desc->handle = att_get_u16(value);
-		desc->ch = ch;
-
-		if (format == ATT_FIND_INFO_RESP_FMT_16BIT)
-			desc->uuid = att_get_uuid16(&value[2]);
-		else
-			desc->uuid = att_get_uuid128(&value[2]);
+		handle = att_get_u16(value);
+		uuid = att_get_u16(value + 2);
 
-		ch->desc = g_slist_append(ch->desc, desc);
-		process_thermometer_desc(desc);
+		process_thermometer_desc(ch, uuid, handle);
 	}
 
+done:
 	att_data_list_free(list);
 }
 
-- 
1.8.0

