Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal-bluetooth: Use static memory for enum convertion
Date: Mon, 25 Nov 2013 12:32:00 +0100
Message-Id: <1385379120-10142-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to use dynamic allocation for enum properties
convertion. Each property type can be present only once in properties
callback so using static allocation is safe. This also remove need
for cleanup properties after HAL callback is called making code
simpler.
---
 android/hal-bluetooth.c | 109 ++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 72 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 6b821dd..a879583 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -29,10 +29,10 @@
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 #define create_enum_prop(prop, hal_prop, type) do { \
-	type *pe = malloc(sizeof(type)); \
-	prop.val = pe; \
-	prop.len = sizeof(*pe); \
-	*pe = *((uint8_t *) (hal_prop->val)); \
+	static type e; \
+	prop.val = &e; \
+	prop.len = sizeof(e); \
+	e = *((uint8_t *) (hal_prop->val)); \
 } while (0)
 
 static void handle_adapter_state_changed(void *buf, uint16_t len)
@@ -45,13 +45,20 @@ static void handle_adapter_state_changed(void *buf, uint16_t len)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
 
-static void adapter_props_to_hal(bt_property_t *send_props, void *buf,
-							uint8_t num_props)
+static void adapter_props_to_hal(bt_property_t *send_props,
+					struct hal_property *prop,
+					uint8_t num_props, uint16_t len)
 {
-	struct hal_property *prop = buf;
+	void *buf = prop;
 	uint8_t i;
 
 	for (i = 0; i < num_props; i++) {
+		if (sizeof(*prop) + prop->len > len) {
+			error("invalid adapter properties(%zu > %u), aborting",
+					sizeof(*prop) + prop->len, len);
+			exit(EXIT_FAILURE);
+		}
+
 		send_props[i].type = prop->type;
 
 		switch (prop->type) {
@@ -72,34 +79,32 @@ static void adapter_props_to_hal(bt_property_t *send_props, void *buf,
 
 		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
 
+		len -= sizeof(*prop) + prop->len;
 		buf += sizeof(*prop) + prop->len;
 		prop = buf;
 	}
-}
 
-static void adapter_hal_props_cleanup(bt_property_t *props, uint8_t num)
-{
-	uint8_t i;
+	if (!len)
+		return;
 
-	for (i = 0; i < num; i++) {
-		switch (props[i].type) {
-		case HAL_PROP_ADAPTER_TYPE:
-		case HAL_PROP_ADAPTER_SCAN_MODE:
-			free(props[i].val);
-			break;
-		default:
-			break;
-		}
-	}
+	error("invalid adapter properties (%u bytes left), aborting", len);
+	exit(EXIT_FAILURE);
 }
 
-static void device_props_to_hal(bt_property_t *send_props, void *buf,
-							uint8_t num_props)
+static void device_props_to_hal(bt_property_t *send_props,
+				struct hal_property *prop, uint8_t num_props,
+				uint16_t len)
 {
-	struct hal_property *prop = buf;
+	void *buf = prop;
 	uint8_t i;
 
 	for (i = 0; i < num_props; i++) {
+		if (sizeof(*prop) + prop->len > len) {
+			error("invalid device properties (%zu > %u), aborting",
+					sizeof(*prop) + prop->len, len);
+			exit(EXIT_FAILURE);
+		}
+
 		send_props[i].type = prop->type;
 
 		switch (prop->type) {
@@ -115,48 +120,17 @@ static void device_props_to_hal(bt_property_t *send_props, void *buf,
 			break;
 		}
 
+		len -= sizeof(*prop) + prop->len;
 		buf += sizeof(*prop) + prop->len;
 		prop = buf;
 
 		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
 	}
-}
-
-
-static void device_hal_props_cleanup(bt_property_t *props, uint8_t num)
-{
-	uint8_t i;
-
-	for (i = 0; i < num; i++) {
-		switch (props[i].type) {
-		case HAL_PROP_DEVICE_TYPE:
-			free(props[i].val);
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-static void check_props(int num, const struct hal_property *prop, uint16_t len)
-{
-	int i;
-
-	for (i = 0; i < num; i++) {
-		if (sizeof(*prop) + prop->len > len) {
-			error("invalid properties (%zu > %u), aborting",
-					sizeof(*prop) + prop->len, len);
-			exit(EXIT_FAILURE);
-		}
-
-		len -= sizeof(*prop) + prop->len;
-		prop = ((void *) prop) + sizeof(*prop) + prop->len;
-	}
 
 	if (!len)
 		return;
 
-	error("invalid properties length (%u bytes left), aborting", len);
+	error("invalid device properties (%u bytes left), aborting", len);
 	exit(EXIT_FAILURE);
 }
 
@@ -167,16 +141,13 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 
 	DBG("");
 
-	check_props(ev->num_props, ev->props, len - sizeof(*ev));
-
 	if (!bt_hal_cbacks->adapter_properties_cb)
 		return;
 
-	adapter_props_to_hal(props, ev->props, ev->num_props);
+	len -= sizeof(*ev);
+	adapter_props_to_hal(props, ev->props, ev->num_props, len);
 
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
-
-	adapter_hal_props_cleanup(props, ev->num_props);
 }
 
 static void handle_bond_state_change(void *buf, uint16_t len)
@@ -253,16 +224,13 @@ static void handle_device_found(void *buf, uint16_t len)
 
 	DBG("");
 
-	check_props(ev->num_props, ev->props, len - sizeof(*ev));
-
 	if (!bt_hal_cbacks->device_found_cb)
 		return;
 
-	device_props_to_hal(props, ev->props, ev->num_props);
+	len -= sizeof(*ev);
+	device_props_to_hal(props, ev->props, ev->num_props, len);
 
 	bt_hal_cbacks->device_found_cb(ev->num_props, props);
-
-	device_hal_props_cleanup(props, ev->num_props);
 }
 
 static void handle_device_state_changed(void *buf, uint16_t len)
@@ -272,18 +240,15 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 
 	DBG("");
 
-	check_props(ev->num_props, ev->props, len - sizeof(*ev));
-
 	if (!bt_hal_cbacks->remote_device_properties_cb)
 		return;
 
-	device_props_to_hal(props, ev->props, ev->num_props);
+	len -= sizeof(*ev);
+	device_props_to_hal(props, ev->props, ev->num_props, len);
 
 	bt_hal_cbacks->remote_device_properties_cb(ev->status,
 						(bt_bdaddr_t *)ev->bdaddr,
 						ev->num_props, props);
-
-	device_hal_props_cleanup(props, ev->num_props);
 }
 
 static void handle_acl_state_changed(void *buf, uint16_t len)
-- 
1.8.3.2

