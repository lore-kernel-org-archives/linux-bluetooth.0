Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/15] adapter: Remove create_stored_device_from_primaries
Date: Thu, 13 Dec 2012 21:39:28 +0100
Message-Id: <1355431170-12897-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Loading of primaries list is done by device_create_from_storage().

As all device load during start-up has been converted, we can remove
temporary hack in device_create().
---
 src/adapter.c |   80 ++-------------------------------------------------------
 src/device.c  |   22 +++++-----------
 2 files changed, 8 insertions(+), 94 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 64d8ed3..80dbc77 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1725,80 +1725,6 @@ failed:
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
-	device_register_primaries(device, services, -1);
-
-	device_probe_profiles(device, uuids);
-
-	g_slist_free(uuids);
-}
-
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -1811,10 +1737,6 @@ static void load_devices(struct btd_adapter *adapter)
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primaries");
-	textfile_foreach(filename, create_stored_device_from_primaries,
-								adapter);
-
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s", srcaddr);
 	filename[PATH_MAX] = '\0';
 
@@ -1864,6 +1786,8 @@ static void load_devices(struct btd_adapter *adapter)
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
 
+		/* TODO: register services from pre-loaded list of primaries */
+
 		l = device_get_uuids(device);
 		if (l)
 			device_probe_profiles(device, l);
diff --git a/src/device.c b/src/device.c
index d49b397..fc37e51 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2013,8 +2013,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	struct btd_device *device;
 	const bdaddr_t *src;
 	char srcaddr[18];
-	char filename[PATH_MAX + 1];
-	GKeyFile *key_file;
+	char *str;
 
 	device = device_new(adapter, address);
 	if (device == NULL)
@@ -2024,20 +2023,11 @@ struct btd_device *device_create(struct btd_adapter *adapter,
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
-- 
1.7.9.5

