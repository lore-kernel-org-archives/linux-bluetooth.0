Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/hal-bluetooth: Rename create_enum_prop to enum_prop_to_hal
Date: Fri, 29 Nov 2013 09:05:57 +0100
Message-Id: <1385712358-8121-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This better describes purpose of this macro.
---
 android/hal-bluetooth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a879583..f232afd 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -28,7 +28,7 @@
 
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
-#define create_enum_prop(prop, hal_prop, type) do { \
+#define enum_prop_to_hal(prop, hal_prop, type) do { \
 	static type e; \
 	prop.val = &e; \
 	prop.len = sizeof(e); \
@@ -63,11 +63,11 @@ static void adapter_props_to_hal(bt_property_t *send_props,
 
 		switch (prop->type) {
 		case HAL_PROP_ADAPTER_TYPE:
-			create_enum_prop(send_props[i], prop,
+			enum_prop_to_hal(send_props[i], prop,
 							bt_device_type_t);
 			break;
 		case HAL_PROP_ADAPTER_SCAN_MODE:
-			create_enum_prop(send_props[i], prop,
+			enum_prop_to_hal(send_props[i], prop,
 							bt_scan_mode_t);
 			break;
 		case HAL_PROP_ADAPTER_SERVICE_REC:
@@ -109,7 +109,7 @@ static void device_props_to_hal(bt_property_t *send_props,
 
 		switch (prop->type) {
 		case HAL_PROP_DEVICE_TYPE:
-			create_enum_prop(send_props[i], prop,
+			enum_prop_to_hal(send_props[i], prop,
 							bt_device_type_t);
 			break;
 		case HAL_PROP_DEVICE_SERVICE_REC:
-- 
1.8.3.2

