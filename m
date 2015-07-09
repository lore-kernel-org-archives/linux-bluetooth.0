Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Fix possible crash when removing device
Date: Thu,  9 Jul 2015 15:40:48 +0300
Message-Id: <1436445648-1892-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently it is not possible to cancel avdtp_discover procedure leading
to crashe if the device is removed while avdtp_discover is pending since
its callback is still reachable.
---
 profiles/audio/a2dp.c   | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/a2dp.h   |  6 ++++++
 profiles/audio/avdtp.c  |  7 +++++++
 profiles/audio/sink.c   |  4 +++-
 profiles/audio/source.c |  4 +++-
 5 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 22fdb52..c0fd1f6 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -82,6 +82,7 @@ struct a2dp_sep {
 
 struct a2dp_setup_cb {
 	struct a2dp_setup *setup;
+	a2dp_discover_cb_t discover_cb;
 	a2dp_select_cb_t select_cb;
 	a2dp_config_cb_t config_cb;
 	a2dp_stream_cb_t resume_cb;
@@ -98,6 +99,7 @@ struct a2dp_setup {
 	struct avdtp_stream *stream;
 	struct avdtp_error *err;
 	avdtp_set_configuration_cb setconf_cb;
+	GSList *seps;
 	GSList *caps;
 	gboolean reconfigure;
 	gboolean start;
@@ -302,6 +304,23 @@ static void finalize_select(struct a2dp_setup *s)
 	}
 }
 
+static void finalize_discover(struct a2dp_setup *s)
+{
+	GSList *l;
+
+	for (l = s->cb; l != NULL; ) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (!cb->discover_cb)
+			continue;
+
+		cb->discover_cb(s->session, s->seps, s->err, cb->user_data);
+		setup_cb_free(cb);
+	}
+}
+
 static struct a2dp_setup *find_setup_by_session(struct avdtp *session)
 {
 	GSList *l;
@@ -1797,6 +1816,40 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
 	return a2dp_find_sep(session, l, NULL);
 }
 
+static void discover_cb(struct avdtp *session, GSList *seps,
+				struct avdtp_error *err, void *user_data)
+{
+	struct a2dp_setup *setup = user_data;
+
+	DBG("err %p", err);
+
+	setup->seps = seps;
+	setup->err = err;
+
+	finalize_discover(setup);
+}
+
+unsigned int a2dp_discover(struct avdtp *session, a2dp_discover_cb_t cb,
+							void *user_data)
+{
+	struct a2dp_setup *setup;
+	struct a2dp_setup_cb *cb_data;
+
+	setup = a2dp_setup_get(session);
+	if (!setup)
+		return 0;
+
+	cb_data = setup_cb_new(setup);
+	cb_data->discover_cb = cb;
+	cb_data->user_data = user_data;
+
+	if (avdtp_discover(session, discover_cb, setup) == 0)
+		return cb_data->id;
+
+	setup_cb_free(cb_data);
+	return 0;
+}
+
 unsigned int a2dp_select_capabilities(struct avdtp *session,
 					uint8_t type, const char *sender,
 					a2dp_select_cb_t cb,
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 544eea1..19d1877 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -52,6 +52,9 @@ struct a2dp_endpoint {
 							void *user_data);
 };
 
+typedef void (*a2dp_discover_cb_t) (struct avdtp *session, GSList *seps,
+					struct avdtp_error *err,
+					void *user_data);
 typedef void (*a2dp_select_cb_t) (struct avdtp *session,
 					struct a2dp_sep *sep, GSList *caps,
 					void *user_data);
@@ -70,6 +73,9 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				int *err);
 void a2dp_remove_sep(struct a2dp_sep *sep);
 
+
+unsigned int a2dp_discover(struct avdtp *session, a2dp_discover_cb_t cb,
+							void *user_data);
 unsigned int a2dp_select_capabilities(struct avdtp *session,
 					uint8_t type, const char *sender,
 					a2dp_select_cb_t cb,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d2cd1dc..660fd24 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3475,6 +3475,13 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	struct seid_req req;
 	int ret;
 
+	if (!stream && session->discover) {
+		/* Don't call cb since it being aborted */
+		session->discover->cb = NULL;
+		finalize_discovery(session, -ECANCELED);
+		return 0;
+	}
+
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 14ece4f..1c36735 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -272,7 +272,9 @@ gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session)
 	if (!sink->session)
 		return FALSE;
 
-	if (avdtp_discover(sink->session, discovery_complete, sink) < 0)
+	sink->connect_id = a2dp_discover(sink->session, discovery_complete,
+								sink);
+	if (sink->connect_id == 0)
 		return FALSE;
 
 	return TRUE;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index b235a7d..16a8287 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -273,7 +273,9 @@ gboolean source_setup_stream(struct btd_service *service,
 	if (!source->session)
 		return FALSE;
 
-	if (avdtp_discover(source->session, discovery_complete, source) < 0)
+	source->connect_id = a2dp_discover(source->session, discovery_complete,
+								source);
+	if (source->connect_id == 0)
 		return FALSE;
 
 	return TRUE;
-- 
2.1.0

