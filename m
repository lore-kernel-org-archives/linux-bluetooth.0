Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/5] Add device type to identify LE, BR/EDR or dual mode devices
Date: Fri,  3 Dec 2010 11:28:48 -0300
Message-Id: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If EIR Flags field is sent in the advertising data, it can be used
to detect the operation mode. If the remote device is dual mode,
GAP operation mode defines that it shall follow the connectable
mode for BR/EDR and non-connectable mode for LE. This patch forces
service discovery protocol prior to Discover All Primary Services.
---
 src/adapter.c |   41 ++++++++++++++++++++++++++++++-----------
 src/adapter.h |    4 ++--
 src/device.c  |   10 +++++-----
 src/device.h  |    8 +++++++-
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 62afc0c..4d21d95 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1198,14 +1198,14 @@ sdp_list_t *adapter_get_services(struct btd_adapter *adapter)
 
 struct btd_device *adapter_create_device(DBusConnection *conn,
 					struct btd_adapter *adapter,
-					const char *address, gboolean le)
+					const char *address, uint8_t type)
 {
 	struct btd_device *device;
 	const char *path;
 
 	DBG("%s", address);
 
-	device = device_create(conn, adapter, address, le);
+	device = device_create(conn, adapter, address, type);
 	if (!device)
 		return NULL;
 
@@ -1686,6 +1686,19 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static uint8_t flags2type(uint8_t flags)
+{
+	/* Inferring the remote type based on the EIR Flags field */
+
+	if (flags & EIR_SIM_CONTROLLER && flags & EIR_SIM_HOST)
+		return DUALMODE_TYPE;
+
+	if (flags & (EIR_BREDR_UNSUP | EIR_LIM_DISC | EIR_GEN_DISC))
+		return LE_TYPE;
+
+	return UNKNOWN_TYPE;
+}
+
 static DBusMessage *create_device(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1693,8 +1706,8 @@ static DBusMessage *create_device(DBusConnection *conn,
 	struct btd_device *device;
 	struct remote_dev_info *dev, match;
 	const gchar *address;
-	gboolean le;
 	int err;
+	uint8_t type;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -1715,9 +1728,9 @@ static DBusMessage *create_device(DBusConnection *conn,
 	match.name_status = NAME_ANY;
 
 	dev = adapter_search_found_devices(adapter, &match);
-	le  = dev ? dev->le : FALSE;
+	type = dev ? dev->type : BREDR_TYPE;
 
-	device = adapter_create_device(conn, adapter, address, le);
+	device = adapter_create_device(conn, adapter, address, type);
 	if (!device)
 		return NULL;
 
@@ -3054,16 +3067,19 @@ static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
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
@@ -3082,6 +3098,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	if (new_dev) {
 		dev->le = TRUE;
 		dev->evt_type = info->evt_type;
+		dev->type = LE_TYPE;
 	} else if (dev->rssi == rssi)
 		return;
 
@@ -3091,14 +3108,15 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 						(GCompareFunc) dev_rssi_cmp);
 
 	if (info->length) {
-		uint8_t type;
+		uint8_t type, flags;
 		char *tmp_name = bt_extract_eir_name(info->data, &type);
 		if (tmp_name) {
 			g_free(dev->name);
 			dev->name = tmp_name;
 		}
 
-		dev->flags = extract_eir_flags(info->data);
+		if (extract_eir_flags(info->data, &flags))
+			dev->type = flags2type(flags);
 	}
 
 	/* FIXME: check if other information was changed before emitting the
@@ -3124,6 +3142,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 			dev->alias = g_strdup(alias);
 
 		dev->le = FALSE;
+		dev->type = BREDR_TYPE;
 		dev->class = class;
 		dev->legacy = legacy;
 		dev->name_status = name_status;
diff --git a/src/adapter.h b/src/adapter.h
index b189b27..feeb9c9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -70,12 +70,12 @@ struct remote_dev_info {
 	dbus_bool_t legacy;
 	name_status_t name_status;
 	gboolean le;
+	uint8_t type;
 	char **uuids;
 	size_t uuid_count;
 	GSList *services;
 	uint8_t evt_type;
 	uint8_t bdaddr_type;
-	uint8_t flags;
 };
 
 struct hci_dev {
@@ -110,7 +110,7 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 						gboolean remove_storage);
 struct btd_device *adapter_create_device(DBusConnection *conn,
 					struct btd_adapter *adapter,
-					const char *address, gboolean le);
+					const char *address, uint8_t type);
 
 int adapter_resolve_names(struct btd_adapter *adapter);
 
diff --git a/src/device.c b/src/device.c
index 5326e3f..6f80635 100644
--- a/src/device.c
+++ b/src/device.c
@@ -107,7 +107,7 @@ struct browse_req {
 
 struct btd_device {
 	bdaddr_t	bdaddr;
-	gboolean	le;
+	uint8_t		type;
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
@@ -212,7 +212,7 @@ static void browse_request_cancel(struct browse_req *req)
 
 	adapter_get_address(adapter, &src);
 
-	if (device->le == FALSE)
+	if (device->type != LE_TYPE)
 		bt_cancel_discovery(&src, &device->bdaddr);
 
 	device->browse = NULL;
@@ -965,7 +965,7 @@ void device_set_secmode3_conn(struct btd_device *device, gboolean enable)
 
 struct btd_device *device_create(DBusConnection *conn,
 					struct btd_adapter *adapter,
-					const gchar *address, gboolean le)
+					const gchar *address, uint8_t type)
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
+	if (device->type == LE_TYPE)
 		req = browse_primary(device, &err);
 	else
 		req = browse_sdp(device, search, reverse, &err);
diff --git a/src/device.h b/src/device.h
index a5b6273..cfb82bd 100644
--- a/src/device.h
+++ b/src/device.h
@@ -34,9 +34,15 @@ typedef enum {
 	AUTH_TYPE_AUTO,
 } auth_type_t;
 
+/* Operation modes for BR/EDR/LE */
+#define UNKNOWN_TYPE		0x00
+#define BREDR_TYPE		0x01
+#define LE_TYPE			0x02
+#define DUALMODE_TYPE		0x03
+
 struct btd_device *device_create(DBusConnection *conn,
 					struct btd_adapter *adapter,
-					const gchar *address, gboolean le);
+					const gchar *address, uint8_t type);
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 void device_remove(struct btd_device *device, gboolean remove_stored);
-- 
1.7.3.2

