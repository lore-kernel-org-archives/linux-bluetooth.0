Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 1/5] Add device type to identify LE, BR/EDR or dual mode devices
Date: Tue,  7 Dec 2010 18:30:40 -0300
Message-Id: <1291757440-15217-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <AANLkTinFBtVhu0j6xcHsH6XQZM8J-UeHSG2fOJJ-otcJ@mail.gmail.com>
References: <AANLkTinFBtVhu0j6xcHsH6XQZM8J-UeHSG2fOJJ-otcJ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If EIR Flags field is sent in the advertising data, it can be used
to detect the operation mode. If the remote device is dual mode,
GAP operation mode defines that it shall follow the connectable
mode for BR/EDR and non-connectable mode for LE. This patch forces
service discovery protocol prior to Discover All Primary Services.
---
 src/adapter.c |   55 +++++++++++++++++++++++++++++++++++++++----------------
 src/adapter.h |    3 ---
 src/device.c  |   12 ++++++------
 src/device.h  |   11 +++++++++--
 4 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 62afc0c..b3270ce 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1196,16 +1196,17 @@ sdp_list_t *adapter_get_services(struct btd_adapter *adapter)
 	return adapter->services;
 }
 
-struct btd_device *adapter_create_device(DBusConnection *conn,
-					struct btd_adapter *adapter,
-					const char *address, gboolean le)
+static struct btd_device *adapter_create_device(DBusConnection *conn,
+						struct btd_adapter *adapter,
+						const char *address,
+						device_type_t type)
 {
 	struct btd_device *device;
 	const char *path;
 
 	DBG("%s", address);
 
-	device = device_create(conn, adapter, address, le);
+	device = device_create(conn, adapter, address, type);
 	if (!device)
 		return NULL;
 
@@ -1264,7 +1265,8 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 	if (device)
 		return device;
 
-	return adapter_create_device(conn, adapter, address, FALSE);
+	return adapter_create_device(conn, adapter, address,
+						DEVICE_TYPE_BREDR);
 }
 
 static gboolean stop_scanning(gpointer user_data)
@@ -1686,6 +1688,24 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static device_type_t flags2type(uint8_t flags)
+{
+	/* Inferring the remote type based on the EIR Flags field */
+
+	/* For LE only and dual mode the following flags must be zero */
+	if (flags & (EIR_SIM_CONTROLLER | EIR_SIM_HOST))
+		return DEVICE_TYPE_UNKNOWN;
+
+	/* Limited or General discoverable mode bit must be enabled */
+	if (!(flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
+		return DEVICE_TYPE_UNKNOWN;
+
+	if (flags & EIR_BREDR_UNSUP)
+		return DEVICE_TYPE_LE;
+	else
+		return DEVICE_TYPE_DUALMODE;
+}
+
 static DBusMessage *create_device(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1693,8 +1713,8 @@ static DBusMessage *create_device(DBusConnection *conn,
 	struct btd_device *device;
 	struct remote_dev_info *dev, match;
 	const gchar *address;
-	gboolean le;
 	int err;
+	device_type_t type;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -1715,9 +1735,9 @@ static DBusMessage *create_device(DBusConnection *conn,
 	match.name_status = NAME_ANY;
 
 	dev = adapter_search_found_devices(adapter, &match);
-	le  = dev ? dev->le : FALSE;
+	type = dev && dev->flags ? flags2type(dev->flags) : DEVICE_TYPE_BREDR;
 
-	device = adapter_create_device(conn, adapter, address, le);
+	device = adapter_create_device(conn, adapter, address, type);
 	if (!device)
 		return NULL;
 
@@ -2013,7 +2033,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, FALSE);
+	device = device_create(connection, adapter, key, DEVICE_TYPE_BREDR);
 	if (!device)
 		return;
 
@@ -2036,7 +2056,7 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, FALSE);
+	device = device_create(connection, adapter, key, DEVICE_TYPE_BREDR);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -2053,7 +2073,7 @@ static void create_stored_device_from_blocked(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, FALSE);
+	device = device_create(connection, adapter, key, DEVICE_TYPE_BREDR);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -3054,16 +3074,19 @@ static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
 	return dev;
 }
 
-static uint8_t extract_eir_flags(uint8_t *eir_data)
+static gboolean extract_eir_flags(uint8_t *flags, uint8_t *eir_data)
 {
 	if (eir_data[0] == 0)
-		return 0;
+		return FALSE;
 
 	if (eir_data[1] != EIR_FLAGS)
-		return 0;
+		return FALSE;
 
 	/* For now, only one octet is used for flags */
-	return eir_data[2];
+	if (flags)
+		*flags = eir_data[2];
+
+	return TRUE;
 }
 
 void adapter_update_device_from_info(struct btd_adapter *adapter,
@@ -3098,7 +3121,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 			dev->name = tmp_name;
 		}
 
-		dev->flags = extract_eir_flags(info->data);
+		extract_eir_flags(info->data, &dev->flags);
 	}
 
 	/* FIXME: check if other information was changed before emitting the
diff --git a/src/adapter.h b/src/adapter.h
index b189b27..3a2cf9c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -108,9 +108,6 @@ struct btd_device *adapter_find_connection(struct btd_adapter *adapter, uint16_t
 void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 						struct btd_device *device,
 						gboolean remove_storage);
-struct btd_device *adapter_create_device(DBusConnection *conn,
-					struct btd_adapter *adapter,
-					const char *address, gboolean le);
 
 int adapter_resolve_names(struct btd_adapter *adapter);
 
diff --git a/src/device.c b/src/device.c
index 5326e3f..50fb83c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -107,7 +107,7 @@ struct browse_req {
 
 struct btd_device {
 	bdaddr_t	bdaddr;
-	gboolean	le;
+	device_type_t	type;
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
@@ -212,7 +212,7 @@ static void browse_request_cancel(struct browse_req *req)
 
 	adapter_get_address(adapter, &src);
 
-	if (device->le == FALSE)
+	if (device->type != DEVICE_TYPE_LE)
 		bt_cancel_discovery(&src, &device->bdaddr);
 
 	device->browse = NULL;
@@ -964,8 +964,8 @@ void device_set_secmode3_conn(struct btd_device *device, gboolean enable)
 }
 
 struct btd_device *device_create(DBusConnection *conn,
-					struct btd_adapter *adapter,
-					const gchar *address, gboolean le)
+				struct btd_adapter *adapter,
+				const gchar *address, device_type_t type)
 {
 	gchar *address_up;
 	struct btd_device *device;
@@ -993,7 +993,7 @@ struct btd_device *device_create(DBusConnection *conn,
 
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
-	device->le = le;
+	device->type = type;
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
 	read_device_name(srcaddr, address, device->name);
@@ -1656,7 +1656,7 @@ int device_browse(struct btd_device *device, DBusConnection *conn,
 	if (device->browse)
 		return -EBUSY;
 
-	if (device->le)
+	if (device->type == DEVICE_TYPE_LE)
 		req = browse_primary(device, &err);
 	else
 		req = browse_sdp(device, search, reverse, &err);
diff --git a/src/device.h b/src/device.h
index a5b6273..784e931 100644
--- a/src/device.h
+++ b/src/device.h
@@ -34,9 +34,16 @@ typedef enum {
 	AUTH_TYPE_AUTO,
 } auth_type_t;
 
+typedef enum {
+	DEVICE_TYPE_UNKNOWN,
+	DEVICE_TYPE_BREDR,
+	DEVICE_TYPE_LE,
+	DEVICE_TYPE_DUALMODE
+} device_type_t;
+
 struct btd_device *device_create(DBusConnection *conn,
-					struct btd_adapter *adapter,
-					const gchar *address, gboolean le);
+				struct btd_adapter *adapter,
+				const gchar *address, device_type_t type);
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 void device_remove(struct btd_device *device, gboolean remove_stored);
-- 
1.7.3.2

