Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH v2 21/40] android/gatt: Register GATT service
Date: Tue, 29 Apr 2014 18:47:10 +0200
Message-Id: <1398790049-30303-22-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This adds database record about gatt's 'services changed'
characteristic. Proper flag in device is being set to mark it for
notification if gatt services are changed.
---
 android/gatt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 9719637..dd1053f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -133,6 +133,8 @@ struct gatt_device {
 	GIOChannel *att_io;
 	struct queue *services;
 
+	bool notify_services_changed;
+
 	guint watch_id;
 	guint server_id;
 
@@ -3891,6 +3893,43 @@ static void register_device_info_service(void)
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 }
 
+static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
+						const uint8_t *val, size_t len,
+						void *req_data,
+						gatt_db_complete_func_t cb,
+						void *user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	struct req_data *data = req_data;
+	uint16_t length;
+
+	/* Set services changed notification flag */
+	data->dev->notify_services_changed = !!(*val);
+
+	length = enc_write_resp(pdu);
+
+	cb(data, pdu, length);
+}
+
+static void register_gatt_service(void)
+{
+	bt_uuid_t uuid;
+	uint16_t srvc_handle;
+
+	DBG("");
+
+	bt_uuid16_create(&uuid, 0x1801);
+	srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 3);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
+	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
+					GATT_CHR_PROP_INDICATE,
+					NULL, gatt_srvc_change_register_cb,
+					NULL);
+
+	gatt_db_service_set_active(gatt_db, srvc_handle, true);
+}
+
 static int start_listen_socket(void)
 {
 	GError *gerr = NULL;
@@ -3959,6 +3998,7 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 
 	register_gap_service();
 	register_device_info_service();
+	register_gatt_service();
 
 	return true;
 }
-- 
1.8.4

