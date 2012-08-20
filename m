Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 02/10] gatt: Add Service Changed CCC discovery
Date: Mon, 20 Aug 2012 14:22:47 -0300
Message-Id: <1345483375-27621-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the Client Characteristic discovery of the Service
Changed Changed characteristic.
---
 profiles/gatt/gas.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 01017fe..d36a457 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -43,6 +43,8 @@ struct gas {
 	struct att_range gatt;	/* GATT Primary service range */
 	GAttrib *attrib;
 	guint attioid;
+	guint changed_ind;
+	uint16_t changed_handle;
 };
 
 static GSList *devices = NULL;
@@ -98,6 +100,26 @@ done:
 	att_data_list_free(list);
 }
 
+static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t handle, start, end;
+
+	if (len < 7) { /* 1-byte opcode + 2-byte handle + 4 range */
+		error("Malformed ATT notification");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+	start = att_get_u16(&pdu[3]);
+	end = att_get_u16(&pdu[5]);
+
+	if (handle != gas->changed_handle)
+		return;
+
+	DBG("Service Changed start: 0x%04X end: 0x%04X", start, end);
+}
+
 static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -120,14 +142,76 @@ static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
 	DBG("GATT Service Changed start: 0x%04X end: 0x%04X", start, end);
 }
 
+static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct att_data_list *list;
+	int i;
+	uint8_t format;
+
+	if (status) {
+		error("Discover all GATT characteristic descriptors: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (list == NULL)
+		return;
+
+	if (format != 0x01)
+		goto done;
+
+	for (i = 0; i < list->num; i++) {
+		uint16_t uuid16, ccc;
+		uint8_t *value;
+
+		value = list->data[i];
+		ccc = att_get_u16(value);
+		uuid16 = att_get_u16(&value[2]);
+		DBG("CCC: 0x%04x UUID: 0x%04x", ccc, uuid16);
+	}
+
+done:
+	att_data_list_free(list);
+}
+
+static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct gas *gas = user_data;
+	struct gatt_char *chr;
+	uint16_t start, end;
+
+	if (status) {
+		error("Discover Service Changed handle: %s", att_ecode2str(status));
+		return;
+	}
+
+	chr = characteristics->data;
+
+	start = chr->value_handle + 1;
+	end = gas->gatt.end;
+
+	if (start <= end) {
+		error("Inconsistent database: Service Changed CCC missing");
+		return;
+	}
+
+	gas->changed_handle = chr->value_handle;
+	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct gas *gas = user_data;
-	bt_uuid_t changed_uuid;
 	uint16_t app;
 
 	gas->attrib = g_attrib_ref(attrib);
 
+	gas->changed_ind = g_attrib_register(gas->attrib, ATT_OP_HANDLE_IND,
+						indication_cb, gas, NULL);
+
 	if (device_get_appearance(gas->device, &app) < 0) {
 		bt_uuid_t uuid;
 
@@ -143,18 +227,31 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	/*
 	 * Always read the characteristic value in the first connection
 	 * since attribute handles caching is not supported at the moment.
+	 * When re-connecting <<Service Changed>> handle and characteristic
+	 * value doesn't need to read again: known information from the
+	 * previous interaction.
 	 */
-	bt_uuid16_create(&changed_uuid, GATT_CHARAC_SERVICE_CHANGED);
+	if (gas->changed_handle == 0) {
+		bt_uuid_t uuid;
+
+		bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 
-	gatt_read_char_by_uuid(gas->attrib, gas->gatt.start,
-					gas->gatt.end, &changed_uuid,
-					gatt_service_changed_cb, gas);
+		gatt_read_char_by_uuid(gas->attrib, gas->gatt.start,
+						gas->gatt.end, &uuid,
+						gatt_service_changed_cb, gas);
+
+		gatt_discover_char(gas->attrib, gas->gatt.start, gas->gatt.end,
+					&uuid, gatt_characteristic_cb, gas);
+	}
 }
 
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct gas *gas = user_data;
 
+	g_attrib_unregister(gas->attrib, gas->changed_ind);
+	gas->changed_ind = 0;
+
 	g_attrib_unref(gas->attrib);
 	gas->attrib = NULL;
 }
-- 
1.7.8.6

