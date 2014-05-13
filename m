Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 6/6] android/gatt: Use configuration data for device information profile
Date: Tue, 13 May 2014 19:09:21 +0200
Message-Id: <1400000961-24376-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
References: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 125 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 157ebe6..c213eb0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4532,25 +4532,6 @@ static void register_gap_service(void)
 	gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
 }
 
-/* TODO: Get those data from device possible via androig/bluetooth.c */
-static struct device_info {
-	const char *manufacturer_name;
-	const char *system_id;
-	const char *model_number;
-	const char *serial_number;
-	const char *firmware_rev;
-	const char *hardware_rev;
-	const char *software_rev;
-} device_info = {
-	.manufacturer_name =	"BlueZ",
-	.system_id =		"BlueZ for Android",
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
@@ -4575,6 +4556,7 @@ static void register_device_info_service(void)
 {
 	bt_uuid_t uuid;
 	uint16_t srvc_handle;
+	const char *data;
 
 	DBG("");
 
@@ -4583,47 +4565,72 @@ static void register_device_info_service(void)
 	srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 15);
 
 	/* User data are not const hence (void *) cast is used */
-	bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.system_id);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.model_number);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.serial_number);
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.firmware_rev);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.hardware_rev);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.software_rev);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
-					GATT_CHR_PROP_READ,
-					device_info_read_cb, NULL,
-					(void *) device_info.manufacturer_name);
+	data = bt_config_get_system_id();
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	data = bt_config_get_model();
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	data = bt_config_get_serial();
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	data = NULL;
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	data = NULL;
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	/* TODO */
+	data = NULL;
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
+
+	data = bt_config_get_manufacturer();
+	if (data) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
+		gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+						GATT_CHR_PROP_READ,
+						device_info_read_cb, NULL,
+						(void *) data);
+	}
 
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 }
-- 
1.9.1

