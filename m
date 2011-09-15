Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 1/5] Remove storing device type
Date: Thu, 15 Sep 2011 16:31:43 -0300
Message-Id: <1316115103-19730-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315572669-5006-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1315572669-5006-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device type doesn't need to be stored since GATT services information
exported through basic rate can be retrieved from the SDP records.
Device "type" is also a wrong expression to represent the operation
mode: over which transport GATT service is being exported.
---
 src/adapter.c |   28 ----------------------------
 src/device.c  |    2 --
 src/storage.c |   38 --------------------------------------
 src/storage.h |    3 ---
 4 files changed, 0 insertions(+), 71 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7d0c63e..628db60 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1967,31 +1967,6 @@ static void create_stored_device_from_blocked(char *key, char *value,
 	}
 }
 
-static void create_stored_device_from_types(char *key, char *value,
-							void *user_data)
-{
-	GSList *l;
-	struct btd_adapter *adapter = user_data;
-	struct btd_device *device;
-	uint8_t type;
-
-	type = strtol(value, NULL, 16);
-
-	l = g_slist_find_custom(adapter->devices,
-				key, (GCompareFunc) device_address_cmp);
-	if (l) {
-		device = l->data;
-		device_set_type(device, type);
-		return;
-	}
-
-	device = device_create(connection, adapter, key, type);
-	if (device) {
-		device_set_temporary(device, FALSE);
-		adapter->devices = g_slist_append(adapter->devices, device);
-	}
-}
-
 static GSList *string_to_primary_list(char *str)
 {
 	GSList *l = NULL;
@@ -2091,9 +2066,6 @@ static void load_devices(struct btd_adapter *adapter)
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "types");
-	textfile_foreach(filename, create_stored_device_from_types, adapter);
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/device.c b/src/device.c
index d54edbb..3be328d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1500,7 +1500,6 @@ cleanup:
 		device_get_address(device, &dba);
 
 		store_profiles(device);
-		write_device_type(&sba, &dba, device->type);
 	}
 
 	device->browse = NULL;
@@ -1588,7 +1587,6 @@ static void store_services(struct btd_device *device)
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba);
 
-	write_device_type(&sba, &dba, device->type);
 	write_device_services(&sba, &dba, str);
 
 	g_free(str);
diff --git a/src/storage.c b/src/storage.c
index 1f3da6e..8511823 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1303,41 +1303,3 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 
 	return textfile_foreach(filename, func, data);
 }
-
-int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
-						device_type_t type)
-{
-	char filename[PATH_MAX + 1], addr[18], chars[3];
-
-	create_filename(filename, PATH_MAX, sba, "types");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(dba, addr);
-
-	snprintf(chars, sizeof(chars), "%2.2X", type);
-
-	return textfile_put(filename, addr, chars);
-}
-
-device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba)
-{
-	char filename[PATH_MAX + 1], addr[18], *chars;
-	device_type_t type;
-
-	create_filename(filename, PATH_MAX, sba, "types");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(dba, addr);
-
-	chars = textfile_caseget(filename, addr);
-	if (chars == NULL)
-		return DEVICE_TYPE_UNKNOWN;
-
-	type = strtol(chars, NULL, 16);
-
-	free(chars);
-
-	return type;
-}
diff --git a/src/storage.h b/src/storage.h
index bb64727..7340ff7 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -84,9 +84,6 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
                                         uint16_t handle, const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
-int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
-						device_type_t type);
-device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.6.1

