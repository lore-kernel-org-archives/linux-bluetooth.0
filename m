Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/4] plugins/policy: Try reconnect Control/Target services
Date: Fri, 13 Mar 2015 11:19:52 +0100
Message-Id: <1426241992-27194-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If state of Control/Remote services changed from CONNECTING to
DISCONNECTED, and error is set to -EAGAIN, set random timer and try
reconnect. This approach is described in AVRCP Spec 1.5 4.1.1:
"If both devices open an AVCTP channel at the same time both channels
shall be closed and each device shall wait a random time
(not more than 1 s and not less than 100ms) and then try to open
the AVCTP channel again."
---
 plugins/policy.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 9cbf146..45706f6 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -48,8 +48,12 @@
 #define CONTROL_CONNECT_TIMEOUT 2
 #define SOURCE_RETRY_TIMEOUT 2
 #define SINK_RETRY_TIMEOUT SOURCE_RETRY_TIMEOUT
+#define CT_RETRY_TIMEOUT 1
+#define TG_RETRY_TIMEOUT CT_RETRY_TIMEOUT
 #define SOURCE_RETRIES 1
 #define SINK_RETRIES SOURCE_RETRIES
+#define CT_RETRIES 1
+#define TG_RETRIES CT_RETRIES
 
 /* Tracking of remote services to be auto-reconnected upon link loss */
 
@@ -82,7 +86,9 @@ struct policy_data {
 	guint sink_timer;
 	uint8_t sink_retries;
 	guint ct_timer;
+	uint8_t ct_retries;
 	guint tg_timer;
+	uint8_t tg_retries;
 };
 
 static void policy_connect(struct policy_data *data,
@@ -111,6 +117,7 @@ static gboolean policy_connect_ct(gpointer user_data)
 	struct btd_service *service;
 
 	data->ct_timer = 0;
+	data->ct_retries++;
 
 	service = btd_device_get_service(data->dev, AVRCP_REMOTE_UUID);
 	if (service != NULL)
@@ -119,13 +126,13 @@ static gboolean policy_connect_ct(gpointer user_data)
 	return FALSE;
 }
 
-static void policy_set_ct_timer(struct policy_data *data)
+static void policy_set_ct_timer(struct policy_data *data, int timeout)
 {
 	if (data->ct_timer > 0)
 		g_source_remove(data->ct_timer);
 
-	data->ct_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
-						policy_connect_ct, data);
+	data->ct_timer = g_timeout_add_seconds(timeout, policy_connect_ct,
+									data);
 }
 
 static struct policy_data *find_data(struct btd_device *dev)
@@ -260,7 +267,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 			policy_connect(data, controller);
 		else if (btd_service_get_state(controller) !=
 						BTD_SERVICE_STATE_CONNECTED)
-			policy_set_ct_timer(data);
+			policy_set_ct_timer(data, CONTROL_CONNECT_TIMEOUT);
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
@@ -273,6 +280,7 @@ static gboolean policy_connect_tg(gpointer user_data)
 	struct btd_service *service;
 
 	data->tg_timer = 0;
+	data->tg_retries++;
 
 	service = btd_device_get_service(data->dev, AVRCP_TARGET_UUID);
 	if (service != NULL)
@@ -281,13 +289,12 @@ static gboolean policy_connect_tg(gpointer user_data)
 	return FALSE;
 }
 
-static void policy_set_tg_timer(struct policy_data *data)
+static void policy_set_tg_timer(struct policy_data *data, int timeout)
 {
 	if (data->tg_timer > 0)
 		g_source_remove(data->tg_timer);
 
-	data->tg_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
-							policy_connect_tg,
+	data->tg_timer = g_timeout_add_seconds(timeout, policy_connect_tg,
 							data);
 }
 
@@ -375,7 +382,7 @@ static void source_cb(struct btd_service *service,
 			policy_connect(data, target);
 		else if (btd_service_get_state(target) !=
 						BTD_SERVICE_STATE_CONNECTED)
-			policy_set_tg_timer(data);
+			policy_set_tg_timer(data, CONTROL_CONNECT_TIMEOUT);
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
@@ -401,6 +408,23 @@ static void controller_cb(struct btd_service *service,
 		}
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
+			int err = btd_service_get_error(service);
+
+			if (err == -EAGAIN) {
+				if (data->ct_retries < CT_RETRIES)
+					policy_set_ct_timer(data,
+							CT_RETRY_TIMEOUT);
+				else
+					data->ct_retries = 0;
+				break;
+			} else if (data->ct_timer > 0) {
+				g_source_remove(data->ct_timer);
+				data->ct_timer = 0;
+			}
+		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
+			data->ct_retries = 0;
+		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
 		break;
@@ -434,6 +458,23 @@ static void target_cb(struct btd_service *service,
 		}
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
+			int err = btd_service_get_error(service);
+
+			if (err == -EAGAIN) {
+				if (data->tg_retries < TG_RETRIES)
+					policy_set_tg_timer(data,
+							TG_RETRY_TIMEOUT);
+				else
+					data->tg_retries = 0;
+				break;
+			} else if (data->tg_timer > 0) {
+				g_source_remove(data->tg_timer);
+				data->tg_timer = 0;
+			}
+		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
+			data->tg_retries = 0;
+		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
 		break;
-- 
2.1.0

