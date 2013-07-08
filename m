Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 19/20] audio/source: Move stream retry logic to policy plugin
Date: Mon,  8 Jul 2013 17:10:25 +0300
Message-Id: <1373292626-3776-20-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

policy plugin is a better place to have such a logic as it is already
handling other connection policies related to such profiles.
---
 plugins/policy.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/source.c | 54 ++++++++++---------------------------------------
 2 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 87cd2c0..3b57baa 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -41,6 +41,7 @@
 #include "src/profile.h"
 
 #define CONTROL_CONNECT_TIMEOUT 2
+#define SOURCE_RETRY_TIMEOUT 2
 
 static unsigned int service_id = 0;
 static GSList *devices = NULL;
@@ -48,6 +49,7 @@ static GSList *devices = NULL;
 struct policy_data {
 	struct btd_device *dev;
 
+	guint source_timer;
 	guint ct_timer;
 	guint tg_timer;
 };
@@ -113,6 +115,9 @@ static void policy_remove(void *user_data)
 {
 	struct policy_data *data = user_data;
 
+	if (data->source_timer > 0)
+		g_source_remove(data->source_timer);
+
 	if (data->ct_timer > 0)
 		g_source_remove(data->ct_timer);
 
@@ -201,9 +206,35 @@ static void policy_set_tg_timer(struct policy_data *data)
 							data);
 }
 
-static void source_cb(struct btd_device *dev, btd_service_state_t old_state,
+static gboolean policy_connect_source(gpointer user_data)
+{
+	struct policy_data *data = user_data;
+	struct btd_service *service;
+
+	data->source_timer = 0;
+
+	service = btd_device_get_service(data->dev, A2DP_SOURCE_UUID);
+	if (service != NULL)
+		policy_connect(data, service);
+
+	return FALSE;
+}
+
+static void policy_set_source_timer(struct policy_data *data)
+{
+	if (data->source_timer > 0)
+		g_source_remove(data->source_timer);
+
+	data->source_timer = g_timeout_add_seconds(SOURCE_RETRY_TIMEOUT,
+							policy_connect_source,
+							data);
+}
+
+static void source_cb(struct btd_service *service,
+						btd_service_state_t old_state,
 						btd_service_state_t new_state)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	struct policy_data *data;
 	struct btd_service *target;
 
@@ -216,6 +247,18 @@ static void source_cb(struct btd_device *dev, btd_service_state_t old_state,
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
+			int err = btd_service_get_error(service);
+
+			if (err == -EAGAIN) {
+				policy_set_source_timer(data);
+				break;
+			} else if (data->source_timer > 0) {
+				g_source_remove(data->source_timer);
+				data->source_timer = 0;
+			}
+		}
+
 		if (data->tg_timer > 0) {
 			g_source_remove(data->tg_timer);
 			data->tg_timer = 0;
@@ -226,6 +269,11 @@ static void source_cb(struct btd_device *dev, btd_service_state_t old_state,
 	case BTD_SERVICE_STATE_CONNECTING:
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
+		if (data->source_timer > 0) {
+			g_source_remove(data->source_timer);
+			data->source_timer = 0;
+		}
+
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
@@ -304,7 +352,7 @@ static void service_cb(struct btd_service *service,
 	if (g_str_equal(profile->remote_uuid, A2DP_SINK_UUID))
 		sink_cb(dev, old_state, new_state);
 	else if (g_str_equal(profile->remote_uuid, A2DP_SOURCE_UUID))
-		source_cb(dev, old_state, new_state);
+		source_cb(service, old_state, new_state);
 	else if (g_str_equal(profile->remote_uuid, AVRCP_REMOTE_UUID))
 		controller_cb(dev, old_state, new_state);
 	else if (g_str_equal(profile->remote_uuid, AVRCP_TARGET_UUID))
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 3cb3dbb..0793af3 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -52,14 +52,11 @@
 #include "source.h"
 #include "dbus-common.h"
 
-#define STREAM_SETUP_RETRY_TIMER 2
-
 struct source {
 	struct btd_service *service;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
-	guint retry_id;
 	avdtp_session_state_t session_state;
 	avdtp_state_t stream_state;
 	source_state_t state;
@@ -179,25 +176,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	source->stream_state = new_state;
 }
 
-static gboolean stream_setup_retry(gpointer user_data)
-{
-	struct source *source = user_data;
-
-	source->retry_id = 0;
-
-	if (source->stream_state < AVDTP_STATE_OPEN) {
-		DBG("Stream setup failed, after XCASE connect:connect");
-		btd_service_connecting_complete(source->service, -EIO);
-	}
-
-	if (source->connect_id > 0) {
-		a2dp_cancel(source->connect_id);
-		source->connect_id = 0;
-	}
-
-	return FALSE;
-}
-
 static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
 					struct avdtp_error *err, void *user_data)
@@ -212,15 +190,10 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	avdtp_unref(source->session);
 	source->session = NULL;
 	if (avdtp_error_category(err) == AVDTP_ERRNO
-			&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-		DBG("connect:connect XCASE detected");
-		source->retry_id = g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
-							stream_setup_retry,
-							source);
-	} else {
-		DBG("Stream setup failed : %s", avdtp_strerror(err));
+				&& avdtp_error_posix_errno(err) != EHOSTDOWN)
+		btd_service_connecting_complete(source->service, -EAGAIN);
+	else
 		btd_service_connecting_complete(source->service, -EIO);
-	}
 }
 
 static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
@@ -252,35 +225,33 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 				void *user_data)
 {
 	struct source *source = user_data;
-	int id;
+	int id, perr;
 
 	if (err) {
 		avdtp_unref(source->session);
 		source->session = NULL;
 		if (avdtp_error_category(err) == AVDTP_ERRNO
 				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-			DBG("connect:connect XCASE detected");
-			source->retry_id =
-				g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
-							stream_setup_retry,
-							source);
+			perr = -EAGAIN;
 		} else
-			goto failed;
-		return;
+			perr = -EIO;
+		goto failed;
 	}
 
 	DBG("Discovery complete");
 
 	id = a2dp_select_capabilities(source->session, AVDTP_SEP_TYPE_SOURCE, NULL,
 						select_complete, source);
-	if (id == 0)
+	if (id == 0) {
+		perr = -EIO;
 		goto failed;
+	}
 
 	source->connect_id = id;
 	return;
 
 failed:
-	btd_service_connecting_complete(source->service, -EIO);
+	btd_service_connecting_complete(source->service, perr);
 	avdtp_unref(source->session);
 	source->session = NULL;
 }
@@ -356,9 +327,6 @@ static void source_free(struct btd_service *service)
 		source->disconnect_id = 0;
 	}
 
-	if (source->retry_id)
-		g_source_remove(source->retry_id);
-
 	avdtp_remove_state_cb(source->avdtp_callback_id);
 	btd_service_unref(source->service);
 
-- 
1.8.1.4

