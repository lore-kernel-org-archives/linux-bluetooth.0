Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 02/15] thermometer: Store Intermediate Temperature CCC handle in struct
Date: Fri, 9 Nov 2012 09:55:44 +0100
Message-ID: <1352451357-22097-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Intermediate Measurement CCC handle value directly into
thermometer struct. This way there's no need to traverse nested lists
looking for value.

write_ccc() function and related helpers are now unused so can be
removed.
---
 profiles/thermometer/thermometer.c | 80 ++++++++++++--------------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 3ea6e96..d836462 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -82,6 +82,7 @@ struct thermometer {
 	gboolean			has_interval;
 
 	uint16_t			measurement_ccc_handle;
+	uint16_t			intermediate_ccc_handle;
 };
 
 struct characteristic {
@@ -255,14 +256,6 @@ static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
 	return ch->attr.value_handle - *handle;
 }
 
-static gint cmp_descriptor(gconstpointer a, gconstpointer b)
-{
-	const struct descriptor *desc = a;
-	const bt_uuid_t *uuid = b;
-
-	return bt_uuid_cmp(&desc->uuid, uuid);
-}
-
 static struct thermometer_adapter *
 find_thermometer_adapter(struct btd_adapter *adapter)
 {
@@ -286,18 +279,6 @@ static struct characteristic *get_characteristic(struct thermometer *t,
 	return l->data;
 }
 
-static struct descriptor *get_descriptor(struct characteristic *ch,
-							const bt_uuid_t *uuid)
-{
-	GSList *l;
-
-	l = g_slist_find_custom(ch->desc, uuid, cmp_descriptor);
-	if (l == NULL)
-		return NULL;
-
-	return l->data;
-}
-
 static void change_property(struct thermometer *t, const char *name,
 							gpointer value) {
 	if (g_strcmp0(name, "Intermediate") == 0) {
@@ -415,6 +396,8 @@ static void process_thermometer_desc(struct descriptor *desc)
 								"indication");
 		} else if (g_strcmp0(ch->attr.uuid,
 					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
+			desc->ch->t->intermediate_ccc_handle = desc->handle;
+
 			if (g_slist_length(ch->t->tadapter->iwatchers) == 0)
 				return;
 
@@ -728,38 +711,6 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	return write_attr_interval(t, msg, value);
 }
 
-static void write_ccc(struct thermometer *t, const char *uuid, uint16_t value)
-{
-	struct characteristic *ch;
-	struct descriptor *desc;
-	bt_uuid_t btuuid;
-	uint8_t atval[2];
-	char *msg;
-
-	if (t->attrib == NULL)
-		return;
-
-	ch = get_characteristic(t, uuid);
-	if (ch == NULL) {
-		DBG("Characteristic %s not found", uuid);
-		return;
-	}
-
-	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	desc = get_descriptor(ch, &btuuid);
-	if (desc == NULL) {
-		DBG("CCC descriptor for %s not found", uuid);
-		return;
-	}
-
-	att_put_u16(value, atval);
-
-	msg = g_strdup_printf("Write CCC: %04x for %s", value, uuid);
-
-	gatt_write_char(t->attrib, desc->handle, atval, sizeof(atval),
-							write_ccc_cb, msg);
-}
-
 static void enable_final_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
@@ -780,9 +731,18 @@ static void enable_final_measurement(gpointer data, gpointer user_data)
 static void enable_intermediate_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
+	uint16_t handle = t->intermediate_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (t->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	msg = g_strdup("Enable Intermediate Temperature notifications");
 
-	write_ccc(t, INTERMEDIATE_TEMPERATURE_UUID,
-					GATT_CLIENT_CHARAC_CFG_NOTIF_BIT);
+	gatt_write_char(t->attrib, handle, value, sizeof(value),
+							write_ccc_cb, msg);
 }
 
 static void disable_final_measurement(gpointer data, gpointer user_data)
@@ -805,8 +765,18 @@ static void disable_final_measurement(gpointer data, gpointer user_data)
 static void disable_intermediate_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
+	uint16_t handle = t->intermediate_ccc_handle;
+	uint8_t value[2];
+	char *msg;
 
-	write_ccc(t, INTERMEDIATE_TEMPERATURE_UUID, 0x0000);
+	if (t->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(0x0000, value);
+	msg = g_strdup("Disable Intermediate Temperature notifications");
+
+	gatt_write_char(t->attrib, handle, value, sizeof(value),
+							write_ccc_cb, msg);
 }
 
 static void remove_int_watcher(struct thermometer_adapter *tadapter,
-- 
1.8.0

