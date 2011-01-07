Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/3] Refactor example server to use att_put_u16()
Date: Fri,  7 Jan 2011 16:12:11 -0400
Message-Id: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The original code was written before att_put_u16() was implemented.
---
 attrib/example.c |  162 +++++++++++++++---------------------------------------
 1 files changed, 45 insertions(+), 117 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 6987fac..f28068a 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -78,23 +78,17 @@ static int register_attributes(void)
 	uint8_t atval[256];
 	uuid_t uuid;
 	int len;
-	uint16_t u16;
 
 	/* GAP service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	u16 = htons(GENERIC_ACCESS_PROFILE_ID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
 	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* GAP service: device name characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(GATT_CHARAC_DEVICE_NAME);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x06;
-	atval[2] = 0x00;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0006, &atval[1]);
+	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
 	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device name attribute */
@@ -105,19 +99,14 @@ static int register_attributes(void)
 
 	/* GATT service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	u16 = htons(GENERIC_ATTRIB_PROFILE_ID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
 	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* GATT service: attributes opcodes characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(OPCODES_SUPPORTED_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x12;
-	atval[2] = 0x00;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0012, &atval[1]);
+	att_put_u16(OPCODES_SUPPORTED_UUID, &atval[3]);
 	attrib_db_add(0x0011, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* GATT service: attribute opcodes supported */
@@ -128,19 +117,14 @@ static int register_attributes(void)
 
 	/* Battery state service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	u16 = htons(BATTERY_STATE_SVC_UUID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0100, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Battery: battery state characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(BATTERY_STATE_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x10;
-	atval[2] = 0x01;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0110, &atval[1]);
+	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
 	attrib_db_add(0x0106, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Battery: battery state attribute */
@@ -156,37 +140,26 @@ static int register_attributes(void)
 
 	/* Thermometer: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	u16 = htons(THERM_HUMIDITY_SVC_UUID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0200, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Thermometer: Include */
 	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
-	u16 = htons(MANUFACTURER_SVC_UUID);
-	atval[0] = 0x00;
-	atval[1] = 0x05;
-	atval[2] = 0x04;
-	atval[3] = 0x05;
-	atval[4] = u16 >> 8;
-	atval[5] = u16;
+	att_put_u16(0x0500, &atval[0]);
+	att_put_u16(0x0504, &atval[2]);
+	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
 	attrib_db_add(0x0201, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Thermometer: Include */
-	atval[0] = 0x50;
-	atval[1] = 0x05;
-	atval[2] = 0x68;
-	atval[3] = 0x05;
+	att_put_u16(0x0550, &atval[0]);
+	att_put_u16(0x0568, &atval[2]);
 	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
 
 	/* Thermometer: temperature characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(TEMPERATURE_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x04;
-	atval[2] = 0x02;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0204, &atval[1]);
+	att_put_u16(TEMPERATURE_UUID, &atval[3]);
 	attrib_db_add(0x0203, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: temperature characteristic value */
@@ -197,15 +170,11 @@ static int register_attributes(void)
 
 	/* Thermometer: temperature characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
-	u16 = htons(FMT_CELSIUS_UUID);
 	atval[0] = 0x0E;
 	atval[1] = 0xFE;
-	atval[2] = u16 >> 8;
-	atval[3] = u16;
+	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
 	atval[4] = 0x01;
-	u16 = htons(FMT_OUTSIDE_UUID);
-	atval[5] = u16 >> 8;
-	atval[6] = u16;
+	att_put_u16(FMT_OUTSIDE_UUID, &atval[5]);
 	attrib_db_add(0x0205, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
 
 	/* Thermometer: characteristic user description */
@@ -216,12 +185,9 @@ static int register_attributes(void)
 
 	/* Thermometer: relative humidity characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(RELATIVE_HUMIDITY_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x12;
-	atval[2] = 0x02;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0212, &atval[1]);
+	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
 	attrib_db_add(0x0210, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: relative humidity value */
@@ -231,17 +197,11 @@ static int register_attributes(void)
 
 	/* Thermometer: relative humidity characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
-	u16 = htons(FMT_PERCENT_UUID);
 	atval[0] = 0x04;
 	atval[1] = 0x00;
-	atval[2] = u16 >> 8;
-	atval[3] = u16;
-	u16 = htons(BLUETOOTH_SIG_UUID);
-	atval[4] = u16 >> 8;
-	atval[5] = u16;
-	u16 = htons(FMT_OUTSIDE_UUID);
-	atval[6] = u16 >> 8;
-	atval[7] = u16;
+	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
+	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
+	att_put_u16(FMT_OUTSIDE_UUID, &atval[6]);
 	attrib_db_add(0x0213, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Thermometer: characteristic user description */
@@ -252,19 +212,14 @@ static int register_attributes(void)
 
 	/* Secondary Service: Manufacturer Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
-	u16 = htons(MANUFACTURER_SVC_UUID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0500, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(MANUFACTURER_NAME_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x02;
-	atval[2] = 0x05;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0502, &atval[1]);
+	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(0x0501, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer name characteristic value */
@@ -275,12 +230,9 @@ static int register_attributes(void)
 
 	/* Manufacturer serial number characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(MANUFACTURER_SERIAL_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x04;
-	atval[2] = 0x05;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0504, &atval[1]);
+	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(0x0503, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer serial number characteristic value */
@@ -291,36 +243,26 @@ static int register_attributes(void)
 
 	/* Secondary Service: Manufacturer Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
-	u16 = htons(MANUFACTURER_SVC_UUID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0505, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(MANUFACTURER_NAME_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x07;
-	atval[2] = 0x05;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0507, &atval[1]);
+	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(0x0506, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Secondary Service: Vendor Specific Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
-	u16 = htons(VENDOR_SPECIFIC_SVC_UUID);
-	atval[0] = u16 >> 8;
-	atval[1] = u16;
+	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0550, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(VENDOR_SPECIFIC_TYPE_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x68;
-	atval[2] = 0x05;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0568, &atval[1]);
+	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
 	attrib_db_add(0x0560, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Vendor Specific Type characteristic value */
@@ -341,12 +283,9 @@ static int register_attributes(void)
 
 	/* Characteristic: serial number */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	u16 = htons(MANUFACTURER_SERIAL_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x09;
-	atval[2] = 0x05;
-	atval[3] = u16 >> 8;
-	atval[4] = u16;
+	att_put_u16(0x0509, &atval[1]);
+	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(0x0508, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Serial number characteristic value */
@@ -362,21 +301,16 @@ static int register_attributes(void)
 
 	/* Weight: include */
 	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
-	u16 = htons(MANUFACTURER_SVC_UUID);
-	atval[0] = 0x05;
-	atval[1] = 0x05;
-	atval[2] = 0x09;
-	atval[3] = 0x05;
-	atval[4] = u16 >> 8;
-	atval[5] = u16;
+	att_put_u16(0x0505, &atval[0]);
+	att_put_u16(0x0509, &atval[2]);
+	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
 	attrib_db_add(0x0681, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Weight: characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	atval[1] = 0x83;
-	atval[2] = 0x06;
-	memcpy(atval + 3, char_weight_uuid, 16);
+	att_put_u16(0x0683, &atval[1]);
+	memcpy(&atval[3], char_weight_uuid, 16);
 	attrib_db_add(0x0682, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
 
 	/* Weight: characteristic value */
@@ -389,17 +323,11 @@ static int register_attributes(void)
 
 	/* Weight: characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
-	u16 = htons(FMT_KILOGRAM_UUID);
 	atval[0] = 0x08;
 	atval[1] = 0xFD;
-	atval[2] = u16 >> 8;
-	atval[3] = u16;
-	u16 = htons(BLUETOOTH_SIG_UUID);
-	atval[4] = u16 >> 8;
-	atval[5] = u16;
-	u16 = htons(FMT_HANGING_UUID);
-	atval[6] = u16 >> 8;
-	atval[7] = u16;
+	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
+	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
+	att_put_u16(FMT_HANGING_UUID, &atval[6]);
 	attrib_db_add(0x0684, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Weight: characteristic user description */
-- 
1.7.0.4

