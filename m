Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] adapter: Add ConnectDevice method
Date: Fri, 19 Jan 2018 15:52:16 +0100
Message-Id: <20180119145216.30032-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to connect device without doing general discovery. This is
needed for some of qualification tests where there is no general
discovery upfront and we need to do connection to device with provided
address.

Another usecase is for scenario where scanning happen on one controller but
connection handling on another.

Implementation wide this results in new temporary object being created and
connect being called on it which behaves exactly the same as if Connect
method from Device1 interface was called on discovered device. If connection
fails, created object is removed. On success this method returns path to
created device object.

This patch implements bare minimum properties needed for connection - address
and address type. If needed eg. for non-NFC based OOB it could be extended with
more options.
---
 doc/adapter-api.txt | 36 ++++++++++++++++++++++
 src/adapter.c       | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c        | 64 +++++++++++++++++++++++++++++++-------
 src/device.h        |  2 ++
 4 files changed, 180 insertions(+), 11 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 0533b674a..67b7ca487 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -145,6 +145,42 @@ Methods		void StartDiscovery()
 
 			Possible errors: None
 
+		object ConnectDevice(dict properties) [experimental]
+
+			This method creates new temporary device with defined
+			properties and issues connection to that device without
+			need of performing General Discovery first. Connection
+			mechanism is the same as if Connect method from Device1
+			interface was called. If connection failed, created
+			device is removed and this method fails. If connection
+			was successful this method returns object path to
+			created device object.
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
index 0a25ae27e..31686bc04 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3080,6 +3080,92 @@ static DBusMessage *get_discovery_filters(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *connect_device(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter iter, subiter, dictiter, value;
+	uint8_t addr_type = BDADDR_BREDR;
+	bdaddr_t addr = *BDADDR_ANY;
+	struct btd_device *device;
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
+	do {
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
+	} while (true);
+
+	if (!bacmp(&addr, BDADDR_ANY))
+		return btd_error_invalid_args(msg);
+
+	device = btd_adapter_find_device(adapter, &addr, addr_type);
+	if (device)
+		return btd_error_already_exists(msg);
+
+	device = adapter_create_device(adapter, &addr, addr_type);
+	if (!device)
+		return btd_error_failed(msg, "Failed to create new device");
+
+	device_update_last_seen(device, addr_type);
+
+	return device_connect(conn, msg, device);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -3091,6 +3177,9 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("GetDiscoveryFilters", NULL,
 			GDBUS_ARGS({ "filters", "as" }),
 			get_discovery_filters) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ConnectDevice",
+				GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
+				connect_device) },
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index 1acecce33..5efde4b54 100644
--- a/src/device.c
+++ b/src/device.c
@@ -624,6 +624,11 @@ static void browse_request_cancel(struct browse_req *req)
 
 	attio_cleanup(device);
 
+	if (req->msg && dbus_message_is_method_call(req->msg,
+				"org.bluez.Adapter1", "ConnectDevice"))
+		g_dbus_send_message(dbus_conn, btd_error_failed(req->msg,
+							strerror(ECANCELED)));
+
 	browse_request_free(req);
 }
 
@@ -1577,9 +1582,14 @@ done:
 	if (!dev->connect)
 		return;
 
-	if (!err && dbus_message_is_method_call(dev->connect, DEVICE_INTERFACE,
-								"Connect"))
+	if (!err) {
+		if (dbus_message_is_method_call(dev->connect, DEVICE_INTERFACE,
+								"Connect") ||
+				dbus_message_is_method_call(dev->connect,
+					"org.bluez.Adapter1", "ConnectDevice"))
 		dev->general_connect = TRUE;
+		btd_device_set_temporary(dev, false);
+	}
 
 	DBG("returning response to %s", dbus_message_get_sender(dev->connect));
 
@@ -1599,7 +1609,15 @@ done:
 		/* Start passive SDP discovery to update known services */
 		if (dev->bredr && !dev->svc_refreshed)
 			device_browse_sdp(dev, NULL);
-		g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
+
+		if (dbus_message_is_method_call(dev->connect,
+					"org.bluez.Adapter1", "ConnectDevice"))
+			g_dbus_send_reply(dbus_conn, dev->connect,
+						DBUS_TYPE_OBJECT_PATH,
+						&dev->path, DBUS_TYPE_INVALID);
+		else
+			g_dbus_send_reply(dbus_conn, dev->connect,
+							DBUS_TYPE_INVALID);
 	}
 
 	dbus_message_unref(dev->connect);
@@ -1773,11 +1791,15 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (!btd_adapter_get_powered(dev->adapter))
 		return btd_error_not_ready(msg);
 
-	btd_device_set_temporary(dev, false);
+	if (!dbus_message_is_method_call(msg, "org.bluez.Adapter1",
+							"ConnectDevice"))
+		btd_device_set_temporary(dev, false);
 
 	if (!state->svc_resolved)
 		goto resolve_services;
 
+	/* will never happen for ConnectDevice call */
+
 	dev->pending = create_pending_list(dev, uuid);
 	if (!dev->pending) {
 		if (dev->svc_refreshed) {
@@ -1864,7 +1886,7 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	return dev->bdaddr_type;
 }
 
-static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
+DBusMessage *device_connect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *dev = user_data;
@@ -1889,10 +1911,13 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	if (bdaddr_type != BDADDR_BREDR) {
 		int err;
 
+		/* This will never happen for ConnectDevice call */
 		if (dev->le_state.connected)
 			return dbus_message_new_method_return(msg);
 
-		btd_device_set_temporary(dev, false);
+		if (!dbus_message_is_method_call(msg, "org.bluez.Adapter1",
+							"ConnectDevice"))
+			btd_device_set_temporary(dev, false);
 
 		if (dev->disable_auto_connect) {
 			dev->disable_auto_connect = FALSE;
@@ -2272,12 +2297,15 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 	 * device->browse is set and "InProgress" error is returned instead
 	 * of actually connecting services
 	 */
+
 	msg = dbus_message_ref(req->msg);
 	browse_request_free(req);
 	req = NULL;
 
-	if (dbus_message_is_method_call(msg, DEVICE_INTERFACE, "Connect"))
-		reply = dev_connect(dbus_conn, msg, dev);
+	if (dbus_message_is_method_call(msg, DEVICE_INTERFACE, "Connect") ||
+		dbus_message_is_method_call(msg, "org.bluez.Adapter1",
+							"ConnectDevice"))
+		reply = device_connect(dbus_conn, msg, dev);
 	else if (dbus_message_is_method_call(msg, DEVICE_INTERFACE,
 							"ConnectProfile"))
 		reply = connect_profile(dbus_conn, msg, dev);
@@ -2624,7 +2652,7 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, device_connect) },
 	{ GDBUS_ASYNC_METHOD("ConnectProfile", GDBUS_ARGS({ "UUID", "s" }),
 						NULL, connect_profile) },
 	{ GDBUS_ASYNC_METHOD("DisconnectProfile", GDBUS_ARGS({ "UUID", "s" }),
@@ -4998,16 +5026,30 @@ done:
 		device_browse_gatt(device, NULL);
 
 	if (device->connect) {
-		if (err < 0)
+		if (err < 0) {
 			reply = btd_error_failed(device->connect,
 							strerror(-err));
-		else
+		} else {
 			reply = dbus_message_new_method_return(device->connect);
 
+			if (dbus_message_is_method_call(device->connect,
+					"org.bluez.Adapter1", "ConnectDevice"))
+				dbus_message_append_args(reply,
+							DBUS_TYPE_OBJECT_PATH,
+							&device->path,
+							DBUS_TYPE_INVALID);
+		}
+
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
 	}
+
+	/* This is the case only for error in ConnectProfile, otherwise device
+	 * is not temporary
+	 */
+	if (err && device_is_temporary(device))
+		btd_adapter_remove_device(device->adapter, device);
 }
 
 int device_connect_le(struct btd_device *dev)
diff --git a/src/device.h b/src/device.h
index bc046f780..608bc27d3 100644
--- a/src/device.h
+++ b/src/device.h
@@ -151,6 +151,8 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version);
 
 int device_connect_le(struct btd_device *dev);
+DBusMessage *device_connect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data);
 
 typedef void (*device_svc_cb_t) (struct btd_device *dev, int err,
 							void *user_data);
-- 
2.14.3

