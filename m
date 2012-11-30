Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 04/12] adapter: Add force dir creation to convert_file()
Date: Fri, 30 Nov 2012 15:46:58 +0100
Message-Id: <1354286826-24016-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some device information, like class or device id, should only be
converted if directory for this device has already been created
during previous conversion (from aliases, trusts, blocked, ...
files).
---
 src/adapter.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8e3251b..a976793 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -34,6 +34,7 @@
 #include <stdbool.h>
 #include <sys/ioctl.h>
 #include <sys/file.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -2526,6 +2527,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 struct device_converter {
 	char *address;
 	void (*cb)(GKeyFile *key_file, void *value);
+	gboolean force;
 };
 
 static void convert_aliases_entry(GKeyFile *key_file, void *value)
@@ -2601,6 +2603,19 @@ static void convert_entry(char *key, char *value, void *user_data)
 	if (bachk(key) != 0)
 		return;
 
+	if (converter->force == FALSE) {
+		struct stat st;
+		int err;
+
+		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
+				converter->address, key);
+		filename[PATH_MAX] = '\0';
+
+		err = stat(filename, &st);
+		if (err || !S_ISDIR(st.st_mode))
+			return;
+	}
+
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			converter->address, key);
 	filename[PATH_MAX] = '\0';
@@ -2621,7 +2636,8 @@ static void convert_entry(char *key, char *value, void *user_data)
 }
 
 static void convert_file(char *file, char *address,
-				void (*cb)(GKeyFile *key_file, void *value))
+				void (*cb)(GKeyFile *key_file, void *value),
+				gboolean force)
 {
 	char filename[PATH_MAX + 1];
 	struct device_converter converter;
@@ -2636,6 +2652,7 @@ static void convert_file(char *file, char *address,
 	} else {
 		converter.address = address;
 		converter.cb = cb;
+		converter.force = force;
 
 		textfile_foreach(filename, convert_entry, &converter);
 		textfile_put(filename, "converted", "yes");
@@ -2665,19 +2682,19 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	free(str);
 
 	/* Convert aliases */
-	convert_file("aliases", address, convert_aliases_entry);
+	convert_file("aliases", address, convert_aliases_entry, TRUE);
 
 	/* Convert trusts */
-	convert_file("trusts", address, convert_trusts_entry);
-
-	/* Convert classes */
-	convert_file("classes", address, convert_classes_entry);
+	convert_file("trusts", address, convert_trusts_entry, TRUE);
 
 	/* Convert blocked */
-	convert_file("blocked", address, convert_blocked_entry);
+	convert_file("blocked", address, convert_blocked_entry, TRUE);
+
+	/* Convert classes */
+	convert_file("classes", address, convert_classes_entry, FALSE);
 
 	/* Convert device ids */
-	convert_file("did", address, convert_did_entry);
+	convert_file("did", address, convert_did_entry, FALSE);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

