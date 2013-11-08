Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 2/3] android/debug: Convert uuid helper to use uint8_t buffer
Date: Fri,  8 Nov 2013 11:35:48 +0200
Message-Id: <1383903349-17487-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383903349-17487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383903349-17487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

At this moment Android uses uint8_t * and bt_uuid_t for representing
UUID for different HALs. Convert debug helper to use uint8_t * string.
---
 android/client/textconv.c |    8 ++++++--
 android/hal-utils.c       |   17 ++++++++---------
 android/hal-utils.h       |    4 ++--
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 469b2c3..a1ce7dd 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -272,7 +272,9 @@ char *btproperty2str(const bt_property_t *property)
 			strcat(p, "{");
 
 			while (count--) {
-				strcat(p, btuuid2str((bt_uuid_t *) ptr));
+				bt_uuid_t *uuid = (bt_uuid_t *) ptr;
+				strcat(p, btuuid2str(uuid->uu,
+							sizeof(uuid->uu)));
 				if (count)
 					strcat(p, ", ");
 				ptr += sizeof(bt_uuid_t);
@@ -286,8 +288,10 @@ char *btproperty2str(const bt_property_t *property)
 	case BT_PROPERTY_SERVICE_RECORD:
 		{
 			bt_service_record_t *rec = property->val;
+			bt_uuid_t *uuid = &rec->uuid;
 
-			sprintf(p, "{%s, %d, %s}", btuuid2str(&rec->uuid),
+			sprintf(p, "{%s, %d, %s}", btuuid2str(uuid->uu,
+						sizeof(uuid->uu)),
 						rec->channel, rec->name);
 		}
 		break;
diff --git a/android/hal-utils.c b/android/hal-utils.c
index 84cfad1..3dc70c3 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -17,8 +17,7 @@
 
 #include <stdio.h>
 #include <string.h>
-
-#include <hardware/bluetooth.h>
+#include <stdint.h>
 
 #include "hal-utils.h"
 
@@ -28,15 +27,15 @@
  *
  * returns string representation of uuid
  */
-char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
+char *bt_uuid_t2str(const uint8_t *uuid, size_t len, char *buf)
 {
 	int shift = 0;
-	int i;
+	unsigned int i;
 	int is_bt;
 
-	is_bt = !memcmp(&uuid->uu[4], &BT_BASE_UUID[4], sizeof(bt_uuid_t) - 4);
+	is_bt = !memcmp(&uuid[4], &BT_BASE_UUID[4], len - 4);
 
-	for (i = 0; i < (int) sizeof(bt_uuid_t); i++) {
+	for (i = 0; i < len; i++) {
 		if (i == 4 && is_bt)
 			break;
 
@@ -44,15 +43,15 @@ char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
 			buf[i * 2 + shift] = '-';
 			shift++;
 		}
-		sprintf(buf + i * 2 + shift, "%02x", uuid->uu[i]);
+		sprintf(buf + i * 2 + shift, "%02x", uuid[i]);
 	}
 
 	return buf;
 }
 
-char *btuuid2str(const bt_uuid_t *uuid)
+char *btuuid2str(const uint8_t *uuid, size_t len)
 {
 	static char buf[MAX_UUID_STR_LEN];
 
-	return bt_uuid_t2str(uuid, buf);
+	return bt_uuid_t2str(uuid, len, buf);
 }
diff --git a/android/hal-utils.h b/android/hal-utils.h
index d40b430..3b00e98 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -22,5 +22,5 @@ static const char BT_BASE_UUID[] = {
 	0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb
 };
 
-char *btuuid2str(const bt_uuid_t *uuid);
-char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
+char *bt_uuid_t2str(const uint8_t *uuid, size_t len, char *buf);
+char *btuuid2str(const uint8_t *uuid, size_t len);
-- 
1.7.10.4

