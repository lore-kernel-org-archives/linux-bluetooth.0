Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/14] android/tester: Add support for GATT Get Included Service callback
Date: Thu, 11 Sep 2014 08:08:48 +0200
Message-Id: <1410415732-23212-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service and verify GATT Client Get Included Service callback.
---
 android/tester-main.c | 28 +++++++++++++++++++++++++++-
 android/tester-main.h | 10 ++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 39a6b5a..4513fcb 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -584,6 +584,14 @@ static bool match_data(struct step *step)
 				return false;
 			}
 		}
+
+		if (exp->callback_result.included) {
+			if (!verify_services(step->callback_result.included,
+					exp->callback_result.included)) {
+				tester_debug("Gatt include srvc doesn't match");
+				return false;
+			}
+		}
 	}
 
 	return true;
@@ -677,6 +685,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.descriptor)
 		free(step->callback_result.descriptor);
 
+	if (step->callback_result.included)
+		free(step->callback_result.included);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1150,6 +1161,21 @@ static void gattc_get_descriptor_cb(int conn_id, int status,
 	schedule_callback_call(step);
 }
 
+static void gattc_get_included_service_cb(int conn_id, int status,
+		btgatt_srvc_id_t *srvc_id, btgatt_srvc_id_t *incl_srvc_id)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_GET_INCLUDED_SERVICE;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
+	step->callback_result.included = g_memdup(incl_srvc_id,
+							sizeof(*srvc_id));
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1258,7 +1284,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.search_result_cb = gattc_search_result_cb,
 	.get_characteristic_cb = gattc_get_characteristic_cb,
 	.get_descriptor_cb = gattc_get_descriptor_cb,
-	.get_included_service_cb = NULL,
+	.get_included_service_cb = gattc_get_included_service_cb,
 	.register_for_notification_cb = NULL,
 	.notify_cb = NULL,
 	.read_characteristic_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index d69d5ca..6f59330 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -165,6 +165,15 @@
 		.callback_result.descriptor = cb_desc \
 	}
 
+#define CALLBACK_GATTC_GET_INCLUDED(cb_res, cb_conn_id, cb_service, \
+							cb_incl) { \
+		.callback = CB_GATTC_GET_INCLUDED_SERVICE, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_res, \
+		.callback_result.service = cb_service, \
+		.callback_result.included = cb_incl, \
+	}
+
 #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
 		.callback = CB_GATTC_CLOSE, \
 		.callback_result.status = cb_res, \
@@ -407,6 +416,7 @@ struct bt_callback_data {
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
 	btgatt_gatt_id_t *descriptor;
+	btgatt_srvc_id_t *included;
 	int char_prop;
 
 	btpan_control_state_t ctrl_state;
-- 
1.9.3

