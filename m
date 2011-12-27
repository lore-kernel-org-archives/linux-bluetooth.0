Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/8] attrib-server: Add bluetooth adapter in attrib_db_add
Date: Tue, 27 Dec 2011 10:29:36 +0100
Message-Id: <1324978182-5707-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1324978182-5707-2-git-send-email-sancane@gmail.com>
References: <1324978182-5707-1-git-send-email-sancane@gmail.com>
 <1324978182-5707-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Because of there can be many adapters plugged, the GATT servers
must provide te adapter in wich the attributes will be retgistered.
---
 attrib/gatt-service.c  |   15 +++++---
 plugins/gatt-example.c |   93 +++++++++++++++++++++++++++++++-----------------
 proximity/reporter.c   |   30 ++++++++++-----
 src/attrib-server.c    |   15 ++++----
 src/attrib-server.h    |    5 ++-
 5 files changed, 100 insertions(+), 58 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 327569f..73230f2 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -197,11 +197,14 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 	atval[0] = info->props;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(info->uuid.value.u16, &atval[3]);
-	attrib_db_add(h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
 								sizeof(atval));
 
 	/* characteristic value */
-	a = attrib_db_add(h++, &info->uuid, read_reqs, write_reqs, NULL, 0);
+	/* FIXME: Provide the adapter in next function */
+	a = attrib_db_add(NULL, h++, &info->uuid, read_reqs, write_reqs, NULL,
+									0);
 	for (l = info->callbacks; l != NULL; l = l->next) {
 		struct attrib_cb *cb = l->data;
 
@@ -225,8 +228,9 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 		bt_uuid16_create(&bt_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 		cfg_val[0] = 0x00;
 		cfg_val[1] = 0x00;
-		a = attrib_db_add(h++, &bt_uuid, ATT_NONE, ATT_AUTHENTICATION,
-						cfg_val, sizeof(cfg_val));
+		/* FIXME: Provide the adapter in next function */
+		a = attrib_db_add(NULL, h++, &bt_uuid, ATT_NONE,
+				ATT_AUTHENTICATION, cfg_val, sizeof(cfg_val));
 
 		if (info->ccc_handle != NULL)
 			*info->ccc_handle = a->handle;
@@ -278,7 +282,8 @@ gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ..
 	h = start_handle;
 	bt_uuid16_create(&bt_uuid, uuid);
 	att_put_u16(svc_uuid, &atval[0]);
-	attrib_db_add(h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
 								sizeof(atval));
 
 	for (l = chrs; l != NULL; l = l->next) {
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 4aa5a8b..f3f2b3a 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -140,7 +140,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	/* Thermometer: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 
@@ -149,8 +150,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 		att_put_u16(manuf1[0], &atval[0]);
 		att_put_u16(manuf1[1], &atval[2]);
 		att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
-		attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
-									6);
+		attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 6);
 	}
 
 	/* Thermometer: Include */
@@ -158,8 +159,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 		att_put_u16(manuf2[0], &atval[0]);
 		att_put_u16(manuf2[1], &atval[2]);
 		att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
-		attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
-									6);
+		attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 6);
 	}
 
 	/* Thermometer: temperature characteristic */
@@ -167,13 +168,15 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(TEMPERATURE_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Thermometer: temperature characteristic value */
 	bt_uuid16_create(&uuid, TEMPERATURE_UUID);
 	atval[0] = 0x8A;
 	atval[1] = 0x02;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	/* Thermometer: temperature characteristic format */
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -182,25 +185,29 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
 	atval[4] = 0x01;
 	att_put_u16(FMT_OUTSIDE_UUID, &atval[5]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 7);
 
 	/* Thermometer: characteristic user description */
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_temp);
 	strncpy((char *) atval, desc_out_temp, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	/* Thermometer: relative humidity characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Thermometer: relative humidity value */
 	bt_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
 	atval[0] = 0x27;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 1);
 
 	/* Thermometer: relative humidity characteristic format */
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -209,13 +216,15 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
 	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
 	att_put_u16(FMT_OUTSIDE_UUID, &atval[6]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 8);
 
 	/* Thermometer: characteristic user description */
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	g_assert(h - start_handle == svc_size);
 
@@ -250,33 +259,38 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 	/* Secondary Service: Manufacturer Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Manufacturer name characteristic value */
 	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name1);
 	strncpy((char *) atval, manufacturer_name1, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	/* Manufacturer serial number characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Manufacturer serial number characteristic value */
 	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	g_assert(h - start_handle == svc_size);
 
@@ -308,33 +322,38 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 	/* Secondary Service: Manufacturer Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Manufacturer name attribute */
 	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name2);
 	strncpy((char *) atval, manufacturer_name2, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	/* Characteristic: serial number */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Serial number characteristic value */
 	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial2);
 	strncpy((char *) atval, serial2, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	g_assert(h - start_handle == svc_size);
 
@@ -363,14 +382,16 @@ static void register_vendor_service(struct gatt_example_adapter *adapter,
 	/* Secondary Service: Vendor Specific Service */
 	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* Vendor Specific Type characteristic value */
 	bt_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
@@ -380,7 +401,8 @@ static void register_vendor_service(struct gatt_example_adapter *adapter,
 	atval[3] = 0x64;
 	atval[4] = 0x6F;
 	atval[5] = 0x72;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 6);
 
 	g_assert(h - start_handle == svc_size);
 
@@ -422,7 +444,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	/* Weight service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	memcpy(atval, &prim_weight_uuid_btorder, 16);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 16);
 
 	if (vendor[0] && vendor[1]) {
 		/* Weight: include */
@@ -430,8 +453,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 		att_put_u16(vendor[0], &atval[0]);
 		att_put_u16(vendor[1], &atval[2]);
 		att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
-		attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
-									6);
+		attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 6);
 	}
 
 	/* Weight: characteristic */
@@ -439,7 +462,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(h + 1, &atval[1]);
 	memcpy(&atval[3], &char_weight_uuid_btorder, 16);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 19);
 
 	/* Weight: characteristic value */
 	bt_uuid128_create(&uuid, char_weight_uuid);
@@ -447,7 +471,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	atval[1] = 0x55;
 	atval[2] = 0x00;
 	atval[3] = 0x00;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 4);
 
 	/* Weight: characteristic format */
 	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
@@ -456,13 +481,15 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
 	att_put_u16(BLUETOOTH_SIG_UUID, &atval[4]);
 	att_put_u16(FMT_HANGING_UUID, &atval[6]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 8);
 
 	/* Weight: characteristic user description */
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
+	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, len);
 
 	g_assert(h - start_handle == svc_size);
 
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 050b1c7..d8cc58f 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -73,19 +73,22 @@ static void register_link_loss(void)
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(LINK_LOSS_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Alert level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Alert level value */
 	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
 	att_put_u8(NO_ALERT, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
 
 	g_assert(h - start_handle == svc_size);
 }
@@ -111,26 +114,30 @@ static void register_tx_power(void)
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(TX_POWER_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Power level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(POWER_LEVEL_CHR_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Power level value */
 	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
 	att_put_u8(0x00, &atval[0]);
 	tx_power_handle = h;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Client characteristic configuration */
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NONE, atval, 2);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 2);
 
 	g_assert(h - start_handle == svc_size);
 }
@@ -156,19 +163,22 @@ static void register_immediate_alert(void)
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(IMMEDIATE_ALERT_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Alert level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Alert level value */
 	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
 	att_put_u8(NO_ALERT, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
 
 	g_assert(h - start_handle == svc_size);
 }
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 6a3ce4f..cdf54ee 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1316,18 +1316,17 @@ uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems)
 	return 0;
 }
 
-struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
-				int write_reqs, const uint8_t *value, int len)
+struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
+				bt_uuid_t *uuid, int read_reqs, int write_reqs,
+						const uint8_t *value, int len)
 {
-	struct gatt_adapter *gadapter;
-
-	DBG("Deprecated function!");
+	GSList *l;
 
-	gadapter = get_default_gatt_adapter();
-	if (gadapter == NULL)
+	l = g_slist_find_custom(adapters, adapter, adapter_cmp);
+	if (l == NULL)
 		return NULL;
 
-	return attrib_db_add_new(gadapter, handle, uuid, read_reqs, write_reqs,
+	return attrib_db_add_new(l->data, handle, uuid, read_reqs, write_reqs,
 								value, len);
 }
 
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 8bf9c07..ac1c388 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -23,8 +23,9 @@
  */
 
 uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems);
-struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
-				int write_reqs, const uint8_t *value, int len);
+struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
+				bt_uuid_t *uuid, int read_reqs, int write_reqs,
+				const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr);
 int attrib_db_del(uint16_t handle);
-- 
1.7.8.1

