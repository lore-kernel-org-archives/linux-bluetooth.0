Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 19/22] Replace att_put_u16() by put_le16()
Date: Mon, 24 Mar 2014 16:25:40 -0300
Message-Id: <1395689143-11091-20-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c                         | 48 ++++++++++++------------
 attrib/gatt-service.c                |  2 +-
 plugins/gatt-example.c               | 73 ++++++++++++++++++------------------
 profiles/cyclingspeed/cyclingspeed.c | 10 ++---
 profiles/gatt/gas.c                  |  2 +-
 profiles/heartrate/heartrate.c       |  8 ++--
 profiles/proximity/reporter.c        |  7 ++--
 profiles/scanparam/scan.c            |  6 +--
 profiles/thermometer/thermometer.c   | 12 +++---
 profiles/time/server.c               |  3 +-
 src/attrib-server.c                  | 26 ++++++-------
 11 files changed, 100 insertions(+), 97 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index bdf7c00..8e9c06d 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -161,9 +161,9 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_BY_GROUP_REQ;
 	/* Starting Handle (2 octets) */
-	att_put_u16(start, &pdu[1]);
+	put_le16(start, &pdu[1]);
 	/* Ending Handle (2 octets) */
-	att_put_u16(end, &pdu[3]);
+	put_le16(end, &pdu[3]);
 	/* Attribute Group Type (2 or 16 octet UUID) */
 	put_uuid_le(uuid, &pdu[5]);
 
@@ -291,8 +291,8 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 		vlen = len - min_len;
 
 	pdu[0] = ATT_OP_FIND_BY_TYPE_REQ;
-	att_put_u16(start, &pdu[1]);
-	att_put_u16(end, &pdu[3]);
+	put_le16(start, &pdu[1]);
+	put_le16(end, &pdu[3]);
 	put_le16(uuid->value.u16, &pdu[5]);
 
 	if (vlen > 0) {
@@ -347,8 +347,8 @@ uint16_t enc_find_by_type_resp(GSList *matches, uint8_t *pdu, size_t len)
 				l = l->next, offset += sizeof(uint16_t) * 2) {
 		struct att_range *range = l->data;
 
-		att_put_u16(range->start, &pdu[offset]);
-		att_put_u16(range->end, &pdu[offset + 2]);
+		put_le16(range->start, &pdu[offset]);
+		put_le16(range->end, &pdu[offset + 2]);
 	}
 
 	return offset;
@@ -406,9 +406,9 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_BY_TYPE_REQ;
 	/* Starting Handle (2 octets) */
-	att_put_u16(start, &pdu[1]);
+	put_le16(start, &pdu[1]);
 	/* Ending Handle (2 octets) */
-	att_put_u16(end, &pdu[3]);
+	put_le16(end, &pdu[3]);
 	/* Attribute Type (2 or 16 octet UUID) */
 	put_uuid_le(uuid, &pdu[5]);
 
@@ -527,7 +527,7 @@ uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, size_t vlen,
 		vlen = len - min_len;
 
 	pdu[0] = ATT_OP_WRITE_CMD;
-	att_put_u16(handle, &pdu[1]);
+	put_le16(handle, &pdu[1]);
 
 	if (vlen > 0) {
 		memcpy(&pdu[3], value, vlen);
@@ -573,7 +573,7 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
 		vlen = len - min_len;
 
 	pdu[0] = ATT_OP_WRITE_REQ;
-	att_put_u16(handle, &pdu[1]);
+	put_le16(handle, &pdu[1]);
 
 	if (vlen > 0) {
 		memcpy(&pdu[3], value, vlen);
@@ -637,7 +637,7 @@ uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, size_t len)
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_REQ;
 	/* Attribute Handle (2 octets) */
-	att_put_u16(handle, &pdu[1]);
+	put_le16(handle, &pdu[1]);
 
 	return 3;
 }
@@ -651,9 +651,9 @@ uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_BLOB_REQ;
 	/* Attribute Handle (2 octets) */
-	att_put_u16(handle, &pdu[1]);
+	put_le16(handle, &pdu[1]);
 	/* Value Offset (2 octets) */
-	att_put_u16(offset, &pdu[3]);
+	put_le16(offset, &pdu[3]);
 
 	return 5;
 }
@@ -769,7 +769,7 @@ uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 	/* Request Opcode In Error (1 octet) */
 	pdu[1] = opcode;
 	/* Attribute Handle In Error (2 octets) */
-	att_put_u16(handle, &pdu[2]);
+	put_le16(handle, &pdu[2]);
 	/* Error Code (1 octet) */
 	pdu[4] = status;
 
@@ -785,9 +785,9 @@ uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu,
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_FIND_INFO_REQ;
 	/* Starting Handle (2 octets) */
-	att_put_u16(start, &pdu[1]);
+	put_le16(start, &pdu[1]);
 	/* Ending Handle (2 octets) */
-	att_put_u16(end, &pdu[3]);
+	put_le16(end, &pdu[3]);
 
 	return 5;
 }
@@ -895,7 +895,7 @@ uint16_t enc_notification(uint16_t handle, uint8_t *value, size_t vlen,
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_NOTIFY;
-	att_put_u16(handle, &pdu[1]);
+	put_le16(handle, &pdu[1]);
 	memcpy(&pdu[3], value, vlen);
 
 	return vlen + min_len;
@@ -913,7 +913,7 @@ uint16_t enc_indication(uint16_t handle, uint8_t *value, size_t vlen,
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_IND;
-	att_put_u16(handle, &pdu[1]);
+	put_le16(handle, &pdu[1]);
 	memcpy(&pdu[3], value, vlen);
 
 	return vlen + min_len;
@@ -963,7 +963,7 @@ uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, size_t len)
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_MTU_REQ;
 	/* Client Rx MTU (2 octets) */
-	att_put_u16(mtu, &pdu[1]);
+	put_le16(mtu, &pdu[1]);
 
 	return 3;
 }
@@ -997,7 +997,7 @@ uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, size_t len)
 	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_MTU_RESP;
 	/* Server Rx MTU (2 octets) */
-	att_put_u16(mtu, &pdu[1]);
+	put_le16(mtu, &pdu[1]);
 
 	return 3;
 }
@@ -1037,8 +1037,8 @@ uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
 		vlen = len - min_len;
 
 	pdu[0] = ATT_OP_PREP_WRITE_REQ;
-	att_put_u16(handle, &pdu[1]);
-	att_put_u16(offset, &pdu[3]);
+	put_le16(handle, &pdu[1]);
+	put_le16(offset, &pdu[3]);
 
 	if (vlen > 0) {
 		memcpy(&pdu[5], value, vlen);
@@ -1090,8 +1090,8 @@ uint16_t enc_prep_write_resp(uint16_t handle, uint16_t offset,
 		vlen = len - min_len;
 
 	pdu[0] = ATT_OP_PREP_WRITE_RESP;
-	att_put_u16(handle, &pdu[1]);
-	att_put_u16(offset, &pdu[3]);
+	put_le16(handle, &pdu[1]);
+	put_le16(offset, &pdu[3]);
 
 	if (vlen > 0) {
 		memcpy(&pdu[5], value, vlen);
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 699ac1e..d68e8b9 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -232,7 +232,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	/* characteristic declaration */
 	bt_uuid16_create(&bt_uuid, GATT_CHARAC_UUID);
 	atval[0] = info->props;
-	att_put_u16(h + 1, &atval[1]);
+	put_le16(h + 1, &atval[1]);
 	put_uuid_le(&info->uuid, &atval[3]);
 	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
 				atval, 3 + info->uuid.type / 8) == NULL)
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index d710917..22a6925 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -33,6 +33,7 @@
 #include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/hcid.h"
+#include "src/shared/util.h"
 #include "src/log.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt-service.h"
@@ -149,7 +150,7 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 
 	/* Thermometer: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
+	put_le16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
 
@@ -157,18 +158,18 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 
 	/* Thermometer: Include */
 	if (manuf1[0] && manuf1[1]) {
-		att_put_u16(manuf1[0], &atval[0]);
-		att_put_u16(manuf1[1], &atval[2]);
-		att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
+		put_le16(manuf1[0], &atval[0]);
+		put_le16(manuf1[1], &atval[2]);
+		put_le16(MANUFACTURER_SVC_UUID, &atval[4]);
 		attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
 						ATT_NOT_PERMITTED, atval, 6);
 	}
 
 	/* Thermometer: Include */
 	if (manuf2[0] && manuf2[1]) {
-		att_put_u16(manuf2[0], &atval[0]);
-		att_put_u16(manuf2[1], &atval[2]);
-		att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
+		put_le16(manuf2[0], &atval[0]);
+		put_le16(manuf2[1], &atval[2]);
+		put_le16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
 		attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
 						ATT_NOT_PERMITTED, atval, 6);
 	}
@@ -176,8 +177,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	/* Thermometer: temperature characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(TEMPERATURE_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(TEMPERATURE_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -192,9 +193,9 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x0E;
 	atval[1] = 0xFE;
-	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
+	put_le16(FMT_CELSIUS_UUID, &atval[2]);
 	atval[4] = 0x01;
-	att_put_u16(FMT_OUTSIDE_UUID, &atval[5]);
+	put_le16(FMT_OUTSIDE_UUID, &atval[5]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 7);
 
@@ -208,8 +209,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	/* Thermometer: relative humidity characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(RELATIVE_HUMIDITY_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -223,9 +224,9 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x04;
 	atval[1] = 0x00;
-	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
-	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
-	att_put_u16(FMT_OUTSIDE_UUID, &atval[6]);
+	put_le16(FMT_PERCENT_UUID, &atval[2]);
+	put_le16(BLUETOOTH_SIG_UUID, &atval[4]);
+	put_le16(FMT_OUTSIDE_UUID, &atval[6]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 8);
 
@@ -270,15 +271,15 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 
 	/* Secondary Service: Manufacturer Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
-	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
+	put_le16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -292,8 +293,8 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 	/* Manufacturer serial number characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -334,15 +335,15 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 
 	/* Secondary Service: Manufacturer Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
-	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
+	put_le16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -356,8 +357,8 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 	/* Characteristic: serial number */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -395,15 +396,15 @@ static void register_vendor_service(struct gatt_example_adapter *adapter,
 
 	/* Secondary Service: Vendor Specific Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
-	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
+	put_le16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -465,9 +466,9 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	if (vendor[0] && vendor[1]) {
 		/* Weight: include */
 		bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
-		att_put_u16(vendor[0], &atval[0]);
-		att_put_u16(vendor[1], &atval[2]);
-		att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
+		put_le16(vendor[0], &atval[0]);
+		put_le16(vendor[1], &atval[2]);
+		put_le16(MANUFACTURER_SVC_UUID, &atval[4]);
 		attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
 						ATT_NOT_PERMITTED, atval, 6);
 	}
@@ -475,7 +476,7 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	/* Weight: characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(h + 1, &atval[1]);
+	put_le16(h + 1, &atval[1]);
 	memcpy(&atval[3], &char_weight_uuid_btorder, 16);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 19);
@@ -493,9 +494,9 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x08;
 	atval[1] = 0xFD;
-	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
-	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
-	att_put_u16(FMT_HANGING_UUID, &atval[6]);
+	put_le16(FMT_KILOGRAM_UUID, &atval[2]);
+	put_le16(BLUETOOTH_SIG_UUID, &atval[4]);
+	put_le16(FMT_HANGING_UUID, &atval[6]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 8);
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 63e969a..2f80bca 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -457,16 +457,16 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 			ch->csc->measurement_ccc_handle = handle;
 
 			if (g_slist_length(ch->csc->cadapter->watchers) == 0) {
-				att_put_u16(0x0000, attr_val);
+				put_le16(0x0000, attr_val);
 				msg = g_strdup("Disable measurement");
 			} else {
-				att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
+				put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
 								attr_val);
 				msg = g_strdup("Enable measurement");
 			}
 
 		} else if (g_strcmp0(ch->uuid, SC_CONTROL_POINT_UUID) == 0) {
-			att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, attr_val);
+			put_le16(GATT_CLIENT_CHARAC_CFG_IND_BIT, attr_val);
 			msg = g_strdup("Enable SC Control Point indications");
 		} else {
 			break;
@@ -817,7 +817,7 @@ static void enable_measurement(gpointer data, gpointer user_data)
 	if (csc->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 	msg = g_strdup("Enable measurement");
 
 	gatt_write_char(csc->attrib, handle, value, sizeof(value),
@@ -834,7 +834,7 @@ static void disable_measurement(gpointer data, gpointer user_data)
 	if (csc->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(0x0000, value);
+	put_le16(0x0000, value);
 	msg = g_strdup("Disable measurement");
 
 	gatt_write_char(csc->attrib, handle, value, sizeof(value),
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 38f5e72..7a9d34e 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -233,7 +233,7 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
 {
 	uint8_t value[2];
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
+	put_le16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
 	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
 								user_data);
 }
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 15ccdfd..1dcbdf4 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -428,10 +428,10 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 		hr->measurement_ccc_handle = handle;
 
 		if (g_slist_length(hr->hradapter->watchers) == 0) {
-			att_put_u16(0x0000, attr_val);
+			put_le16(0x0000, attr_val);
 			msg = g_strdup("Disable measurement");
 		} else {
-			att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, attr_val);
+			put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, attr_val);
 			msg = g_strdup("Enable measurement");
 		}
 
@@ -511,7 +511,7 @@ static void enable_measurement(gpointer data, gpointer user_data)
 	if (hr->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 	msg = g_strdup("Enable measurement");
 
 	gatt_write_char(hr->attrib, handle, value, sizeof(value),
@@ -528,7 +528,7 @@ static void disable_measurement(gpointer data, gpointer user_data)
 	if (hr->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(0x0000, value);
+	put_le16(0x0000, value);
 	msg = g_strdup("Disable measurement");
 
 	gatt_write_char(hr->attrib, handle, value, sizeof(value),
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index bda993d..5861923 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -43,6 +43,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/util.h"
 #include "src/hcid.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -117,14 +118,14 @@ static void register_tx_power(struct btd_adapter *adapter)
 
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(TX_POWER_SVC_UUID, &atval[0]);
+	put_le16(TX_POWER_SVC_UUID, &atval[0]);
 	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Power level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(POWER_LEVEL_CHR_UUID, &atval[3]);
+	put_le16(h + 1, &atval[1]);
+	put_le16(POWER_LEVEL_CHR_UUID, &atval[3]);
 	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Power level value */
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index d6e477e..156682f 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -67,8 +67,8 @@ static void write_scan_params(GAttrib *attrib, uint16_t handle)
 {
 	uint8_t value[4];
 
-	att_put_u16(SCAN_INTERVAL, &value[0]);
-	att_put_u16(SCAN_WINDOW, &value[2]);
+	put_le16(SCAN_INTERVAL, &value[0]);
+	put_le16(SCAN_WINDOW, &value[2]);
 
 	gatt_write_cmd(attrib, handle, value, sizeof(value), NULL, NULL);
 }
@@ -126,7 +126,7 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 	if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
 		goto done;
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 	gatt_write_char(scan->attrib, handle, value, sizeof(value),
 						ccc_written_cb, user_data);
 done:
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 5b90792..9462cc9 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -569,7 +569,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 		return;
 	}
 
-	att_put_u16(val, atval);
+	put_le16(val, atval);
 	gatt_write_char(ch->t->attrib, handle, atval, sizeof(atval),
 							write_ccc_cb, msg);
 }
@@ -790,7 +790,7 @@ static void enable_final_measurement(gpointer data, gpointer user_data)
 	if (t->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
+	put_le16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
 	msg = g_strdup("Enable Temperature Measurement indications");
 
 	gatt_write_char(t->attrib, handle, value, sizeof(value),
@@ -807,7 +807,7 @@ static void enable_intermediate_measurement(gpointer data, gpointer user_data)
 	if (t->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 	msg = g_strdup("Enable Intermediate Temperature notifications");
 
 	gatt_write_char(t->attrib, handle, value, sizeof(value),
@@ -824,7 +824,7 @@ static void disable_final_measurement(gpointer data, gpointer user_data)
 	if (t->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(0x0000, value);
+	put_le16(0x0000, value);
 	msg = g_strdup("Disable Temperature Measurement indications");
 
 	gatt_write_char(t->attrib, handle, value, sizeof(value),
@@ -841,7 +841,7 @@ static void disable_intermediate_measurement(gpointer data, gpointer user_data)
 	if (t->attrib == NULL || !handle)
 		return;
 
-	att_put_u16(0x0000, value);
+	put_le16(0x0000, value);
 	msg = g_strdup("Disable Intermediate Temperature notifications");
 
 	gatt_write_char(t->attrib, handle, value, sizeof(value),
@@ -1071,7 +1071,7 @@ static void property_set_interval(const GDBusPropertyTable *property,
 		return;
 	}
 
-	att_put_u16(val, &atval[0]);
+	put_le16(val, &atval[0]);
 
 	interval_data = g_new0(struct tmp_interval_data, 1);
 	interval_data->thermometer = t;
diff --git a/profiles/time/server.c b/profiles/time/server.c
index 142d15c..31ddb06 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -41,6 +41,7 @@
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 #include "attrib/att-database.h"
+#include "src/shared/util.h"
 #include "src/attrib-server.h"
 #include "attrib/gatt-service.h"
 #include "src/log.h"
@@ -90,7 +91,7 @@ static int encode_current_time(uint8_t value[10])
 		return -EINVAL;
 	}
 
-	att_put_u16(1900 + tm.tm_year, &value[0]); /* Year */
+	put_le16(1900 + tm.tm_year, &value[0]); /* Year */
 	value[2] = tm.tm_mon + 1; /* Month */
 	value[3] = tm.tm_mday; /* Day */
 	value[4] = tm.tm_hour; /* Hours */
diff --git a/src/attrib-server.c b/src/attrib-server.c
index cb27315..953a3f2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -513,8 +513,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 		value = (void *) adl->data[i];
 
-		att_put_u16(cur->handle, value);
-		att_put_u16(cur->end, &value[2]);
+		put_le16(cur->handle, value);
+		put_le16(cur->end, &value[2]);
 		/* Attribute Value */
 		memcpy(&value[4], cur->data, cur->len);
 	}
@@ -602,7 +602,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 
 		value = (void *) adl->data[i];
 
-		att_put_u16(a->handle, value);
+		put_le16(a->handle, value);
 
 		/* Attribute Value */
 		memcpy(&value[2], a->data, a->len);
@@ -682,7 +682,7 @@ static uint16_t find_info(struct gatt_channel *channel, uint16_t start,
 
 		value = (void *) adl->data[i];
 
-		att_put_u16(a->handle, value);
+		put_le16(a->handle, value);
 
 		/* Attribute Value */
 		put_uuid_le(&a->uuid, &value[2]);
@@ -811,7 +811,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 		read_device_ccc(channel->device, handle, &cccval) == 0) {
 		uint8_t config[2];
 
-		att_put_u16(cccval, config);
+		put_le16(cccval, config);
 		return enc_read_resp(config, sizeof(config), pdu, len);
 	}
 
@@ -852,7 +852,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 		read_device_ccc(channel->device, handle, &cccval) == 0) {
 		uint8_t config[2];
 
-		att_put_u16(cccval, config);
+		put_le16(cccval, config);
 		return enc_read_blob_resp(config, sizeof(config), offset,
 								pdu, len);
 	}
@@ -1299,7 +1299,7 @@ static gboolean register_core_services(struct gatt_server *server)
 
 	/* GAP service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
+	put_le16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
 	attrib_db_add_new(server, 0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
 
@@ -1307,8 +1307,8 @@ static gboolean register_core_services(struct gatt_server *server)
 	server->name_handle = 0x0006;
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(server->name_handle, &atval[1]);
-	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
+	put_le16(server->name_handle, &atval[1]);
+	put_le16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
 	attrib_db_add_new(server, 0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
@@ -1321,14 +1321,14 @@ static gboolean register_core_services(struct gatt_server *server)
 	server->appearance_handle = 0x0008;
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(server->appearance_handle, &atval[1]);
-	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
+	put_le16(server->appearance_handle, &atval[1]);
+	put_le16(GATT_CHARAC_APPEARANCE, &atval[3]);
 	attrib_db_add_new(server, 0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
 	/* GAP service: device appearance attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
-	att_put_u16(appearance, &atval[0]);
+	put_le16(appearance, &atval[0]);
 	attrib_db_add_new(server, server->appearance_handle, &uuid, ATT_NONE,
 						ATT_NOT_PERMITTED, atval, 2);
 	server->gap_sdp_handle = attrib_create_sdp_new(server, 0x0001,
@@ -1340,7 +1340,7 @@ static gboolean register_core_services(struct gatt_server *server)
 
 	/* GATT service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
+	put_le16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
 	attrib_db_add_new(server, 0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
 
-- 
1.8.3.1

