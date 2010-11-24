Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/5] Check the device type when creating the device
Date: Wed, 24 Nov 2010 00:30:44 -0200
Message-Id: <1290565847-17382-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For CreateDevice, if the remote device is LE capable, Discover All
Primary Services shall be issued instead of SDP queries. The logic
to define if the remote is LE capable shall be based on the result
of the interleaved discovery results. Meaning, the remote device
is classified as LE capable only if an advertising event from this
device was collected during the discovery.

Limitation: Advertising event data is not being considered yet to
infer the remote properties and CreateDevice needs to be called
during the discovery session.
---
 src/adapter.c |   25 +++++++++++++++++--------
 src/adapter.h |    3 ++-
 src/device.c  |    3 ++-
 src/device.h  |    5 +++--
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6b4a354..029bec8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1199,15 +1199,15 @@ sdp_list_t *adapter_get_services(struct btd_adapter *adapter)
 }
 
 struct btd_device *adapter_create_device(DBusConnection *conn,
-						struct btd_adapter *adapter,
-						const char *address)
+					struct btd_adapter *adapter,
+					const char *address, gboolean le)
 {
 	struct btd_device *device;
 	const char *path;
 
 	DBG("%s", address);
 
-	device = device_create(conn, adapter, address);
+	device = device_create(conn, adapter, address, le);
 	if (!device)
 		return NULL;
 
@@ -1266,7 +1266,7 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 	if (device)
 		return device;
 
-	return adapter_create_device(conn, adapter, address);
+	return adapter_create_device(conn, adapter, address, FALSE);
 }
 
 static gboolean stop_scanning(gpointer user_data)
@@ -1693,7 +1693,9 @@ static DBusMessage *create_device(DBusConnection *conn,
 {
 	struct btd_adapter *adapter = data;
 	struct btd_device *device;
+	struct remote_dev_info *dev, match;
 	const gchar *address;
+	gboolean le;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -1709,7 +1711,14 @@ static DBusMessage *create_device(DBusConnection *conn,
 
 	DBG("%s", address);
 
-	device = adapter_create_device(conn, adapter, address);
+	memset(&match, 0, sizeof(struct remote_dev_info));
+	str2ba(address, &match.bdaddr);
+	match.name_status = NAME_ANY;
+
+	dev = adapter_search_found_devices(adapter, &match);
+	le  = dev ? dev->le : FALSE;
+
+	device = adapter_create_device(conn, adapter, address, le);
 	if (!device)
 		return NULL;
 
@@ -2003,7 +2012,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key);
+	device = device_create(connection, adapter, key, FALSE);
 	if (!device)
 		return;
 
@@ -2026,7 +2035,7 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key);
+	device = device_create(connection, adapter, key, FALSE);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -2043,7 +2052,7 @@ static void create_stored_device_from_blocked(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key);
+	device = device_create(connection, adapter, key, FALSE);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
diff --git a/src/adapter.h b/src/adapter.h
index de6a6f5..4f5ccdb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -109,7 +109,8 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 						struct btd_device *device,
 						gboolean remove_storage);
 struct btd_device *adapter_create_device(DBusConnection *conn,
-				struct btd_adapter *adapter, const char *address);
+					struct btd_adapter *adapter,
+					const char *address, gboolean le);
 
 int adapter_resolve_names(struct btd_adapter *adapter);
 
diff --git a/src/device.c b/src/device.c
index f236b29..1c119d5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -965,7 +965,7 @@ void device_set_secmode3_conn(struct btd_device *device, gboolean enable)
 
 struct btd_device *device_create(DBusConnection *conn,
 					struct btd_adapter *adapter,
-					const gchar *address)
+					const gchar *address, gboolean le)
 {
 	gchar *address_up;
 	struct btd_device *device;
@@ -993,6 +993,7 @@ struct btd_device *device_create(DBusConnection *conn,
 
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
+	device->le = le;
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
 	read_device_name(srcaddr, address, device->name);
diff --git a/src/device.h b/src/device.h
index b570bd1..a5b6273 100644
--- a/src/device.h
+++ b/src/device.h
@@ -34,8 +34,9 @@ typedef enum {
 	AUTH_TYPE_AUTO,
 } auth_type_t;
 
-struct btd_device *device_create(DBusConnection *conn, struct btd_adapter *adapter,
-				const gchar *address);
+struct btd_device *device_create(DBusConnection *conn,
+					struct btd_adapter *adapter,
+					const gchar *address, gboolean le);
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 void device_remove(struct btd_device *device, gboolean remove_stored);
-- 
1.7.3.2

