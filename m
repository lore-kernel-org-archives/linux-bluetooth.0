Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] device: Store services in device's attributes file
Date: Fri, 14 Dec 2012 17:45:16 +0100
Message-Id: <1355503519-26573-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove no more used write_device_primaries() from storage.[ch].
---
 src/device.c  |   73 +++++++++++++++++++++++++++++++++++++++++----------------
 src/storage.c |   15 ------------
 src/storage.h |    2 --
 3 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/src/device.c b/src/device.c
index 780a496..d6a6f04 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2872,37 +2872,70 @@ static void init_browse(struct browse_req *req, gboolean reverse)
 						l->data);
 }
 
-static char *primary_list_to_string(GSList *primary_list)
+static void store_services(struct btd_device *device)
 {
-	GString *services;
+	struct btd_adapter *adapter = device->adapter;
+	char filename[PATH_MAX + 1];
+	char src_addr[18], dst_addr[18];
+	uuid_t uuid;
+	char *prim_uuid;
+	GKeyFile *key_file;
 	GSList *l;
+	char *data;
+	gsize length = 0;
 
-	services = g_string_new(NULL);
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
 
-	for (l = primary_list; l; l = l->next) {
-		struct gatt_primary *primary = l->data;
-		char service[64];
+	ba2str(adapter_get_address(adapter), src_addr);
+	ba2str(&device->bdaddr, dst_addr);
 
-		memset(service, 0, sizeof(service));
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
+								dst_addr);
+	filename[PATH_MAX] = '\0';
 
-		snprintf(service, sizeof(service), "%04X#%04X#%s ",
-				primary->range.start, primary->range.end, primary->uuid);
+	key_file = g_key_file_new();
 
-		services = g_string_append(services, service);
-	}
+	for (l = device->primaries; l; l = l->next) {
+		struct gatt_primary *primary = l->data;
+		char handle[6], uuid_str[33];
+		int i;
 
-	return g_string_free(services, FALSE);
-}
+		sprintf(handle, "%hu", primary->range.start);
 
-static void store_services(struct btd_device *device)
-{
-	struct btd_adapter *adapter = device->adapter;
-	char *str = primary_list_to_string(device->primaries);
+		bt_string2uuid(&uuid, primary->uuid);
+		sdp_uuid128_to_uuid(&uuid);
 
-	write_device_primaries(adapter_get_address(adapter), &device->bdaddr,
-						device->bdaddr_type, str);
+		switch (uuid.type) {
+		case SDP_UUID16:
+			sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
+			break;
+		case SDP_UUID32:
+			sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
+			break;
+		case SDP_UUID128:
+			for (i = 0; i < 16; i++)
+				sprintf(uuid_str + (i * 2), "%2.2X",
+						uuid.value.uuid128.data[i]);
+			break;
+		default:
+			uuid_str[0] = '\0';
+		}
 
-	g_free(str);
+		g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
+		g_key_file_set_string(key_file, handle, "Value", uuid_str);
+		g_key_file_set_integer(key_file, handle, "EndGroupHandle",
+					primary->range.end);
+	}
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+	g_key_file_free(key_file);
 }
 
 static void attio_connected(gpointer data, gpointer user_data)
diff --git a/src/storage.c b/src/storage.c
index 713a421..02ac1f3 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -273,21 +273,6 @@ int read_device_pairable(const bdaddr_t *bdaddr, gboolean *mode)
 	return 0;
 }
 
-int write_device_primaries(const bdaddr_t *sba, const bdaddr_t *dba,
-			  uint8_t bdaddr_type, const char *services)
-{
-	char filename[PATH_MAX + 1], key[20];
-
-	create_filename(filename, PATH_MAX, sba, "primaries");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(dba, key);
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
-	return textfile_put(filename, key, services);
-}
-
 static void filter_keys(char *key, char *value, void *data)
 {
 	struct match *match = data;
diff --git a/src/storage.h b/src/storage.h
index d150f15..682523a 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -35,8 +35,6 @@ ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
 int read_device_pairable(const bdaddr_t *local, gboolean *mode);
-int write_device_primaries(const bdaddr_t *sba, const bdaddr_t *dba,
-				uint8_t bdaddr_type, const char *services);
 int read_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
 			uint8_t bdaddr_type, uint16_t handle, uint16_t *value);
 int write_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
-- 
1.7.9.5

