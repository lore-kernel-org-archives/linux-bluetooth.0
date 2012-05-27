Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 3/9] storage: Store address type in "ccc" file
Date: Sat, 26 May 2012 21:40:48 -0300
Message-Id: <1338079254-14054-4-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Addressing types can be either BR/EDR, BLE public or BLE random so
the entries in the "ccc" file did not contain enough information to
distinguish which addressing type it's supposed to be. Entries will
now contain both address number and address type as a single key in
every entry in the file.
---
 src/attrib-server.c |   19 ++++++++++++++-----
 src/device.c        |    5 +++++
 src/device.h        |    1 +
 src/storage.c       |   20 ++++++++++----------
 src/storage.h       |    8 ++++----
 5 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 21b1501..3291e2d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -737,6 +737,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	uint8_t status;
 	GList *l;
 	uint16_t cccval;
+	uint8_t bdaddr_type;
 	guint h = handle;
 
 	l = g_list_find_custom(channel->server->database,
@@ -747,9 +748,11 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 
 	a = l->data;
 
+	bdaddr_type = device_get_addr_type(channel->device);
+
 	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) == 0 &&
-		read_device_ccc(&channel->src, &channel->dst,
-					handle, &cccval) == 0) {
+		read_device_ccc(&channel->src, &channel->dst, bdaddr_type,
+							handle, &cccval) == 0) {
 		uint8_t config[2];
 
 		att_put_u16(cccval, config);
@@ -775,6 +778,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	uint8_t status;
 	GList *l;
 	uint16_t cccval;
+	uint8_t bdaddr_type;
 	guint h = handle;
 
 	l = g_list_find_custom(channel->server->database,
@@ -789,9 +793,11 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
 					ATT_ECODE_INVALID_OFFSET, pdu, len);
 
+	bdaddr_type = device_get_addr_type(channel->device);
+
 	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) == 0 &&
-		read_device_ccc(&channel->src, &channel->dst,
-					handle, &cccval) == 0) {
+		read_device_ccc(&channel->src, &channel->dst, bdaddr_type,
+							handle, &cccval) == 0) {
 		uint8_t config[2];
 
 		att_put_u16(cccval, config);
@@ -847,7 +853,10 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		}
 	} else {
 		uint16_t cccval = att_get_u16(value);
-		write_device_ccc(&channel->src, &channel->dst, handle, cccval);
+		uint8_t bdaddr_type = device_get_addr_type(channel->device);
+
+		write_device_ccc(&channel->src, &channel->dst, bdaddr_type,
+								handle, cccval);
 	}
 
 	return enc_write_resp(pdu, len);
diff --git a/src/device.c b/src/device.c
index eb015ec..a01a524 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2205,6 +2205,11 @@ void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type)
 	device->bdaddr_type = bdaddr_type;
 }
 
+uint8_t device_get_addr_type(struct btd_device *device)
+{
+	return device->bdaddr_type;
+}
+
 const gchar *device_get_path(struct btd_device *device)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index 51140c7..26e17f7 100644
--- a/src/device.h
+++ b/src/device.h
@@ -62,6 +62,7 @@ struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
 							uint8_t *bdaddr_type);
 void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type);
+uint8_t device_get_addr_type(struct btd_device *device);
 const gchar *device_get_path(struct btd_device *device);
 struct agent *device_get_agent(struct btd_device *device);
 gboolean device_is_bredr(struct btd_device *device);
diff --git a/src/storage.c b/src/storage.c
index ab9b1ed..3cde9c1 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1229,12 +1229,12 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 	create_filename(filename, PATH_MAX, sba, "attributes");
 	delete_by_pattern(filename, key);
 
+	sprintf(&key[17], "#%hhu", bdaddr_type);
+
 	/* Deleting all CCC values of a given key */
 	create_filename(filename, PATH_MAX, sba, "ccc");
 	delete_by_pattern(filename, key);
 
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
 	create_filename(filename, PATH_MAX, sba, "primary");
 
 	return textfile_del(filename, key);
@@ -1307,10 +1307,10 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 	return textfile_foreach(filename, func, data);
 }
 
-int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
-							uint16_t *value)
+int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+					uint16_t handle, uint16_t *value)
 {
-	char filename[PATH_MAX + 1], addr[18], key[23];
+	char filename[PATH_MAX + 1], addr[18], key[25];
 	char *str;
 	unsigned int config;
 	int err = 0;
@@ -1318,7 +1318,7 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 	create_filename(filename, PATH_MAX, local, "ccc");
 
 	ba2str(peer, addr);
-	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
 
 	str = textfile_caseget(filename, key);
 	if (str == NULL)
@@ -1334,18 +1334,18 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 	return err;
 }
 
-int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
-							uint16_t value)
+int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+					uint16_t handle, uint16_t value)
 {
-	char filename[PATH_MAX + 1], addr[18], key[23], config[5];
+	char filename[PATH_MAX + 1], addr[18], key[25], config[5];
 
 	create_filename(filename, PATH_MAX, local, "ccc");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	ba2str(peer, addr);
+	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
 
-	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
 	snprintf(config, sizeof(config), "%04X", value);
 
 	return textfile_put(filename, key, config);
diff --git a/src/storage.h b/src/storage.h
index db33b43..b6d24e9 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -91,10 +91,10 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
                                         uint16_t handle, const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
-int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
-							uint16_t *value);
-int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
-							uint16_t value);
+int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+					uint16_t handle, uint16_t *value);
+int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+					uint16_t handle, uint16_t value);
 void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer);
 int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
 gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer);
-- 
1.7.7.6

