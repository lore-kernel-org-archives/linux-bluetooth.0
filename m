Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 12/15] adapter: Convert device primaries list
Date: Thu, 13 Dec 2012 21:39:27 +0100
Message-Id: <1355431170-12897-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 02d54a3..64d8ed3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2762,6 +2762,88 @@ failed:
 	g_free(att_uuid);
 }
 
+static void convert_primaries_entry(char *key, char *value, void *user_data)
+{
+	char *address = user_data;
+	char device_type = -1;
+	uuid_t uuid;
+	char **services, **service, *prim_uuid;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	int ret;
+	uint16_t start, end;
+	char uuid_str[MAX_LEN_UUID_STR + 1];
+	char *data;
+	gsize length = 0;
+
+	if (key[17] == '#') {
+		key[17] = '\0';
+		device_type = key[18] - '0';
+	}
+
+	if (bachk(key) != 0)
+		return;
+
+	services = g_strsplit(value, " ", 0);
+	if (services == NULL)
+		return;
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", address,
+									key);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	for (service = services; *service; service++) {
+		ret = sscanf(*service, "%04hX#%04hX#%s", &start, &end,
+								uuid_str);
+		if (ret < 3)
+			continue;
+
+		bt_string2uuid(&uuid, uuid_str);
+		sdp_uuid128_to_uuid(&uuid);
+
+		store_attribute_uuid(key_file, start, prim_uuid, uuid);
+	}
+
+	g_strfreev(services);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length == 0)
+		goto end;
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+	g_file_set_contents(filename, data, length, NULL);
+
+	if (device_type < 0)
+		goto end;
+
+	g_free(data);
+	g_key_file_free(key_file);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", address, key);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	set_device_type(key_file, device_type);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+end:
+	g_free(data);
+	g_free(prim_uuid);
+	g_key_file_free(key_file);
+}
+
 static void convert_device_storage(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -2795,6 +2877,19 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert profiles */
 	convert_file("profiles", address, convert_profiles_entry, TRUE);
 
+	/* Convert primaries */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy %s file already converted", filename);
+	} else {
+		textfile_foreach(filename, convert_primaries_entry, address);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
+
 	/* Convert linkkeys */
 	convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
 
-- 
1.7.9.5

