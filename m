Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 7/9] audi: Refactor avdtp_get function
Date: Fri, 20 Feb 2015 14:43:21 +0200
Message-Id: <1424436203-28935-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactor avdtp_get() moving it from avdtp to a2dp and renaming to
a2dp_avdtp_get().
---
 profiles/audio/a2dp.c      | 16 +++++++++++++
 profiles/audio/a2dp.h      |  1 +
 profiles/audio/avdtp.c     | 57 +++-------------------------------------------
 profiles/audio/avdtp.h     |  2 --
 profiles/audio/sink.c      |  2 +-
 profiles/audio/source.c    |  2 +-
 profiles/audio/transport.c |  2 +-
 7 files changed, 23 insertions(+), 59 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 1ecbf3a..2471954 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1212,6 +1212,22 @@ static struct avdtp_server *find_avdtp_server(GSList *list,
 	return NULL;
 }
 
+struct avdtp *a2dp_avdtp_get(struct btd_device *device)
+{
+	struct avdtp_server *server;
+	struct avdtp *session;
+
+	server = find_avdtp_server(avdtp_servers, device_get_adapter(device));
+	if (server == NULL)
+		return NULL;
+
+	session = avdtp_new(server, server->sessions, NULL, device);
+	if (!session)
+		return NULL;
+
+	return avdtp_ref(session);
+}
+
 static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index ef3be5c..544eea1 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -87,3 +87,4 @@ gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup);
+struct avdtp *a2dp_avdtp_get(struct btd_device *device);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4d0b506..39b0dd1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -427,8 +427,6 @@ struct avdtp {
 	gboolean stream_setup;
 };
 
-static GSList *servers = NULL;
-
 static GSList *state_callbacks = NULL;
 
 static int send_request(struct avdtp *session, gboolean priority,
@@ -447,18 +445,6 @@ static void avdtp_sep_set_state(struct avdtp *session,
 				struct avdtp_local_sep *sep,
 				avdtp_state_t state);
 
-static struct avdtp_server *find_server(GSList *list, struct btd_adapter *a)
-{
-	for (; list; list = list->next) {
-		struct avdtp_server *server = list->data;
-
-		if (server->adapter == a)
-			return server;
-	}
-
-	return NULL;
-}
-
 static const char *avdtp_statestr(avdtp_state_t state)
 {
 	switch (state) {
@@ -2311,46 +2297,6 @@ static uint16_t get_version(struct avdtp *session)
 	return ver;
 }
 
-static struct avdtp *avdtp_get_internal(struct btd_device *device)
-{
-	struct avdtp_server *server;
-	struct avdtp *session;
-
-	server = find_server(servers, device_get_adapter(device));
-	if (server == NULL)
-		return NULL;
-
-	session = find_session(server->sessions, device);
-	if (session)
-		return session;
-
-	session = g_new0(struct avdtp, 1);
-
-	session->server = server;
-	session->device = btd_device_ref(device);
-	/* We don't use avdtp_set_state() here since this isn't a state change
-	 * but just setting of the initial state */
-	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
-
-	session->version = get_version(session);
-
-	server->sessions = g_slist_append(server->sessions, session);
-
-	return session;
-}
-
-struct avdtp *avdtp_get(struct btd_device *device)
-{
-	struct avdtp *session;
-
-	session = avdtp_get_internal(device);
-
-	if (!session)
-		return NULL;
-
-	return avdtp_ref(session);
-}
-
 static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct avdtp *session = user_data;
@@ -2451,6 +2397,9 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
 
 	sessions = g_slist_append(sessions, session);
 
+	if (!chan)
+		return session;
+
 	/* This state (ie, session is already *connecting*) happens when the
 	 * device initiates a connect (really a config'd L2CAP channel) even
 	 * though there is a connect we initiated in progress. In sink.c &
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 8bf6611..be2c3e5 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -214,8 +214,6 @@ struct avdtp_sep_ind {
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 
-struct avdtp *avdtp_get(struct btd_device *device);
-
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index f475709..3ecdab8 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -282,7 +282,7 @@ int sink_connect(struct btd_service *service)
 	struct sink *sink = btd_service_get_user_data(service);
 
 	if (!sink->session)
-		sink->session = avdtp_get(btd_service_get_device(service));
+		sink->session = a2dp_avdtp_get(btd_service_get_device(service));
 
 	if (!sink->session) {
 		DBG("Unable to get a session");
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index aca2fcb..c00e354 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -283,7 +283,7 @@ int source_connect(struct btd_service *service)
 	struct source *source = btd_service_get_user_data(service);
 
 	if (!source->session)
-		source->session = avdtp_get(btd_service_get_device(service));
+		source->session = a2dp_avdtp_get(btd_service_get_device(service));
 
 	if (!source->session) {
 		DBG("Unable to get a session");
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c05aa3a..cfb9125 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -333,7 +333,7 @@ static guint resume_a2dp(struct media_transport *transport,
 	guint id;
 
 	if (a2dp->session == NULL) {
-		a2dp->session = avdtp_get(transport->device);
+		a2dp->session = a2dp_avdtp_get(transport->device);
 		if (a2dp->session == NULL)
 			return 0;
 	}
-- 
2.1.0

