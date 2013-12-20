Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/hal-bluetooth: Add support for device service record property
Date: Fri, 20 Dec 2013 11:25:39 +0100
Message-Id: <1387535140-6223-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to correctly handle device service record property.
---
 android/hal-bluetooth.c | 15 +++++++++++++++
 android/hal-msg.h       |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index d0c1c01..4ef2ebe 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -166,6 +166,21 @@ static void device_props_to_hal(bt_property_t *send_props,
 			break;
 #endif
 		case HAL_PROP_DEVICE_SERVICE_REC:
+		{
+			static bt_service_record_t e;
+			const struct hal_prop_device_service_rec *p;
+
+			send_props[i].val = &e;
+			send_props[i].len = sizeof(e);
+
+			p = (struct hal_prop_device_service_rec *) prop->val;
+
+			memset(&e, 0, sizeof(e));
+			memcpy(&e.channel, &p->channel, sizeof(e.channel));
+			memcpy(e.uuid.uu, p->uuid, sizeof(e.uuid.uu));
+			memcpy(e.name, p->name, p->name_len);
+		}
+			break;
 		default:
 			send_props[i].len = prop->len;
 			send_props[i].val = prop->val;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bb196d8..c351501 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -107,6 +107,13 @@ struct hal_cmd_get_adapter_prop {
 #define HAL_PROP_DEVICE_CLASS			0x04
 #define HAL_PROP_DEVICE_TYPE			0x05
 #define HAL_PROP_DEVICE_SERVICE_REC		0x06
+struct hal_prop_device_service_rec {
+	uint8_t uuid[16];
+	uint16_t channel;
+	uint8_t name_len;
+	uint8_t name[];
+} __attribute__((packed));
+
 #define HAL_PROP_DEVICE_FRIENDLY_NAME		0x0a
 #define HAL_PROP_DEVICE_RSSI			0x0b
 #define HAL_PROP_DEVICE_VERSION_INFO		0x0c
-- 
1.8.3.2

