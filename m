Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 05/12] core: Fix sscanf() format specification
Date: Fri,  3 Jan 2014 21:55:21 -0400
Message-Id: <1388800528-10699-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also change the type of the "handle" variable so it is compatible with
the "%hu" specification used for sprintf() on the same function.

Fixes clang error:

src/adapter.c:3550:24: error: format specifies type 'unsigned short' but
the argument has type 'int' [-Werror,-Wformat]
---
 src/adapter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9480103..230f3ce 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3515,16 +3515,16 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 	char *src_addr = user_data;
 	char dst_addr[18];
 	char type = BDADDR_BREDR;
-	int handle, ret;
+	uint16_t handle;
+	int ret, err;
 	char filename[PATH_MAX + 1];
 	GKeyFile *key_file;
 	struct stat st;
-	int err;
 	char group[6];
 	char *data;
 	gsize length = 0;
 
-	ret = sscanf(key, "%17s#%hhu#%04X", dst_addr, &type, &handle);
+	ret = sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);
 	if (ret < 3)
 		return;
 
@@ -3565,16 +3565,16 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 	char *src_addr = user_data;
 	char dst_addr[18];
 	char type = BDADDR_BREDR;
-	int handle, ret;
+	uint16_t handle;
+	int ret, err;
 	char filename[PATH_MAX + 1];
 	GKeyFile *key_file;
 	struct stat st;
-	int err;
 	char group[6];
 	char *data;
 	gsize length = 0;
 
-	ret = sscanf(key, "%17s#%hhu#%04X", dst_addr, &type, &handle);
+	ret = sscanf(key, "%17s#%hhu#%04hX", dst_addr, &type, &handle);
 	if (ret < 3)
 		return;
 
-- 
1.8.3.2

