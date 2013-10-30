Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] android/hal: Add support for repacking received IPC data to HAL data
Date: Wed, 30 Oct 2013 16:30:54 +0100
Message-ID: <1383147054-16528-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some HAL defined types that are passed as type-len-value in properties
callback needs to be repacked at runtime to match defined types.

This is due to HAL using data types without strict refined sizes like
enums or unpacked structures. This is needed only if data is passed as
TLV. With data passed to callbacks as parameters compiler will handle
types convertion.

Currently only enum types are supported.
---

This is only for received events. Same needs to be done when sending props
from HAL lib to daemon.

 android/hal-bluetooth.c | 104 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 2237063..a6228d7 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -29,6 +29,13 @@
 
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
+#define create_enum_prop(prop, hal_prop, type) do { \
+	type *pe = malloc(sizeof(type)); \
+	prop.val = pe; \
+	prop.len = sizeof(*pe); \
+	*pe = *((uint8_t *) (hal_prop->val)); \
+} while (0)
+
 static void handle_adapter_state_changed(void *buf)
 {
 	struct hal_ev_adapter_state_changed *ev = buf;
@@ -37,10 +44,58 @@ static void handle_adapter_state_changed(void *buf)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
 
-static void repack_properties(bt_property_t *send_props,
+static void adapter_props_to_hal(bt_property_t *send_props,
+					struct hal_property *hal_prop,
+					uint8_t num_props, void *buff_end)
+{
+	void *p = hal_prop;
+	uint8_t i;
+
+	for (i = 0; i < num_props; i++) {
+		if (p + sizeof(*hal_prop) + hal_prop->len > buff_end) {
+			error("invalid adapter properties event, aborting");
+			exit(EXIT_FAILURE);
+		}
+
+		send_props[i].type = hal_prop->type;
+
+		switch (hal_prop->type) {
+		case HAL_PROP_ADAPTER_TYPE:
+			create_enum_prop(send_props[i], hal_prop,
+							bt_device_type_t);
+			break;
+		case HAL_PROP_ADAPTER_SCAN_MODE:
+			create_enum_prop(send_props[i], hal_prop,
+							bt_scan_mode_t);
+			break;
+		case HAL_PROP_ADAPTER_SERVICE_REC:
+		default:
+			send_props[i].len = hal_prop->len;
+			send_props[i].val = hal_prop->val;
+			break;
+		}
+	}
+}
+
+static void adapter_hal_props_cleanup(bt_property_t *props, uint8_t num)
+{
+	uint8_t i;
+
+	for (i = 0; i < num; i++) {
+		switch (props[i].type) {
+		case HAL_PROP_ADAPTER_TYPE:
+		case HAL_PROP_ADAPTER_SCAN_MODE:
+			free(props[i].val);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void device_props_to_hal(bt_property_t *send_props,
 					struct hal_property *hal_prop,
-					uint8_t num_props,
-					void *buff_end)
+					uint8_t num_props, void *buff_end)
 {
 	void *p = hal_prop;
 	uint8_t i;
@@ -52,14 +107,41 @@ static void repack_properties(bt_property_t *send_props,
 		}
 
 		send_props[i].type = hal_prop->type;
-		send_props[i].len = hal_prop->len;
-		send_props[i].val = hal_prop->val;
+
+		switch (hal_prop->type) {
+		case HAL_PROP_DEVICE_TYPE:
+			create_enum_prop(send_props[i], hal_prop,
+							bt_device_type_t);
+			break;
+		case HAL_PROP_DEVICE_SERVICE_REC:
+		case HAL_PROP_DEVICE_VERSION_INFO:
+		default:
+			send_props[i].len = hal_prop->len;
+			send_props[i].val = hal_prop->val;
+			break;
+		}
 
 		p += sizeof(*hal_prop) + hal_prop->len;
 		hal_prop = p;
 	}
 }
 
+
+static void device_hal_props_cleanup(bt_property_t *props, uint8_t num)
+{
+	uint8_t i;
+
+	for (i = 0; i < num; i++) {
+		switch (props[i].type) {
+		case HAL_PROP_DEVICE_TYPE:
+			free(props[i].val);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void handle_adapter_props_changed(void *buf, uint16_t len)
 {
 	struct hal_ev_adapter_props_changed *ev = buf;
@@ -68,9 +150,11 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 	if (!bt_hal_cbacks->adapter_properties_cb)
 		return;
 
-	repack_properties(props, ev->props, ev->num_props, buf + len);
+	adapter_props_to_hal(props, ev->props, ev->num_props, buf + len);
 
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
+
+	adapter_hal_props_cleanup(props, ev->num_props);
 }
 
 static void handle_bond_state_change(void *buf)
@@ -140,9 +224,11 @@ static void handle_device_found(void *buf, uint16_t len)
 	if (!bt_hal_cbacks->device_found_cb)
 		return;
 
-	repack_properties(props, ev->props, ev->num_props, buf + len);
+	device_props_to_hal(props, ev->props, ev->num_props, buf + len);
 
 	bt_hal_cbacks->device_found_cb(ev->num_props, props);
+
+	device_hal_props_cleanup(props, ev->num_props);
 }
 
 static void handle_device_state_changed(void *buf, uint16_t len)
@@ -153,11 +239,13 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 	if (!bt_hal_cbacks->remote_device_properties_cb)
 		return;
 
-	repack_properties(props, ev->props, ev->num_props, buf + len);
+	device_props_to_hal(props, ev->props, ev->num_props, buf + len);
 
 	bt_hal_cbacks->remote_device_properties_cb(ev->status,
 						(bt_bdaddr_t *)ev->bdaddr,
 						ev->num_props, props);
+
+	device_hal_props_cleanup(props, ev->num_props);
 }
 
 /* will be called from notification thread context */
-- 
1.8.4.1

