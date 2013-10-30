Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 1/8] android/haltest: Export print property
Date: Wed, 30 Oct 2013 14:16:39 +0200
Message-Id: <1383135406-23658-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Export property printing debug function.
---
 android/client/if-bt.c    |  110 ---------------------------------------------
 android/client/textconv.c |  110 +++++++++++++++++++++++++++++++++++++++++++++
 android/client/textconv.h |    3 ++
 3 files changed, 113 insertions(+), 110 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index a20a7c6..e9edec5 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -29,20 +29,6 @@ const bt_interface_t *if_bluetooth;
 		} \
 	} while (0)
 
-static char *bdaddr2str(const bt_bdaddr_t *bd_addr)
-{
-	static char buf[MAX_ADDR_STR_LEN];
-
-	return bt_bdaddr_t2str(bd_addr, buf);
-}
-
-static char *btuuid2str(const bt_uuid_t *uuid)
-{
-	static char buf[MAX_UUID_STR_LEN];
-
-	return bt_uuid_t2str(uuid, buf);
-}
-
 static bt_scan_mode_t str2btscanmode(const char *str)
 {
 	bt_scan_mode_t v = str2bt_scan_mode_t(str);
@@ -76,102 +62,6 @@ static bt_property_type_t str2btpropertytype(const char *str)
 	return (bt_property_type_t) atoi(str);
 }
 
-static char *btproperty2str(bt_property_t property)
-{
-	static char buf[4096];
-	char *p;
-
-	p = buf + sprintf(buf, "type=%s len=%d val=",
-					bt_property_type_t2str(property.type),
-					property.len);
-
-	switch (property.type) {
-	case BT_PROPERTY_BDNAME:
-	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
-		sprintf(p, "%*s", property.len,
-					((bt_bdname_t *) property.val)->name);
-		break;
-
-	case BT_PROPERTY_BDADDR:
-		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property.val));
-		break;
-
-	case BT_PROPERTY_CLASS_OF_DEVICE:
-		sprintf(p, "%06x", *((int *) property.val));
-		break;
-
-	case BT_PROPERTY_TYPE_OF_DEVICE:
-		sprintf(p, "%s", bt_device_type_t2str(
-					*((bt_device_type_t *) property.val)));
-		break;
-
-	case BT_PROPERTY_REMOTE_RSSI:
-		sprintf(p, "%d", *((char *) property.val));
-		break;
-
-	case BT_PROPERTY_ADAPTER_SCAN_MODE:
-		sprintf(p, "%s",
-			bt_scan_mode_t2str(*((bt_scan_mode_t *) property.val)));
-		break;
-
-	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-		sprintf(p, "%d", *((int *) property.val));
-		break;
-
-	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-		{
-			int count = property.len / sizeof(bt_bdaddr_t);
-			char *ptr = property.val;
-
-			strcat(p, "{");
-
-			while (count--) {
-				strcat(p, bdaddr2str((bt_bdaddr_t *) ptr));
-				if (count)
-					strcat(p, ", ");
-				ptr += sizeof(bt_bdaddr_t);
-			}
-
-			strcat(p, "}");
-
-		}
-		break;
-
-	case BT_PROPERTY_UUIDS:
-		{
-			int count = property.len / sizeof(bt_uuid_t);
-			char *ptr = property.val;
-
-			strcat(p, "{");
-
-			while (count--) {
-				strcat(p, btuuid2str((bt_uuid_t *) ptr));
-				if (count)
-					strcat(p, ", ");
-				ptr += sizeof(bt_uuid_t);
-			}
-
-			strcat(p, "}");
-
-		}
-		break;
-
-	case BT_PROPERTY_SERVICE_RECORD:
-		{
-			bt_service_record_t *rec = property.val;
-
-			sprintf(p, "{%s, %d, %s}", btuuid2str(&rec->uuid),
-						rec->channel, rec->name);
-		}
-		break;
-
-	default:
-		sprintf(p, "%p", property.val);
-	}
-
-	return buf;
-}
-
 static void dump_properties(int num_properties, bt_property_t *properties)
 {
 	int i;
diff --git a/android/client/textconv.c b/android/client/textconv.c
index 32b1cab..8f27948 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -226,3 +226,113 @@ const char *enum_one_string(void *v, int i)
 
 	return (i == 0) && (m[0] != 0) ? m : NULL;
 }
+
+char *bdaddr2str(const bt_bdaddr_t *bd_addr)
+{
+	static char buf[MAX_ADDR_STR_LEN];
+
+	return bt_bdaddr_t2str(bd_addr, buf);
+}
+
+static char *btuuid2str(const bt_uuid_t *uuid)
+{
+	static char buf[MAX_UUID_STR_LEN];
+
+	return bt_uuid_t2str(uuid, buf);
+}
+
+char *btproperty2str(bt_property_t property)
+{
+	static char buf[4096];
+	char *p;
+
+	p = buf + sprintf(buf, "type=%s len=%d val=",
+					bt_property_type_t2str(property.type),
+					property.len);
+
+	switch (property.type) {
+	case BT_PROPERTY_BDNAME:
+	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
+		sprintf(p, "%*s", property.len,
+					((bt_bdname_t *) property.val)->name);
+		break;
+
+	case BT_PROPERTY_BDADDR:
+		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property.val));
+		break;
+
+	case BT_PROPERTY_CLASS_OF_DEVICE:
+		sprintf(p, "%06x", *((int *) property.val));
+		break;
+
+	case BT_PROPERTY_TYPE_OF_DEVICE:
+		sprintf(p, "%s", bt_device_type_t2str(
+					*((bt_device_type_t *) property.val)));
+		break;
+
+	case BT_PROPERTY_REMOTE_RSSI:
+		sprintf(p, "%d", *((char *) property.val));
+		break;
+
+	case BT_PROPERTY_ADAPTER_SCAN_MODE:
+		sprintf(p, "%s",
+			bt_scan_mode_t2str(*((bt_scan_mode_t *) property.val)));
+		break;
+
+	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+		sprintf(p, "%d", *((int *) property.val));
+		break;
+
+	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+		{
+			int count = property.len / sizeof(bt_bdaddr_t);
+			char *ptr = property.val;
+
+			strcat(p, "{");
+
+			while (count--) {
+				strcat(p, bdaddr2str((bt_bdaddr_t *) ptr));
+				if (count)
+					strcat(p, ", ");
+				ptr += sizeof(bt_bdaddr_t);
+			}
+
+			strcat(p, "}");
+
+		}
+		break;
+
+	case BT_PROPERTY_UUIDS:
+		{
+			int count = property.len / sizeof(bt_uuid_t);
+			char *ptr = property.val;
+
+			strcat(p, "{");
+
+			while (count--) {
+				strcat(p, btuuid2str((bt_uuid_t *) ptr));
+				if (count)
+					strcat(p, ", ");
+				ptr += sizeof(bt_uuid_t);
+			}
+
+			strcat(p, "}");
+
+		}
+		break;
+
+	case BT_PROPERTY_SERVICE_RECORD:
+		{
+			bt_service_record_t *rec = property.val;
+
+			sprintf(p, "{%s, %d, %s}", btuuid2str(&rec->uuid),
+						rec->channel, rec->name);
+		}
+		break;
+
+	default:
+		sprintf(p, "%p", property.val);
+	}
+
+	return buf;
+}
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 085b141..89b29c6 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -107,6 +107,9 @@ void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
 char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
 void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 
+char *btproperty2str(bt_property_t property);
+char *bdaddr2str(const bt_bdaddr_t *bd_addr);
+
 DECINTMAP(bt_status_t);
 DECINTMAP(bt_state_t);
 DECINTMAP(bt_device_type_t);
-- 
1.7.10.4

