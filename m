Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 20/20] audio/sink: Move stream retry logic to policy plugin
Date: Mon,  8 Jul 2013 17:10:26 +0300
Message-Id: <1373292626-3776-21-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

policy plugin is a better place to have such a logic as it is already
handling other connection policies related to such profiles.
---
 plugins/policy.c      | 51 ++++++++++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/sink.c | 52 +++++++++++----------------------------------------
 2 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 3b57baa..33258b3 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -42,6 +42,7 @@
 
 #define CONTROL_CONNECT_TIMEOUT 2
 #define SOURCE_RETRY_TIMEOUT 2
+#define SINK_RETRY_TIMEOUT SOURCE_RETRY_TIMEOUT
 
 static unsigned int service_id = 0;
 static GSList *devices = NULL;
@@ -50,6 +51,7 @@ struct policy_data {
 	struct btd_device *dev;
 
 	guint source_timer;
+	guint sink_timer;
 	guint ct_timer;
 	guint tg_timer;
 };
@@ -118,6 +120,9 @@ static void policy_remove(void *user_data)
 	if (data->source_timer > 0)
 		g_source_remove(data->source_timer);
 
+	if (data->sink_timer > 0)
+		g_source_remove(data->sink_timer);
+
 	if (data->ct_timer > 0)
 		g_source_remove(data->ct_timer);
 
@@ -143,9 +148,34 @@ static struct policy_data *policy_get_data(struct btd_device *dev)
 	return data;
 }
 
-static void sink_cb(struct btd_device *dev, btd_service_state_t old_state,
+static gboolean policy_connect_sink(gpointer user_data)
+{
+	struct policy_data *data = user_data;
+	struct btd_service *service;
+
+	data->source_timer = 0;
+
+	service = btd_device_get_service(data->dev, A2DP_SINK_UUID);
+	if (service != NULL)
+		policy_connect(data, service);
+
+	return FALSE;
+}
+
+static void policy_set_sink_timer(struct policy_data *data)
+{
+	if (data->sink_timer > 0)
+		g_source_remove(data->sink_timer);
+
+	data->sink_timer = g_timeout_add_seconds(SINK_RETRY_TIMEOUT,
+							policy_connect_sink,
+							data);
+}
+
+static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 						btd_service_state_t new_state)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	struct policy_data *data;
 	struct btd_service *controller;
 
@@ -158,6 +188,18 @@ static void sink_cb(struct btd_device *dev, btd_service_state_t old_state,
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
+			int err = btd_service_get_error(service);
+
+			if (err == -EAGAIN) {
+				policy_set_sink_timer(data);
+				break;
+			} else if (data->sink_timer > 0) {
+				g_source_remove(data->sink_timer);
+				data->sink_timer = 0;
+			}
+		}
+
 		if (data->ct_timer > 0) {
 			g_source_remove(data->ct_timer);
 			data->ct_timer = 0;
@@ -168,6 +210,11 @@ static void sink_cb(struct btd_device *dev, btd_service_state_t old_state,
 	case BTD_SERVICE_STATE_CONNECTING:
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
+		if (data->sink_timer > 0) {
+			g_source_remove(data->sink_timer);
+			data->sink_timer = 0;
+		}
+
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
@@ -350,7 +397,7 @@ static void service_cb(struct btd_service *service,
 	struct btd_profile *profile = btd_service_get_profile(service);
 
 	if (g_str_equal(profile->remote_uuid, A2DP_SINK_UUID))
-		sink_cb(dev, old_state, new_state);
+		sink_cb(service, old_state, new_state);
 	else if (g_str_equal(profile->remote_uuid, A2DP_SOURCE_UUID))
 		source_cb(service, old_state, new_state);
 	else if (g_str_equal(profile->remote_uuid, AVRCP_REMOTE_UUID))
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 9226002..7211e68 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -58,7 +58,6 @@ struct sink {
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
-	guint retry_id;
 	avdtp_session_state_t session_state;
 	avdtp_state_t stream_state;
 	sink_state_t state;
@@ -180,25 +179,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	sink->stream_state = new_state;
 }
 
-static gboolean stream_setup_retry(gpointer user_data)
-{
-	struct sink *sink = user_data;
-
-	sink->retry_id = 0;
-
-	if (sink->stream_state < AVDTP_STATE_OPEN) {
-		DBG("Stream setup failed, after XCASE connect:connect");
-		btd_service_connecting_complete(sink->service, -EIO);
-	}
-
-	if (sink->connect_id > 0) {
-		a2dp_cancel(sink->connect_id);
-		sink->connect_id = 0;
-	}
-
-	return FALSE;
-}
-
 static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
 					struct avdtp_error *err, void *user_data)
@@ -213,15 +193,10 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	avdtp_unref(sink->session);
 	sink->session = NULL;
 	if (avdtp_error_category(err) == AVDTP_ERRNO
-			&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-		DBG("connect:connect XCASE detected");
-		sink->retry_id = g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
-							stream_setup_retry,
-							sink);
-	} else {
-		DBG("Stream setup failed : %s", avdtp_strerror(err));
+				&& avdtp_error_posix_errno(err) != EHOSTDOWN)
+		btd_service_connecting_complete(sink->service, -EAGAIN);
+	else
 		btd_service_connecting_complete(sink->service, -EIO);
-	}
 }
 
 static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
@@ -250,35 +225,33 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 				void *user_data)
 {
 	struct sink *sink = user_data;
-	int id;
+	int id, perr;
 
 	if (err) {
 		avdtp_unref(sink->session);
 		sink->session = NULL;
 		if (avdtp_error_category(err) == AVDTP_ERRNO
 				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-			DBG("connect:connect XCASE detected");
-			sink->retry_id =
-				g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
-							stream_setup_retry,
-							sink);
+			perr = -EAGAIN;
 		} else
-			goto failed;
-		return;
+			perr = -EIO;
+		goto failed;
 	}
 
 	DBG("Discovery complete");
 
 	id = a2dp_select_capabilities(sink->session, AVDTP_SEP_TYPE_SINK, NULL,
 						select_complete, sink);
-	if (id == 0)
+	if (id == 0) {
+		perr = -EIO;
 		goto failed;
+	}
 
 	sink->connect_id = id;
 	return;
 
 failed:
-	btd_service_connecting_complete(sink->service, -EIO);
+	btd_service_connecting_complete(sink->service, perr);
 	avdtp_unref(sink->session);
 	sink->session = NULL;
 }
@@ -353,9 +326,6 @@ static void sink_free(struct btd_service *service)
 		sink->disconnect_id = 0;
 	}
 
-	if (sink->retry_id)
-		g_source_remove(sink->retry_id);
-
 	avdtp_remove_state_cb(sink->avdtp_callback_id);
 	btd_service_unref(sink->service);
 
-- 
1.8.1.4

