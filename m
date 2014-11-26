Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/client: Add support to read local le features
Date: Wed, 26 Nov 2014 17:04:25 +0100
Message-Id: <1417017865-23994-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-utils.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/android/hal-utils.c b/android/hal-utils.c
index 05e8920..f59b96f 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -22,6 +22,7 @@
 
 #include <cutils/properties.h>
 
+#include "hal.h"
 #include "hal-utils.h"
 
 /*
@@ -116,6 +117,7 @@ INTMAP(bt_ssp_variant_t, -1, "(unknown)")
 	DELEMENT(BT_SSP_VARIANT_PASSKEY_NOTIFICATION),
 ENDMAP
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 INTMAP(bt_property_type_t, -1, "(unknown)")
 	DELEMENT(BT_PROPERTY_BDNAME),
 	DELEMENT(BT_PROPERTY_BDADDR),
@@ -129,8 +131,26 @@ INTMAP(bt_property_type_t, -1, "(unknown)")
 	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
 	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
 	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
+	DELEMENT(BT_PROPERTY_LOCAL_LE_FEATURES),
 	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
 ENDMAP
+#else
+INTMAP(bt_property_type_t, -1, "(unknown)")
+	DELEMENT(BT_PROPERTY_BDNAME),
+	DELEMENT(BT_PROPERTY_BDADDR),
+	DELEMENT(BT_PROPERTY_UUIDS),
+	DELEMENT(BT_PROPERTY_CLASS_OF_DEVICE),
+	DELEMENT(BT_PROPERTY_TYPE_OF_DEVICE),
+	DELEMENT(BT_PROPERTY_SERVICE_RECORD),
+	DELEMENT(BT_PROPERTY_ADAPTER_SCAN_MODE),
+	DELEMENT(BT_PROPERTY_ADAPTER_BONDED_DEVICES),
+	DELEMENT(BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT),
+	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
+	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
+	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
+	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
+ENDMAP
+#endif
 
 INTMAP(bt_cb_thread_evt, -1, "(unknown)")
 	DELEMENT(ASSOCIATE_JVM),
@@ -326,7 +346,46 @@ const char *btproperty2str(const bt_property_t *property)
 						rec->channel, rec->name);
 		}
 		break;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	case BT_PROPERTY_LOCAL_LE_FEATURES:
+		{
+			uint8_t *val = property->val;
+			int l;
+
+			l = sprintf(p, "{\n");
+			p += l;
+
+			l = sprintf(p, "Privacy supported: %s,\n",
+						val[0] ? "TRUE" : "FALSE");
+			p += l;
+
+			l = sprintf(p, "Num of advertising instances: %u,\n",
+									val[1]);
+			p += l;
+
+			l = sprintf(p, "PRA offloading support: %s,\n",
+						val[2] ? "TRUE" : "FALSE");
+			p += l;
 
+			l = sprintf(p, "Num of offloaded IRKs: %u,\n", val[3]);
+			p += l;
+
+			l = sprintf(p, "Num of offloaded scan filters: %u,\n",
+									val[4]);
+			p += l;
+
+			l = sprintf(p, "Num of offloaded scan results: %u,\n",
+					(val[6] << 8) + val[5]);
+			p += l;
+
+			l = sprintf(p, "Activity & energy report support: %s\n",
+						val[7] ? "TRUE" : "FALSE");
+			p += l;
+
+			sprintf(p, "}");
+		}
+		break;
+#endif
 	default:
 		sprintf(p, "%p", property->val);
 	}
-- 
1.8.4

