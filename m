Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/3] Add SDP registration of Primary GATT services
Date: Wed, 16 Feb 2011 13:18:00 -0800
Message-Id: <1297891081-27976-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP registration can be supressed by passing Zero as the end
handle argument to attrib_db_add().
---
 attrib/example.c    |  119 +++++++++++++++++++++++++++++++------------
 src/attrib-server.c |  139 +++++++++++++++++++++++++++++++++++----------------
 src/attrib-server.h |    6 ++-
 3 files changed, 184 insertions(+), 80 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 1911912..eab3c0f 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -31,6 +31,7 @@
 
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <src/sdpd.h>
 
 #include <glib.h>
 
@@ -59,6 +60,9 @@
 #define FMT_KILOGRAM_UUID		0xA010
 #define FMT_HANGING_UUID		0xA011
 
+#define SDP_RECORD_COUNT 10
+sdp_record_t *sdp_records[SDP_RECORD_COUNT];
+
 static int register_attributes(void)
 {
 	const char *desc_out_temp = "Outside Temperature";
@@ -77,59 +81,73 @@ static int register_attributes(void)
 	uint8_t atval[256];
 	uuid_t uuid;
 	int len;
+	int i = 0;
 
 	/* Battery state service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0100, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	sdp_records[i++] = attrib_db_add(0x0100, 0x0111, &uuid,
+						"Battery State Service",
+						ATT_NONE, ATT_NOT_PERMITTED,
+						atval, 2);
 
 	/* Battery: battery state characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0110, &atval[1]);
 	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
-	attrib_db_add(0x0106, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0106, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Battery: battery state attribute */
 	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
 	atval[0] = 0x04;
-	attrib_db_add(0x0110, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	attrib_db_add(0x0110, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 1);
 
 	/* Battery: Client Characteristic Configuration */
 	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
-	attrib_db_add(0x0111, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
+	attrib_db_add(0x0111, 0, &uuid, NULL, ATT_NONE, ATT_AUTHENTICATION,
+			atval, 2);
 
 	/* Thermometer: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0200, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	sdp_records[i++] = attrib_db_add(0x0200, 0x0214, &uuid, "Thermometer",
+						ATT_NONE, ATT_NOT_PERMITTED,
+						atval, 2);
 
 	/* Thermometer: Include */
 	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	att_put_u16(0x0500, &atval[0]);
 	att_put_u16(0x0504, &atval[2]);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
-	attrib_db_add(0x0201, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	attrib_db_add(0x0201, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 6);
 
 	/* Thermometer: Include */
 	att_put_u16(0x0550, &atval[0]);
 	att_put_u16(0x0568, &atval[2]);
-	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
+	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
+	attrib_db_add(0x0202, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 6);
 
 	/* Thermometer: temperature characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0204, &atval[1]);
 	att_put_u16(TEMPERATURE_UUID, &atval[3]);
-	attrib_db_add(0x0203, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0203, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Thermometer: temperature characteristic value */
 	sdp_uuid16_create(&uuid, TEMPERATURE_UUID);
 	atval[0] = 0x8A;
 	atval[1] = 0x02;
-	attrib_db_add(0x0204, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(0x0204, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 2);
 
 	/* Thermometer: temperature characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -138,25 +156,29 @@ static int register_attributes(void)
 	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
 	atval[4] = 0x01;
 	att_put_u16(FMT_OUTSIDE_UUID, &atval[5]);
-	attrib_db_add(0x0205, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
+	attrib_db_add(0x0205, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 7);
 
 	/* Thermometer: characteristic user description */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_temp);
 	strncpy((char *) atval, desc_out_temp, len);
-	attrib_db_add(0x0206, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0206, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	/* Thermometer: relative humidity characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0212, &atval[1]);
 	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
-	attrib_db_add(0x0210, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0210, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Thermometer: relative humidity value */
 	sdp_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
 	atval[0] = 0x27;
-	attrib_db_add(0x0212, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	attrib_db_add(0x0212, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 1);
 
 	/* Thermometer: relative humidity characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -165,68 +187,79 @@ static int register_attributes(void)
 	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
 	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
 	att_put_u16(FMT_OUTSIDE_UUID, &atval[6]);
-	attrib_db_add(0x0213, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
+	attrib_db_add(0x0213, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 8);
 
 	/* Thermometer: characteristic user description */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
-	attrib_db_add(0x0214, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0214, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	/* Secondary Service: Manufacturer Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0500, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(0x0500, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0502, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
-	attrib_db_add(0x0501, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0501, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Manufacturer name characteristic value */
 	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name1);
 	strncpy((char *) atval, manufacturer_name1, len);
-	attrib_db_add(0x0502, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0502, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	/* Manufacturer serial number characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0504, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
-	attrib_db_add(0x0503, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0503, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Manufacturer serial number characteristic value */
 	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
-	attrib_db_add(0x0504, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0504, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	/* Secondary Service: Manufacturer Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0505, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(0x0505, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0507, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
-	attrib_db_add(0x0506, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0506, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Secondary Service: Vendor Specific Service */
 	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
-	attrib_db_add(0x0550, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(0x0550, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0568, &atval[1]);
 	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
-	attrib_db_add(0x0560, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0560, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Vendor Specific Type characteristic value */
 	sdp_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
@@ -236,45 +269,53 @@ static int register_attributes(void)
 	atval[3] = 0x64;
 	atval[4] = 0x6F;
 	atval[5] = 0x72;
-	attrib_db_add(0x0568, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	attrib_db_add(0x0568, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 6);
 
 	/* Manufacturer name attribute */
 	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name2);
 	strncpy((char *) atval, manufacturer_name2, len);
-	attrib_db_add(0x0507, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0507, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	/* Characteristic: serial number */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0509, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
-	attrib_db_add(0x0508, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0508, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* Serial number characteristic value */
 	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial2);
 	strncpy((char *) atval, serial2, len);
-	attrib_db_add(0x0509, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0509, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	/* Weight service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	memcpy(atval, prim_weight_uuid, 16);
-	attrib_db_add(0x0680, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
+	sdp_records[i++] = attrib_db_add(0x0680, 0x685, &uuid, "Weight Service",
+						ATT_NONE, ATT_NOT_PERMITTED,
+						atval, 16);
 
 	/* Weight: include */
 	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	att_put_u16(0x0505, &atval[0]);
 	att_put_u16(0x0509, &atval[2]);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
-	attrib_db_add(0x0681, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	attrib_db_add(0x0681, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 6);
 
 	/* Weight: characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0683, &atval[1]);
 	memcpy(&atval[3], char_weight_uuid, 16);
-	attrib_db_add(0x0682, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
+	attrib_db_add(0x0682, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 19);
 
 	/* Weight: characteristic value */
 	sdp_uuid128_create(&uuid, char_weight_uuid);
@@ -282,7 +323,8 @@ static int register_attributes(void)
 	atval[1] = 0x55;
 	atval[2] = 0x00;
 	atval[3] = 0x00;
-	attrib_db_add(0x0683, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
+	attrib_db_add(0x0683, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 4);
 
 	/* Weight: characteristic format */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -291,13 +333,15 @@ static int register_attributes(void)
 	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
 	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
 	att_put_u16(FMT_HANGING_UUID, &atval[6]);
-	attrib_db_add(0x0684, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
+	attrib_db_add(0x0684, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 8);
 
 	/* Weight: characteristic user description */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
-	attrib_db_add(0x0685, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(0x0685, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, len);
 
 	return 0;
 }
@@ -309,4 +353,11 @@ int server_example_init(void)
 
 void server_example_exit(void)
 {
+	int i;
+
+	for (i = 0; i < SDP_RECORD_COUNT; i++)
+		if (sdp_records[i]) {
+			remove_record_from_server(sdp_records[i]->handle);
+			sdp_records[i] = NULL;
+		}
 }
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 72f5b17..db42ab2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -70,7 +70,8 @@ struct group_elem {
 static GIOChannel *l2cap_io = NULL;
 static GIOChannel *le_io = NULL;
 static GSList *clients = NULL;
-static uint32_t sdp_handle = 0;
+static uint32_t gatt_sdp_handle = 0;
+static uint32_t gap_sdp_handle = 0;
 
 static uuid_t prim_uuid = {
 			.type = SDP_UUID16,
@@ -81,14 +82,19 @@ static uuid_t snd_uuid = {
 			.value.uuid16 = GATT_SND_SVC_UUID
 };
 
-static sdp_record_t *server_record_new(void)
+static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
-	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
+	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
 	uuid_t root_uuid, proto_uuid, gatt_uuid, l2cap;
-	sdp_profile_desc_t profile;
 	sdp_record_t *record;
 	sdp_data_t *psm, *sh, *eh;
-	uint16_t lp = GATT_PSM, start = 0x0001, end = 0xffff;
+	uint16_t lp = GATT_PSM;
+
+	if (uuid == NULL)
+		return NULL;
+
+	if (start > end)
+		return NULL;
 
 	record = sdp_record_alloc();
 	if (record == NULL)
@@ -99,17 +105,10 @@ static sdp_record_t *server_record_new(void)
 	sdp_set_browse_groups(record, root);
 	sdp_list_free(root, NULL);
 
-	sdp_uuid16_create(&gatt_uuid, GENERIC_ATTRIB_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &gatt_uuid);
+	svclass_id = sdp_list_append(NULL, uuid);
 	sdp_set_service_classes(record, svclass_id);
 	sdp_list_free(svclass_id, NULL);
 
-	sdp_uuid16_create(&profile.uuid, GENERIC_ATTRIB_PROFILE_ID);
-	profile.version = 0x0100;
-	profiles = sdp_list_append(NULL, &profile);
-	sdp_set_profile_descs(record, profiles);
-	sdp_list_free(profiles, NULL);
-
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
 	proto[0] = sdp_list_append(NULL, &l2cap);
 	psm = sdp_data_alloc(SDP_UINT16, &lp);
@@ -127,11 +126,6 @@ static sdp_record_t *server_record_new(void)
 	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	sdp_set_info_attr(record, "Generic Attribute Profile", "BlueZ", NULL);
-
-	sdp_set_url_attr(record, "http://www.bluez.org/",
-			"http://www.bluez.org/", "http://www.bluez.org/");
-
 	sdp_set_service_id(record, gatt_uuid);
 
 	sdp_data_free(psm);
@@ -609,7 +603,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 		uint8_t *pdu, int len)
 {
-	channel->mtu = MIN(mtu, ATT_MAX_MTU);
+	channel->mtu = MIN(mtu, channel->mtu);
 
 	return enc_mtu_resp(channel->mtu, pdu, len);
 }
@@ -796,43 +790,68 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
-static void register_core_services(void)
+static gboolean register_core_services(void)
 {
 	uint8_t atval[256];
 	uuid_t uuid;
 	int len;
+	sdp_record_t *record;
 
 	/* GAP service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	record = attrib_db_add(0x0001, 0x0006, &uuid, "Generic Access Profile",
+				ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* GAP service: device name characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0006, &atval[1]);
 	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
-	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(0x0004, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
+			atval, 5);
 
 	/* GAP service: device name attribute */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
 	len = strlen(main_opts.name);
-	attrib_db_add(0x0006, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(0x0006, 0, &uuid, NULL, ATT_NONE, ATT_NOT_PERMITTED,
 					(uint8_t *) main_opts.name, len);
 
 	/* TODO: Implement Appearance characteristic. It is mandatory for
 	 * Peripheral/Central GAP roles. */
 
+	if (record == NULL) {
+		error("Failed to register GAP service record");
+		goto failed;
+	}
+
+	gap_sdp_handle = record->handle;
+
 	/* GATT service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	record = attrib_db_add(0x0010, 0x0010, &uuid, "Generic Attribute Profile",
+				ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+
+	if (record == NULL) {
+		error("Failed to register GATT service record");
+		goto failed;
+	}
+
+	gatt_sdp_handle = record->handle;
+
+	return TRUE;
+
+failed:
+	if (gap_sdp_handle)
+		remove_record_from_server(gap_sdp_handle);
+
+	return FALSE;
 }
 
 int attrib_server_init(void)
 {
 	GError *gerr = NULL;
-	sdp_record_t *record;
 
 	/* BR/EDR socket */
 	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
@@ -848,21 +867,8 @@ int attrib_server_init(void)
 		return -1;
 	}
 
-	record = server_record_new();
-	if (record == NULL) {
-		error("Unable to create GATT service record");
+	if (!register_core_services())
 		goto failed;
-	}
-
-	if (add_record_to_server(BDADDR_ANY, record) < 0) {
-		error("Failed to register GATT service record");
-		sdp_record_free(record);
-		goto failed;
-	}
-
-	sdp_handle = record->handle;
-
-	register_core_services();
 
 	if (!main_opts.le)
 		return 0;
@@ -921,15 +927,60 @@ void attrib_server_exit(void)
 
 	g_slist_free(clients);
 
-	if (sdp_handle)
-		remove_record_from_server(sdp_handle);
+	if (gatt_sdp_handle)
+		remove_record_from_server(gatt_sdp_handle);
+
+	if (gap_sdp_handle)
+		remove_record_from_server(gap_sdp_handle);
 }
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
-						const uint8_t *value, int len)
+sdp_record_t *attrib_db_add(uint16_t handle, uint16_t end, uuid_t *uuid,
+				const char *name,
+				int read_reqs, int write_reqs,
+				const uint8_t *value, int len)
 {
 	struct attribute *a;
+	uuid_t svc;
+	sdp_record_t *record = NULL;
+
+	/* If a valid range is being added AND this is a Primary Service, */
+	/* add it to the SDP database as well. */
+
+	if (end == 0 || handle > end)
+		goto no_sdp;
+
+	if (uuid->type != SDP_UUID16 || uuid->value.uuid16 != GATT_PRIM_SVC_UUID)
+		goto no_sdp;
+
+	if (len == 2) {
+		svc.type = SDP_UUID16;
+		svc.value.uuid16 = att_get_u16(value);
+	} else if (len == 16) {
+		svc.type = SDP_UUID128;
+		memcpy(&svc.value.uuid128, value, sizeof(uint128_t));
+	} else
+		return NULL;
 
+	record = server_record_new(&svc, handle, end);
+	if (record == NULL)
+		return NULL;
+
+	if (name)
+		sdp_set_info_attr(record, name, "BlueZ", NULL);
+
+	if (svc.type == SDP_UUID16 &&
+			svc.value.uuid16 == GENERIC_ACCESS_PROFILE_ID) {
+		sdp_set_url_attr(record, "http://www.bluez.org/",
+				"http://www.bluez.org/",
+				"http://www.bluez.org/");
+	}
+
+	if (add_record_to_server(BDADDR_ANY, record) < 0) {
+		sdp_record_free(record);
+		return NULL;
+	}
+
+no_sdp:
 	/* FIXME: handle conflicts */
 
 	a = g_malloc0(sizeof(struct attribute) + len);
@@ -942,7 +993,7 @@ int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
 
 	database = g_slist_insert_sorted(database, a, attribute_cmp);
 
-	return 0;
+	return record;
 }
 
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
diff --git a/src/attrib-server.h b/src/attrib-server.h
index ba90ff4..2601d0e 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -25,8 +25,10 @@
 int attrib_server_init(void);
 void attrib_server_exit(void);
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
-						const uint8_t *value, int len);
+sdp_record_t *attrib_db_add(uint16_t handle, uint16_t end, uuid_t *uuid,
+				const char *name,
+				int read_reqs, int write_reqs,
+				const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 								int len);
 int attrib_db_del(uint16_t handle);
-- 
1.7.1

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
