Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/3] Remove hard-coded handles from example GATT plugin
Date: Tue, 29 Mar 2011 12:15:28 -0400
Message-Id: <1301415328-14257-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of having static handles, use attrib_db_find_avail() to find
available handle ranges.

Also split the big register_attributes() into one function per service.
---
 plugins/gatt-example.c |  350 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 250 insertions(+), 100 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f1dfd5b..f86e76d 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -56,89 +56,116 @@
 
 static GSList *sdp_handles = NULL;
 
-static int register_attributes(void)
+static void register_battery_service(void)
 {
-	const char *desc_out_temp = "Outside Temperature";
-	const char *desc_out_hum = "Outside Relative Humidity";
-	const char *desc_weight = "Rucksack Weight";
-	const char *manufacturer_name1 = "ACME Temperature Sensor";
-	const char *manufacturer_name2 = "ACME Weighing Scales";
-	const char *serial1 = "237495-3282-A";
-	const char *serial2 = "11267-2327A00239";
-
-	const uint128_t char_weight_uuid_btorder = {
-		.data = { 0x80, 0x88, 0xF2, 0x18, 0x90, 0x2C, 0x45, 0x0B,
-			  0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25, 0xE9 } };
-	const uint128_t prim_weight_uuid_btorder = {
-		.data = { 0x4F, 0x0A, 0xC0, 0x96, 0x35, 0xD4, 0x49, 0x11,
-			  0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE, 0xFE } };
-
-	uint128_t char_weight_uuid;
+	uint16_t start_handle, h;
+	const int svc_size = 4;
+	uint32_t sdp_handle;
 	uint8_t atval[256];
-	uint32_t handle;
 	bt_uuid_t uuid;
-	int len;
 
-	btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x", start_handle);
+
+	h = start_handle;
 
 	/* Battery state service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0100, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Battery: battery state characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0110, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
-	attrib_db_add(0x0106, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Battery: battery state attribute */
 	bt_uuid16_create(&uuid, BATTERY_STATE_UUID);
 	atval[0] = 0x04;
-	attrib_db_add(0x0110, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Battery: Client Characteristic Configuration */
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
-	attrib_db_add(0x0111, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
+
+	g_assert(h - start_handle == svc_size);
 
 	/* Add an SDP record for the above service */
-	handle = attrib_create_sdp(0x0100, "Battery State Service");
-	if (handle)
-		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
+	sdp_handle = attrib_create_sdp(start_handle, "Battery State Service");
+	if (sdp_handle)
+		sdp_handles = g_slist_prepend(sdp_handles,
+						GUINT_TO_POINTER(sdp_handle));
+}
+
+static void register_termometer_service(const uint16_t manuf1[2],
+						const uint16_t manuf2[2])
+{
+	const char *desc_out_temp = "Outside Temperature";
+	const char *desc_out_hum = "Outside Relative Humidity";
+	uint16_t start_handle, h;
+	const int svc_size = 11;
+	uint32_t sdp_handle;
+	uint8_t atval[256];
+	bt_uuid_t uuid;
+	int len;
+
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x manuf1=0x%04x-0x%04x, manuf2=0x%04x-0x%04x",
+		start_handle, manuf1[0], manuf1[1], manuf2[0], manuf2[1]);
+
+	h = start_handle;
 
 	/* Thermometer: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0200, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
-	/* Thermometer: Include */
 	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
-	att_put_u16(0x0500, &atval[0]);
-	att_put_u16(0x0504, &atval[2]);
-	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
-	attrib_db_add(0x0201, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Thermometer: Include */
-	att_put_u16(0x0550, &atval[0]);
-	att_put_u16(0x0568, &atval[2]);
-	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
-	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	if (manuf1[0] && manuf1[1]) {
+		att_put_u16(manuf1[0], &atval[0]);
+		att_put_u16(manuf1[1], &atval[2]);
+		att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
+		attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+									6);
+	}
+
+	/* Thermometer: Include */
+	if (manuf2[0] && manuf2[1]) {
+		att_put_u16(manuf2[0], &atval[0]);
+		att_put_u16(manuf2[1], &atval[2]);
+		att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
+		attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+									6);
+	}
 
 	/* Thermometer: temperature characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0204, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(TEMPERATURE_UUID, &atval[3]);
-	attrib_db_add(0x0203, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: temperature characteristic value */
 	bt_uuid16_create(&uuid, TEMPERATURE_UUID);
 	atval[0] = 0x8A;
 	atval[1] = 0x02;
-	attrib_db_add(0x0204, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Thermometer: temperature characteristic format */
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -147,25 +174,25 @@ static int register_attributes(void)
 	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
 	atval[4] = 0x01;
 	att_put_u16(FMT_OUTSIDE_UUID, &atval[5]);
-	attrib_db_add(0x0205, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
 
 	/* Thermometer: characteristic user description */
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_temp);
 	strncpy((char *) atval, desc_out_temp, len);
-	attrib_db_add(0x0206, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Thermometer: relative humidity characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0212, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
-	attrib_db_add(0x0210, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: relative humidity value */
 	bt_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
 	atval[0] = 0x27;
-	attrib_db_add(0x0212, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Thermometer: relative humidity characteristic format */
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -174,73 +201,165 @@ static int register_attributes(void)
 	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
 	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
 	att_put_u16(FMT_OUTSIDE_UUID, &atval[6]);
-	attrib_db_add(0x0213, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Thermometer: characteristic user description */
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
-	attrib_db_add(0x0214, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+
+	g_assert(h - start_handle == svc_size);
 
 	/* Add an SDP record for the above service */
-	handle = attrib_create_sdp(0x0200, "Thermometer");
-	if (handle)
-		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
+	sdp_handle = attrib_create_sdp(start_handle, "Thermometer");
+	if (sdp_handle)
+		sdp_handles = g_slist_prepend(sdp_handles,
+						GUINT_TO_POINTER(sdp_handle));
+}
+
+static void register_manuf1_service(uint16_t range[2])
+{
+	const char *manufacturer_name1 = "ACME Temperature Sensor";
+	const char *serial1 = "237495-3282-A";
+	uint16_t start_handle, h;
+	const int svc_size = 5;
+	uint8_t atval[256];
+	bt_uuid_t uuid;
+	int len;
+
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x", start_handle);
+
+	h = start_handle;
 
 	/* Secondary Service: Manufacturer Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0500, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0502, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
-	attrib_db_add(0x0501, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer name characteristic value */
 	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name1);
 	strncpy((char *) atval, manufacturer_name1, len);
-	attrib_db_add(0x0502, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Manufacturer serial number characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0504, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
-	attrib_db_add(0x0503, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer serial number characteristic value */
 	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
-	attrib_db_add(0x0504, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+
+	g_assert(h - start_handle == svc_size);
+
+	range[0] = start_handle;
+	range[1] = start_handle + svc_size - 1;
+}
+
+static void register_manuf2_service(uint16_t range[2])
+{
+	const char *manufacturer_name2 = "ACME Weighing Scales";
+	const char *serial2 = "11267-2327A00239";
+	uint16_t start_handle, h;
+	const int svc_size = 5;
+	uint8_t atval[256];
+	bt_uuid_t uuid;
+	int len;
+
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x", start_handle);
+
+	h = start_handle;
 
 	/* Secondary Service: Manufacturer Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0505, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0507, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
-	attrib_db_add(0x0506, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+
+	/* Manufacturer name attribute */
+	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
+	len = strlen(manufacturer_name2);
+	strncpy((char *) atval, manufacturer_name2, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+
+	/* Characteristic: serial number */
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	atval[0] = ATT_CHAR_PROPER_READ;
+	att_put_u16(h + 1, &atval[1]);
+	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+
+	/* Serial number characteristic value */
+	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
+	len = strlen(serial2);
+	strncpy((char *) atval, serial2, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+
+	g_assert(h - start_handle == svc_size);
+
+	range[0] = start_handle;
+	range[1] = start_handle + svc_size - 1;
+}
+
+static void register_vendor_service(uint16_t range[2])
+{
+	uint16_t start_handle, h;
+	const int svc_size = 3;
+	uint8_t atval[256];
+	bt_uuid_t uuid;
+
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x", start_handle);
+
+	h = start_handle;
 
 	/* Secondary Service: Vendor Specific Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0550, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0568, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
-	attrib_db_add(0x0560, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Vendor Specific Type characteristic value */
 	bt_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
@@ -250,45 +369,65 @@ static int register_attributes(void)
 	atval[3] = 0x64;
 	atval[4] = 0x6F;
 	atval[5] = 0x72;
-	attrib_db_add(0x0568, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
-	/* Manufacturer name attribute */
-	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
-	len = strlen(manufacturer_name2);
-	strncpy((char *) atval, manufacturer_name2, len);
-	attrib_db_add(0x0507, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	g_assert(h - start_handle == svc_size);
 
-	/* Characteristic: serial number */
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0509, &atval[1]);
-	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
-	attrib_db_add(0x0508, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	range[0] = start_handle;
+	range[1] = start_handle + svc_size - 1;
+}
 
-	/* Serial number characteristic value */
-	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
-	len = strlen(serial2);
-	strncpy((char *) atval, serial2, len);
-	attrib_db_add(0x0509, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+static void register_weight_service(const uint16_t vendor[2])
+{
+	const char *desc_weight = "Rucksack Weight";
+	const uint128_t char_weight_uuid_btorder = {
+		.data = { 0x80, 0x88, 0xF2, 0x18, 0x90, 0x2C, 0x45, 0x0B,
+			  0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25, 0xE9 } };
+	const uint128_t prim_weight_uuid_btorder = {
+		.data = { 0x4F, 0x0A, 0xC0, 0x96, 0x35, 0xD4, 0x49, 0x11,
+			  0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE, 0xFE } };
+	uint128_t char_weight_uuid;
+	uint16_t start_handle, h;
+	const int svc_size = 6;
+	uint32_t sdp_handle;
+	uint8_t atval[256];
+	bt_uuid_t uuid;
+	int len;
+
+	btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
+
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x, vendor=0x%04x-0x%04x", start_handle,
+							vendor[0], vendor[1]);
+
+	h = start_handle;
 
 	/* Weight service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	memcpy(atval, &prim_weight_uuid_btorder, 16);
-	attrib_db_add(0x0680, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
-
-	/* Weight: include */
-	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
-	att_put_u16(0x0505, &atval[0]);
-	att_put_u16(0x0509, &atval[2]);
-	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
-	attrib_db_add(0x0681, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
+
+	if (vendor[0] && vendor[1]) {
+		/* Weight: include */
+		bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+		att_put_u16(vendor[0], &atval[0]);
+		att_put_u16(vendor[1], &atval[2]);
+		att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
+		attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+									6);
+	}
 
 	/* Weight: characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0683, &atval[1]);
+	att_put_u16(h + 1, &atval[1]);
 	memcpy(&atval[3], &char_weight_uuid_btorder, 16);
-	attrib_db_add(0x0682, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
 
 	/* Weight: characteristic value */
 	bt_uuid128_create(&uuid, char_weight_uuid);
@@ -296,7 +435,7 @@ static int register_attributes(void)
 	atval[1] = 0x55;
 	atval[2] = 0x00;
 	atval[3] = 0x00;
-	attrib_db_add(0x0683, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
 
 	/* Weight: characteristic format */
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -305,30 +444,41 @@ static int register_attributes(void)
 	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
 	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
 	att_put_u16(FMT_HANGING_UUID, &atval[6]);
-	attrib_db_add(0x0684, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Weight: characteristic user description */
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
-	attrib_db_add(0x0685, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
-	/* Add an SDP record for the above service */
-	handle = attrib_create_sdp(0x0680, "Weight Service");
-	if (handle)
-		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
+	g_assert(h - start_handle == svc_size);
 
-	return 0;
+	/* Add an SDP record for the above service */
+	sdp_handle = attrib_create_sdp(start_handle, "Weight Service");
+	if (sdp_handle)
+		sdp_handles = g_slist_prepend(sdp_handles,
+						GUINT_TO_POINTER(sdp_handle));
 }
 
 static int gatt_example_init(void)
 {
+	uint16_t manuf1_range[2] = {0, 0}, manuf2_range[2] = {0, 0};
+	uint16_t vendor_range[2] = {0, 0};
+
 	if (!main_opts.attrib_server) {
 		DBG("Attribute server is disabled");
 		return -1;
 	}
 
-	return register_attributes();
+	register_battery_service();
+	register_manuf1_service(manuf1_range);
+	register_manuf2_service(manuf2_range);
+	register_termometer_service(manuf1_range, manuf2_range);
+	register_vendor_service(vendor_range);
+	register_weight_service(vendor_range);
+
+	return 0;
 }
 
 static void gatt_example_exit(void)
-- 
1.7.0.4

