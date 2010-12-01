Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/3] Initial attribute permission implementation
Date: Wed,  1 Dec 2010 12:13:04 -0400
Message-Id: <1291219986-29913-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Create definitions for attribute permissions, add "perms" field to
struct attribute and add attribute permissions to attribute server.
---
 attrib/att.h        |    1 +
 attrib/example.c    |   89 ++++++++++++++++++++++++++++-----------------------
 src/attrib-server.c |    4 ++-
 src/attrib-server.h |   13 +++++++-
 4 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 7c98b4a..a29aae2 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -112,6 +112,7 @@
 struct attribute {
 	uint16_t handle;
 	uuid_t uuid;
+	uint8_t perms;
 	int len;
 	uint8_t data[0];
 };
diff --git a/attrib/example.c b/attrib/example.c
index c29e1e4..2fedfc7 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -101,7 +101,7 @@ static int register_attributes(void)
 	u16 = htons(GENERIC_ACCESS_PROFILE_ID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0001, &uuid, atval, 2);
+	attrib_db_add(0x0001, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* GAP service: device name characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -111,20 +111,21 @@ static int register_attributes(void)
 	atval[2] = 0x00;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0004, &uuid, atval, 5);
+	attrib_db_add(0x0004, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* GAP service: device name attribute */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
 	len = strlen(devname);
 	strncpy((char *) atval, devname, len);
-	attrib_db_add(0x0006, &uuid, atval, len);
+	attrib_db_add(0x0006, &uuid, ATT_ACCESS(ATT_READ | ATT_WRITE, ATT_NONE),
+								atval, len);
 
 	/* GATT service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	u16 = htons(GENERIC_ATTRIB_PROFILE_ID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0010, &uuid, atval, 2);
+	attrib_db_add(0x0010, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* GATT service: attributes opcodes characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -134,20 +135,20 @@ static int register_attributes(void)
 	atval[2] = 0x00;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0011, &uuid, atval, 5);
+	attrib_db_add(0x0011, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* GATT service: attribute opcodes supported */
 	sdp_uuid16_create(&uuid, OPCODES_SUPPORTED_UUID);
 	atval[0] = 0xFF;
 	atval[1] = 0x01;
-	attrib_db_add(0x0012, &uuid, atval, 2);
+	attrib_db_add(0x0012, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Battery state service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	u16 = htons(BATTERY_STATE_SVC_UUID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0100, &uuid, atval, 2);
+	attrib_db_add(0x0100, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Battery: battery state characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -157,18 +158,19 @@ static int register_attributes(void)
 	atval[2] = 0x01;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0106, &uuid, atval, 5);
+	attrib_db_add(0x0106, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Battery: battery state attribute */
 	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
 	atval[0] = 0x04;
-	attrib_db_add(0x0110, &uuid, atval, 1);
+	attrib_db_add(0x0110, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 1);
 
 	/* Battery: Client Characteristic Configuration */
 	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
-	attrib_db_add(0x0111, &uuid, atval, 2);
+	attrib_db_add(0x0111, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE) |
+			ATT_ACCESS(ATT_WRITE, ATT_AUTHENTICATION), atval, 2);
 
 	timeout_id = g_timeout_add_seconds(10, change_battery_state, NULL);
 
@@ -177,7 +179,7 @@ static int register_attributes(void)
 	u16 = htons(THERM_HUMIDITY_SVC_UUID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0200, &uuid, atval, 2);
+	attrib_db_add(0x0200, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Thermometer: Include */
 	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
@@ -188,14 +190,14 @@ static int register_attributes(void)
 	atval[3] = 0x05;
 	atval[4] = u16 >> 8;
 	atval[5] = u16;
-	attrib_db_add(0x0201, &uuid, atval, 6);
+	attrib_db_add(0x0201, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 6);
 
 	/* Thermometer: Include */
 	atval[0] = 0x50;
 	atval[1] = 0x05;
 	atval[2] = 0x68;
 	atval[3] = 0x05;
-	attrib_db_add(0x0202, &uuid, atval, 4);
+	attrib_db_add(0x0202, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 4);
 
 	/* Thermometer: temperature characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -205,13 +207,13 @@ static int register_attributes(void)
 	atval[2] = 0x02;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0203, &uuid, atval, 5);
+	attrib_db_add(0x0203, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Thermometer: temperature characteristic value */
 	sdp_uuid16_create(&uuid, TEMPERATURE_UUID);
 	atval[0] = 0x8A;
 	atval[1] = 0x02;
-	attrib_db_add(0x0204, &uuid, atval, 2);
+	attrib_db_add(0x0204, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Thermometer: temperature characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -224,13 +226,14 @@ static int register_attributes(void)
 	u16 = htons(FMT_OUTSIDE_UUID);
 	atval[5] = u16 >> 8;
 	atval[6] = u16;
-	attrib_db_add(0x0205, &uuid, atval, 7);
+	attrib_db_add(0x0205, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 7);
 
 	/* Thermometer: characteristic user description */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_temp);
 	strncpy((char *) atval, desc_out_temp, len);
-	attrib_db_add(0x0206, &uuid, atval, len);
+	attrib_db_add(0x0206, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	/* Thermometer: relative humidity characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -240,12 +243,12 @@ static int register_attributes(void)
 	atval[2] = 0x02;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0210, &uuid, atval, 5);
+	attrib_db_add(0x0210, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Thermometer: relative humidity value */
 	sdp_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
 	atval[0] = 0x27;
-	attrib_db_add(0x0212, &uuid, atval, 1);
+	attrib_db_add(0x0212, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 1);
 
 	/* Thermometer: relative humidity characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -260,20 +263,21 @@ static int register_attributes(void)
 	u16 = htons(FMT_OUTSIDE_UUID);
 	atval[6] = u16 >> 8;
 	atval[7] = u16;
-	attrib_db_add(0x0213, &uuid, atval, 8);
+	attrib_db_add(0x0213, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 8);
 
 	/* Thermometer: characteristic user description */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
-	attrib_db_add(0x0214, &uuid, atval, len);
+	attrib_db_add(0x0214, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	/* Secondary Service: Manufacturer Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	u16 = htons(MANUFACTURER_SVC_UUID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0500, &uuid, atval, 2);
+	attrib_db_add(0x0500, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -283,13 +287,14 @@ static int register_attributes(void)
 	atval[2] = 0x05;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0501, &uuid, atval, 5);
+	attrib_db_add(0x0501, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Manufacturer name characteristic value */
 	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name1);
 	strncpy((char *) atval, manufacturer_name1, len);
-	attrib_db_add(0x0502, &uuid, atval, len);
+	attrib_db_add(0x0502, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	/* Manufacturer serial number characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -299,20 +304,21 @@ static int register_attributes(void)
 	atval[2] = 0x05;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0503, &uuid, atval, 5);
+	attrib_db_add(0x0503, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Manufacturer serial number characteristic value */
 	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
-	attrib_db_add(0x0504, &uuid, atval, len);
+	attrib_db_add(0x0504, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	/* Secondary Service: Manufacturer Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	u16 = htons(MANUFACTURER_SVC_UUID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0505, &uuid, atval, 2);
+	attrib_db_add(0x0505, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -322,14 +328,14 @@ static int register_attributes(void)
 	atval[2] = 0x05;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0506, &uuid, atval, 5);
+	attrib_db_add(0x0506, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Secondary Service: Vendor Specific Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	u16 = htons(VENDOR_SPECIFIC_SVC_UUID);
 	atval[0] = u16 >> 8;
 	atval[1] = u16;
-	attrib_db_add(0x0550, &uuid, atval, 2);
+	attrib_db_add(0x0550, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -339,7 +345,7 @@ static int register_attributes(void)
 	atval[2] = 0x05;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0560, &uuid, atval, 5);
+	attrib_db_add(0x0560, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Vendor Specific Type characteristic value */
 	sdp_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
@@ -349,13 +355,14 @@ static int register_attributes(void)
 	atval[3] = 0x64;
 	atval[4] = 0x6F;
 	atval[5] = 0x72;
-	attrib_db_add(0x0568, &uuid, atval, 6);
+	attrib_db_add(0x0568, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 6);
 
 	/* Manufacturer name attribute */
 	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name2);
 	strncpy((char *) atval, manufacturer_name2, len);
-	attrib_db_add(0x0507, &uuid, atval, len);
+	attrib_db_add(0x0507, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	/* Characteristic: serial number */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -365,18 +372,19 @@ static int register_attributes(void)
 	atval[2] = 0x05;
 	atval[3] = u16 >> 8;
 	atval[4] = u16;
-	attrib_db_add(0x0508, &uuid, atval, 5);
+	attrib_db_add(0x0508, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 5);
 
 	/* Serial number characteristic value */
 	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial2);
 	strncpy((char *) atval, serial2, len);
-	attrib_db_add(0x0509, &uuid, atval, len);
+	attrib_db_add(0x0509, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	/* Weight service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	memcpy(atval, prim_weight_uuid, 16);
-	attrib_db_add(0x0680, &uuid, atval, 16);
+	attrib_db_add(0x0680, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 16);
 
 	/* Weight: include */
 	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
@@ -387,7 +395,7 @@ static int register_attributes(void)
 	atval[3] = 0x05;
 	atval[4] = u16 >> 8;
 	atval[5] = u16;
-	attrib_db_add(0x0681, &uuid, atval, 6);
+	attrib_db_add(0x0681, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 6);
 
 	/* Weight: characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
@@ -395,7 +403,7 @@ static int register_attributes(void)
 	atval[1] = 0x83;
 	atval[2] = 0x06;
 	memcpy(atval + 3, char_weight_uuid, 16);
-	attrib_db_add(0x0682, &uuid, atval, 19);
+	attrib_db_add(0x0682, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 19);
 
 	/* Weight: characteristic value */
 	sdp_uuid128_create(&uuid, char_weight_uuid);
@@ -403,7 +411,7 @@ static int register_attributes(void)
 	atval[1] = 0x55;
 	atval[2] = 0x00;
 	atval[3] = 0x00;
-	attrib_db_add(0x0683, &uuid, atval, 4);
+	attrib_db_add(0x0683, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 4);
 
 	/* Weight: characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -418,13 +426,14 @@ static int register_attributes(void)
 	u16 = htons(FMT_HANGING_UUID);
 	atval[6] = u16 >> 8;
 	atval[7] = u16;
-	attrib_db_add(0x0684, &uuid, atval, 8);
+	attrib_db_add(0x0684, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval, 8);
 
 	/* Weight: characteristic user description */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
-	attrib_db_add(0x0685, &uuid, atval, len);
+	attrib_db_add(0x0685, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
+									len);
 
 	return 0;
 }
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 41c0ffc..4199355 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -760,7 +760,8 @@ void attrib_server_exit(void)
 		remove_record_from_server(sdp_handle);
 }
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, const uint8_t *value, int len)
+int attrib_db_add(uint16_t handle, uuid_t *uuid, uint8_t perms,
+						const uint8_t *value, int len)
 {
 	struct attribute *a;
 
@@ -769,6 +770,7 @@ int attrib_db_add(uint16_t handle, uuid_t *uuid, const uint8_t *value, int len)
 	a = g_malloc0(sizeof(struct attribute) + len);
 	a->handle = handle;
 	memcpy(&a->uuid, uuid, sizeof(uuid_t));
+	a->perms = perms;
 	a->len = len;
 	memcpy(a->data, value, len);
 
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 4a0afa6..e74a134 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -25,7 +25,18 @@
 int attrib_server_init(void);
 void attrib_server_exit(void);
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, const uint8_t *value, int len);
+/* Access permissions */
+#define ATT_READ	1
+#define ATT_WRITE	2
+/* Authentication/Authorization permissions */
+#define ATT_NONE		0
+#define ATT_AUTHENTICATION	2
+#define ATT_AUTHORIZATION	4
+/* Build bit mask for permission checks */
+#define ATT_ACCESS(x, y)	(((x) << y) | (x))
+
+int attrib_db_add(uint16_t handle, uuid_t *uuid, uint8_t perms,
+						const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 								int len);
 int attrib_db_del(uint16_t handle);
-- 
1.7.0.4

