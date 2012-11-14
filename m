Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] adapter: Convert storage aliases
Date: Wed, 14 Nov 2012 12:28:49 +0100
Message-Id: <1352892533-15154-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f9eb3af..7ba821e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2533,6 +2533,69 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 	store_cached_name(&local, &peer, value);
 }
 
+struct device_converter {
+	char *address;
+	void (*cb)(GKeyFile *key_file, void *value);
+};
+
+static void convert_aliases_entry(GKeyFile *key_file, void *value)
+{
+	g_key_file_set_string(key_file, "General", "Alias", value);
+}
+
+static void convert_entry(char *key, char *value, void *user_data)
+{
+	struct device_converter *converter = user_data;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
+
+	if (key[17] == '#')
+		key[17] = '\0';
+
+	if (bachk(key) != 0)
+		return;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+			converter->address, key);
+	filename[PATH_MAX] = '\0';
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	converter->cb(key_file, value);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+static void convert_file(char *file, char *address,
+				void (*cb)(GKeyFile *key_file, void *value))
+{
+	char filename[PATH_MAX + 1];
+	struct device_converter converter;
+	char *str;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, file);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy file %s already converted", filename);
+	} else {
+		converter.address = address;
+		converter.cb = cb;
+
+		textfile_foreach(filename, convert_entry, &converter);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
+}
+
 static void convert_device_storage(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -2553,6 +2616,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 		textfile_put(filename, "converted", "yes");
 	}
 	free(str);
+
+	/* Convert aliases */
+	convert_file("aliases", address, convert_aliases_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

