Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 [2/3]] android/debug: Convert uuid helper to use uint8_t buffer
Date: Fri,  8 Nov 2013 15:48:43 +0200
Message-Id: <1383918523-9641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383916561-9719-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383916561-9719-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

At this moment Android uses uint8_t * and bt_uuid_t for representing
UUID for different HALs. Convert debug helper to use uint8_t * string.
---
 android/client/textconv.c |    6 +++---
 android/hal-utils.c       |   15 +++++++--------
 android/hal-utils.h       |    7 ++++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 469b2c3..60ac08a 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -267,12 +267,12 @@ char *btproperty2str(const bt_property_t *property)
 	case BT_PROPERTY_UUIDS:
 		{
 			int count = property->len / sizeof(bt_uuid_t);
-			char *ptr = property->val;
+			uint8_t *ptr = property->val;
 
 			strcat(p, "{");
 
 			while (count--) {
-				strcat(p, btuuid2str((bt_uuid_t *) ptr));
+				strcat(p, btuuid2str(ptr));
 				if (count)
 					strcat(p, ", ");
 				ptr += sizeof(bt_uuid_t);
@@ -287,7 +287,7 @@ char *btproperty2str(const bt_property_t *property)
 		{
 			bt_service_record_t *rec = property->val;
 
-			sprintf(p, "{%s, %d, %s}", btuuid2str(&rec->uuid),
+			sprintf(p, "{%s, %d, %s}", btuuid2str(rec->uuid.uu),
 						rec->channel, rec->name);
 		}
 		break;
diff --git a/android/hal-utils.c b/android/hal-utils.c
index 84cfad1..96dc234 100644
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
+char *bt_uuid_t2str(const uint8_t *uuid, char *buf)
 {
 	int shift = 0;
-	int i;
+	unsigned int i;
 	int is_bt;
 
-	is_bt = !memcmp(&uuid->uu[4], &BT_BASE_UUID[4], sizeof(bt_uuid_t) - 4);
+	is_bt = !memcmp(&uuid[4], &BT_BASE_UUID[4], HAL_UUID_LEN - 4);
 
-	for (i = 0; i < (int) sizeof(bt_uuid_t); i++) {
+	for (i = 0; i < HAL_UUID_LEN; i++) {
 		if (i == 4 && is_bt)
 			break;
 
@@ -44,13 +43,13 @@ char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
 			buf[i * 2 + shift] = '-';
 			shift++;
 		}
-		sprintf(buf + i * 2 + shift, "%02x", uuid->uu[i]);
+		sprintf(buf + i * 2 + shift, "%02x", uuid[i]);
 	}
 
 	return buf;
 }
 
-char *btuuid2str(const bt_uuid_t *uuid)
+char *btuuid2str(const uint8_t *uuid)
 {
 	static char buf[MAX_UUID_STR_LEN];
 
diff --git a/android/hal-utils.h b/android/hal-utils.h
index d40b430..5287180 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -15,12 +15,13 @@
  *
  */
 
-#define MAX_UUID_STR_LEN 37
+#define MAX_UUID_STR_LEN	37
+#define HAL_UUID_LEN		16
 
 static const char BT_BASE_UUID[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
 	0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb
 };
 
-char *btuuid2str(const bt_uuid_t *uuid);
-char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
+char *bt_uuid_t2str(const uint8_t *uuid, char *buf);
+char *btuuid2str(const uint8_t *uuid);
-- 
1.7.10.4

