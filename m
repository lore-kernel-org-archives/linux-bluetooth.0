Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/14] android/tester: Add support for GATT Get Descriptor callback
Date: Thu, 11 Sep 2014 08:08:42 +0200
Message-Id: <1410415732-23212-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service and verify GATTT Client Get Descriptor callback.
---
 android/tester-main.c | 35 ++++++++++++++++++++++++++++++++++-
 android/tester-main.h | 11 +++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 297aadb..39a6b5a 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -572,6 +572,18 @@ static bool match_data(struct step *step)
 			tester_debug("Gatt char prop doesn't match");
 			return false;
 		}
+
+		if (exp->callback_result.descriptor) {
+			btgatt_gatt_id_t *a;
+			btgatt_gatt_id_t *b;
+			a = step->callback_result.descriptor;
+			b = exp->callback_result.descriptor;
+
+			if (!verify_gatt_ids(a, b)) {
+				tester_debug("Gatt desc doesn't match");
+				return false;
+			}
+		}
 	}
 
 	return true;
@@ -662,6 +674,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.characteristic)
 		free(step->callback_result.characteristic);
 
+	if (step->callback_result.descriptor)
+		free(step->callback_result.descriptor);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1117,6 +1132,24 @@ static void gattc_get_characteristic_cb(int conn_id, int status,
 	schedule_callback_call(step);
 }
 
+static void gattc_get_descriptor_cb(int conn_id, int status,
+			btgatt_srvc_id_t *srvc_id, btgatt_gatt_id_t *char_id,
+			btgatt_gatt_id_t *descr_id)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_GET_DESCRIPTOR;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
+	step->callback_result.characteristic = g_memdup(char_id,
+							sizeof(*char_id));
+	step->callback_result.descriptor = g_memdup(descr_id,
+							sizeof(*descr_id));
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1224,7 +1257,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.search_complete_cb = gattc_search_complete_cb,
 	.search_result_cb = gattc_search_result_cb,
 	.get_characteristic_cb = gattc_get_characteristic_cb,
-	.get_descriptor_cb = NULL,
+	.get_descriptor_cb = gattc_get_descriptor_cb,
 	.get_included_service_cb = NULL,
 	.register_for_notification_cb = NULL,
 	.notify_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 6cad803..d69d5ca 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -155,6 +155,16 @@
 		.callback_result.char_prop = cb_char_prop \
 	}
 
+#define CALLBACK_GATTC_GET_DESCRIPTOR(cb_res, cb_conn_id, cb_service, \
+						cb_char, cb_desc) { \
+		.callback = CB_GATTC_GET_DESCRIPTOR, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.service = cb_service, \
+		.callback_result.characteristic = cb_char, \
+		.callback_result.descriptor = cb_desc \
+	}
+
 #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
 		.callback = CB_GATTC_CLOSE, \
 		.callback_result.status = cb_res, \
@@ -396,6 +406,7 @@ struct bt_callback_data {
 	int conn_id;
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
+	btgatt_gatt_id_t *descriptor;
 	int char_prop;
 
 	btpan_control_state_t ctrl_state;
-- 
1.9.3

