Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 06/11] android/tester-ng: Add pin request and bond state callbacks
Date: Fri, 18 Jul 2014 13:51:15 +0200
Message-Id: <1405684280-1017-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To fully verify data passed by these callbacks we reuse existing
device properties verification mechanism. For this, callback argumenents
are repacked to properties array for further verification.
Those are verified against values passed to the callback step definition
macro just like with any other definition of callback step in which
we get device properties.

An alternative would be to extend 'bt_callback_data' struct and add new
fields for bdaddr, name, class of device and other properties, that we
get in callbacks as sepparate values and not as list of props.
---
 android/tester-main.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 17962e7..043c0b9 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -570,6 +570,33 @@ static bt_property_t *copy_properties(int num_properties,
 	return props;
 }
 
+static bt_property_t *repack_properties(int num_properties,
+						bt_property_t **properties)
+{
+	int i;
+	bt_property_t *props = g_new0(bt_property_t, num_properties);
+
+	for (i = 0; i < num_properties; i++) {
+		props[i].type = properties[i]->type;
+		props[i].len = properties[i]->len;
+		props[i].val = g_memdup(properties[i]->val, properties[i]->len);
+	}
+
+	return props;
+}
+
+static bt_property_t *create_property(bt_property_type_t type, void *val,
+								int len)
+{
+	bt_property_t *prop = g_new0(bt_property_t, 1);
+
+	prop->type = type;
+	prop->len = len;
+	prop->val = g_memdup(val, len);
+
+	return prop;
+}
+
 static void adapter_properties_cb(bt_status_t status, int num_properties,
 						bt_property_t *properties)
 {
@@ -622,6 +649,52 @@ static void remote_device_properties_cb(bt_status_t status,
 	schedule_callback_call(step);
 }
 
+static void bond_state_changed_cb(bt_status_t status,
+						bt_bdaddr_t *remote_bd_addr,
+						bt_bond_state_t state)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback_result.status = status;
+	step->callback_result.state = state;
+
+	/* Utilize property verification mechanism for bdaddr */
+	step->callback_result.num_properties = 1;
+	step->callback_result.properties = create_property(BT_PROPERTY_BDADDR,
+						remote_bd_addr,
+						sizeof(*remote_bd_addr));
+
+	step->callback = CB_BT_BOND_STATE_CHANGED;
+
+	schedule_callback_call(step);
+}
+
+static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
+					bt_bdname_t *bd_name, uint32_t cod)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[3];
+
+	step->callback = CB_BT_PIN_REQUEST;
+
+	/* Utilize property verification mechanism for those */
+	props[0] = create_property(BT_PROPERTY_BDADDR, remote_bd_addr,
+						sizeof(*remote_bd_addr));
+	props[1] = create_property(BT_PROPERTY_BDNAME, bd_name->name,
+						strlen((char *) bd_name->name));
+	props[2] = create_property(BT_PROPERTY_CLASS_OF_DEVICE, &cod,
+								sizeof(cod));
+
+	step->callback_result.num_properties = 3;
+	step->callback_result.properties = repack_properties(3, props);
+
+	g_free(props[0]);
+	g_free(props[1]);
+	g_free(props[2]);
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -629,9 +702,9 @@ static bt_callbacks_t bt_callbacks = {
 	.remote_device_properties_cb = remote_device_properties_cb,
 	.device_found_cb = device_found_cb,
 	.discovery_state_changed_cb = discovery_state_changed_cb,
-	.pin_request_cb = NULL,
+	.pin_request_cb = pin_request_cb,
 	.ssp_request_cb = NULL,
-	.bond_state_changed_cb = NULL,
+	.bond_state_changed_cb = bond_state_changed_cb,
 	.acl_state_changed_cb = NULL,
 	.thread_evt_cb = NULL,
 	.dut_mode_recv_cb = NULL,
-- 
1.9.1

