Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 8/8] gatt-example: Fix g_assert checks when an uint16_t value overflows
Date: Wed, 25 Jan 2012 14:12:41 +0100
Message-Id: <1327497161-14764-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1327497161-14764-8-git-send-email-sancane@gmail.com>
References: <1327497161-14764-1-git-send-email-sancane@gmail.com>
 <1327497161-14764-2-git-send-email-sancane@gmail.com>
 <1327497161-14764-3-git-send-email-sancane@gmail.com>
 <1327497161-14764-4-git-send-email-sancane@gmail.com>
 <1327497161-14764-5-git-send-email-sancane@gmail.com>
 <1327497161-14764-6-git-send-email-sancane@gmail.com>
 <1327497161-14764-7-git-send-email-sancane@gmail.com>
 <1327497161-14764-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_assert statements are buggy when the last handler available
overflows the uint16_t range. This check is currently used to
evaluate if the number of requested attributes for a sevice
match with the number of attributes added in the data base.
---
 plugins/gatt-example.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f12fbde..f026761 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -230,10 +230,10 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
-	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(adapter->adapter, h, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, len);
 
-	g_assert(h - start_handle == svc_size);
+	g_assert(h - start_handle + 1 == svc_size);
 
 	/* Add an SDP record for the above service */
 	sdp_handle = attrib_create_sdp(adapter->adapter, start_handle,
@@ -298,10 +298,10 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
-	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(adapter->adapter, h, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, len);
 
-	g_assert(h - start_handle == svc_size);
+	g_assert(h - start_handle + 1 == svc_size);
 
 	range[0] = start_handle;
 	range[1] = start_handle + svc_size - 1;
@@ -362,10 +362,10 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial2);
 	strncpy((char *) atval, serial2, len);
-	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(adapter->adapter, h, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, len);
 
-	g_assert(h - start_handle == svc_size);
+	g_assert(h - start_handle + 1 == svc_size);
 
 	range[0] = start_handle;
 	range[1] = start_handle + svc_size - 1;
@@ -412,10 +412,10 @@ static void register_vendor_service(struct gatt_example_adapter *adapter,
 	atval[3] = 0x64;
 	atval[4] = 0x6F;
 	atval[5] = 0x72;
-	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(adapter->adapter, h, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 6);
 
-	g_assert(h - start_handle == svc_size);
+	g_assert(h - start_handle + 1 == svc_size);
 
 	range[0] = start_handle;
 	range[1] = start_handle + svc_size - 1;
@@ -500,10 +500,9 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
-	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(adapter->adapter, h, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, len);
-
-	g_assert(h - start_handle == svc_size);
+	g_assert(h - start_handle + 1 == svc_size);
 
 	/* Add an SDP record for the above service */
 	sdp_handle = attrib_create_sdp(adapter->adapter, start_handle,
-- 
1.7.8.4

