Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 5/5] gas: Add the per handle GATT event notifier
Date: Wed, 10 Oct 2012 20:55:57 -0300
Message-Id: <1349913357-25547-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/gatt/gas.c | 72 +++++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index bb626e7..793a3af 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -166,39 +166,10 @@ done:
 	att_data_list_free(list);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gas *gas = user_data;
-
-	if (status) {
-		error("Write Service Changed CCC failed: %s",
-						att_ecode2str(status));
-		return;
-	}
-
-	DBG("Service Changed indications enabled");
-
-	write_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
-					device_get_address(gas->device),
-					device_get_addr_type(gas->device),
-					GATT_CHARAC_SERVICE_CHANGED,
-					gas->changed_handle);
-}
-
-static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
-{
-	uint8_t value[2];
-
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
-	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
-								user_data);
-}
-
 static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	struct gas *gas = user_data;
-	uint16_t handle, start, end, olen;
+	uint16_t start, end, olen;
 	size_t plen;
 	uint8_t *opdu;
 
@@ -207,13 +178,9 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 		return;
 	}
 
-	handle = att_get_u16(&pdu[1]);
 	start = att_get_u16(&pdu[3]);
 	end = att_get_u16(&pdu[5]);
 
-	if (handle != gas->changed_handle)
-		return;
-
 	DBG("Service Changed start: 0x%04X end: 0x%04X", start, end);
 
 	if (device_is_bonded(gas->device) == FALSE) {
@@ -229,6 +196,39 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
+static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gas *gas = user_data;
+
+	if (status) {
+		error("Write Service Changed CCC failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	DBG("Service Changed indications enabled");
+
+	gas->changed_ind = g_attrib_register(gas->attrib, ATT_OP_HANDLE_IND,
+						gas->changed_handle,
+						indication_cb, gas, NULL);
+
+	write_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
+					device_get_address(gas->device),
+					device_get_addr_type(gas->device),
+					GATT_CHARAC_SERVICE_CHANGED,
+					gas->changed_handle);
+}
+
+static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
+{
+	uint8_t value[2];
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
+	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
+								user_data);
+}
+
 static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -333,10 +333,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		DBG("MTU Exchange: Requesting %d", imtu);
 	}
 
-	gas->changed_ind = g_attrib_register(gas->attrib, ATT_OP_HANDLE_IND,
-						GATTRIB_ALL_HANDLES,
-						indication_cb, gas, NULL);
-
 	if (device_get_appearance(gas->device, &app) < 0) {
 		bt_uuid_t uuid;
 
-- 
1.7.12.3

