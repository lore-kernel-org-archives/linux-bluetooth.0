Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] adapter: Convert ccc file
Date: Fri, 14 Dec 2012 17:45:17 +0100
Message-Id: <1355503519-26573-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/settings-storage.txt |   14 +++++++++++
 src/adapter.c            |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 11b127f..ced51d9 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -31,6 +31,7 @@ contains:
    contains:
     - an info file
     - an attributes file containing attributes of remote LE services
+    - a ccc file containing CCC info of remote LE services
 
 So the directory structure is:
     /var/lib/bluetooth/<adapter address>/
@@ -43,6 +44,7 @@ So the directory structure is:
         ./<remote device address>/
             ./info
             ./attributes
+            ./ccc
         ./<remote device address>/
             ./info
             ./attributes
@@ -114,6 +116,18 @@ Sample:
   UUID=00002a00-0000-1000-8000-00805f9b34fb
   Value=4578616D706C6520446576696365
 
+CCC file format
+======================
+
+The ccc file stores CCC  informations related to remote device.
+
+Informations are stored using their handle as group name (decimal format).
+
+Each group contains:
+
+  Value			String		Value of the CCC as hexadecimal encoded
+					string
+
 Cache directory file format
 ============================
 
diff --git a/src/adapter.c b/src/adapter.c
index 37e85ed..0dda57d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2636,6 +2636,56 @@ end:
 	g_key_file_free(key_file);
 }
 
+static void convert_ccc_entry(char *key, char *value, void *user_data)
+{
+	char *src_addr = user_data;
+	char dst_addr[18];
+	char type = BDADDR_BREDR;
+	int handle, ret;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	struct stat st;
+	int err;
+	char group[6];
+	char *data;
+	gsize length = 0;
+
+	ret = sscanf(key, "%17s#%hhu#%04X", dst_addr, &type, &handle);
+	if (ret < 3)
+		return;
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
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/ccc", src_addr,
+								dst_addr);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	sprintf(group, "%hu", handle);
+	g_key_file_set_string(key_file, group, "Value", value);
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
@@ -2706,6 +2756,19 @@ static void convert_device_storage(struct btd_adapter *adapter)
 		textfile_put(filename, "converted", "yes");
 	}
 	free(str);
+
+	/* Convert ccc */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy %s file already converted", filename);
+	} else {
+		textfile_foreach(filename, convert_ccc_entry, address);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

