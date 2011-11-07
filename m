Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Fix removing storage for device over BR/EDR
Date: Mon,  7 Nov 2011 11:16:20 -0300
Message-Id: <1320675380-23186-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"characteristic", "attributes" and "ccc" files will be shared by both
transports: LE and BR/EDR. Remove the entry from the "primary" file
should be the last operation to clean the storage properly if the
device operation mode is GATT/ATT over BR/EDR.
---
 Dependencies:
 [PATCH BlueZ 0/7] CCC persistence
 [PATCH BlueZ 0/2] CCC for bonded devices

 src/storage.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index e4ad4ab..a47720a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1170,17 +1170,10 @@ done:
 int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
 {
 	char filename[PATH_MAX + 1], address[18];
-	int err;
-
-	create_filename(filename, PATH_MAX, sba, "primary");
 
 	memset(address, 0, sizeof(address));
 	ba2str(dba, address);
 
-	err = textfile_del(filename, address);
-	if (err < 0)
-		return err;
-
 	/* Deleting all characteristics of a given address */
 	create_filename(filename, PATH_MAX, sba, "characteristic");
 	delete_by_pattern(filename, address);
@@ -1193,7 +1186,8 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
 	create_filename(filename, PATH_MAX, sba, "ccc");
 	delete_by_pattern(filename, address);
 
-	return 0;
+	create_filename(filename, PATH_MAX, sba, "primary");
+	return textfile_del(filename, address);
 }
 
 char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba)
-- 
1.7.7.2

