Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 2/7] android/haltest: Use pointer as parameter for debug
Date: Fri,  1 Nov 2013 17:19:14 +0200
Message-Id: <1383319159-13060-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Pass structure as pointer. This makes it consistent with the rest of
the code and helps to reuse this function in other parts.
---
 android/client/if-bt.c    |    2 +-
 android/client/textconv.c |   36 ++++++++++++++++++------------------
 android/client/textconv.h |    2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index e7d0659..43e8788 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -74,7 +74,7 @@ static void dump_properties(int num_properties, bt_property_t *properties)
 		bt_property_t prop;
 		memcpy(&prop, properties + i, sizeof(prop));
 
-		haltest_info("prop: %s\n", btproperty2str(prop));
+		haltest_info("prop: %s\n", btproperty2str(&prop));
 	}
 }
 
diff --git a/android/client/textconv.c b/android/client/textconv.c
index 8f27948..1dc6ad0 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -241,52 +241,52 @@ static char *btuuid2str(const bt_uuid_t *uuid)
 	return bt_uuid_t2str(uuid, buf);
 }
 
-char *btproperty2str(bt_property_t property)
+char *btproperty2str(const bt_property_t *property)
 {
 	static char buf[4096];
 	char *p;
 
 	p = buf + sprintf(buf, "type=%s len=%d val=",
-					bt_property_type_t2str(property.type),
-					property.len);
+					bt_property_type_t2str(property->type),
+					property->len);
 
-	switch (property.type) {
+	switch (property->type) {
 	case BT_PROPERTY_BDNAME:
 	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
-		sprintf(p, "%*s", property.len,
-					((bt_bdname_t *) property.val)->name);
+		sprintf(p, "%*s", property->len,
+					((bt_bdname_t *) property->val)->name);
 		break;
 
 	case BT_PROPERTY_BDADDR:
-		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property.val));
+		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property->val));
 		break;
 
 	case BT_PROPERTY_CLASS_OF_DEVICE:
-		sprintf(p, "%06x", *((int *) property.val));
+		sprintf(p, "%06x", *((int *) property->val));
 		break;
 
 	case BT_PROPERTY_TYPE_OF_DEVICE:
 		sprintf(p, "%s", bt_device_type_t2str(
-					*((bt_device_type_t *) property.val)));
+				*((bt_device_type_t *) property->val)));
 		break;
 
 	case BT_PROPERTY_REMOTE_RSSI:
-		sprintf(p, "%d", *((char *) property.val));
+		sprintf(p, "%d", *((char *) property->val));
 		break;
 
 	case BT_PROPERTY_ADAPTER_SCAN_MODE:
 		sprintf(p, "%s",
-			bt_scan_mode_t2str(*((bt_scan_mode_t *) property.val)));
+			bt_scan_mode_t2str(*((bt_scan_mode_t *) property->val)));
 		break;
 
 	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-		sprintf(p, "%d", *((int *) property.val));
+		sprintf(p, "%d", *((int *) property->val));
 		break;
 
 	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
 		{
-			int count = property.len / sizeof(bt_bdaddr_t);
-			char *ptr = property.val;
+			int count = property->len / sizeof(bt_bdaddr_t);
+			char *ptr = property->val;
 
 			strcat(p, "{");
 
@@ -304,8 +304,8 @@ char *btproperty2str(bt_property_t property)
 
 	case BT_PROPERTY_UUIDS:
 		{
-			int count = property.len / sizeof(bt_uuid_t);
-			char *ptr = property.val;
+			int count = property->len / sizeof(bt_uuid_t);
+			char *ptr = property->val;
 
 			strcat(p, "{");
 
@@ -323,7 +323,7 @@ char *btproperty2str(bt_property_t property)
 
 	case BT_PROPERTY_SERVICE_RECORD:
 		{
-			bt_service_record_t *rec = property.val;
+			bt_service_record_t *rec = property->val;
 
 			sprintf(p, "{%s, %d, %s}", btuuid2str(&rec->uuid),
 						rec->channel, rec->name);
@@ -331,7 +331,7 @@ char *btproperty2str(bt_property_t property)
 		break;
 
 	default:
-		sprintf(p, "%p", property.val);
+		sprintf(p, "%p", property->val);
 	}
 
 	return buf;
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 89b29c6..1c848ef 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -107,7 +107,7 @@ void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
 char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
 void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 
-char *btproperty2str(bt_property_t property);
+char *btproperty2str(const bt_property_t *property);
 char *bdaddr2str(const bt_bdaddr_t *bd_addr);
 
 DECINTMAP(bt_status_t);
-- 
1.7.10.4

