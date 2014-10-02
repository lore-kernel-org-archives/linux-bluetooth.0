Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/5] android/tester: Add support for GATT Notification in tester
Date: Thu,  2 Oct 2014 14:34:07 +0200
Message-Id: <1412253251-7258-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service register_for_notification and notification callbacks.
---
 android/tester-main.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 android/tester-main.h | 18 ++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 5517973..fe452f8 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -718,6 +718,21 @@ static bool match_data(struct step *step)
 			tester_debug("Gatt write_param doesn't match");
 			return false;
 		}
+
+		if (exp->callback_result.notification_registered !=
+				step->callback_result.notification_registered) {
+			tester_debug("Gatt registered flag mismatch");
+			return false;
+		}
+
+		if (exp->callback_result.notify_params) {
+			if (memcmp(step->callback_result.notify_params,
+					exp->callback_result.notify_params,
+					sizeof(btgatt_notify_params_t))) {
+				tester_debug("Gatt notify_param doesn't match");
+				return false;
+			}
+		}
 	}
 
 	return true;
@@ -820,6 +835,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.write_params)
 		free(step->callback_result.write_params);
 
+	if (step->callback_result.notify_params)
+		free(step->callback_result.notify_params);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1360,6 +1378,35 @@ static void gattc_write_descriptor_cb(int conn_id, int status,
 	schedule_callback_call(step);
 }
 
+static void gattc_register_for_notification_cb(int conn_id, int registered,
+						int status,
+						btgatt_srvc_id_t *srvc_id,
+						btgatt_gatt_id_t *char_id)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_REGISTER_FOR_NOTIFICATION;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
+	step->callback_result.characteristic = g_memdup(char_id,
+							sizeof(*char_id));
+	step->callback_result.notification_registered = registered;
+
+	schedule_callback_call(step);
+}
+
+static void gattc_notif_cb(int conn_id, btgatt_notify_params_t *p_data)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_NOTIFY;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.notify_params = g_memdup(p_data, sizeof(*p_data));
+
+	schedule_callback_call(step);
+}
+
 static void gatts_register_server_cb(int status, int server_if,
 							bt_uuid_t *app_uuid)
 {
@@ -1481,8 +1528,8 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.get_characteristic_cb = gattc_get_characteristic_cb,
 	.get_descriptor_cb = gattc_get_descriptor_cb,
 	.get_included_service_cb = gattc_get_included_service_cb,
-	.register_for_notification_cb = NULL,
-	.notify_cb = NULL,
+	.register_for_notification_cb = gattc_register_for_notification_cb,
+	.notify_cb = gattc_notif_cb,
 	.read_characteristic_cb = gattc_read_characteristic_cb,
 	.write_characteristic_cb = gattc_write_characteristic_cb,
 	.read_descriptor_cb = gattc_read_descriptor_cb,
diff --git a/android/tester-main.h b/android/tester-main.h
index c6662ca..57b7508 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -218,6 +218,22 @@ struct pdu_set {
 		.callback_result.write_params = cb_write_data, \
 	}
 
+#define CALLBACK_GATTC_REGISTER_FOR_NOTIF(cb_res, cb_conn_id, cb_char,\
+						cb_service, cb_registered) { \
+		.callback = CB_GATTC_REGISTER_FOR_NOTIFICATION, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.service = cb_service, \
+		.callback_result.characteristic = cb_char, \
+		.callback_result.notification_registered = cb_registered \
+	}
+
+#define CALLBACK_GATTC_NOTIFY(cb_conn_id, cb_notify) { \
+		.callback = CB_GATTC_NOTIFY, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.notify_params = cb_notify \
+	}
+
 #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
 		.callback = CB_GATTC_CLOSE, \
 		.callback_result.status = cb_res, \
@@ -473,6 +489,8 @@ struct bt_callback_data {
 	btgatt_srvc_id_t *included;
 	btgatt_read_params_t *read_params;
 	btgatt_write_params_t *write_params;
+	btgatt_notify_params_t *notify_params;
+	int notification_registered;
 	int char_prop;
 
 	btpan_control_state_t ctrl_state;
-- 
1.9.3

