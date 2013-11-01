Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 4/7] android/hal: Add extra logs to HAL
Date: Fri,  1 Nov 2013 17:19:16 +0200
Message-Id: <1383319159-13060-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use exported functions from hal test tool to print properties.
---
 android/hal-bluetooth.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5fb8846..7334d24 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -40,6 +40,8 @@ static void handle_adapter_state_changed(void *buf)
 {
 	struct hal_ev_adapter_state_changed *ev = buf;
 
+	DBG("state: %s", bt_state_t2str(ev->state));
+
 	if (bt_hal_cbacks->adapter_state_changed_cb)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
@@ -74,6 +76,8 @@ static void adapter_props_to_hal(bt_property_t *send_props,
 			send_props[i].val = hal_prop->val;
 			break;
 		}
+
+		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
 	}
 }
 
@@ -123,6 +127,8 @@ static void device_props_to_hal(bt_property_t *send_props,
 
 		p += sizeof(*hal_prop) + hal_prop->len;
 		hal_prop = p;
+
+		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
 	}
 }
 
@@ -280,6 +286,8 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	if (!interface_ready())
 		return;
 
+	DBG("opcode 0x%x", opcode);
+
 	switch (opcode) {
 	case HAL_EV_ADAPTER_STATE_CHANGED:
 		handle_adapter_state_changed(buf);
@@ -406,7 +414,7 @@ static int get_adapter_property(bt_property_type_t type)
 {
 	struct hal_cmd_get_adapter_prop cmd;
 
-	DBG("prop: %s", bt_property_type_t2str(type));
+	DBG("prop: %s (%d)", bt_property_type_t2str(type), type);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -438,7 +446,7 @@ static int set_adapter_property(const bt_property_t *property)
 	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
 	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
 
-	DBG("prop: %s", bt_property_type_t2str(property->type));
+	DBG("prop: %s", btproperty2str(property));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -463,7 +471,7 @@ static int set_adapter_property(const bt_property_t *property)
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -474,7 +482,8 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 						bt_property_type_t type)
 {
-	DBG("");
+	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
+						bt_property_type_t2str(type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -485,7 +494,8 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
-	DBG("");
+	DBG("bdaddr: %s prop: %s", bdaddr2str(remote_addr),
+						btproperty2str(property));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -495,7 +505,7 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -505,7 +515,7 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(remote_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -541,7 +551,7 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_create_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -556,7 +566,7 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_cancel_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -571,7 +581,7 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_remove_bond cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -587,7 +597,7 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 {
 	struct hal_cmd_pin_reply cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -606,7 +616,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 {
 	struct hal_cmd_ssp_reply cmd;
 
-	DBG("");
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
-- 
1.7.10.4

