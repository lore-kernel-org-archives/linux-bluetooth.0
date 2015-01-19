Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] core/device: Cleanup device_svc_resolved code
Date: Mon, 19 Jan 2015 15:55:42 +0200
Message-Id: <1421675742-20120-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This split device_svc_resolved into 2 parts with the later
browse_request_complete actually calling browse_request_free.
---
 src/device.c | 269 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 126 insertions(+), 143 deletions(-)

diff --git a/src/device.c b/src/device.c
index 63babc2..59e4dea 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1664,17 +1664,134 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	return btd_error_failed(msg, strerror(-err));
 }
 
+static void store_services(struct btd_device *device)
+{
+	struct btd_adapter *adapter = device->adapter;
+	char filename[PATH_MAX];
+	char src_addr[18], dst_addr[18];
+	uuid_t uuid;
+	char *prim_uuid;
+	GKeyFile *key_file;
+	GSList *l;
+	char *data;
+	gsize length = 0;
+
+	if (device_address_is_private(device)) {
+		warn("Can't store services for private addressed device %s",
+								device->path);
+		return;
+	}
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
+	if (prim_uuid == NULL)
+		return;
+
+	ba2str(btd_adapter_get_address(adapter), src_addr);
+	ba2str(&device->bdaddr, dst_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
+								dst_addr);
+	key_file = g_key_file_new();
+
+	for (l = device->primaries; l; l = l->next) {
+		struct gatt_primary *primary = l->data;
+		char handle[6], uuid_str[33];
+		int i;
+
+		sprintf(handle, "%hu", primary->range.start);
+
+		bt_string2uuid(&uuid, primary->uuid);
+		sdp_uuid128_to_uuid(&uuid);
+
+		switch (uuid.type) {
+		case SDP_UUID16:
+			sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
+			break;
+		case SDP_UUID32:
+			sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
+			break;
+		case SDP_UUID128:
+			for (i = 0; i < 16; i++)
+				sprintf(uuid_str + (i * 2), "%2.2X",
+						uuid.value.uuid128.data[i]);
+			break;
+		default:
+			uuid_str[0] = '\0';
+		}
+
+		g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
+		g_key_file_set_string(key_file, handle, "Value", uuid_str);
+		g_key_file_set_integer(key_file, handle, "EndGroupHandle",
+					primary->range.end);
+	}
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	free(prim_uuid);
+	g_free(data);
+	g_key_file_free(key_file);
+}
+
+static void browse_request_complete(struct browse_req *req, uint8_t bdaddr_type,
+									int err)
+{
+	struct btd_device *dev = req->device;
+	DBusMessage *reply = NULL;
+
+	if (!req->msg)
+		goto done;
+
+	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE, "Pair")) {
+		if (!device_is_paired(dev, bdaddr_type)) {
+			reply = btd_error_failed(req->msg, "Not paired");
+			goto done;
+		}
+
+		if (dev->pending_paired) {
+			g_dbus_emit_property_changed(dbus_conn, dev->path,
+						DEVICE_INTERFACE, "Paired");
+			dev->pending_paired = false;
+		}
+
+		/* Disregard browse errors in case of Pair */
+		reply = g_dbus_create_reply(req->msg, DBUS_TYPE_INVALID);
+		goto done;
+	}
+
+	if (err) {
+		reply = btd_error_failed(req->msg, strerror(-err));
+		goto done;
+	}
+
+	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE, "Connect"))
+		reply = dev_connect(dbus_conn, req->msg, dev);
+	else if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
+							"ConnectProfile"))
+		reply = connect_profile(dbus_conn, req->msg, dev);
+	else
+		reply = g_dbus_create_reply(req->msg, DBUS_TYPE_INVALID);
+
+done:
+	if (reply)
+		g_dbus_send_message(dbus_conn, reply);
+
+	browse_request_free(req);
+}
+
 static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 								int err)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
-	DBusMessage *reply;
 	struct browse_req *req = dev->browse;
 
 	DBG("%s err %d", dev->path, err);
 
 	state->svc_resolved = true;
-	dev->browse = NULL;
 
 	/* Disconnection notification can happen before this function
 	 * gets called, so don't set svc_refreshed for a disconnected
@@ -1708,34 +1825,14 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 	if (!dev->temporary)
 		store_device_info(dev);
 
-	if (!req || !req->msg)
-		return;
-
-	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
-								"Pair")) {
-		g_dbus_send_reply(dbus_conn, req->msg, DBUS_TYPE_INVALID);
-		return;
-	}
+	if (bdaddr_type != BDADDR_BREDR && err == 0)
+		store_services(dev);
 
-	if (err) {
-		reply = btd_error_failed(req->msg, strerror(-err));
-		g_dbus_send_message(dbus_conn, reply);
-		return;
-	}
-
-	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE, "Connect"))
-		reply = dev_connect(dbus_conn, req->msg, dev);
-	else if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
-							"ConnectProfile"))
-		reply = connect_profile(dbus_conn, req->msg, dev);
-	else
+	if (!req)
 		return;
 
-	dbus_message_unref(req->msg);
-	req->msg = NULL;
-
-	if (reply)
-		g_dbus_send_message(dbus_conn, reply);
+	dev->browse = NULL;
+	browse_request_complete(req, bdaddr_type, err);
 }
 
 static struct bonding_req *bonding_request_new(DBusMessage *msg,
@@ -2438,8 +2535,6 @@ static void device_add_uuids(struct btd_device *device, GSList *uuids)
 						DEVICE_INTERFACE, "UUIDs");
 }
 
-static void store_services(struct btd_device *device);
-
 struct gatt_probe_data {
 	struct btd_device *dev;
 	bool all_services;
@@ -3641,7 +3736,6 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 send_reply:
 	device_svc_resolved(device, BDADDR_BREDR, err);
-	browse_request_free(req);
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -3677,79 +3771,6 @@ done:
 	search_cb(recs, err, user_data);
 }
 
-static void store_services(struct btd_device *device)
-{
-	struct btd_adapter *adapter = device->adapter;
-	char filename[PATH_MAX];
-	char src_addr[18], dst_addr[18];
-	uuid_t uuid;
-	char *prim_uuid;
-	GKeyFile *key_file;
-	GSList *l;
-	char *data;
-	gsize length = 0;
-
-	if (device_address_is_private(device)) {
-		warn("Can't store services for private addressed device %s",
-								device->path);
-		return;
-	}
-
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	prim_uuid = bt_uuid2string(&uuid);
-	if (prim_uuid == NULL)
-		return;
-
-	ba2str(btd_adapter_get_address(adapter), src_addr);
-	ba2str(&device->bdaddr, dst_addr);
-
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
-								dst_addr);
-	key_file = g_key_file_new();
-
-	for (l = device->primaries; l; l = l->next) {
-		struct gatt_primary *primary = l->data;
-		char handle[6], uuid_str[33];
-		int i;
-
-		sprintf(handle, "%hu", primary->range.start);
-
-		bt_string2uuid(&uuid, primary->uuid);
-		sdp_uuid128_to_uuid(&uuid);
-
-		switch (uuid.type) {
-		case SDP_UUID16:
-			sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
-			break;
-		case SDP_UUID32:
-			sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
-			break;
-		case SDP_UUID128:
-			for (i = 0; i < 16; i++)
-				sprintf(uuid_str + (i * 2), "%2.2X",
-						uuid.value.uuid128.data[i]);
-			break;
-		default:
-			uuid_str[0] = '\0';
-		}
-
-		g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
-		g_key_file_set_string(key_file, handle, "Value", uuid_str);
-		g_key_file_set_integer(key_file, handle, "EndGroupHandle",
-					primary->range.end);
-	}
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
-		g_file_set_contents(filename, data, length, NULL);
-	}
-
-	free(prim_uuid);
-	g_free(data);
-	g_key_file_free(key_file);
-}
-
 static bool device_get_auto_connect(struct btd_device *device)
 {
 	if (device->disable_auto_connect)
@@ -3811,36 +3832,6 @@ done:
 	attio_cleanup(device);
 }
 
-static void send_le_browse_response(struct browse_req *req)
-{
-	struct btd_device *dev = req->device;
-	struct bearer_state *state = &dev->le_state;
-	DBusMessage *reply, *msg = req->msg;
-
-	if (!msg)
-		return;
-
-	if (!dbus_message_is_method_call(msg, DEVICE_INTERFACE, "Pair")) {
-		reply = btd_error_failed(msg, "Service discovery failed");
-		g_dbus_send_message(dbus_conn, reply);
-		return;
-	}
-
-	if (!state->paired) {
-		reply = btd_error_failed(msg, "Not paired");
-		g_dbus_send_message(dbus_conn, reply);
-		return;
-	}
-
-	if (!dev->bredr_state.paired && dev->pending_paired) {
-		g_dbus_emit_property_changed(dbus_conn, dev->path,
-						DEVICE_INTERFACE, "Paired");
-		dev->pending_paired = false;
-	}
-
-	g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
-}
-
 static void register_gatt_services(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
@@ -3866,10 +3857,6 @@ static void register_gatt_services(struct browse_req *req)
 	device_probe_gatt_profiles(device);
 
 	device_svc_resolved(device, device->bdaddr_type, 0);
-
-	store_services(device);
-
-	browse_request_free(req);
 }
 
 static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
@@ -3883,9 +3870,8 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 		if (device->browse) {
 			struct browse_req *req = device->browse;
 
-			send_le_browse_response(req);
 			device->browse = NULL;
-			browse_request_free(req);
+			browse_request_complete(req, device->bdaddr_type, -EIO);
 		}
 
 		return;
@@ -4153,9 +4139,8 @@ static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 	struct btd_device *device = attcb->user_data;
 	struct browse_req *req = device->browse;
 
-	send_le_browse_response(req);
 	device->browse = NULL;
-	browse_request_free(req);
+	browse_request_complete(req, device->bdaddr_type, -ECONNABORTED);
 }
 
 static void att_browse_cb(gpointer user_data)
@@ -4216,8 +4201,6 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 		 * request as resolved.
 		 */
 		device_svc_resolved(device, device->bdaddr_type, 0);
-		device->browse = NULL;
-		browse_request_free(req);
 		return 0;
 	}
 
-- 
1.9.3

