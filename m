Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/a2dp: Simplify error handling
Date: Wed, 23 Mar 2016 14:55:29 +0200
Message-Id: <1458737729-4233-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1458737729-4233-1-git-send-email-luiz.dentz@gmail.com>
References: <1458737729-4233-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't expose avdtp_error in a2dp.h instead handle it internally
converting to posix error whenever necessary.
---
 profiles/audio/a2dp.c      | 36 +++++++++++++++++++++++++++++++-----
 profiles/audio/a2dp.h      |  9 +++------
 profiles/audio/sink.c      | 28 ++++++++--------------------
 profiles/audio/source.c    | 32 ++++++++++----------------------
 profiles/audio/transport.c |  8 ++++----
 5 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b0fea7c..b391fc2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -225,6 +225,29 @@ static void finalize_setup_errno(struct a2dp_setup *s, int err,
 	va_end(args);
 }
 
+static int error_to_errno(struct avdtp_error *err)
+{
+	int perr;
+
+	if (!err)
+		return 0;
+
+	if (avdtp_error_category(err) != AVDTP_ERRNO)
+		return -EIO;
+
+	perr = -avdtp_error_posix_errno(err);
+	switch (-perr) {
+	case -EHOSTDOWN:
+	case -ECONNABORTED:
+		return perr;
+	default:
+		/*
+		 * An unexpect error has occurred setup may be attempted again.
+		 */
+		return -EAGAIN;
+	}
+}
+
 static gboolean finalize_config(gpointer data)
 {
 	struct a2dp_setup *s = data;
@@ -239,8 +262,8 @@ static gboolean finalize_config(gpointer data)
 		if (!cb->config_cb)
 			continue;
 
-		cb->config_cb(s->session, s->sep, stream, s->err,
-							cb->user_data);
+		cb->config_cb(s->session, s->sep, stream,
+				error_to_errno(s->err), cb->user_data);
 		setup_cb_free(cb);
 	}
 
@@ -260,7 +283,8 @@ static gboolean finalize_resume(gpointer data)
 		if (!cb->resume_cb)
 			continue;
 
-		cb->resume_cb(s->session, s->err, cb->user_data);
+		cb->resume_cb(s->session, error_to_errno(s->err),
+							cb->user_data);
 		setup_cb_free(cb);
 	}
 
@@ -280,7 +304,8 @@ static gboolean finalize_suspend(gpointer data)
 		if (!cb->suspend_cb)
 			continue;
 
-		cb->suspend_cb(s->session, s->err, cb->user_data);
+		cb->suspend_cb(s->session, error_to_errno(s->err),
+							cb->user_data);
 		setup_cb_free(cb);
 	}
 
@@ -316,7 +341,8 @@ static void finalize_discover(struct a2dp_setup *s)
 		if (!cb->discover_cb)
 			continue;
 
-		cb->discover_cb(s->session, s->seps, s->err, cb->user_data);
+		cb->discover_cb(s->session, s->seps, error_to_errno(s->err),
+								cb->user_data);
 		setup_cb_free(cb);
 	}
 }
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 19d1877..2c388bb 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -53,17 +53,14 @@ struct a2dp_endpoint {
 };
 
 typedef void (*a2dp_discover_cb_t) (struct avdtp *session, GSList *seps,
-					struct avdtp_error *err,
-					void *user_data);
+						int err, void *user_data);
 typedef void (*a2dp_select_cb_t) (struct avdtp *session,
 					struct a2dp_sep *sep, GSList *caps,
 					void *user_data);
 typedef void (*a2dp_config_cb_t) (struct avdtp *session, struct a2dp_sep *sep,
-					struct avdtp_stream *stream,
-					struct avdtp_error *err,
+					struct avdtp_stream *stream, int err,
 					void *user_data);
-typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
-					struct avdtp_error *err,
+typedef void (*a2dp_stream_cb_t) (struct avdtp *session, int err,
 					void *user_data);
 
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index ac7237b..3167b3a 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -180,8 +180,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 }
 
 static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
-					struct avdtp_stream *stream,
-					struct avdtp_error *err, void *user_data)
+					struct avdtp_stream *stream, int err,
+					void *user_data)
 {
 	struct sink *sink = user_data;
 
@@ -192,11 +192,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	avdtp_unref(sink->session);
 	sink->session = NULL;
-	if (avdtp_error_category(err) == AVDTP_ERRNO
-				&& avdtp_error_posix_errno(err) != EHOSTDOWN)
-		btd_service_connecting_complete(sink->service, -EAGAIN);
-	else
-		btd_service_connecting_complete(sink->service, -EIO);
+	btd_service_connecting_complete(sink->service, err);
 }
 
 static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
@@ -221,25 +217,17 @@ failed:
 	sink->session = NULL;
 }
 
-static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp_error *err,
-				void *user_data)
+static void discovery_complete(struct avdtp *session, GSList *seps, int err,
+							void *user_data)
 {
 	struct sink *sink = user_data;
-	int id, perr;
+	int id;
 
 	sink->connect_id = 0;
 
 	if (err) {
 		avdtp_unref(sink->session);
 		sink->session = NULL;
-
-		perr = -avdtp_error_posix_errno(err);
-		if (perr != -EHOSTDOWN) {
-			if (avdtp_error_category(err) == AVDTP_ERRNO)
-				perr = -EAGAIN;
-			else
-				perr = -EIO;
-		}
 		goto failed;
 	}
 
@@ -248,7 +236,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	id = a2dp_select_capabilities(sink->session, AVDTP_SEP_TYPE_SINK, NULL,
 						select_complete, sink);
 	if (id == 0) {
-		perr = -EIO;
+		err = -EIO;
 		goto failed;
 	}
 
@@ -256,7 +244,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	btd_service_connecting_complete(sink->service, perr);
+	btd_service_connecting_complete(sink->service, err);
 	avdtp_unref(sink->session);
 	sink->session = NULL;
 }
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 372b132..493524e 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -177,8 +177,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 }
 
 static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
-					struct avdtp_stream *stream,
-					struct avdtp_error *err, void *user_data)
+					struct avdtp_stream *stream, int err,
+					void *user_data)
 {
 	struct source *source = user_data;
 
@@ -189,11 +189,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	avdtp_unref(source->session);
 	source->session = NULL;
-	if (avdtp_error_category(err) == AVDTP_ERRNO
-				&& avdtp_error_posix_errno(err) != EHOSTDOWN)
-		btd_service_connecting_complete(source->service, -EAGAIN);
-	else
-		btd_service_connecting_complete(source->service, -EIO);
+	btd_service_connecting_complete(source->service, err);
 }
 
 static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
@@ -221,34 +217,26 @@ failed:
 	source->session = NULL;
 }
 
-static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp_error *err,
-				void *user_data)
+static void discovery_complete(struct avdtp *session, GSList *seps, int err,
+							void *user_data)
 {
 	struct source *source = user_data;
-	int id, perr;
+	int id;
 
 	source->connect_id = 0;
 
 	if (err) {
 		avdtp_unref(source->session);
 		source->session = NULL;
-
-		perr = -avdtp_error_posix_errno(err);
-		if (perr != -EHOSTDOWN) {
-			if (avdtp_error_category(err) == AVDTP_ERRNO)
-				perr = -EAGAIN;
-			else
-				perr = -EIO;
-		}
 		goto failed;
 	}
 
 	DBG("Discovery complete");
 
-	id = a2dp_select_capabilities(source->session, AVDTP_SEP_TYPE_SOURCE, NULL,
-						select_complete, source);
+	id = a2dp_select_capabilities(source->session, AVDTP_SEP_TYPE_SOURCE,
+					NULL, select_complete, source);
 	if (id == 0) {
-		perr = -EIO;
+		err = -EIO;
 		goto failed;
 	}
 
@@ -256,7 +244,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	btd_service_connecting_complete(source->service, perr);
+	btd_service_connecting_complete(source->service, err);
 	avdtp_unref(source->session);
 	source->session = NULL;
 }
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 4121e52..b9d357e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -283,8 +283,8 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 	return TRUE;
 }
 
-static void a2dp_resume_complete(struct avdtp *session,
-				struct avdtp_error *err, void *user_data)
+static void a2dp_resume_complete(struct avdtp *session, int err,
+							void *user_data)
 {
 	struct media_owner *owner = user_data;
 	struct media_request *req = owner->pending;
@@ -362,8 +362,8 @@ static guint resume_a2dp(struct media_transport *transport,
 	return id;
 }
 
-static void a2dp_suspend_complete(struct avdtp *session,
-				struct avdtp_error *err, void *user_data)
+static void a2dp_suspend_complete(struct avdtp *session, int err,
+							void *user_data)
 {
 	struct media_owner *owner = user_data;
 	struct media_transport *transport = owner->transport;
-- 
2.5.0

