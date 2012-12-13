Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/15] adapter: Convert device sdp file
Date: Thu, 13 Dec 2012 21:39:23 +0100
Message-Id: <1355431170-12897-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Save SDP records in device device file located in SDP directory.

Parse "sdp" file to retrieve services, i.e. sdp records with
attribute uuid.
Create device attributes file based on this.
---
 src/adapter.c |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 241c6c8..02d54a3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2604,6 +2604,164 @@ static void convert_file(char *file, char *address,
 	free(str);
 }
 
+static gboolean record_has_uuid(const sdp_record_t *rec,
+				const char *profile_uuid)
+{
+	sdp_list_t *pat;
+
+	for (pat = rec->pattern; pat != NULL; pat = pat->next) {
+		char *uuid;
+		int ret;
+
+		uuid = bt_uuid2string(pat->data);
+		if (!uuid)
+			continue;
+
+		ret = strcasecmp(uuid, profile_uuid);
+
+		g_free(uuid);
+
+		if (ret == 0)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void store_attribute_uuid(GKeyFile *key_file, uint16_t start,
+					char *att_uuid, uuid_t uuid)
+{
+	char handle[6], uuid_str[33];
+	int i;
+
+	switch (uuid.type) {
+	case SDP_UUID16:
+		sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
+		break;
+	case SDP_UUID32:
+		sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
+		break;
+	case SDP_UUID128:
+		for (i = 0; i < 16; i++)
+			sprintf(uuid_str + (i * 2), "%2.2X",
+					uuid.value.uuid128.data[i]);
+		break;
+	default:
+		uuid_str[0] = '\0';
+	}
+
+	sprintf(handle, "%hu", start);
+	g_key_file_set_string(key_file, handle, "UUID", att_uuid);
+	g_key_file_set_string(key_file, handle, "Value", uuid_str);
+}
+
+static void store_sdp_record(char *local, char *peer, int handle, char *value)
+{
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char handle_str[11];
+	char *data;
+	gsize length = 0;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	sprintf(handle_str, "0x%8.8X", handle);
+	g_key_file_set_string(key_file, "ServiceRecords", handle_str, value);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+static void convert_sdp_entry(char *key, char *value, void *user_data)
+{
+	char *src_addr = user_data;
+	char dst_addr[18];
+	char type = BDADDR_BREDR;
+	int handle, ret;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	struct stat st;
+	sdp_record_t *rec;
+	uuid_t uuid;
+	char *att_uuid, *prim_uuid;
+	uint16_t start = 0, end = 0, psm = 0;
+	int err;
+	char *data;
+	gsize length = 0;
+
+	ret = sscanf(key, "%17s#%hhu#%08X", dst_addr, &type, &handle);
+	if (ret < 3) {
+		ret = sscanf(key, "%17s#%08X", dst_addr, &handle);
+		if (ret < 2)
+			return;
+	}
+
+	if (bachk(dst_addr) != 0)
+		return;
+
+	/* Check if the device directory has been created as records should
+	 * only be converted for known devices */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
+	filename[PATH_MAX] = '\0';
+
+	err = stat(filename, &st);
+	if (err || !S_ISDIR(st.st_mode))
+		return;
+
+	/* store device records in cache */
+	store_sdp_record(src_addr, dst_addr, handle, value);
+
+	/* Retrieve device record and check if there is an
+	 * attribute entry in it */
+	sdp_uuid16_create(&uuid, ATT_UUID);
+	att_uuid = bt_uuid2string(&uuid);
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
+
+	rec = record_from_string(value);
+
+	if (record_has_uuid(rec, att_uuid))
+		goto failed;
+
+	if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
+		goto failed;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
+								dst_addr);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	store_attribute_uuid(key_file, start, prim_uuid, uuid);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+	g_key_file_free(key_file);
+
+failed:
+	sdp_record_free(rec);
+	g_free(prim_uuid);
+	g_free(att_uuid);
+}
+
 static void convert_device_storage(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -2648,6 +2806,19 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert device ids */
 	convert_file("did", address, convert_did_entry, FALSE);
+
+	/* Convert sdp */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy %s file already converted", filename);
+	} else {
+		textfile_foreach(filename, convert_sdp_entry, address);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

