Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/hal-utils: Refactor btproperty2str
Date: Thu, 27 Nov 2014 18:04:38 +0100
Message-Id: <1417107880-13118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function grown to big. Factor out more complex properties to
separate helper functions.
---
 android/hal-utils.c | 168 ++++++++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 92 deletions(-)

diff --git a/android/hal-utils.c b/android/hal-utils.c
index f18a82c..3c640b7 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -258,8 +258,77 @@ const char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 	return bt_bdaddr_t2str(bd_addr, buf);
 }
 
+static void bonded_devices2string(char *str, void *prop, int prop_len)
+{
+	int count = prop_len / sizeof(bt_bdaddr_t);
+	bt_bdaddr_t *addr = prop;
+
+	strcat(str, "{");
+
+	while (count--) {
+		strcat(str, bdaddr2str(addr));
+		if (count)
+			strcat(str, ", ");
+		addr++;
+	}
+
+	strcat(str, "}");
+}
+
+static void uuids2string(char *str, void *prop, int prop_len)
+{
+	int count = prop_len / sizeof(bt_uuid_t);
+	bt_uuid_t *uuid = prop;
+
+	strcat(str, "{");
+
+	while (count--) {
+		strcat(str, btuuid2str(uuid->uu));
+		if (count)
+			strcat(str, ", ");
+		uuid++;
+	}
+
+	strcat(str, "}");
+}
+
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void local_le_feat2string(char *str, const bt_local_le_features_t *f)
+{
+	uint16_t scan_num;
+
+	str += sprintf(str, "{\n");
+
+	str += sprintf(str, "Privacy supported: %s,\n",
+				f->local_privacy_enabled ? "TRUE" : "FALSE");
+
+	str += sprintf(str, "Num of advertising instances: %u,\n",
+							f->max_adv_instance);
+
+	str += sprintf(str, "PRA offloading support: %s,\n",
+				f->rpa_offload_supported ? "TRUE" : "FALSE");
+
+	str += sprintf(str, "Num of offloaded IRKs: %u,\n",
+							f->max_irk_list_size);
+
+	str += sprintf(str, "Num of offloaded scan filters: %u,\n",
+						f->max_adv_filter_supported);
+
+	scan_num = (f->scan_result_storage_size_hibyte << 8) +
+					f->scan_result_storage_size_lobyte;
+
+	str += sprintf(str, "Num of offloaded scan results: %u,\n", scan_num);
+
+	str += sprintf(str, "Activity & energy report support: %s\n",
+			f->activity_energy_info_supported ? "TRUE" : "FALSE");
+
+	sprintf(str, "}");
+}
+#endif
+
 const char *btproperty2str(const bt_property_t *property)
 {
+	bt_service_record_t *rec;
 	static char buf[4096];
 	char *p;
 
@@ -273,130 +342,45 @@ const char *btproperty2str(const bt_property_t *property)
 		snprintf(p, property->len + 1, "%s",
 					((bt_bdname_t *) property->val)->name);
 		break;
-
 	case BT_PROPERTY_BDADDR:
 		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property->val));
 		break;
-
 	case BT_PROPERTY_CLASS_OF_DEVICE:
 		sprintf(p, "%06x", *((int *) property->val));
 		break;
-
 	case BT_PROPERTY_TYPE_OF_DEVICE:
 		sprintf(p, "%s", bt_device_type_t2str(
-				*((bt_device_type_t *) property->val)));
+					*((bt_device_type_t *) property->val)));
 		break;
-
 	case BT_PROPERTY_REMOTE_RSSI:
 		sprintf(p, "%d", *((char *) property->val));
 		break;
-
 	case BT_PROPERTY_ADAPTER_SCAN_MODE:
 		sprintf(p, "%s",
 			bt_scan_mode_t2str(*((bt_scan_mode_t *) property->val)));
 		break;
-
 	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
 		sprintf(p, "%d", *((int *) property->val));
 		break;
-
 	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-		{
-			int count = property->len / sizeof(bt_bdaddr_t);
-			char *ptr = property->val;
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
+		bonded_devices2string(p, property->val, property->len);
 		break;
-
 	case BT_PROPERTY_UUIDS:
-		{
-			int count = property->len / sizeof(bt_uuid_t);
-			uint8_t *ptr = property->val;
-
-			strcat(p, "{");
-
-			while (count--) {
-				strcat(p, btuuid2str(ptr));
-				if (count)
-					strcat(p, ", ");
-				ptr += sizeof(bt_uuid_t);
-			}
-
-			strcat(p, "}");
-
-		}
+		uuids2string(p, property->val, property->len);
 		break;
-
 	case BT_PROPERTY_SERVICE_RECORD:
-		{
-			bt_service_record_t *rec = property->val;
-
-			sprintf(p, "{%s, %d, %s}", btuuid2str(rec->uuid.uu),
+		rec = property->val;
+		sprintf(p, "{%s, %d, %s}", btuuid2str(rec->uuid.uu),
 						rec->channel, rec->name);
-		}
 		break;
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	case BT_PROPERTY_LOCAL_LE_FEATURES:
-		{
-			bt_local_le_features_t *f = property->val;
-			int l;
-			uint16_t s;
-
-			l = sprintf(p, "{\n");
-			p += l;
-
-			l = sprintf(p, "Privacy supported: %s,\n",
-						f->local_privacy_enabled ?
-						"TRUE" : "FALSE");
-			p += l;
-
-			l = sprintf(p, "Num of advertising instances: %u,\n",
-							f->max_adv_instance);
-			p += l;
-
-			l = sprintf(p, "PRA offloading support: %s,\n",
-						f->rpa_offload_supported ?
-						"TRUE" : "FALSE");
-
-			p += l;
-
-			l = sprintf(p, "Num of offloaded IRKs: %u,\n",
-							f->max_irk_list_size);
-			p += l;
-
-			l = sprintf(p, "Num of offloaded scan filters: %u,\n",
-						f->max_adv_filter_supported);
-			p += l;
-
-			s = (f->scan_result_storage_size_hibyte << 8) +
-					f->scan_result_storage_size_lobyte;
-
-			l = sprintf(p, "Num of offloaded scan results: %u,\n",
-									s);
-			p += l;
-
-			l = sprintf(p, "Activity & energy report support: %s\n",
-					f->activity_energy_info_supported ?
-					"TRUE" : "FALSE");
-			p += l;
-
-			sprintf(p, "}");
-		}
+		local_le_feat2string(p, property->val);
 		break;
 #endif
 	default:
 		sprintf(p, "%p", property->val);
+		break;
 	}
 
 	return buf;
-- 
1.9.1

