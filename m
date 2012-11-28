Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] adapter: Add destination file to convert_file()
Date: Wed, 28 Nov 2012 14:39:23 +0100
Message-Id: <1354109967-6238-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to convert keys and longtermkeys, we will need to use
different target file names.
---
 src/adapter.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1d6aa08..f9382fd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2570,6 +2570,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 struct device_converter {
 	char *address;
 	void (*cb)(GKeyFile *key_file, void *value);
+	char *filename;
 };
 
 static void convert_aliases_entry(GKeyFile *key_file, void *value)
@@ -2657,8 +2658,8 @@ static void convert_entry(char *key, char *value, void *user_data)
 	if (bachk(key) != 0)
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-			converter->address, key);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/%s",
+			converter->address, key, converter->filename);
 	filename[PATH_MAX] = '\0';
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
@@ -2673,7 +2674,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 	g_key_file_free(key_file);
 }
 
-static void convert_file(char *file, char *address,
+static void convert_file(char *file, char *address, char *dest_file,
 				void (*cb)(GKeyFile *key_file, void *value))
 {
 	char filename[PATH_MAX + 1];
@@ -2689,6 +2690,7 @@ static void convert_file(char *file, char *address,
 	} else {
 		converter.address = address;
 		converter.cb = cb;
+		converter.filename = dest_file;
 
 		textfile_foreach(filename, convert_entry, &converter);
 		textfile_put(filename, "converted", "yes");
@@ -2718,10 +2720,10 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	free(str);
 
 	/* Convert aliases */
-	convert_file("aliases", address, convert_aliases_entry);
+	convert_file("aliases", address, "info", convert_aliases_entry);
 
 	/* Convert trusts */
-	convert_file("trusts", address, convert_trusts_entry);
+	convert_file("trusts", address, "info", convert_trusts_entry);
 
 	/* Convert classes */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
@@ -2738,10 +2740,10 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 
 	/* Convert blocked */
-	convert_file("blocked", address, convert_blocked_entry);
+	convert_file("blocked", address, "info", convert_blocked_entry);
 
 	/* Convert device ids */
-	convert_file("did", address, convert_did_entry);
+	convert_file("did", address, "info", convert_did_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

