Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/hal-bluetooth: Register IPC message handlers
Date: Sat, 16 Nov 2013 15:13:25 +0100
Message-Id: <1384611208-18536-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
References: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register handlers on service init. Since this requires all handlers to
be registered (unknown opcode is considered IPC error) missing handlers
stubs are provided.
---
 android/hal-bluetooth.c | 223 ++++++++++++++++++++++++++++++------------------
 android/hal.h           |   1 -
 2 files changed, 142 insertions(+), 82 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 078d537..2ec7c10 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -35,7 +35,7 @@ static const bt_callbacks_t *bt_hal_cbacks = NULL;
 	*pe = *((uint8_t *) (hal_prop->val)); \
 } while (0)
 
-static void handle_adapter_state_changed(void *buf)
+static void handle_adapter_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_adapter_state_changed *ev = buf;
 
@@ -45,38 +45,35 @@ static void handle_adapter_state_changed(void *buf)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
 
-static void adapter_props_to_hal(bt_property_t *send_props,
-					struct hal_property *hal_prop,
-					uint8_t num_props, void *buff_end)
+static void adapter_props_to_hal(bt_property_t *send_props, void *buf,
+							uint8_t num_props)
 {
-	void *p = hal_prop;
+	struct hal_property *prop = buf;
 	uint8_t i;
 
 	for (i = 0; i < num_props; i++) {
-		if (p + sizeof(*hal_prop) + hal_prop->len > buff_end) {
-			error("invalid adapter properties event, aborting");
-			exit(EXIT_FAILURE);
-		}
-
-		send_props[i].type = hal_prop->type;
+		send_props[i].type = prop->type;
 
-		switch (hal_prop->type) {
+		switch (prop->type) {
 		case HAL_PROP_ADAPTER_TYPE:
-			create_enum_prop(send_props[i], hal_prop,
+			create_enum_prop(send_props[i], prop,
 							bt_device_type_t);
 			break;
 		case HAL_PROP_ADAPTER_SCAN_MODE:
-			create_enum_prop(send_props[i], hal_prop,
+			create_enum_prop(send_props[i], prop,
 							bt_scan_mode_t);
 			break;
 		case HAL_PROP_ADAPTER_SERVICE_REC:
 		default:
-			send_props[i].len = hal_prop->len;
-			send_props[i].val = hal_prop->val;
+			send_props[i].len = prop->len;
+			send_props[i].val = prop->val;
 			break;
 		}
 
 		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
+
+		buf += sizeof(*prop) + prop->len;
+		prop = buf;
 	}
 }
 
@@ -96,36 +93,30 @@ static void adapter_hal_props_cleanup(bt_property_t *props, uint8_t num)
 	}
 }
 
-static void device_props_to_hal(bt_property_t *send_props,
-					struct hal_property *hal_prop,
-					uint8_t num_props, void *buff_end)
+static void device_props_to_hal(bt_property_t *send_props, void *buf,
+							uint8_t num_props)
 {
-	void *p = hal_prop;
+	struct hal_property *prop = buf;
 	uint8_t i;
 
 	for (i = 0; i < num_props; i++) {
-		if (p + sizeof(*hal_prop) + hal_prop->len > buff_end) {
-			error("invalid adapter properties event, aborting");
-			exit(EXIT_FAILURE);
-		}
+		send_props[i].type = prop->type;
 
-		send_props[i].type = hal_prop->type;
-
-		switch (hal_prop->type) {
+		switch (prop->type) {
 		case HAL_PROP_DEVICE_TYPE:
-			create_enum_prop(send_props[i], hal_prop,
+			create_enum_prop(send_props[i], prop,
 							bt_device_type_t);
 			break;
 		case HAL_PROP_DEVICE_SERVICE_REC:
 		case HAL_PROP_DEVICE_VERSION_INFO:
 		default:
-			send_props[i].len = hal_prop->len;
-			send_props[i].val = hal_prop->val;
+			send_props[i].len = prop->len;
+			send_props[i].val = prop->val;
 			break;
 		}
 
-		p += sizeof(*hal_prop) + hal_prop->len;
-		hal_prop = p;
+		buf += sizeof(*prop) + prop->len;
+		prop = buf;
 
 		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
 	}
@@ -147,24 +138,48 @@ static void device_hal_props_cleanup(bt_property_t *props, uint8_t num)
 	}
 }
 
-static void handle_adapter_props_changed(void *buf, uint16_t len)
+static void check_props(int num, const struct hal_property *prop, uint16_t len)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (sizeof(*prop) + prop->len > len) {
+			error("invalid properties (%zu > %u), aborting",
+					sizeof(*prop) + prop->len, len);
+			exit(EXIT_FAILURE);
+		}
+
+		len -= sizeof(*prop) + prop->len;
+		prop = ((void *) prop) + sizeof(*prop) + prop->len;
+	}
+
+	if (!len)
+		return;
+
+	error("invalid properties length (%u bytes left), aborting", len);
+	exit(EXIT_FAILURE);
+}
+
+static void handle_adapter_props_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_adapter_props_changed *ev = buf;
 	bt_property_t props[ev->num_props];
 
 	DBG("");
 
+	check_props(ev->num_props, ev->props, len - sizeof(*ev));
+
 	if (!bt_hal_cbacks->adapter_properties_cb)
 		return;
 
-	adapter_props_to_hal(props, ev->props, ev->num_props, buf + len);
+	adapter_props_to_hal(props, ev->props, ev->num_props);
 
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
 
 	adapter_hal_props_cleanup(props, ev->num_props);
 }
 
-static void handle_bond_state_change(void *buf)
+static void handle_bond_state_change(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_bond_state_changed *ev = buf;
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
@@ -176,7 +191,7 @@ static void handle_bond_state_change(void *buf)
 								ev->state);
 }
 
-static void handle_pin_request(void *buf)
+static void handle_pin_request(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_pin_request *ev = buf;
 	/* Those are declared as packed, so it's safe to assign pointers */
@@ -189,7 +204,7 @@ static void handle_pin_request(void *buf)
 		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev);
 }
 
-static void handle_ssp_request(void *buf)
+static void handle_ssp_request(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_ssp_request *ev = buf;
 	/* Those are declared as packed, so it's safe to assign pointers */
@@ -221,7 +236,7 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
-static void handle_discovery_state_changed(void *buf)
+static void handle_discovery_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_discovery_state_changed *ev = buf;
 
@@ -231,34 +246,38 @@ static void handle_discovery_state_changed(void *buf)
 		bt_hal_cbacks->discovery_state_changed_cb(ev->state);
 }
 
-static void handle_device_found(void *buf, uint16_t len)
+static void handle_device_found(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_device_found *ev = buf;
 	bt_property_t props[ev->num_props];
 
 	DBG("");
 
+	check_props(ev->num_props, ev->props, len - sizeof(*ev));
+
 	if (!bt_hal_cbacks->device_found_cb)
 		return;
 
-	device_props_to_hal(props, ev->props, ev->num_props, buf + len);
+	device_props_to_hal(props, ev->props, ev->num_props);
 
 	bt_hal_cbacks->device_found_cb(ev->num_props, props);
 
 	device_hal_props_cleanup(props, ev->num_props);
 }
 
-static void handle_device_state_changed(void *buf, uint16_t len)
+static void handle_device_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_remote_device_props *ev = buf;
 	bt_property_t props[ev->num_props];
 
 	DBG("");
 
+	check_props(ev->num_props, ev->props, len - sizeof(*ev));
+
 	if (!bt_hal_cbacks->remote_device_properties_cb)
 		return;
 
-	device_props_to_hal(props, ev->props, ev->num_props, buf + len);
+	device_props_to_hal(props, ev->props, ev->num_props);
 
 	bt_hal_cbacks->remote_device_properties_cb(ev->status,
 						(bt_bdaddr_t *)ev->bdaddr,
@@ -267,7 +286,7 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 	device_hal_props_cleanup(props, ev->num_props);
 }
 
-static void handle_acl_state_changed(void *buf)
+static void handle_acl_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_acl_state_changed *ev = buf;
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
@@ -279,48 +298,82 @@ static void handle_acl_state_changed(void *buf)
 								ev->state);
 }
 
-/* will be called from notification thread context */
-void bt_notify_adapter(uint8_t opcode, void *buf, uint16_t len)
+static void handle_dut_mode_receive(void *buf, uint16_t len, int fd)
 {
-	if (!interface_ready())
-		return;
-
-	DBG("opcode 0x%x", opcode);
+	DBG("");
 
-	switch (opcode) {
-	case HAL_EV_ADAPTER_STATE_CHANGED:
-		handle_adapter_state_changed(buf);
-		break;
-	case HAL_EV_ADAPTER_PROPS_CHANGED:
-		handle_adapter_props_changed(buf, len);
-		break;
-	case HAL_EV_DISCOVERY_STATE_CHANGED:
-		handle_discovery_state_changed(buf);
-		break;
-	case HAL_EV_DEVICE_FOUND:
-		handle_device_found(buf, len);
-		break;
-	case HAL_EV_REMOTE_DEVICE_PROPS:
-		handle_device_state_changed(buf, len);
-		break;
-	case HAL_EV_BOND_STATE_CHANGED:
-		handle_bond_state_change(buf);
-		break;
-	case HAL_EV_PIN_REQUEST:
-		handle_pin_request(buf);
-		break;
-	case HAL_EV_SSP_REQUEST:
-		handle_ssp_request(buf);
-		break;
-	case HAL_EV_ACL_STATE_CHANGED:
-		handle_acl_state_changed(buf);
-		break;
-	default:
-		DBG("Unhandled callback opcode=0x%x", opcode);
-		break;
-	}
+	/* TODO */
 }
 
+static void handle_le_test_mode(void *buf, uint16_t len, int fd)
+{
+	DBG("");
+
+	/* TODO */
+}
+
+/* handlers will be called from notification thread context */
+static const struct hal_ipc_handler ev_handlers[] = {
+	{
+		.handler = handle_adapter_state_changed,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_adapter_state_changed)
+	},
+	{
+		.handler = handle_adapter_props_changed,
+		.var_len = true,
+		.data_len = sizeof(struct hal_ev_adapter_props_changed) +
+						sizeof(struct hal_property),
+	},
+	{
+		.handler = handle_device_state_changed,
+		.var_len = true,
+		.data_len = sizeof(struct hal_ev_remote_device_props) +
+						sizeof(struct hal_property),
+	},
+	{
+		.handler = handle_device_found,
+		.var_len = true,
+		.data_len = sizeof(struct hal_ev_device_found) +
+						sizeof(struct hal_property),
+	},
+	{
+		.handler = handle_discovery_state_changed,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_discovery_state_changed),
+	},
+	{
+		.handler = handle_pin_request,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_pin_request),
+	},
+	{
+		.handler = handle_ssp_request,
+		.var_len = false,
+		.data_len = sizeof(handle_ssp_request),
+	},
+	{
+		.handler = handle_bond_state_change,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_bond_state_changed),
+	},
+	{
+		.handler = handle_acl_state_changed,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_acl_state_changed),
+	},
+	{
+		.handler = handle_dut_mode_receive,
+		.var_len = true,
+		.data_len = sizeof(struct hal_ev_dut_mode_receive),
+	},
+	{
+		.handler = handle_le_test_mode,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_le_test_mode),
+	},
+};
+
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -333,6 +386,9 @@ static int init(bt_callbacks_t *callbacks)
 
 	bt_hal_cbacks = callbacks;
 
+	hal_ipc_register(HAL_SERVICE_ID_BLUETOOTH, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
 	if (!hal_ipc_init()) {
 		bt_hal_cbacks = NULL;
 		return BT_STATUS_FAIL;
@@ -361,6 +417,9 @@ static int init(bt_callbacks_t *callbacks)
 fail:
 	hal_ipc_cleanup();
 	bt_hal_cbacks = NULL;
+
+	hal_ipc_unregister(HAL_SERVICE_ID_BLUETOOTH);
+
 	return status;
 }
 
@@ -396,6 +455,8 @@ static void cleanup(void)
 	hal_ipc_cleanup();
 
 	bt_hal_cbacks = NULL;
+
+	hal_ipc_unregister(HAL_SERVICE_ID_BLUETOOTH);
 }
 
 static int get_adapter_properties(void)
diff --git a/android/hal.h b/android/hal.h
index 72090fe..67dad5d 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -26,7 +26,6 @@ bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_a2dp_interface(void);
 
-void bt_notify_adapter(uint8_t opcode, void *buf, uint16_t len);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_hidhost(uint8_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2

