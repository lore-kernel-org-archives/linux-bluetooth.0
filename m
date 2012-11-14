Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] device: Use new storage for device alias
Date: Wed, 14 Nov 2012 12:28:50 +0100
Message-Id: <1352892533-15154-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1352892533-15154-1-git-send-email-frederic.danis@linux.intel.com>
References: <1352892533-15154-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As set_alias() changes value in device structure and write to
storage is deferred, property set could not return failure.
---
 src/device.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/src/device.c b/src/device.c
index 48970d2..c508d18 100644
--- a/src/device.c
+++ b/src/device.c
@@ -222,6 +222,10 @@ static gboolean store_device_info_cb(gpointer user_data)
 
 	g_key_file_set_string(key_file, "General", "Name", device->name);
 
+	if (device->alias != NULL)
+		g_key_file_set_string(key_file, "General", "Alias",
+					device->alias);
+
 	ba2str(adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 	snprintf(filename, PATH_MAX, INFO_PATH, adapter_addr, device_addr);
@@ -432,28 +436,17 @@ static void set_alias(GDBusPendingPropertySet id, const char *alias,
 								void *data)
 {
 	struct btd_device *device = data;
-	struct btd_adapter *adapter = device->adapter;
-	char srcaddr[18], dstaddr[18];
-	int err;
 
 	/* No change */
 	if ((device->alias == NULL && g_str_equal(alias, "")) ||
 					g_strcmp0(device->alias, alias) == 0)
 		return g_dbus_pending_property_success(id);
 
-	ba2str(adapter_get_address(adapter), srcaddr);
-	ba2str(&device->bdaddr, dstaddr);
-
-	/* Remove alias if empty string */
-	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
-					g_str_equal(alias, "") ? NULL : alias);
-	if (err < 0)
-		return g_dbus_pending_property_error(id,
-				ERROR_INTERFACE ".Failed", strerror(-err));
-
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
 
+	store_device_info(device);
+
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device->path, DEVICE_INTERFACE, "Alias");
 
@@ -1746,6 +1739,10 @@ static void load_info(struct btd_device *device, const gchar *local,
 		g_free(str);
 	}
 
+	/* Load alias */
+	device->alias = g_key_file_get_string(key_file, "General", "Alias",
+						NULL);
+
 	if (store_needed)
 		store_device_info(device);
 
@@ -1759,7 +1756,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	struct btd_device *device;
 	const gchar *adapter_path = adapter_get_path(adapter);
 	const bdaddr_t *src;
-	char srcaddr[18], alias[MAX_NAME_LENGTH + 1];
+	char srcaddr[18];
 	uint16_t vendor, product, version;
 
 	device = g_try_malloc0(sizeof(struct btd_device));
@@ -1790,9 +1787,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	load_info(device, srcaddr, address);
 
-	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
-							sizeof(alias)) == 0)
-		device->alias = g_strdup(alias);
 	device->trusted = read_trust(src, address, device->bdaddr_type);
 
 	if (read_blocked(src, &device->bdaddr, device->bdaddr_type))
-- 
1.7.9.5

