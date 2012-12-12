Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/14] adapter: Register services after device creation
Date: Wed, 12 Dec 2012 16:48:00 +0100
Message-Id: <1355327283-1558-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add device_register_services_from_primaries() to device.c to allow
to register from device->primaries pre-loaded during device creation
from storage.

As all device load during start-up has been converted, we can remove
temporary hack in device_create().
---
 src/adapter.c |   80 ++-------------------------------------------------------
 src/device.c  |   28 +++++++++-----------
 src/device.h  |    1 +
 3 files changed, 15 insertions(+), 94 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 754bc2a..1a220cf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1728,80 +1728,6 @@ failed:
 	return ltk;
 }
 
-static GSList *string_to_primary_list(char *str)
-{
-	GSList *l = NULL;
-	char **services;
-	int i;
-
-	if (str == NULL)
-		return NULL;
-
-	services = g_strsplit(str, " ", 0);
-	if (services == NULL)
-		return NULL;
-
-	for (i = 0; services[i]; i++) {
-		struct gatt_primary *prim;
-		int ret;
-
-		prim = g_new0(struct gatt_primary, 1);
-
-		ret = sscanf(services[i], "%04hX#%04hX#%s", &prim->range.start,
-							&prim->range.end, prim->uuid);
-
-		if (ret < 3) {
-			g_free(prim);
-			continue;
-		}
-
-		l = g_slist_append(l, prim);
-	}
-
-	g_strfreev(services);
-
-	return l;
-}
-
-static void create_stored_device_from_primaries(char *key, char *value,
-							void *user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	struct btd_device *device;
-	GSList *services, *uuids, *l;
-	char address[18];
-	uint8_t bdaddr_type;
-
-	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
-		return;
-
-	if (g_slist_find_custom(adapter->devices,
-			address, (GCompareFunc) device_address_cmp))
-		return;
-
-	device = device_create(adapter, address, bdaddr_type);
-	if (!device)
-		return;
-
-	device_set_temporary(device, FALSE);
-	adapter->devices = g_slist_append(adapter->devices, device);
-
-	services = string_to_primary_list(value);
-	if (services == NULL)
-		return;
-
-	for (l = services, uuids = NULL; l; l = l->next) {
-		struct gatt_primary *prim = l->data;
-		uuids = g_slist_append(uuids, prim->uuid);
-	}
-
-	device_register_services(device, services, -1);
-
-	device_probe_profiles(device, uuids);
-
-	g_slist_free(uuids);
-}
-
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -1814,10 +1740,6 @@ static void load_devices(struct btd_adapter *adapter)
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primaries");
-	textfile_foreach(filename, create_stored_device_from_primaries,
-								adapter);
-
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s", srcaddr);
 	filename[PATH_MAX] = '\0';
 
@@ -1867,6 +1789,8 @@ static void load_devices(struct btd_adapter *adapter)
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
 
+		device_register_services_from_primaries(device);
+
 		l = device_get_uuids(device);
 		if (l)
 			device_probe_profiles(device, l);
diff --git a/src/device.c b/src/device.c
index 6c3d5e8..9c3211c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2202,8 +2202,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	struct btd_device *device;
 	const bdaddr_t *src;
 	char srcaddr[18];
-	char filename[PATH_MAX + 1];
-	GKeyFile *key_file;
+	char *str;
 
 	device = device_new(adapter, address);
 	if (device == NULL)
@@ -2213,24 +2212,21 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	src = adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
-	/*TODO: after all device load during start-up has been converted to
-	 * new key file structure, this should be replaced by :
-	 *	str = load_cached_name(device, srcaddr, address);
-	 *	if (str) {
-	 *		strcpy(device->name, str);
-	 *		g_free(str);
-	 *	}
-	 */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", srcaddr,
-			address);
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-	load_info(device, srcaddr, address, key_file);
-	g_key_file_free(key_file);
+	str = load_cached_name(device, srcaddr, address);
+	if (str) {
+		strcpy(device->name, str);
+		g_free(str);
+	}
 
 	return btd_device_ref(device);
 }
 
+void device_register_services_from_primaries(struct btd_device *device)
+{
+	device->services = attrib_client_register(device, -1, NULL,
+							device->primaries);
+}
+
 void device_set_name(struct btd_device *device, const char *name)
 {
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
diff --git a/src/device.h b/src/device.h
index 1785a75..750b1ea 100644
--- a/src/device.h
+++ b/src/device.h
@@ -30,6 +30,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 				const char *address, uint8_t bdaddr_type);
 struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 				const char *address, GKeyFile *key_file);
+void device_register_services_from_primaries(struct btd_device *device);
 
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
-- 
1.7.9.5

