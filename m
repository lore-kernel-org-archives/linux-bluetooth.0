Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/13] adapter: Convert proximity file
Date: Mon, 17 Dec 2012 16:09:49 +0100
Message-Id: <1355756994-18953-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1417a85..581c528 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2614,6 +2614,54 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 	g_key_file_free(key_file);
 }
 
+static void convert_proximity_entry(char *key, char *value, void *user_data)
+{
+	char *src_addr = user_data;
+	char *alert;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	struct stat st;
+	int err;
+	char *data;
+	gsize length = 0;
+
+	if (!strchr(key, '#'))
+		return;
+
+	key[17] = '\0';
+	alert = &key[18];
+
+	if (bachk(key) != 0)
+		return;
+
+	/* Check if the device directory has been created as records should
+	 * only be converted for known devices */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, key);
+	filename[PATH_MAX] = '\0';
+
+	err = stat(filename, &st);
+	if (err || !S_ISDIR(st.st_mode))
+		return;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/proximity", src_addr,
+									key);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	g_key_file_set_string(key_file, alert, "Level", value);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+	g_key_file_free(key_file);
+}
+
 static void convert_device_storage(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -2713,6 +2761,19 @@ static void convert_device_storage(struct btd_adapter *adapter)
 		textfile_put(filename, "converted", "yes");
 	}
 	free(str);
+
+	/* Convert proximity */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy %s file already converted", filename);
+	} else {
+		textfile_foreach(filename, convert_proximity_entry, address);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

