Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/5] Remove create_file calls for read operations
Date: Fri,  9 Sep 2011 09:51:06 -0300
Message-Id: <1315572669-5006-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315572669-5006-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1315572669-5006-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes some read only functions in storage.c removing
create_file function calls.
---
 src/storage.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 1002753..c2d1edc 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1110,8 +1110,6 @@ int read_device_pairable(bdaddr_t *bdaddr, gboolean *mode)
 
 	create_filename(filename, PATH_MAX, bdaddr, "config");
 
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
 	str = textfile_get(filename, "pairable");
 	if (!str)
 		return -ENOENT;
@@ -1238,8 +1236,6 @@ char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba)
 
 	create_filename(filename, PATH_MAX, sba, "primary");
 
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
 	ba2str(dba, addr);
 
 	return textfile_caseget(filename, addr);
@@ -1268,8 +1264,6 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 
 	create_filename(filename, PATH_MAX, sba, "characteristic");
 
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
 	ba2str(dba, addr);
 
 	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
@@ -1299,8 +1293,6 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 
 	create_filename(filename, PATH_MAX, sba, "attributes");
 
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
 	return textfile_foreach(filename, func, data);
 }
 
-- 
1.7.6

