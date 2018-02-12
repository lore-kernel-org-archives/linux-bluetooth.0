Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v3] adapter: Add ConnectDevice method
Date: Mon, 12 Feb 2018 22:59:46 +0100
Message-Id: <20180212215946.30909-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to connect device without doing general discovery. This is
needed for some of qualification tests where there is no general
discovery upfront and we need to do connection to device with provided
address.

Another usecase is for scenario where scanning happen on one controller
but connection handling on another.

New device object is announced only if physical connection was
successful. On success this method returns path to created device
object. After ConnectProfile return bluetoothd continue with
services discovery and profile connection.

This patch implements bare minimum properties needed for connection -
address and address type. If needed eg. for non-NFC based OOB it could
be extended with more options.
---
 doc/adapter-api.txt |  40 ++++++++++++
 src/adapter.c       | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c        |  32 +++++----
 3 files changed, 241 insertions(+), 14 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 0533b674a..23121a936 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -145,6 +145,46 @@ Methods		void StartDiscovery()
 
 			Possible errors: None
 
+		object ConnectDevice(dict properties) [experimental]
+
+			This method creates new temporary device with defined
+			properties and issues connection to that device without
+			need of performing General Discovery first. Connection
+			mechanism is similar to Connect method from Device1
+			interface with exception that this method returns
+			success when physical connection is established. After
+			this method returns bluetoothd will continue with
+			services discovery and connect any supported profiles so
+			there is no need for calling Connect on Device1.
+			If connection failed, created device is removed and this
+			method fails. If connection was successful this method
+			returns object path to created device object.
+
+			Parameters that may be set in the filter dictionary
+			include the following:
+
+			string Address
+
+				The Bluetooth device address of the remote
+				device. This parameter is mandatory.
+
+			string AddressType
+
+				The Bluetooth device Address Type. This is
+				address type that should be used for initial
+				connection. If this parameter is not present
+				BR/EDR device is created.
+
+				Possible values:
+					"public" - Public address
+					"random" - Random address
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+					 org.bluez.Error.NotSupported
+					 org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
diff --git a/src/adapter.c b/src/adapter.c
index bd5c1e150..3a62dd142 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -59,6 +59,7 @@
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 
+#include "btio/btio.h"
 #include "hcid.h"
 #include "sdpd.h"
 #include "adapter.h"
@@ -3074,6 +3075,185 @@ static DBusMessage *get_discovery_filters(DBusConnection *conn,
 	return reply;
 }
 
+struct device_connect_data {
+	struct btd_adapter *adapter;
+	bdaddr_t dst;
+	uint8_t dst_type;
+	DBusMessage *msg;
+};
+
+static void device_browse_cb(struct btd_device *dev, int err, void *user_data)
+{
+	DBG("err %d (%s)", err, strerror(-err));
+
+	if (!err)
+		btd_device_connect_services(dev, NULL);
+}
+
+static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	struct device_connect_data *data = user_data;
+	struct btd_adapter *adapter = data->adapter;
+	struct btd_device *device;
+	const char *path;
+
+	DBG("%s", gerr ? gerr->message : "");
+
+	if (gerr)
+		goto failed;
+
+	/* object might already exist due to mgmt socket event */
+	device = btd_adapter_get_device(adapter, &data->dst, data->dst_type);
+	if (!device)
+		goto failed;
+
+	path = device_get_path(device);
+
+	g_dbus_send_reply(dbus_conn, data->msg, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID);
+
+	/* continue with service discovery and connection */
+	btd_device_set_temporary(device, false);
+	device_update_last_seen(device, data->dst_type);
+
+	if (data->dst_type != BDADDR_BREDR){
+		g_io_channel_set_close_on_unref(io, FALSE);
+		device_attach_att(device, io);
+	}
+
+	device_discover_services(device);
+	device_wait_for_svc_complete(device, device_browse_cb, NULL);
+
+	g_io_channel_unref(io);
+	dbus_message_unref(data->msg);
+	free(data);
+	return;
+
+failed:
+	g_dbus_send_error(dbus_conn, data->msg, "org.bluez.Failed", NULL);
+	g_io_channel_unref(io);
+	dbus_message_unref(data->msg);
+	free(data);
+}
+
+static void device_connect(struct btd_adapter *adapter, const bdaddr_t *dst,
+					uint8_t dst_type, DBusMessage *msg)
+{
+	struct device_connect_data *data;
+	GIOChannel *io;
+
+	data = new0(struct device_connect_data, 1);
+	data->adapter = adapter;
+	bacpy(&data->dst, dst);
+	data->dst_type = dst_type;
+	data->msg = dbus_message_ref(msg);
+
+	if (dst_type == BDADDR_BREDR)
+		io = bt_io_connect(device_connect_cb, data, NULL, NULL,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter->bdaddr,
+				BT_IO_OPT_SOURCE_TYPE, BDADDR_BREDR,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_DEST_TYPE, BDADDR_BREDR,
+				BT_IO_OPT_PSM, SDP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	else
+		io = bt_io_connect(device_connect_cb, data, NULL, NULL,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter->bdaddr,
+				BT_IO_OPT_SOURCE_TYPE, adapter->bdaddr_type,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_DEST_TYPE, dst_type,
+				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+
+	if (!io) {
+		g_dbus_send_message(dbus_conn,
+				btd_error_failed(msg, "Connect failed"));
+		dbus_message_unref(data->msg);
+		free(data);
+	}
+}
+
+static DBusMessage *connect_device(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter iter, subiter, dictiter, value;
+	uint8_t addr_type = BDADDR_BREDR;
+	bdaddr_t addr = *BDADDR_ANY;
+
+	DBG("sender %s", dbus_message_get_sender(msg));
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
+	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &subiter);
+	while (true) {
+		int type = dbus_message_iter_get_arg_type(&subiter);
+		char *key;
+		char *str;
+
+		if (type == DBUS_TYPE_INVALID)
+			break;
+
+		dbus_message_iter_recurse(&subiter, &dictiter);
+
+		dbus_message_iter_get_basic(&dictiter, &key);
+		if (!dbus_message_iter_next(&dictiter))
+			return btd_error_invalid_args(msg);
+
+		if (dbus_message_iter_get_arg_type(&dictiter) !=
+							DBUS_TYPE_VARIANT)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&dictiter, &value);
+
+		if (!strcmp(key, "Address")) {
+			if (dbus_message_iter_get_arg_type(&value) !=
+							DBUS_TYPE_STRING)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_get_basic(&value, &str);
+
+			if (str2ba(str, &addr) < 0 )
+				return btd_error_invalid_args(msg);
+		} else if (!strcmp(key, "AddressType")) {
+			if (dbus_message_iter_get_arg_type(&value) !=
+							DBUS_TYPE_STRING)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_get_basic(&value, &str);
+
+
+			if (!strcmp(str, "public"))
+				addr_type = BDADDR_LE_PUBLIC;
+			else if (!strcmp(str, "random"))
+				addr_type = BDADDR_LE_RANDOM;
+			else
+				return btd_error_invalid_args(msg);
+		} else {
+			return btd_error_invalid_args(msg);
+		}
+
+		dbus_message_iter_next(&subiter);
+	}
+
+	if (!bacmp(&addr, BDADDR_ANY))
+		return btd_error_invalid_args(msg);
+
+	if (btd_adapter_find_device(adapter, &addr, addr_type))
+		return btd_error_already_exists(msg);
+
+	device_connect(adapter, &addr, addr_type, msg);
+	return NULL;
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -3085,6 +3265,9 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("GetDiscoveryFilters", NULL,
 			GDBUS_ARGS({ "filters", "as" }),
 			get_discovery_filters) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ConnectDevice",
+				GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
+				connect_device) },
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index 1acecce33..1633516a7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1749,10 +1749,16 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 	if (!dev->bredr_state.svc_resolved)
 		return -ENOENT;
 
-	for (l = services; l; l = g_slist_next(l)) {
-		struct btd_service *service = l->data;
+	if (services) {
+		for (l = services; l; l = g_slist_next(l)) {
+			struct btd_service *service = l->data;
+
+			dev->pending = g_slist_append(dev->pending, service);
+		}
+	} else {
+		dev->pending = create_pending_list(dev, NULL);
 
-		dev->pending = g_slist_append(dev->pending, service);
+		DBG("BLAH %d", g_slist_length(dev->pending));
 	}
 
 	return connect_next(dev);
@@ -2331,6 +2337,15 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 		dev->pending_paired = false;
 	}
 
+	if (!dev->temporary)
+		store_device_info(dev);
+
+	if (bdaddr_type != BDADDR_BREDR && err == 0)
+		store_services(dev);
+
+	if (req)
+		browse_request_complete(req, browse_type, bdaddr_type, err);
+
 	while (dev->svc_callbacks) {
 		struct svc_callback *cb = dev->svc_callbacks->data;
 
@@ -2343,17 +2358,6 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 							dev->svc_callbacks);
 		g_free(cb);
 	}
-
-	if (!dev->temporary)
-		store_device_info(dev);
-
-	if (bdaddr_type != BDADDR_BREDR && err == 0)
-		store_services(dev);
-
-	if (!req)
-		return;
-
-	browse_request_complete(req, browse_type, bdaddr_type, err);
 }
 
 static struct bonding_req *bonding_request_new(DBusMessage *msg,
-- 
2.14.3

