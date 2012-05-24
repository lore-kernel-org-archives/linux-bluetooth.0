Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 13/16] storage: Rename characteristic to characteristics
Date: Thu, 24 May 2012 15:46:10 -0300
Message-Id: <1337885173-9129-14-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch renames the "characteristic" file to "characteristics" to be
more suitable with its content.
---
 src/storage.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 2d15a23..8693552 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1237,7 +1237,7 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 	sprintf(&key[17], "#%hhu", bdaddr_type);
 
 	/* Deleting all characteristics of a given key */
-	create_filename(filename, PATH_MAX, sba, "characteristic");
+	create_filename(filename, PATH_MAX, sba, "characteristics");
 	delete_by_pattern(filename, key);
 
 	/* Deleting all attributes values of a given key */
@@ -1272,7 +1272,7 @@ int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 {
 	char filename[PATH_MAX + 1], addr[18], key[25];
 
-	create_filename(filename, PATH_MAX, sba, "characteristic");
+	create_filename(filename, PATH_MAX, sba, "characteristics");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
@@ -1287,7 +1287,7 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 {
 	char filename[PATH_MAX + 1], addr[18], key[25];
 
-	create_filename(filename, PATH_MAX, sba, "characteristic");
+	create_filename(filename, PATH_MAX, sba, "characteristics");
 
 	ba2str(dba, addr);
 	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
-- 
1.7.7.6

