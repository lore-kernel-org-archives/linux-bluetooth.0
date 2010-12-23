Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v5 2/5] Change CreatePairedDevice to support LE devices
Date: Thu, 23 Dec 2010 16:29:50 -0500
Message-Id: <1293139790-9646-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20101221084243.GA14108@jh-x301>
References: <20101221084243.GA14108@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CreatePairedDevice implements now the same behaviour of CreateDevice,
triggering Discover All Primary Services when needed. SMP negotiation
starts when the link is established. LE capable kernel is required to
test this method properly.

Limitation: For dual mode devices, Discover All Primary Services is not
being executed after SDP search if GATT record is found.
---
 src/adapter.c     |  102 +++++++++++++++++++++++++++++++++++++----------------
 src/device.c      |   89 ++++++++++++++++++++++++----------------------
 src/device.h      |    5 ++-
 src/glib-helper.c |   12 +++++-
 src/glib-helper.h |    1 +
 5 files changed, 132 insertions(+), 77 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1913171..fddf0ad 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1520,15 +1520,48 @@ static gboolean event_is_connectable(uint8_t type)
 	}
 }
 
+static struct btd_device *create_device_internal(DBusConnection *conn,
+						struct btd_adapter *adapter,
+						const gchar *address,
+						gboolean force, int *err)
+{
+	struct remote_dev_info *dev, match;
+	struct btd_device *device;
+	device_type_t type;
+
+	memset(&match, 0, sizeof(struct remote_dev_info));
+	str2ba(address, &match.bdaddr);
+	match.name_status = NAME_ANY;
+
+	dev = adapter_search_found_devices(adapter, &match);
+	if (dev && dev->flags)
+		type = flags2type(dev->flags);
+	else
+		type = DEVICE_TYPE_BREDR;
+
+	if (!force && type == DEVICE_TYPE_LE &&
+					!event_is_connectable(dev->evt_type)) {
+		if (err)
+			*err = -ENOTCONN;
+
+		return NULL;
+	}
+
+	device = adapter_create_device(conn, adapter, address, type);
+	if (!device && err)
+		*err = -ENOMEM;
+
+	return device;
+}
+
 static DBusMessage *create_device(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter = data;
 	struct btd_device *device;
-	struct remote_dev_info *dev, match;
 	const gchar *address;
+	DBusMessage *reply;
 	int err;
-	device_type_t type;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -1545,41 +1578,36 @@ static DBusMessage *create_device(DBusConnection *conn,
 
 	DBG("%s", address);
 
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	str2ba(address, &match.bdaddr);
-	match.name_status = NAME_ANY;
+	device = create_device_internal(conn, adapter, address, TRUE, &err);
+	if (!device)
+		goto failed;
 
-	dev = adapter_search_found_devices(adapter, &match);
-	if (dev && dev->flags)
-		type = flags2type(dev->flags);
+	if (device_get_type(device) != DEVICE_TYPE_LE)
+		err = device_browse_sdp(device, conn, msg, NULL, FALSE);
 	else
-		type = DEVICE_TYPE_BREDR;
+		err = device_browse_primary(device, conn, msg, FALSE);
 
-	device = adapter_create_device(conn, adapter, address, type);
-	if (!device)
-		return NULL;
+	if (err < 0) {
+		adapter_remove_device(conn, adapter, device, TRUE);
+		return btd_error_failed(msg, strerror(-err));
+	}
 
-	if (type == DEVICE_TYPE_LE && !event_is_connectable(dev->evt_type)) {
+	return NULL;
+
+failed:
+	if (err == -ENOTCONN) {
 		/* Device is not connectable */
 		const char *path = device_get_path(device);
-		DBusMessage *reply;
 
 		reply = dbus_message_new_method_return(msg);
 
 		dbus_message_append_args(reply,
-					DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_INVALID);
-
-		return reply;
-	}
-
-	err = device_browse(device, conn, msg, NULL, FALSE);
-	if (err < 0) {
-		adapter_remove_device(conn, adapter, device, TRUE);
-		return btd_error_failed(msg, strerror(-err));
-	}
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+	} else
+		reply = btd_error_failed(msg, strerror(-err));
 
-	return NULL;
+	return reply;
 }
 
 static uint8_t parse_io_capability(const char *capability)
@@ -1604,6 +1632,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 	struct btd_device *device;
 	const gchar *address, *agent_path, *capability, *sender;
 	uint8_t cap;
+	int err;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 					DBUS_TYPE_OBJECT_PATH, &agent_path,
@@ -1628,12 +1657,23 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 	if (cap == IO_CAPABILITY_INVALID)
 		return btd_error_invalid_args(msg);
 
-	device = adapter_get_device(conn, adapter, address);
-	if (!device)
-		return btd_error_failed(msg,
-				"Unable to create a new device object");
+	device = adapter_find_device(adapter, address);
+	if (!device) {
+		device = create_device_internal(conn, adapter, address,
+								FALSE, &err);
+		if (!device)
+			return btd_error_failed(msg, strerror(-err));
+	}
+
+	if (device_get_type(device) != DEVICE_TYPE_LE)
+		return device_create_bonding(device, conn, msg,
+							agent_path, cap);
 
-	return device_create_bonding(device, conn, msg, agent_path, cap);
+	err = device_browse_primary(device, conn, msg, TRUE);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return NULL;
 }
 
 static gint device_path_cmp(struct btd_device *device, const gchar *path)
diff --git a/src/device.c b/src/device.c
index e093b82..c33b22b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -588,7 +588,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (strlen(pattern) == 0) {
-		err = device_browse(device, conn, msg, NULL, FALSE);
+		err = device_browse_sdp(device, conn, msg, NULL, FALSE);
 		if (err < 0)
 			goto fail;
 	} else {
@@ -599,7 +599,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 
 		sdp_uuid128_to_uuid(&uuid);
 
-		err = device_browse(device, conn, msg, &uuid, FALSE);
+		err = device_browse_sdp(device, conn, msg, &uuid, FALSE);
 		if (err < 0)
 			goto fail;
 	}
@@ -992,6 +992,11 @@ void device_get_name(struct btd_device *device, char *name, size_t len)
 	strncpy(name, device->name, len);
 }
 
+device_type_t device_get_type(struct btd_device *device)
+{
+	return device->type;
+}
+
 void device_remove_bonding(struct btd_device *device)
 {
 	char filename[PATH_MAX + 1];
@@ -1599,41 +1604,62 @@ done:
 	browse_request_free(req);
 }
 
-static struct browse_req *browse_primary(struct btd_device *device, int *err)
+int device_browse_primary(struct btd_device *device, DBusConnection *conn,
+				DBusMessage *msg, gboolean secure)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 	bdaddr_t src;
-	int ret;
+	int err;
+
+	if (device->browse)
+		return -EBUSY;
 
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
 
 	adapter_get_address(adapter, &src);
 
-	ret = bt_discover_primary(&src, &device->bdaddr, -1, primary_cb, req,
-									NULL);
-
-	if (ret < 0) {
+	err = bt_discover_primary(&src, &device->bdaddr, -1, primary_cb, req,
+							secure, NULL);
+	if (err < 0) {
 		browse_request_free(req);
-		if (err)
-			*err = ret;
+		return err;
+	}
 
-		return NULL;
+	if (conn == NULL)
+		conn = get_dbus_connection();
+
+	req->conn = dbus_connection_ref(conn);
+	device->browse = req;
+
+	if (msg) {
+		const char *sender = dbus_message_get_sender(msg);
+
+		req->msg = dbus_message_ref(msg);
+		/* Track the request owner to cancel it
+		 * automatically if the owner exits */
+		req->listener_id = g_dbus_add_disconnect_watch(conn,
+						sender,
+						discover_services_req_exit,
+						req, NULL);
 	}
 
-	return req;
+	return err;
 }
 
-static struct browse_req *browse_sdp(struct btd_device *device, uuid_t *search,
-						gboolean reverse, int *err)
+int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
+			DBusMessage *msg, uuid_t *search, gboolean reverse)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 	bt_callback_t cb;
 	bdaddr_t src;
 	uuid_t uuid;
-	int ret;
+	int err;
+
+	if (device->browse)
+		return -EBUSY;
 
 	adapter_get_address(adapter, &src);
 
@@ -1648,34 +1674,11 @@ static struct browse_req *browse_sdp(struct btd_device *device, uuid_t *search,
 		cb = browse_cb;
 	}
 
-	ret = bt_search_service(&src, &device->bdaddr, &uuid, cb, req, NULL);
-	if (ret < 0) {
+	err = bt_search_service(&src, &device->bdaddr, &uuid, cb, req, NULL);
+	if (err < 0) {
 		browse_request_free(req);
-		if (err)
-			*err = ret;
-
-		return NULL;
-	}
-
-	return req;
-}
-
-int device_browse(struct btd_device *device, DBusConnection *conn,
-			DBusMessage *msg, uuid_t *search, gboolean reverse)
-{
-	struct browse_req *req;
-	int err = 0;
-
-	if (device->browse)
-		return -EBUSY;
-
-	if (device->type == DEVICE_TYPE_LE)
-		req = browse_primary(device, &err);
-	else
-		req = browse_sdp(device, search, reverse, &err);
-
-	if (req == NULL)
 		return err;
+	}
 
 	if (conn == NULL)
 		conn = get_dbus_connection();
@@ -1786,7 +1789,7 @@ static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	device_browse(device, NULL, NULL, NULL, TRUE);
+	device_browse_sdp(device, NULL, NULL, NULL, TRUE);
 
 	device->discov_timer = 0;
 
@@ -2123,7 +2126,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 			device->discov_timer = 0;
 		}
 
-		device_browse(device, bonding->conn, bonding->msg,
+		device_browse_sdp(device, bonding->conn, bonding->msg,
 				NULL, FALSE);
 
 		bonding_request_free(bonding);
diff --git a/src/device.h b/src/device.h
index 86721bf..5dea953 100644
--- a/src/device.h
+++ b/src/device.h
@@ -47,9 +47,12 @@ struct btd_device *device_create(DBusConnection *conn,
 				const gchar *address, device_type_t type);
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
+device_type_t device_get_type(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 gint device_address_cmp(struct btd_device *device, const gchar *address);
-int device_browse(struct btd_device *device, DBusConnection *conn,
+int device_browse_primary(struct btd_device *device, DBusConnection *conn,
+				DBusMessage *msg, gboolean secure);
+int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
 			DBusMessage *msg, uuid_t *search, gboolean reverse);
 void device_probe_drivers(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 648dd62..01517a3 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -517,9 +517,11 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 					bt_primary_t cb, void *user_data,
+					gboolean secure,
 					bt_destroy_t destroy)
 {
 	struct gattrib_context *ctxt;
+	BtIOSecLevel sec_level;
 	GIOChannel *io;
 
 	ctxt = g_try_new0(struct gattrib_context, 1);
@@ -532,19 +534,25 @@ int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 	ctxt->cb = cb;
 	ctxt->destroy = destroy;
 
+	if (secure == TRUE)
+		sec_level = BT_IO_SEC_HIGH;
+	else
+		sec_level = BT_IO_SEC_LOW;
+
+
 	if (psm < 0)
 		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR, dst,
 				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	else
 		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR, dst,
 				BT_IO_OPT_PSM, psm,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
 	if (io == NULL) {
diff --git a/src/glib-helper.h b/src/glib-helper.h
index ad81d7f..25fe276 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -32,6 +32,7 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst);
 
 int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 					bt_primary_t cb, void *user_data,
+					gboolean secure,
 					bt_destroy_t destroy);
 
 gchar *bt_uuid2string(uuid_t *uuid);
-- 
1.7.3.2

