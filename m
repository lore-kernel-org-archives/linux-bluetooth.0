Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/13] device: Load appearance from storage
Date: Mon, 17 Dec 2012 16:09:46 +0100
Message-Id: <1355756994-18953-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update adapter_update_found_devices() to store appearance in device.

Remove no more used functions in storage.[ch].
---
 src/adapter.c |    7 +++----
 src/device.c  |   37 +++++++++++++++++++++++--------------
 src/storage.c |   41 -----------------------------------------
 src/storage.h |    4 ----
 4 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c95e341..26950b7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3074,10 +3074,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
-	if (eir_data.appearance != 0)
-		write_remote_appearance(&adapter->bdaddr, bdaddr, bdaddr_type,
-							eir_data.appearance);
-
 	if (eir_data.name != NULL && eir_data.name_complete)
 		adapter_store_cached_name(&adapter->bdaddr, bdaddr,
 								eir_data.name);
@@ -3101,6 +3097,9 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	device_set_legacy(dev, legacy);
 	device_set_rssi(dev, rssi);
 
+	if (eir_data.appearance != 0)
+		device_set_appearance(dev, eir_data.appearance);
+
 	if (eir_data.name)
 		device_set_name(dev, eir_data.name);
 
diff --git a/src/device.c b/src/device.c
index 30d5eb9..047c26a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -149,6 +149,7 @@ struct btd_device {
 	uint16_t	vendor;
 	uint16_t	product;
 	uint16_t	version;
+	uint16_t	appearance;
 	struct btd_adapter	*adapter;
 	GSList		*uuids;
 	GSList		*primaries;		/* List of primary services */
@@ -241,6 +242,13 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_remove_key(key_file, "General", "Class", NULL);
 	}
 
+	if (device->appearance) {
+		sprintf(class, "0x%4.4x", device->appearance);
+		g_key_file_set_string(key_file, "General", "Appearance", class);
+	} else {
+		g_key_file_remove_key(key_file, "General", "Appearance", NULL);
+	}
+
 	switch (device->bdaddr_type) {
 	case BDADDR_BREDR:
 		g_key_file_set_string(key_file, "General",
@@ -564,10 +572,10 @@ static gboolean get_appearance(const GDBusPropertyTable *property, void *data,
 	if (dev_property_exists_class(property, data))
 		return FALSE;
 
-	if (read_remote_appearance(adapter_get_address(device->adapter),
-					&device->bdaddr, device->bdaddr_type,
-					appearance) == 0)
+	if (device->appearance) {
+		*appearance = device->appearance;
 		return TRUE;
+	}
 
 	return FALSE;
 }
@@ -1745,6 +1753,13 @@ static void load_info(struct btd_device *device, const gchar *local,
 		g_free(str);
 	}
 
+	/* Load appearance */
+	str = g_key_file_get_string(key_file, "General", "Appearance", NULL);
+	if (str) {
+		device->appearance = strtol(str, NULL, 16);
+		g_free(str);
+	}
+
 	/* Load device technology */
 	techno = g_key_file_get_string_list(key_file, "General",
 					"SupportedTechnologies", NULL, NULL);
@@ -4093,17 +4108,11 @@ void btd_device_unref(struct btd_device *device)
 
 int device_get_appearance(struct btd_device *device, uint16_t *value)
 {
-	uint16_t app;
-	int err;
-
-	err = read_remote_appearance(adapter_get_address(device->adapter),
-					&device->bdaddr, device->bdaddr_type,
-					&app);
-	if (err < 0)
-		return err;
+	if (device->appearance == 0)
+		return -1;
 
 	if (value)
-		*value = app;
+		*value = device->appearance;
 
 	return 0;
 }
@@ -4119,8 +4128,8 @@ void device_set_appearance(struct btd_device *device, uint16_t value)
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device->path, DEVICE_INTERFACE, "Icon");
 
-	write_remote_appearance(adapter_get_address(device->adapter),
-				&device->bdaddr, device->bdaddr_type, value);
+	device->appearance = value;
+	store_device_info(device);
 }
 
 static gboolean notify_attios(gpointer user_data)
diff --git a/src/storage.c b/src/storage.c
index 38e5897..35049f1 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -144,47 +144,6 @@ int read_local_name(const bdaddr_t *bdaddr, char *name)
 	return 0;
 }
 
-int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
-				uint8_t bdaddr_type, uint16_t *appearance)
-{
-	char filename[PATH_MAX + 1], key[20], *str;
-
-	create_filename(filename, PATH_MAX, local, "appearances");
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
-	str = textfile_get(filename, key);
-	if (!str)
-		return -ENOENT;
-
-	if (sscanf(str, "%hx", appearance) != 1) {
-		free(str);
-		return -ENOENT;
-	}
-
-	free(str);
-
-	return 0;
-}
-
-int write_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
-				uint8_t bdaddr_type, uint16_t appearance)
-{
-	char filename[PATH_MAX + 1], key[20], str[7];
-
-	create_filename(filename, PATH_MAX, local, "appearances");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
-	sprintf(str, "0x%4.4x", appearance);
-
-	return textfile_put(filename, key, str);
-}
-
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
 {
 	char filename[PATH_MAX + 1], addr[18], *str;
diff --git a/src/storage.h b/src/storage.h
index cc7f930..9a9c82f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -27,10 +27,6 @@ int read_discoverable_timeout(const char *src, int *timeout);
 int read_pairable_timeout(const char *src, int *timeout);
 int read_on_mode(const char *src, char *mode, int length);
 int read_local_name(const bdaddr_t *bdaddr, char *name);
-int write_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
-				uint8_t bdaddr_type, uint16_t appearance);
-int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
-				uint8_t bdaddr_type, uint16_t *appearance);
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
-- 
1.7.9.5

