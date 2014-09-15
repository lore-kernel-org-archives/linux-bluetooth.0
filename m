Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/11] android/gatt: Use configuration data for device information profile
Date: Mon, 15 Sep 2014 16:49:10 +0200
Message-Id: <1410792555-24765-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 115 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 52 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5a1d215..b008a1d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6386,23 +6386,6 @@ static void register_gap_service(void)
 		error("gatt: Failed to register GAP SDP record");
 }
 
-/* TODO: Get those data from device possible via androig/bluetooth.c */
-static struct device_info {
-	const char *manufacturer_name;
-	const char *model_number;
-	const char *serial_number;
-	const char *firmware_rev;
-	const char *hardware_rev;
-	const char *software_rev;
-} device_info = {
-	.manufacturer_name =	"BlueZ for Android",
-	.model_number =		"model no",
-	.serial_number =	"serial no",
-	.firmware_rev =		"firmware rev",
-	.hardware_rev =		"hardware rev",
-	.software_rev =		"software rev",
-};
-
 static void device_info_read_cb(uint16_t handle, uint16_t offset,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
 					void *user_data)
@@ -6440,6 +6423,7 @@ static void register_device_info_service(void)
 {
 	bt_uuid_t uuid;
 	uint16_t srvc_handle, end_handle;
+	const char *data;
 
 	DBG("");
 
@@ -6448,41 +6432,68 @@ static void register_device_info_service(void)
 	srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 15);
 
 	/* User data are not const hence (void *) cast is used */
-	bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.model_number);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.serial_number);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.firmware_rev);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.hardware_rev);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.software_rev);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.manufacturer_name);
+	data = bt_config_get_name();
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	data = NULL;
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	data = NULL;
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	data = NULL;
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	data = bt_config_get_vendor();
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
+						GATT_PERM_READ,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
 
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 
-- 
1.9.3

