Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] android/tester: Add support for GATT Client Read/Write callbacks
Date: Mon, 22 Sep 2014 13:29:41 +0200
Message-Id: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will service GATT Client read/write callbacks.
---
 android/tester-main.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++---
 android/tester-main.h | 31 +++++++++++++++++++
 2 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 5f0563d..b65029a 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -595,6 +595,24 @@ static bool match_data(struct step *step)
 				return false;
 			}
 		}
+
+		if (exp->callback_result.read_params) {
+			if (memcmp(step->callback_result.read_params,
+					exp->callback_result.read_params,
+					sizeof(btgatt_read_params_t))) {
+				tester_debug("Gatt read_param doesn't match");
+				return false;
+			}
+		}
+
+		if (exp->callback_result.write_params) {
+			if (memcmp(step->callback_result.write_params,
+					exp->callback_result.write_params,
+					sizeof(btgatt_write_params_t))) {
+				tester_debug("Gatt write_param doesn't match");
+				return false;
+			}
+		}
 	}
 
 	return true;
@@ -691,6 +709,12 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.included)
 		free(step->callback_result.included);
 
+	if (step->callback_result.read_params)
+		free(step->callback_result.read_params);
+
+	if (step->callback_result.write_params)
+		free(step->callback_result.write_params);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1179,6 +1203,58 @@ static void gattc_get_included_service_cb(int conn_id, int status,
 	schedule_callback_call(step);
 }
 
+static void gattc_read_characteristic_cb(int conn_id, int status,
+						btgatt_read_params_t *p_data)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_READ_CHARACTERISTIC;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.read_params = g_memdup(p_data, sizeof(*p_data));
+
+	schedule_callback_call(step);
+}
+
+static void gattc_read_descriptor_cb(int conn_id, int status,
+						btgatt_read_params_t *p_data)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_READ_DESCRIPTOR;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.read_params = g_memdup(p_data, sizeof(*p_data));
+
+	schedule_callback_call(step);
+}
+
+static void gattc_write_characteristic_cb(int conn_id, int status,
+						btgatt_write_params_t *p_data)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_WRITE_CHARACTERISTIC;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.write_params = g_memdup(p_data, sizeof(*p_data));
+
+	schedule_callback_call(step);
+}
+
+static void gattc_write_descriptor_cb(int conn_id, int status,
+						btgatt_write_params_t *p_data)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_WRITE_DESCRIPTOR;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.write_params = g_memdup(p_data, sizeof(*p_data));
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1290,10 +1366,10 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.get_included_service_cb = gattc_get_included_service_cb,
 	.register_for_notification_cb = NULL,
 	.notify_cb = NULL,
-	.read_characteristic_cb = NULL,
-	.write_characteristic_cb = NULL,
-	.read_descriptor_cb = NULL,
-	.write_descriptor_cb = NULL,
+	.read_characteristic_cb = gattc_read_characteristic_cb,
+	.write_characteristic_cb = gattc_write_characteristic_cb,
+	.read_descriptor_cb = gattc_read_descriptor_cb,
+	.write_descriptor_cb = gattc_write_descriptor_cb,
 	.execute_write_cb = NULL,
 	.read_remote_rssi_cb = NULL,
 	.listen_cb = gattc_listen_cb
diff --git a/android/tester-main.h b/android/tester-main.h
index 6f59330..8a816ba 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -174,6 +174,35 @@
 		.callback_result.included = cb_incl, \
 	}
 
+#define CALLBACK_GATTC_READ_CHARACTERISTIC(cb_res, cb_conn_id, cb_read_data) { \
+		.callback = CB_GATTC_READ_CHARACTERISTIC, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.read_params = cb_read_data, \
+	}
+
+#define CALLBACK_GATTC_READ_DESCRIPTOR(cb_res, cb_conn_id, cb_read_data) { \
+		.callback = CB_GATTC_READ_DESCRIPTOR, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.read_params = cb_read_data, \
+	}
+
+#define CALLBACK_GATTC_WRITE_DESCRIPTOR(cb_res, cb_conn_id, cb_write_data) { \
+		.callback = CB_GATTC_WRITE_DESCRIPTOR, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.write_params = cb_write_data, \
+	}
+
+#define CALLBACK_GATTC_WRITE_CHARACTERISTIC(cb_res, cb_conn_id, \
+							cb_write_data) { \
+		.callback = CB_GATTC_WRITE_CHARACTERISTIC, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.write_params = cb_write_data, \
+	}
+
 #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
 		.callback = CB_GATTC_CLOSE, \
 		.callback_result.status = cb_res, \
@@ -417,6 +446,8 @@ struct bt_callback_data {
 	btgatt_gatt_id_t *characteristic;
 	btgatt_gatt_id_t *descriptor;
 	btgatt_srvc_id_t *included;
+	btgatt_read_params_t *read_params;
+	btgatt_write_params_t *write_params;
 	int char_prop;
 
 	btpan_control_state_t ctrl_state;
-- 
1.9.3

