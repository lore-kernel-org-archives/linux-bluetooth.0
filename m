Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH v2 19/40] android/gatt: Register device information service
Date: Tue, 29 Apr 2014 18:47:08 +0200
Message-Id: <1398790049-30303-20-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This adds placeholder data to device information service. To get
real data we should figure out the best way to get Android's system
properties and expose them to profiles for reading.
---
 android/gatt.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 88e583c..9719637 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3800,6 +3800,97 @@ static void register_gap_service(void)
 
 	gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
 }
+
+/* TODO: Get those data from device possible via androig/bluetooth.c */
+static struct device_info {
+	const char *manufacturer_name;
+	const char *system_id;
+	const char *model_number;
+	const char *serial_number;
+	const char *firmware_rev;
+	const char *hardware_rev;
+	const char *software_rev;
+} device_info = {
+	.manufacturer_name =	"BlueZ",
+	.system_id =		"BlueZ for Android",
+	.model_number =		"model no",
+	.serial_number =	"serial no",
+	.firmware_rev =		"firmware rev",
+	.hardware_rev =		"hardware rev",
+	.software_rev =		"software rev",
+};
+
+static void device_info_read_cb(uint16_t handle, uint16_t offset,
+					void *req_data,
+					gatt_db_complete_func_t cb,
+					void *user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	char *buf = user_data;
+	uint16_t len;
+
+	len = enc_read_resp((uint8_t *) buf, strlen(buf), pdu, sizeof(pdu));
+
+	cb(req_data, pdu, len);
+}
+
+static void register_device_info_service(void)
+{
+	bt_uuid_t uuid;
+	uint16_t srvc_handle;
+
+	DBG("");
+
+	/* Device Information Service */
+	bt_uuid16_create(&uuid, 0x180a);
+	srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 15);
+
+	/* User data are not const hence (void *) cast is used */
+	bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.system_id);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.model_number);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.serial_number);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.firmware_rev);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.hardware_rev);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.software_rev);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_READ,
+					device_info_read_cb, NULL,
+					(void *) device_info.manufacturer_name);
+
+	gatt_db_service_set_active(gatt_db, srvc_handle, true);
+}
+
 static int start_listen_socket(void)
 {
 	GError *gerr = NULL;
@@ -3867,6 +3958,7 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		error("Could not start GATT listening");
 
 	register_gap_service();
+	register_device_info_service();
 
 	return true;
 }
-- 
1.8.4

