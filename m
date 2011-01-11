Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix possible memory leak on each a2dp stream setup
Date: Tue, 11 Jan 2011 16:42:26 +0200
Message-Id: <1294756947-11714-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Setup capabilities were not freed when capabilities were automatically
generated and not just taken as it used to be with old unix socket
clients.
---
 audio/a2dp.c |   29 ++++++++++++++++++-----------
 audio/unix.c |    2 ++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index b1e94d9..c5da708 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -94,7 +94,7 @@ struct a2dp_setup {
 	struct avdtp_stream *stream;
 	struct avdtp_error *err;
 	avdtp_set_configuration_cb setconf_cb;
-	GSList *client_caps;
+	GSList *caps;
 	gboolean reconfigure;
 	gboolean start;
 	GSList *cb;
@@ -162,6 +162,8 @@ static void setup_free(struct a2dp_setup *s)
 		avdtp_unref(s->session);
 	g_slist_foreach(s->cb, (GFunc) g_free, NULL);
 	g_slist_free(s->cb);
+	g_slist_foreach(s->caps, (GFunc) g_free, NULL);
+	g_slist_free(s->caps);
 	g_free(s);
 }
 
@@ -277,7 +279,7 @@ static gboolean finalize_suspend_errno(struct a2dp_setup *s, int err)
 	return finalize_suspend(s);
 }
 
-static gboolean finalize_select(struct a2dp_setup *s, GSList *caps)
+static gboolean finalize_select(struct a2dp_setup *s)
 {
 	GSList *l;
 
@@ -289,7 +291,7 @@ static gboolean finalize_select(struct a2dp_setup *s, GSList *caps)
 		if (!cb->select_cb)
 			continue;
 
-		cb->select_cb(s->session, s->sep, caps, cb->user_data);
+		cb->select_cb(s->session, s->sep, s->caps, cb->user_data);
 		setup_cb_free(cb);
 	}
 
@@ -1060,7 +1062,7 @@ static gboolean a2dp_reconfigure(gpointer data)
 
 	posix_err = avdtp_set_configuration(setup->session, setup->rsep,
 						sep->lsep,
-						setup->client_caps,
+						setup->caps,
 						&setup->stream);
 	if (posix_err < 0) {
 		error("avdtp_set_configuration: %s", strerror(-posix_err));
@@ -1811,7 +1813,6 @@ static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	struct a2dp_setup *setup = user_data;
 	struct avdtp_service_capability *media_transport, *media_codec;
 	struct avdtp_media_codec_capability *cap;
-	GSList *caps = NULL;
 
 	if (size < 0) {
 		DBG("Endpoint replied an invalid configuration");
@@ -1821,7 +1822,7 @@ static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
 						NULL, 0);
 
-	caps = g_slist_append(caps, media_transport);
+	setup->caps = g_slist_append(setup->caps, media_transport);
 
 	cap = g_malloc0(sizeof(*cap) + size);
 	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
@@ -1831,17 +1832,17 @@ static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
 						sizeof(*cap) + size);
 
-	caps = g_slist_append(caps, media_codec);
+	setup->caps = g_slist_append(setup->caps, media_codec);
 
 done:
-	finalize_select(setup, caps);
+	finalize_select(setup);
 }
 
 static gboolean auto_select(gpointer data)
 {
 	struct a2dp_setup *setup = data;
 
-	finalize_select(setup, setup->client_caps);
+	finalize_select(setup);
 
 	return FALSE;
 }
@@ -1933,7 +1934,7 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	endpoint in the configuration file */
 	if (sep->endpoint == NULL) {
 		if (!select_capabilities(session, setup->rsep,
-					&setup->client_caps)) {
+					&setup->caps)) {
 			error("Unable to auto select remote SEP capabilities");
 			goto fail;
 		}
@@ -2006,7 +2007,13 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 
 	setup->sep = sep;
 	setup->stream = sep->stream;
-	setup->client_caps = caps;
+
+	/* Copy given caps if they are different than current caps */
+	if (setup->caps != caps) {
+		g_slist_foreach(setup->caps, (GFunc) g_free, NULL);
+		g_slist_free(setup->caps);
+		setup->caps = g_slist_copy(caps);
+	}
 
 	switch (avdtp_sep_get_state(sep->lsep)) {
 	case AVDTP_STATE_IDLE:
diff --git a/audio/unix.c b/audio/unix.c
index 62eee31..76c68a8 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1074,6 +1074,8 @@ static void start_config(struct audio_device *dev, struct unix_client *client)
 	}
 
 	client->req_id = id;
+	g_slist_free(client->caps);
+	client->caps = NULL;
 
 	return;
 
-- 
1.7.1

