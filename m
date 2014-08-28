Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/tester: Add support for search services callbacks
Date: Thu, 28 Aug 2014 15:26:19 +0200
Message-Id: <1409232384-24580-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for search_result_cb() and search_complete_cb()
in android tester. It is needed for GATT client test cases.
---
 android/tester-main.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++--
 android/tester-main.h | 14 +++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 369a943..a825035 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -395,6 +395,18 @@ static int verify_property(bt_property_t *exp_props, int exp_num_props,
  * Check each test case step if test case expected
  * data is set and match it with expected result.
  */
+
+static bool verify_services(btgatt_srvc_id_t *a, btgatt_srvc_id_t *b)
+{
+	if (a->is_primary != b->is_primary)
+		return false;
+
+	if (memcmp(&a->id.uuid, &b->id.uuid, sizeof(bt_uuid_t)))
+		return false;
+
+	return true;
+}
+
 static bool match_data(struct step *step)
 {
 	struct test_data *data = tester_get_data();
@@ -529,6 +541,13 @@ static bool match_data(struct step *step)
 			tester_debug("Gatt properties don't match");
 			return false;
 		}
+
+		if (exp->callback_result.service &&
+				!verify_services(step->callback_result.service,
+						exp->callback_result.service)) {
+			tester_debug("Gatt service doesn't match");
+			return false;
+		}
 	}
 
 	return true;
@@ -613,6 +632,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.properties)
 		free_properties(step);
 
+	if (step->callback_result.service)
+		free(step->callback_result.service);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1030,6 +1052,27 @@ static void gattc_listen_cb(int status, int server_if)
 	schedule_callback_call(step);
 }
 
+static void gattc_search_result_cb(int conn_id, btgatt_srvc_id_t *srvc_id)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_SEARCH_RESULT;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
+
+	schedule_callback_call(step);
+}
+
+static void gattc_search_complete_cb(int conn_id, int status)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_SEARCH_COMPLETE;
+	step->callback_result.conn_id = conn_id;
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1130,8 +1173,8 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.scan_result_cb = gattc_scan_result_cb,
 	.open_cb = gattc_connect_cb,
 	.close_cb = gattc_disconnect_cb,
-	.search_complete_cb = NULL,
-	.search_result_cb = NULL,
+	.search_complete_cb = gattc_search_complete_cb,
+	.search_result_cb = gattc_search_result_cb,
 	.get_characteristic_cb = NULL,
 	.get_descriptor_cb = NULL,
 	.get_included_service_cb = NULL,
@@ -1236,6 +1279,12 @@ static bool setup_base(struct test_data *data)
 	if (!(data->steps = queue_new()))
 		return false;
 
+	data->pdus = queue_new();
+	if (!data->pdus) {
+		queue_destroy(data->steps, NULL);
+		return false;
+	}
+
 	return true;
 }
 
@@ -1479,6 +1528,9 @@ static void teardown(const void *test_data)
 	queue_destroy(data->steps, NULL);
 	data->steps = NULL;
 
+	queue_destroy(data->pdus, NULL);
+	data->pdus = NULL;
+
 	if (data->if_gatt) {
 		data->if_gatt->cleanup();
 		data->if_gatt = NULL;
diff --git a/android/tester-main.h b/android/tester-main.h
index ad87878..cc96975 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -140,6 +140,17 @@
 		.callback_result.client_id = cb_client_id, \
 	}
 
+#define CALLBACK_GATTC_SEARCH_RESULT(cb_conn_id, cb_service) { \
+		.callback = CB_GATTC_SEARCH_RESULT, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.service = cb_service \
+	}
+
+#define CALLBACK_GATTC_SEARCH_COMPLETE(cb_res, cb_conn_id) { \
+		.callback = CB_GATTC_SEARCH_COMPLETE, \
+		.callback_result.conn_id = cb_conn_id \
+	}
+
 #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
 		.callback = CB_GATTC_CLOSE, \
 		.callback_result.status = cb_res, \
@@ -315,6 +326,8 @@ struct test_data {
 	guint signalfd;
 	uint16_t mgmt_index;
 	pid_t bluetoothd_pid;
+
+	struct queue *pdus;
 };
 
 /*
@@ -372,6 +385,7 @@ struct bt_callback_data {
 
 	int client_id;
 	int conn_id;
+	btgatt_srvc_id_t *service;
 
 	btpan_control_state_t ctrl_state;
 	btpan_connection_state_t conn_state;
-- 
1.9.3

