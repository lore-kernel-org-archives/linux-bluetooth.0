Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/hal-bluetooth: Add support for remote version info property
Date: Fri, 20 Dec 2013 11:25:38 +0100
Message-Id: <1387535140-6223-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to correctly handle remote version info property. Although
this property is marked as get/set in HAL only get is implemented as
I fail to see how this property could be settable.
---
 android/hal-bluetooth.c | 21 ++++++++++++++++++++-
 android/hal-msg.h       |  6 ++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 905b293..d0c1c01 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -145,8 +145,27 @@ static void device_props_to_hal(bt_property_t *send_props,
 			enum_prop_to_hal(send_props[i], prop,
 							bt_device_type_t);
 			break;
-		case HAL_PROP_DEVICE_SERVICE_REC:
+#if PLATFORM_SDK_VERSION > 17
 		case HAL_PROP_DEVICE_VERSION_INFO:
+		{
+			static bt_remote_version_t e;
+			const struct hal_prop_device_info *p;
+			uint16_t tmp;
+
+			send_props[i].val = &e;
+			send_props[i].len = sizeof(e);
+
+			p = (struct hal_prop_device_info *) prop->val;
+
+			memcpy(&tmp, &p->manufacturer, sizeof(tmp));
+			e.manufacturer = tmp;
+			memcpy(&tmp, &p->sub_version, sizeof(tmp));
+			e.sub_ver = tmp;
+			e.version = p->version;
+		}
+			break;
+#endif
+		case HAL_PROP_DEVICE_SERVICE_REC:
 		default:
 			send_props[i].len = prop->len;
 			send_props[i].val = prop->val;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 3be91aa..bb196d8 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -110,6 +110,12 @@ struct hal_cmd_get_adapter_prop {
 #define HAL_PROP_DEVICE_FRIENDLY_NAME		0x0a
 #define HAL_PROP_DEVICE_RSSI			0x0b
 #define HAL_PROP_DEVICE_VERSION_INFO		0x0c
+struct hal_prop_device_info {
+	uint8_t version;
+	uint16_t sub_version;
+	uint16_t manufacturer;
+} __attribute__((packed));
+
 #define HAL_PROP_DEVICE_TIMESTAMP		0xFF
 
 #define HAL_ADAPTER_SCAN_MODE_NONE		0x00
-- 
1.8.3.2

