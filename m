Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/7] android/tester: add initial support for map-client tester
Date: Wed, 17 Dec 2014 15:01:37 +0100
Message-Id: <1418824897-25342-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds callback, callback verification, step verification, mas
instance verification, map client profile setup handling and basic
files.
---
 android/Makefile.am         |   1 +
 android/tester-main.c       | 187 ++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h       |  28 +++++++
 android/tester-map-client.c | 159 +++++++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 android/tester-map-client.c

diff --git a/android/Makefile.am b/android/Makefile.am
index ac9c360..dbc3780 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -154,6 +154,7 @@ android_android_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
 				android/tester-a2dp.c \
 				android/tester-avrcp.c \
 				android/tester-gatt.c \
+				android/tester-map-client.c \
 				android/tester-main.h android/tester-main.c
 android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
diff --git a/android/tester-main.c b/android/tester-main.c
index ceb5ea8..08a63b1 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -122,6 +122,9 @@ static struct {
 	DBG_CB(CB_GATTS_REQUEST_EXEC_WRITE),
 	DBG_CB(CB_GATTS_RESPONSE_CONFIRMATION),
 
+	/* Map client */
+	DBG_CB(CB_MAP_CLIENT_REMOTE_MAS_INSTANCES),
+
 	/* Emulator callbacks */
 	DBG_CB(CB_EMU_CONFIRM_SEND_DATA),
 	DBG_CB(CB_EMU_ENCRYPTION_ENABLED),
@@ -495,6 +498,37 @@ static bool match_property(bt_property_t *exp_prop, bt_property_t *rec_prop,
 	return 1;
 }
 
+static bool match_mas_inst(btmce_mas_instance_t *exp_inst,
+				btmce_mas_instance_t *rec_inst, int inst_num)
+{
+	if (exp_inst->id && (exp_inst->id != rec_inst->id)) {
+		tester_debug("MAS inst. [%d] id missmatch %d vs %d", inst_num,
+						rec_inst->id, exp_inst->id);
+		return 0;
+	}
+
+	if (exp_inst->scn && (exp_inst->scn != exp_inst->scn)) {
+		tester_debug("MAS inst. [%d] scn missmatch %d vs %d", inst_num,
+						rec_inst->scn, exp_inst->scn);
+		return 0;
+	}
+
+	if (exp_inst->msg_types && (exp_inst->msg_types !=
+							exp_inst->msg_types)) {
+		tester_debug("Mas inst. [%d] mesg type missmatch %d vs %d",
+					inst_num, rec_inst->scn, exp_inst->scn);
+		return 0;
+	}
+
+	if (exp_inst->p_name && memcmp(exp_inst->p_name, rec_inst->p_name,
+						strlen(exp_inst->p_name))) {
+		tester_debug("Mas inst. [%d] name don't match!", inst_num);
+		return 0;
+	}
+
+	return 1;
+}
+
 static int verify_property(bt_property_t *exp_props, int exp_num_props,
 				bt_property_t *rec_props, int rec_num_props)
 {
@@ -523,6 +557,34 @@ static int verify_property(bt_property_t *exp_props, int exp_num_props,
 	return exp_prop_to_find;
 }
 
+static int verify_mas_inst(btmce_mas_instance_t *exp_inst, int exp_num_inst,
+						btmce_mas_instance_t *rec_inst,
+						int rec_num_inst)
+{
+	int i, j;
+	int exp_inst_to_find = exp_num_inst;
+
+	if (rec_num_inst == 0)
+		return 1;
+
+	if (exp_num_inst == 0) {
+		tester_debug("Wrong number of expected MAS instances given");
+		tester_test_failed();
+		return 1;
+	}
+
+	for (i = 0; i < exp_num_inst; i++) {
+		for (j = 0; j < rec_num_inst; j++) {
+			if (match_mas_inst(&exp_inst[i], &rec_inst[i], i)) {
+				exp_inst_to_find--;
+				break;
+			}
+		}
+	}
+
+	return exp_inst_to_find;
+}
+
 /*
  * Check each test case step if test case expected
  * data is set and match it with expected result.
@@ -957,6 +1019,23 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.num_mas_instances !=
+				step->callback_result.num_mas_instances) {
+		tester_debug("Mas instance count mismatch: %d vs %d",
+				exp->callback_result.num_mas_instances,
+				step->callback_result.num_mas_instances);
+		return false;
+	}
+
+	if (exp->callback_result.mas_instances &&
+		verify_mas_inst(exp->callback_result.mas_instances,
+				exp->callback_result.num_mas_instances,
+				step->callback_result.mas_instances,
+				step->callback_result.num_mas_instances)) {
+		tester_debug("Mas instances don't match");
+		return false;
+	}
+
 	if (exp->store_srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
@@ -1042,6 +1121,19 @@ static void free_properties(struct step *step)
 	g_free(properties);
 }
 
+static void free_mas_instances(struct step *step)
+{
+	btmce_mas_instance_t *mas_instances =
+					step->callback_result.mas_instances;
+	int num_instances = step->callback_result.num_mas_instances;
+	int i;
+
+	for (i = 0; i < num_instances; i++)
+		g_free(mas_instances[i].p_name);
+
+	g_free(mas_instances);
+}
+
 static void destroy_callback_step(void *data)
 {
 	struct step *step = data;
@@ -1091,6 +1183,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.value)
 		free(step->callback_result.value);
 
+	if (step->callback_result.mas_instances)
+		free_mas_instances(step);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -2044,6 +2139,48 @@ static btrc_callbacks_t btavrcp_callbacks = {
 	.get_element_attr_cb = avrcp_get_element_attr_cb,
 };
 
+static btmce_mas_instance_t *copy_mas_instances(int num_instances,
+						btmce_mas_instance_t *instances)
+{
+	int i;
+	btmce_mas_instance_t *inst;
+
+	inst = g_new0(btmce_mas_instance_t, num_instances);
+
+	for (i = 0; i < num_instances; i++) {
+		inst[i].id = instances[i].id;
+		inst[i].scn = instances[i].scn;
+		inst[i].msg_types = instances[i].msg_types;
+		inst[i].p_name = g_memdup(instances[i].p_name,
+						strlen(instances[i].p_name));
+	}
+
+	return inst;
+}
+
+static void map_client_get_remote_mas_instances_cb(bt_status_t status,
+							bt_bdaddr_t *bd_addr,
+							int num_instances,
+							btmce_mas_instance_t
+							*instances)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback_result.status = status;
+	step->callback_result.num_mas_instances = num_instances;
+	step->callback_result.mas_instances = copy_mas_instances(num_instances,
+								instances);
+
+	step->callback = CB_MAP_CLIENT_REMOTE_MAS_INSTANCES;
+
+	schedule_callback_verification(step);
+}
+
+static btmce_callbacks_t btmap_client_callbacks = {
+	.size = sizeof(btmap_client_callbacks),
+	.remote_mas_instances_cb = map_client_get_remote_mas_instances_cb,
+};
+
 static bool setup_base(struct test_data *data)
 {
 	const hw_module_t *module;
@@ -2408,6 +2545,44 @@ static void setup_gatt(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_map_client(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *map_client;
+
+	if (!setup_base(data)) {
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	map_client = data->if_bluetooth->get_profile_interface(
+						BT_PROFILE_MAP_CLIENT_ID);
+	if (!map_client) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_map_client = map_client;
+
+	status = data->if_map_client->init(&btmap_client_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_map_client = NULL;
+
+		tester_setup_failed();
+		return;
+	}
+
+	tester_setup_complete();
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2418,6 +2593,10 @@ static void teardown(const void *test_data)
 	queue_destroy(data->pdus, NULL);
 	data->pdus = NULL;
 
+	if (data->if_map_client) {
+		data->if_map_client = NULL;
+	}
+
 	if (data->if_gatt) {
 		data->if_gatt->cleanup();
 		data->if_gatt = NULL;
@@ -3115,6 +3294,13 @@ static void add_gatt_tests(void *data, void *user_data)
 	test(tc, setup_gatt, generic_test_function, teardown);
 }
 
+static void add_map_client_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test(tc, setup_map_client, generic_test_function, teardown);
+}
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -3129,6 +3315,7 @@ int main(int argc, char *argv[])
 	queue_foreach(get_a2dp_tests(), add_a2dp_tests, NULL);
 	queue_foreach(get_avrcp_tests(), add_avrcp_tests, NULL);
 	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
+	queue_foreach(get_map_client_tests(), add_map_client_tests, NULL);
 
 	if (tester_run())
 		return 1;
diff --git a/android/tester-main.h b/android/tester-main.h
index 3674366..dc1a2bb 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -33,6 +33,7 @@
 #include <hardware/bt_gatt.h>
 
 #include "emulator/hciemu.h"
+#include <hardware/bt_mce.h>
 
 struct pdu_set {
 	struct iovec req;
@@ -335,6 +336,16 @@ struct pdu_set {
 		.callback_result.value = cb_value, \
 	}
 
+#define CALLBACK_MAP_CLIENT_REMOTE_MAS_INSTANCE(cb_status, cb_prop, \
+						cb_num_inst, cb_instances) { \
+		.callback = CB_MAP_CLIENT_REMOTE_MAS_INSTANCES, \
+		.callback_result.properties = cb_prop, \
+		.callback_result.num_properties = 1, \
+		.callback_result.status = cb_status, \
+		.callback_result.num_mas_instances = cb_num_inst, \
+		.callback_result.mas_instances = cb_instances, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -517,6 +528,9 @@ typedef enum {
 	CB_GATTS_REQUEST_EXEC_WRITE,
 	CB_GATTS_RESPONSE_CONFIRMATION,
 
+	/* Map client */
+	CB_MAP_CLIENT_REMOTE_MAS_INSTANCES,
+
 	/* Emulator callbacks */
 	CB_EMU_CONFIRM_SEND_DATA,
 	CB_EMU_ENCRYPTION_ENABLED,
@@ -544,6 +558,7 @@ struct test_data {
 	struct audio_stream_out *if_stream;
 	const btrc_interface_t *if_avrcp;
 	const btgatt_interface_t *if_gatt;
+	const btmce_interface_t *if_map_client;
 
 	const void *test_data;
 	struct queue *steps;
@@ -603,6 +618,14 @@ struct emu_l2cap_cid_data {
 	bool is_sdp;
 };
 
+struct map_inst_data {
+	int32_t id;
+	int32_t scn;
+	int32_t msg_types;
+	int32_t name_len;
+	uint8_t *name;
+};
+
 /*
  * Callback data structure should be enhanced with data
  * returned by callbacks. It's used for test case step
@@ -666,6 +689,9 @@ struct bt_callback_data {
 	uint64_t rc_index;
 	uint8_t num_of_attrs;
 	btrc_element_attr_val_t *attrs;
+
+	int num_mas_instances;
+	btmce_mas_instance_t *mas_instances;
 };
 
 /*
@@ -715,6 +741,8 @@ struct queue *get_avrcp_tests(void);
 void remove_avrcp_tests(void);
 struct queue *get_gatt_tests(void);
 void remove_gatt_tests(void);
+struct queue *get_map_client_tests(void);
+void remove_map_client_tests(void);
 
 /* Generic tester API */
 void schedule_action_verification(struct step *step);
diff --git a/android/tester-map-client.c b/android/tester-map-client.c
new file mode 100644
index 0000000..0f7a286
--- /dev/null
+++ b/android/tester-map-client.c
@@ -0,0 +1,159 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdbool.h>
+
+#include "emulator/bthost.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "tester-main.h"
+
+static struct queue *list; /* List of map client test cases */
+
+#define INST0_ID 0
+#define INST1_ID 1
+
+#define sdp_rsp_pdu	0x07, \
+			0x00, 0x00, \
+			0x00, 0xb5, \
+			0x00, 0xb2, \
+			0x35, 0xb0, 0x36, 0x00, 0x56, 0x09, 0x00, 0x00, 0x0a, \
+			0x00, 0x01, 0x00, 0x09, 0x09, 0x00, 0x01, 0x35, 0x03, \
+			0x19, 0x11, 0x32, 0x09, 0x00, 0x04, 0x35, 0x11, 0x35, \
+			0x03, 0x19, 0x01, 0x00, 0x35, 0x05, 0x19, 0x00, 0x03, \
+			0x08, 0x04, 0x35, 0x03, 0x19, 0x00, 0x08, 0x09, 0x00, \
+			0x05, 0x35, 0x03, 0x19, 0x10, 0x02, 0x09, 0x00, 0x09, \
+			0x35, 0x08, 0x35, 0x06, 0x19, 0x11, 0x34, 0x09, 0x01, \
+			0x01, 0x09, 0x01, 0x00, 0x25, 0x0c, 0x4d, 0x41, 0x50, \
+			0x20, 0x53, 0x4d, 0x53, 0x2f, 0x4d, 0x4d, 0x53, 0x00, \
+			0x09, 0x03, 0x15, 0x08, 0x00, 0x09, 0x03, 0x16, 0x08, \
+			0x0e, 0x36, 0x00, 0x54, 0x09, 0x00, 0x00, 0x0a, 0x00, \
+			0x01, 0x00, 0x0a, 0x09, 0x00, 0x01, 0x35, 0x03, 0x19, \
+			0x11, 0x32, 0x09, 0x00, 0x04, 0x35, 0x11, 0x35, 0x03, \
+			0x19, 0x01, 0x00, 0x35, 0x05, 0x19, 0x00, 0x03, 0x08, \
+			0x05, 0x35, 0x03, 0x19, 0x00, 0x08, 0x09, 0x00, 0x05, \
+			0x35, 0x03, 0x19, 0x10, 0x02, 0x09, 0x00, 0x09, 0x35, \
+			0x08, 0x35, 0x06, 0x19, 0x11, 0x34, 0x09, 0x01, 0x01, \
+			0x09, 0x01, 0x00, 0x25, 0x0a, 0x4d, 0x41, 0x50, 0x20, \
+			0x45, 0x4d, 0x41, 0x49, 0x4c, 0x00, 0x09, 0x03, 0x15, \
+			0x08, 0x01, 0x09, 0x03, 0x16, 0x08, 0x01, \
+			0x00
+
+static const struct pdu_set pdus[] = {
+	{ end_pdu, raw_pdu(sdp_rsp_pdu) },
+	{ end_pdu, end_pdu },
+};
+
+static struct emu_l2cap_cid_data cid_data = {
+	.pdu = pdus,
+};
+
+static bt_bdaddr_t emu_remote_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
+};
+
+static struct emu_set_l2cap_data l2cap_sdp_setup_data = {
+	.psm = 1,
+	.func = tester_generic_connect_cb,
+	.user_data = &cid_data,
+};
+
+/* TODO define all parameters according to specification document */
+static btmce_mas_instance_t remote_map_inst_sms_mms_email_val[] = {
+	{ INST0_ID, 4, 14, "MAP SMS/MMS" },
+	{ INST1_ID, 5, 1, "MAP EMAIL" },
+};
+
+static void map_client_cid_hook_cb(const void *data, uint16_t len,
+								void *user_data)
+{
+	/* TODO extend if needed */
+}
+
+static void map_client_conn_cb(uint16_t handle, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	tester_print("New connection with handle 0x%04x", handle);
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDR) {
+		tester_warn("Not handled device type.");
+		return;
+	}
+
+	cid_data.cid = 0x0040;
+	cid_data.handle = handle;
+
+	bthost_add_cid_hook(bthost, handle, cid_data.cid,
+					map_client_cid_hook_cb, &cid_data);
+}
+
+static void map_client_get_instances_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	bt_bdaddr_t *bd_addr = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status =
+		data->if_map_client->get_remote_mas_instances(bd_addr);
+
+	schedule_action_verification(step);
+}
+
+static struct test_case test_cases[] = {
+	TEST_CASE_BREDRLE("MAP Client Init", ACTION_SUCCESS(dummy_action, NULL),
+	),
+	TEST_CASE_BREDRLE("MAP Client - Get mas instances success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_sdp_setup_data),
+		ACTION_SUCCESS(emu_set_connect_cb_action, map_client_conn_cb),
+		ACTION_SUCCESS(map_client_get_instances_action,
+							&emu_remote_bdaddr_val),
+		CALLBACK_MAP_CLIENT_REMOTE_MAS_INSTANCE(BT_STATUS_SUCCESS, NULL,
+					2, remote_map_inst_sms_mms_email_val),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+};
+
+struct queue *get_map_client_tests(void)
+{
+	uint16_t i = 0;
+
+	list = queue_new();
+
+	if (!list)
+		return NULL;
+
+	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
+			return NULL;
+		}
+
+	return list;
+}
+
+void remove_map_client_tests(void)
+{
+	queue_destroy(list, NULL);
+}
-- 
1.9.3

