Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/gatt: Store CCC and indicate service change
Date: Wed,  4 Jun 2014 16:36:31 +0200
Message-Id: <1401892593-11586-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401892593-11586-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401892593-11586-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We indicate service change on service stop and service start API calls.
Indication is also send when connecting to bonded device to force it
rebuilding its cache. Write request is properly handled on the response
queue know.
---
 android/gatt.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 16 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 429181f..058cf87 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -160,8 +160,6 @@ struct gatt_device {
 	struct queue *services;
 	bool partial_srvc_search;
 
-	bool notify_services_changed;
-
 	guint watch_id;
 	guint server_id;
 
@@ -189,6 +187,8 @@ static struct queue *app_connections = NULL;
 static struct queue *listen_apps = NULL;
 static struct gatt_db *gatt_db = NULL;
 
+static uint16_t service_changed_handle = 0;
+
 static GIOChannel *listening_io = NULL;
 
 static struct bt_crypto *crypto = NULL;
@@ -1076,10 +1076,45 @@ static void send_exchange_mtu_request(struct gatt_device *device)
 		device_unref(device);
 }
 
+static void notify_att_range_change(struct gatt_device *dev,
+							struct att_range *range)
+{
+	uint16_t length = 0;
+	uint16_t ccc;
+	uint8_t *pdu;
+	size_t mtu;
+
+	ccc = bt_get_gatt_ccc(&dev->bdaddr);
+	if (!ccc)
+		return;
+
+	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
+
+	switch (ccc) {
+	case 0x0001:
+		length = enc_notification(service_changed_handle,
+						(uint8_t *) range,
+						sizeof(*range), pdu, mtu);
+		break;
+	case 0x0002:
+		length = enc_indication(service_changed_handle,
+					(uint8_t *) range, sizeof(*range), pdu,
+					mtu);
+		break;
+	default:
+		/* 0xfff4 reserved for future use */
+		break;
+	}
+
+	if (length)
+		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
 	struct connect_data data;
+	struct att_range range;
 	uint32_t status;
 	GAttrib *attrib;
 
@@ -1125,6 +1160,22 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	/* TODO: Dont exchange mtu if no client apps */
 	send_exchange_mtu_request(dev);
 
+	/*
+	 * Service Changed Characteristic and CCC Descriptor handles
+	 * should not change if there are bonded devices. We have them
+	 * constant all the time, thus they should be excluded from
+	 * range indicating changes.
+	 */
+	range.start = service_changed_handle + 2;
+	range.end = 0xffff;
+
+	/*
+	 * If there is ccc stored for that device we were acting as server for
+	 * it, and as we dont have last connect and last services (de)activation
+	 * timestamps we should always assume something has changed.
+	 */
+	notify_att_range_change(dev, &range);
+
 	status = GATT_SUCCESS;
 
 reply:
@@ -4407,6 +4458,20 @@ failed:
 				HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, status);
 }
 
+static void notify_service_change(void *data, void *user_data)
+{
+	struct att_range range;
+
+	range.start = PTR_TO_UINT(user_data);
+	range.end = gatt_db_get_end_handle(gatt_db, range.start);
+
+	/* In case of db error */
+	if (!range.end)
+		return;
+
+	notify_att_range_change(data, &range);
+}
+
 static void handle_server_start_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_start_service *cmd = buf;
@@ -4432,6 +4497,9 @@ static void handle_server_start_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	queue_foreach(gatt_devices, notify_service_change,
+					UINT_TO_PTR(cmd->service_handle));
+
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -4468,6 +4536,9 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
 	else
 		status = HAL_STATUS_SUCCESS;
 
+	queue_foreach(gatt_devices, notify_service_change,
+					UINT_TO_PTR(cmd->service_handle));
+
 failed:
 	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
 	ev.server_if = cmd->server_if;
@@ -5588,10 +5659,8 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 						bdaddr_t *bdaddr,
 						void *user_data)
 {
+	struct pending_request *entry;
 	struct gatt_device *dev;
-	uint16_t length;
-	size_t mtu;
-	uint8_t *pdu;
 
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
@@ -5599,16 +5668,20 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
-	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
-
-	/* TODO handle CCC */
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		return;
 
-	/* Set services changed notification flag */
-	dev->notify_services_changed = !!(*val);
+	entry->state = REQUEST_DONE;
 
-	length = enc_write_resp(pdu);
+	if (!bt_device_is_bonded(bdaddr)) {
+		entry->error = ATT_ECODE_AUTHORIZATION;
+		return;
+	}
 
-	g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
+	/* Set services changed indication value */
+	bt_store_gatt_ccc(bdaddr, *val);
 }
 
 static void register_gatt_service(void)
@@ -5622,14 +5695,15 @@ static void register_gatt_service(void)
 	srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
-	gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
+	service_changed_handle =  gatt_db_add_characteristic(gatt_db,
+					srvc_handle, &uuid, 0,
 					GATT_CHR_PROP_INDICATE, NULL, NULL,
 					NULL);
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	gatt_db_add_char_descriptor(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
-					NULL, gatt_srvc_change_register_cb,
-					NULL);
+	gatt_db_add_char_descriptor(gatt_db, srvc_handle, &uuid,
+					GATT_PERM_WRITE, NULL,
+					gatt_srvc_change_register_cb, NULL);
 
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 }
-- 
2.0.0

