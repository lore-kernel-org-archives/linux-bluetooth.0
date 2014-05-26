Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] android/gatt: Add proper permissions to built-in services
Date: Mon, 26 May 2014 11:10:28 +0200
Message-Id: <1401095429-28432-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set permissions to built in services.
---
 android/gatt.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index bfcbb62..cde8816 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5078,7 +5078,7 @@ static void register_gap_service(void)
 	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
 	gap_srvc_data.dev_name =
 			gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
-							&uuid, 0,
+							&uuid, GATT_PERM_READ,
 							GATT_CHR_PROP_READ,
 							gap_read_cb, NULL,
 							NULL);
@@ -5087,7 +5087,7 @@ static void register_gap_service(void)
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
 	gap_srvc_data.appear =
 			gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
-							&uuid, 0,
+							&uuid, GATT_PERM_READ,
 							GATT_CHR_PROP_READ,
 							gap_read_cb, NULL,
 							NULL);
@@ -5096,7 +5096,7 @@ static void register_gap_service(void)
 	bt_uuid16_create(&uuid, GATT_CHARAC_PERIPHERAL_PRIV_FLAG);
 	gap_srvc_data.priv =
 			gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
-							&uuid, 0,
+							&uuid, GATT_PERM_READ,
 							GATT_CHR_PROP_READ,
 							gap_read_cb, NULL,
 							NULL);
@@ -5169,43 +5169,43 @@ static void register_device_info_service(void)
 
 	/* User data are not const hence (void *) cast is used */
 	bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.system_id);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.model_number);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.serial_number);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.firmware_rev);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.hardware_rev);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.software_rev);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_READ,
 					device_info_read_cb, NULL,
 					(void *) device_info.manufacturer_name);
@@ -5250,13 +5250,14 @@ static void register_gatt_service(void)
 	srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
 					GATT_CHR_PROP_INDICATE, NULL, NULL,
 					NULL);
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	gatt_db_add_char_descriptor(gatt_db, srvc_handle, &uuid, 0, NULL,
-					gatt_srvc_change_register_cb, NULL);
+	gatt_db_add_char_descriptor(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
+					NULL, gatt_srvc_change_register_cb,
+					NULL);
 
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 }
-- 
1.9.0

