Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 14/15] storage: Rename primary file to primaries
Date: Wed, 23 May 2012 15:48:32 -0300
Message-Id: <1337798914-20974-15-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
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
index 585c9ed..39ae3df 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1945,7 +1945,7 @@ static GSList *string_to_primary_list(char *str)
 	return l;
 }
 
-static void create_stored_device_from_primary(char *key, char *value,
+static void create_stored_device_from_primaries(char *key, char *value,
 							void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -2004,8 +2004,8 @@ static void load_devices(struct btd_adapter *adapter)
 	textfile_foreach(filename, create_stored_device_from_profiles,
 								adapter);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primary");
-	textfile_foreach(filename, create_stored_device_from_primary,
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primaries");
+	textfile_foreach(filename, create_stored_device_from_primaries,
 								adapter);
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "linkkeys");
diff --git a/src/storage.c b/src/storage.c
index bc13cee..ae27856 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1186,7 +1186,7 @@ int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 {
 	char filename[PATH_MAX + 1], key[20];
 
-	create_filename(filename, PATH_MAX, sba, "primary");
+	create_filename(filename, PATH_MAX, sba, "primaries");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
@@ -1248,7 +1248,7 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 	create_filename(filename, PATH_MAX, sba, "ccc");
 	delete_by_pattern(filename, key);
 
-	create_filename(filename, PATH_MAX, sba, "primary");
+	create_filename(filename, PATH_MAX, sba, "primaries");
 
 	return textfile_del(filename, key);
 }
@@ -1258,7 +1258,7 @@ char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 {
 	char filename[PATH_MAX + 1], key[20];
 
-	create_filename(filename, PATH_MAX, sba, "primary");
+	create_filename(filename, PATH_MAX, sba, "primaries");
 
 	ba2str(dba, key);
 	sprintf(&key[17], "#%hhu", bdaddr_type);
-- 
1.7.7.6

