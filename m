Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 01/15] storage: Store address type in "characteristics"
Date: Wed, 23 May 2012 15:48:19 -0300
Message-Id: <1337798914-20974-2-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT can use BR/EDR or BLE as transport. Addressing types can be either
BR/EDR, BLE public or BLE random so the entries in the "characteristics"
file did not contain enough information to distinguish which addressing
type it's supposed to be. Entries will now contain both address number
and address type as a single key in every entry in the file.
---
 attrib/client.c |   25 +++++++++++++++----------
 src/storage.c   |   19 +++++++++++--------
 src/storage.h   |    5 +++--
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8fbc1cc..8aa2800 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -155,15 +155,15 @@ static void remove_attio(struct gatt_service *gatt)
 	}
 }
 
-static void gatt_get_address(struct gatt_service *gatt,
-				bdaddr_t *sba, bdaddr_t *dba)
+static void gatt_get_address(struct gatt_service *gatt, bdaddr_t *sba,
+					bdaddr_t *dba, uint8_t *bdaddr_type)
 {
 	struct btd_device *device = gatt->dev;
 	struct btd_adapter *adapter;
 
 	adapter = device_get_adapter(device);
 	adapter_get_address(adapter, sba);
-	device_get_address(device, dba, NULL);
+	device_get_address(device, dba, bdaddr_type);
 }
 
 static int characteristic_handle_cmp(gconstpointer a, gconstpointer b)
@@ -548,13 +548,15 @@ static char *characteristic_list_to_string(GSList *chars)
 }
 
 static void store_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-						uint16_t start, GSList *chars)
+					uint8_t bdaddr_type, uint16_t start,
+								GSList *chars)
 {
 	char *characteristics;
 
 	characteristics = characteristic_list_to_string(chars);
 
-	write_device_characteristics(sba, dba, start, characteristics);
+	write_device_characteristics(sba, dba, bdaddr_type, start,
+							characteristics);
 
 	g_free(characteristics);
 }
@@ -614,11 +616,12 @@ static GSList *load_characteristics(struct gatt_service *gatt, uint16_t start)
 {
 	GSList *chrs_list;
 	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
 	char *str;
 
-	gatt_get_address(gatt, &sba, &dba);
+	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
 
-	str = read_device_characteristics(&sba, &dba, start);
+	str = read_device_characteristics(&sba, &dba, bdaddr_type, start);
 	if (str == NULL)
 		return NULL;
 
@@ -647,7 +650,7 @@ static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 	for (i = 0, tmp = str + MAX_LEN_UUID_STR; i < len; i++, tmp += 2)
 		sprintf(tmp, "%02X", value[i]);
 
-	gatt_get_address(gatt, &sba, &dba);
+	gatt_get_address(gatt, &sba, &dba, NULL);
 
 	write_device_attribute(&sba, &dba, handle, str);
 
@@ -886,6 +889,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	uint16_t *previous_end = NULL;
 	GSList *l;
 	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
@@ -924,8 +928,9 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	if (previous_end)
 		*previous_end = prim->range.end;
 
-	gatt_get_address(gatt, &sba, &dba);
-	store_characteristics(&sba, &dba, prim->range.start, gatt->chars);
+	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
+	store_characteristics(&sba, &dba, bdaddr_type, prim->range.start,
+								gatt->chars);
 
 	g_slist_foreach(gatt->chars, update_all_chars, gatt);
 
diff --git a/src/storage.c b/src/storage.c
index 973d545..5c0ef5c 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1212,12 +1212,16 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 	char filename[PATH_MAX + 1], key[20];
 
 	memset(key, 0, sizeof(key));
+
 	ba2str(dba, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
 
 	/* Deleting all characteristics of a given key */
 	create_filename(filename, PATH_MAX, sba, "characteristic");
 	delete_by_pattern(filename, key);
 
+	key[17] = '\0';
+
 	/* Deleting all attributes values of a given key */
 	create_filename(filename, PATH_MAX, sba, "attributes");
 	delete_by_pattern(filename, key);
@@ -1247,31 +1251,30 @@ char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 }
 
 int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-					uint16_t handle, const char *chars)
+					uint8_t bdaddr_type, uint16_t handle,
+							      const char *chars)
 {
-	char filename[PATH_MAX + 1], addr[18], key[23];
+	char filename[PATH_MAX + 1], addr[18], key[25];
 
 	create_filename(filename, PATH_MAX, sba, "characteristic");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	ba2str(dba, addr);
-
-	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
 
 	return textfile_put(filename, key, chars);
 }
 
 char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-							uint16_t handle)
+					uint8_t bdaddr_type, uint16_t handle)
 {
-	char filename[PATH_MAX + 1], addr[18], key[23];
+	char filename[PATH_MAX + 1], addr[18], key[25];
 
 	create_filename(filename, PATH_MAX, sba, "characteristic");
 
 	ba2str(dba, addr);
-
-	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
 
 	return textfile_caseget(filename, key);
 }
diff --git a/src/storage.h b/src/storage.h
index d00976f..c3be64a 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -82,9 +82,10 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 							uint8_t bdaddr_type);
 int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-					uint16_t handle, const char *chars);
+					uint8_t bdaddr_type, uint16_t handle,
+							     const char *chars);
 char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-							uint16_t handle);
+					uint8_t bdaddr_type, uint16_t handle);
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
                                         uint16_t handle, const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
-- 
1.7.7.6

