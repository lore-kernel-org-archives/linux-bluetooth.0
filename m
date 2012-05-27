Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 8/9] storage: Rename primary file to primaries
Date: Sat, 26 May 2012 21:40:53 -0300
Message-Id: <1338079254-14054-9-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch renames the "primary" file to "primaries" to be more suitable
with its content.
---
 src/adapter.c |    6 +++---
 src/storage.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1d9ee6c..6e04faf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1935,7 +1935,7 @@ static GSList *string_to_primary_list(char *str)
 	return l;
 }
 
-static void create_stored_device_from_primary(char *key, char *value,
+static void create_stored_device_from_primaries(char *key, char *value,
 							void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -1994,8 +1994,8 @@ static void load_devices(struct btd_adapter *adapter)
 	textfile_foreach(filename, create_stored_device_from_profiles,
 								adapter);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primary");
-	textfile_foreach(filename, create_stored_device_from_primary,
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primaries");
+	textfile_foreach(filename, create_stored_device_from_primaries,
 								adapter);
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "linkkeys");
diff --git a/src/storage.c b/src/storage.c
index 9a47d29..722abde 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1169,7 +1169,7 @@ int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 {
 	char filename[PATH_MAX + 1], key[20];
 
-	create_filename(filename, PATH_MAX, sba, "primary");
+	create_filename(filename, PATH_MAX, sba, "primaries");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
@@ -1231,7 +1231,7 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 	create_filename(filename, PATH_MAX, sba, "ccc");
 	delete_by_pattern(filename, key);
 
-	create_filename(filename, PATH_MAX, sba, "primary");
+	create_filename(filename, PATH_MAX, sba, "primaries");
 
 	return textfile_del(filename, key);
 }
@@ -1241,7 +1241,7 @@ char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 {
 	char filename[PATH_MAX + 1], key[20];
 
-	create_filename(filename, PATH_MAX, sba, "primary");
+	create_filename(filename, PATH_MAX, sba, "primaries");
 
 	ba2str(dba, key);
 	sprintf(&key[17], "#%hhu", bdaddr_type);
-- 
1.7.7.6

