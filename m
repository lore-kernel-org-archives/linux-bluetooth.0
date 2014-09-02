Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/8] android/tester: Add support for get_characteristic_cb()
Date: Tue,  2 Sep 2014 14:04:30 +0200
Message-Id: <1409659471-25171-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify data passed to get_characteristic_cb. It is needed
for tester-gatt.
---
 android/tester-main.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-----
 android/tester-main.h | 11 +++++++++++
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index aebc1a1..c0f384c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -396,17 +396,23 @@ static int verify_property(bt_property_t *exp_props, int exp_num_props,
  * data is set and match it with expected result.
  */
 
-static bool verify_services(btgatt_srvc_id_t *a, btgatt_srvc_id_t *b)
+static bool verify_gatt_ids(btgatt_gatt_id_t *a, btgatt_gatt_id_t *b)
 {
-	if (a->is_primary != b->is_primary)
-		return false;
 
-	if (memcmp(&a->id.uuid, &b->id.uuid, sizeof(bt_uuid_t)))
+	if (memcmp(&a->uuid, &b->uuid, sizeof(bt_uuid_t)))
 		return false;
 
 	return true;
 }
 
+static bool verify_services(btgatt_srvc_id_t *a, btgatt_srvc_id_t *b)
+{
+	if (a->is_primary != b->is_primary)
+		return false;
+
+	return verify_gatt_ids(&a->id, &b->id);
+}
+
 static bool match_data(struct step *step)
 {
 	struct test_data *data = tester_get_data();
@@ -548,6 +554,24 @@ static bool match_data(struct step *step)
 			tester_debug("Gatt service doesn't match");
 			return false;
 		}
+
+		if (exp->callback_result.characteristic) {
+			btgatt_gatt_id_t *a;
+			btgatt_gatt_id_t *b;
+			a = step->callback_result.characteristic;
+			b = exp->callback_result.characteristic;
+
+			if (!verify_gatt_ids(a, b)) {
+				tester_debug("Gatt char doesn't match");
+				return false;
+			}
+		}
+
+		if (exp->callback_result.char_prop !=
+					step->callback_result.char_prop) {
+			tester_debug("Gatt char prop doesn't match");
+			return false;
+		}
 	}
 
 	return true;
@@ -635,6 +659,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.service)
 		free(step->callback_result.service);
 
+	if (step->callback_result.characteristic)
+		free(step->callback_result.characteristic);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1073,6 +1100,23 @@ static void gattc_search_complete_cb(int conn_id, int status)
 	schedule_callback_call(step);
 }
 
+static void gattc_get_characteristic_cb(int conn_id, int status,
+			btgatt_srvc_id_t *srvc_id, btgatt_gatt_id_t *char_id,
+			int char_prop)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_GET_CHARACTERISTIC;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
+	step->callback_result.characteristic = g_memdup(char_id,
+							sizeof(*char_id));
+	step->callback_result.char_prop = char_prop;
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1175,7 +1219,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.close_cb = gattc_disconnect_cb,
 	.search_complete_cb = gattc_search_complete_cb,
 	.search_result_cb = gattc_search_result_cb,
-	.get_characteristic_cb = NULL,
+	.get_characteristic_cb = gattc_get_characteristic_cb,
 	.get_descriptor_cb = NULL,
 	.get_included_service_cb = NULL,
 	.register_for_notification_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index aa7eb2a..46aacce 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -144,6 +144,15 @@
 		.callback = CB_GATTC_SEARCH_COMPLETE, \
 		.callback_result.conn_id = cb_conn_id \
 	}
+#define CALLBACK_GATTC_GET_CHARACTERISTIC_CB(cb_res, cb_conn_id, cb_service, \
+						cb_char, cb_char_prop) { \
+		.callback = CB_GATTC_GET_CHARACTERISTIC, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.service = cb_service, \
+		.callback_result.characteristic = cb_char, \
+		.callback_result.char_prop = cb_char_prop \
+	}
 
 #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
 		.callback = CB_GATTC_CLOSE, \
@@ -384,6 +393,8 @@ struct bt_callback_data {
 	int client_id;
 	int conn_id;
 	btgatt_srvc_id_t *service;
+	btgatt_gatt_id_t *characteristic;
+	int char_prop;
 
 	btpan_control_state_t ctrl_state;
 	btpan_connection_state_t conn_state;
-- 
1.9.0

