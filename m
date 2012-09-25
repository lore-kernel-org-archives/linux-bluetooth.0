Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 10/14] thermometer: Add common function to write characteristics CCC
Date: Tue, 25 Sep 2012 16:52:39 +0200
Message-ID: <1348584763-22824-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are now few separate functions to write CCC for measurement
characteristics which looks similar. This patch adds common function
to write given value into CCC for given characteristics and leaves
dedicated functions to act only as simple wrappers.
---
 profiles/thermometer/thermometer.c | 108 ++++++++-----------------------------
 1 file changed, 23 insertions(+), 85 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 6f3314a..29d5e02 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -376,7 +376,7 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	change_property(desc->ch->t, "Minimum", &min);
 }
 
-static void measurement_cb(guint8 status, const guint8 *pdu,
+static void write_ccc_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
 	char *msg = user_data;
@@ -426,7 +426,7 @@ static void process_thermometer_desc(struct descriptor *desc)
 
 		att_put_u16(val, atval);
 		gatt_write_char(ch->t->attrib, desc->handle, atval, 2,
-							measurement_cb, msg);
+							write_ccc_cb, msg);
 		return;
 	}
 
@@ -720,9 +720,8 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	return write_attr_interval(t, msg, value);
 }
 
-static void enable_final_measurement(gpointer data, gpointer user_data)
+static void write_ccc(struct thermometer *t, const char *uuid, uint16_t value)
 {
-	struct thermometer *t = data;
 	struct characteristic *ch;
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
@@ -732,116 +731,55 @@ static void enable_final_measurement(gpointer data, gpointer user_data)
 	if (t->attrib == NULL)
 		return;
 
-	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
+	ch = get_characteristic(t, uuid);
 	if (ch == NULL) {
-		DBG("Temperature measurement characteristic not found");
+		DBG("Characteristic %s not found", uuid);
 		return;
 	}
 
 	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	desc = get_descriptor(ch, &btuuid);
 	if (desc == NULL) {
-		DBG("Client characteristic configuration descriptor not found");
+		DBG("CCC descriptor for %s not found", uuid);
 		return;
 	}
 
-	atval[0] = 0x02;
-	atval[1] = 0x00;
-	msg = g_strdup("Enable final measurement");
-	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
+	att_put_u16(value, atval);
+
+	msg = g_strdup_printf("Write CCC: %04x for %s", value, uuid);
+
+	gatt_write_char(t->attrib, desc->handle, atval, sizeof(atval),
+							write_ccc_cb, msg);
 }
 
-static void enable_intermediate_measurement(gpointer data, gpointer user_data)
+static void enable_final_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
-	struct characteristic *ch;
-	struct descriptor *desc;
-	bt_uuid_t btuuid;
-	uint8_t atval[2];
-	char *msg;
-
-	if (t->attrib == NULL || !t->intermediate)
-		return;
 
-	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
-	if (ch == NULL) {
-		DBG("Intermediate measurement characteristic not found");
-		return;
-	}
+	write_ccc(t, TEMPERATURE_MEASUREMENT_UUID,
+					GATT_CLIENT_CHARAC_CFG_IND_BIT);
+}
 
-	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	desc = get_descriptor(ch, &btuuid);
-	if (desc == NULL) {
-		DBG("Client characteristic configuration descriptor not found");
-		return;
-	}
+static void enable_intermediate_measurement(gpointer data, gpointer user_data)
+{
+	struct thermometer *t = data;
 
-	atval[0] = 0x01;
-	atval[1] = 0x00;
-	msg = g_strdup("Enable intermediate measurement");
-	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
+	write_ccc(t, INTERMEDIATE_TEMPERATURE_UUID,
+					GATT_CLIENT_CHARAC_CFG_NOTIF_BIT);
 }
 
 static void disable_final_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
-	struct characteristic *ch;
-	struct descriptor *desc;
-	bt_uuid_t btuuid;
-	uint8_t atval[2];
-	char *msg;
 
-	if (t->attrib == NULL)
-		return;
-
-	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
-	if (ch == NULL) {
-		DBG("Temperature measurement characteristic not found");
-		return;
-	}
-
-	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	desc = get_descriptor(ch, &btuuid);
-	if (desc == NULL) {
-		DBG("Client characteristic configuration descriptor not found");
-		return;
-	}
-
-	atval[0] = 0x00;
-	atval[1] = 0x00;
-	msg = g_strdup("Disable final measurement");
-	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
+	write_ccc(t, TEMPERATURE_MEASUREMENT_UUID, 0x0000);
 }
 
 static void disable_intermediate_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
-	struct characteristic *ch;
-	struct descriptor *desc;
-	bt_uuid_t btuuid;
-	uint8_t atval[2];
-	char *msg;
-
-	if (t->attrib == NULL)
-		return;
-
-	ch = get_characteristic(t, INTERMEDIATE_TEMPERATURE_UUID);
-	if (ch == NULL) {
-		DBG("Intermediate measurement characteristic not found");
-		return;
-	}
-
-	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	desc = get_descriptor(ch, &btuuid);
-	if (desc == NULL) {
-		DBG("Client characteristic configuration descriptor not found");
-		return;
-	}
 
-	atval[0] = 0x00;
-	atval[1] = 0x00;
-	msg = g_strdup("Disable intermediate measurement");
-	gatt_write_char(t->attrib, desc->handle, atval, 2, measurement_cb, msg);
+	write_ccc(t, INTERMEDIATE_TEMPERATURE_UUID, 0x0000);
 }
 
 static void remove_int_watcher(struct thermometer_adapter *tadapter,
-- 
1.7.11.3

