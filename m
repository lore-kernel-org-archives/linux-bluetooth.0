Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/14] adapter: Convert device sdp file
Date: Wed, 12 Dec 2012 16:47:56 +0100
Message-Id: <1355327283-1558-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse sdp file to retrieve services, i.e. sdp records with attribute
uuid.
Create device attributes file based on this.
---
 src/adapter.c |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 10aacbf..baeae79 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2607,6 +2607,127 @@ static void convert_file(char *file, char *address,
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
+	sprintf(handle, "%hd", start);
+	g_key_file_set_string(key_file, handle, "UUID", att_uuid);
+	g_key_file_set_string(key_file, handle, "Value", uuid_str);
+}
+
+static void convert_sdp_entry(char *key, char *value, void *user_data)
+{
+	char *address = user_data;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	struct stat st;
+	sdp_record_t *rec;
+	uuid_t uuid;
+	char *att_uuid, *prim_uuid;
+	uint16_t start = 0, end = 0, psm = 0;
+	char *str;
+	gsize length = 0;
+	int err;
+
+	if (key[17] == '#')
+		key[17] = '\0';
+
+	if (bachk(key) != 0)
+		return;
+
+	/* Check if the device directory has been created as records should
+	 * only be converted for known devices */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, key);
+	filename[PATH_MAX] = '\0';
+
+	err = stat(filename, &st);
+	if (err || !S_ISDIR(st.st_mode))
+		return;
+
+	sdp_uuid16_create(&uuid, ATT_UUID);
+	att_uuid = bt_uuid2string(&uuid);
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
+
+	/* Retrieve device record and check if there is an
+	 * attribute entry in it */
+	rec = record_from_string(value);
+
+	if (!record_has_uuid(rec, att_uuid))
+		goto failed;
+
+	if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
+		goto failed;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", address,
+									key);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	store_attribute_uuid(key_file, start, prim_uuid, uuid);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, str, length, NULL);
+	}
+
+	g_free(str);
+
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
@@ -2651,6 +2772,19 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
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

