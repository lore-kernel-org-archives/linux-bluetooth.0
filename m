Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 4/5 v2] Use new UUID functions in example GATT server
Date: Fri, 11 Mar 2011 11:30:12 -0300
Message-Id: <1299853813-15753-4-git-send-email-epx@signove.com>
In-Reply-To: <1299853813-15753-1-git-send-email-epx@signove.com>
References: <1299853813-15753-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/example.c |   92 ++++++++++++++++++++++++++++--------------------------
 1 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 395650a..fae288c 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -29,8 +29,7 @@
 
 #include <arpa/inet.h>
 
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -70,36 +69,41 @@ static int register_attributes(void)
 	const char *manufacturer_name2 = "ACME Weighing Scales";
 	const char *serial1 = "237495-3282-A";
 	const char *serial2 = "11267-2327A00239";
-	const unsigned char char_weight_uuid[] = { 0x80, 0x88, 0xF2, 0x18, 0x90,
-		0x2C, 0x45, 0x0B, 0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25,
-		0xE9 };
-	const unsigned char prim_weight_uuid[] = { 0x4F, 0x0A, 0xC0, 0x96, 0x35,
-		0xD4, 0x49, 0x11, 0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE,
-		0xFE };
+
+	const uint128_t char_weight_uuid_btorder = {
+		.data = { 0x80, 0x88, 0xF2, 0x18, 0x90, 0x2C, 0x45, 0x0B,
+			  0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25, 0xE9 } };
+	const uint128_t prim_weight_uuid_btorder = {
+		.data = { 0x4F, 0x0A, 0xC0, 0x96, 0x35, 0xD4, 0x49, 0x11,
+			  0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE, 0xFE } };
+
+	uint128_t char_weight_uuid;
 	uint8_t atval[256];
 	uint32_t handle;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	int len;
 
+	btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
+
 	/* Battery state service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0100, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Battery: battery state characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0110, &atval[1]);
 	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
 	attrib_db_add(0x0106, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Battery: battery state attribute */
-	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
+	bt_uuid16_create(&uuid, BATTERY_STATE_UUID);
 	atval[0] = 0x04;
 	attrib_db_add(0x0110, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Battery: Client Characteristic Configuration */
-	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
 	attrib_db_add(0x0111, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
@@ -110,12 +114,12 @@ static int register_attributes(void)
 		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
 
 	/* Thermometer: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0200, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Thermometer: Include */
-	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	att_put_u16(0x0500, &atval[0]);
 	att_put_u16(0x0504, &atval[2]);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
@@ -128,20 +132,20 @@ static int register_attributes(void)
 	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Thermometer: temperature characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0204, &atval[1]);
 	att_put_u16(TEMPERATURE_UUID, &atval[3]);
 	attrib_db_add(0x0203, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: temperature characteristic value */
-	sdp_uuid16_create(&uuid, TEMPERATURE_UUID);
+	bt_uuid16_create(&uuid, TEMPERATURE_UUID);
 	atval[0] = 0x8A;
 	atval[1] = 0x02;
 	attrib_db_add(0x0204, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Thermometer: temperature characteristic format */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x0E;
 	atval[1] = 0xFE;
 	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
@@ -150,25 +154,25 @@ static int register_attributes(void)
 	attrib_db_add(0x0205, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
 
 	/* Thermometer: characteristic user description */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_temp);
 	strncpy((char *) atval, desc_out_temp, len);
 	attrib_db_add(0x0206, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Thermometer: relative humidity characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0212, &atval[1]);
 	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
 	attrib_db_add(0x0210, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: relative humidity value */
-	sdp_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
+	bt_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
 	atval[0] = 0x27;
 	attrib_db_add(0x0212, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Thermometer: relative humidity characteristic format */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x04;
 	atval[1] = 0x00;
 	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
@@ -177,7 +181,7 @@ static int register_attributes(void)
 	attrib_db_add(0x0213, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Thermometer: characteristic user description */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
 	attrib_db_add(0x0214, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
@@ -188,62 +192,62 @@ static int register_attributes(void)
 		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
 
 	/* Secondary Service: Manufacturer Service */
-	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0500, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0502, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(0x0501, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer name characteristic value */
-	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name1);
 	strncpy((char *) atval, manufacturer_name1, len);
 	attrib_db_add(0x0502, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Manufacturer serial number characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0504, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(0x0503, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer serial number characteristic value */
-	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
 	attrib_db_add(0x0504, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Secondary Service: Manufacturer Service */
-	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0505, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0507, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(0x0506, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Secondary Service: Vendor Specific Service */
-	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0550, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0568, &atval[1]);
 	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
 	attrib_db_add(0x0560, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Vendor Specific Type characteristic value */
-	sdp_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
+	bt_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
 	atval[0] = 0x56;
 	atval[1] = 0x65;
 	atval[2] = 0x6E;
@@ -253,45 +257,45 @@ static int register_attributes(void)
 	attrib_db_add(0x0568, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Manufacturer name attribute */
-	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name2);
 	strncpy((char *) atval, manufacturer_name2, len);
 	attrib_db_add(0x0507, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Characteristic: serial number */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0509, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(0x0508, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Serial number characteristic value */
-	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial2);
 	strncpy((char *) atval, serial2, len);
 	attrib_db_add(0x0509, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Weight service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	memcpy(atval, prim_weight_uuid, 16);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	memcpy(atval, &prim_weight_uuid_btorder, 16);
 	attrib_db_add(0x0680, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
 
 	/* Weight: include */
-	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	att_put_u16(0x0505, &atval[0]);
 	att_put_u16(0x0509, &atval[2]);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
 	attrib_db_add(0x0681, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Weight: characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0683, &atval[1]);
-	memcpy(&atval[3], char_weight_uuid, 16);
+	memcpy(&atval[3], &char_weight_uuid_btorder, 16);
 	attrib_db_add(0x0682, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
 
 	/* Weight: characteristic value */
-	sdp_uuid128_create(&uuid, char_weight_uuid);
+	bt_uuid128_create(&uuid, char_weight_uuid);
 	atval[0] = 0x82;
 	atval[1] = 0x55;
 	atval[2] = 0x00;
@@ -299,7 +303,7 @@ static int register_attributes(void)
 	attrib_db_add(0x0683, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
 
 	/* Weight: characteristic format */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x08;
 	atval[1] = 0xFD;
 	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
@@ -308,7 +312,7 @@ static int register_attributes(void)
 	attrib_db_add(0x0684, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Weight: characteristic user description */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
 	attrib_db_add(0x0685, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
-- 
1.7.1

