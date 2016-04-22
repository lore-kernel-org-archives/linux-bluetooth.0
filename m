Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] doc/settings-storage: Add alternative format for descriptors
Date: Fri, 22 Apr 2016 14:42:37 +0300
Message-Id: <1461325357-4013-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
References: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of some descriptors like CEP we must store the actual value since
extended properties are not part of the discovery and btd_gatt_client no
longer attempt to read it the value must be loaded in the db so
gatt_db_attribute_get_char_data is able to retrieve it.
---
 doc/settings-storage.txt |  1 +
 src/device.c             | 49 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index aea50a6..2c34ec4 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -175,6 +175,7 @@ how to interpret rest of value:
     2803:value_handle:properties:uuid
 
   Descriptor:
+    value:uuid
     uuid
 
 Sample Attributes section:
diff --git a/src/device.c b/src/device.c
index ed8fcdf..b004f43 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1957,6 +1957,7 @@ static void store_services(struct btd_device *device)
 
 struct gatt_saver {
 	struct btd_device *device;
+	uint16_t ext_props;
 	GKeyFile *key_file;
 };
 
@@ -1966,6 +1967,7 @@ static void store_desc(struct gatt_db_attribute *attr, void *user_data)
 	GKeyFile *key_file = saver->key_file;
 	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
 	const bt_uuid_t *uuid;
+	bt_uuid_t ext_uuid;
 	uint16_t handle_num;
 
 	handle_num = gatt_db_attribute_get_handle(attr);
@@ -1973,7 +1975,13 @@ static void store_desc(struct gatt_db_attribute *attr, void *user_data)
 
 	uuid = gatt_db_attribute_get_type(attr);
 	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
-	sprintf(value, "%s", uuid_str);
+
+	bt_uuid16_create(&ext_uuid, GATT_CHARAC_EXT_PROPER_UUID);
+	if (!bt_uuid_cmp(uuid, &ext_uuid) && saver->ext_props)
+		sprintf(value, "%04hx:%s", saver->ext_props, uuid_str);
+	else
+		sprintf(value, "%s", uuid_str);
+
 	g_key_file_set_string(key_file, "Attributes", handle, value);
 }
 
@@ -1987,7 +1995,8 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
-						&properties, NULL, &uuid)) {
+						&properties, &saver->ext_props,
+						&uuid)) {
 		warn("Error storing characteristic - can't get data");
 		return;
 	}
@@ -2987,24 +2996,43 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
 	*new_services = g_slist_append(*new_services, prim);
 }
 
+static void load_desc_value(struct gatt_db_attribute *attrib,
+						int err, void *user_data)
+{
+	if (err)
+		warn("loading descriptor value to db failed");
+}
+
 static int load_desc(char *handle, char *value,
 					struct gatt_db_attribute *service)
 {
 	char uuid_str[MAX_LEN_UUID_STR];
 	struct gatt_db_attribute *att;
 	uint16_t handle_int;
-	bt_uuid_t uuid;
+	uint16_t val;
+	bt_uuid_t uuid, ext_uuid;
 
 	if (sscanf(handle, "%04hx", &handle_int) != 1)
 		return -EIO;
 
-	if (sscanf(value, "%s", uuid_str) != 1)
-		return -EIO;
+	/* Check if there is any value stored, otherwise it is just the UUID */
+	if (sscanf(value, "%04hx:%s", &val, uuid_str) != 2) {
+		if (sscanf(value, "%s", uuid_str) != 1)
+			return -EIO;
+		val = 0;
+	}
+
+	DBG("loading descriptor handle: 0x%04x, value: 0x%04x, uuid: %s",
+				handle_int, val, uuid_str);
 
 	bt_string_to_uuid(&uuid, uuid_str);
+	bt_uuid16_create(&ext_uuid, GATT_CHARAC_EXT_PROPER_UUID);
 
-	DBG("loading descriptor handle: 0x%04x, uuid: %s", handle_int,
-								uuid_str);
+	/* If it is CEP then it must contain the value */
+	if (!bt_uuid_cmp(&uuid, &ext_uuid) && !val) {
+		warn("cannot load CEP descriptor without value");
+		return -EIO;
+	}
 
 	att = gatt_db_service_insert_descriptor(service, handle_int, &uuid,
 							0, NULL, NULL, NULL);
@@ -3013,6 +3041,13 @@ static int load_desc(char *handle, char *value,
 		return -EIO;
 	}
 
+	if (val) {
+		if (!gatt_db_attribute_write(att, 0, (uint8_t *)&val,
+						sizeof(val), 0, NULL,
+						load_desc_value, NULL))
+			return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.5.5

