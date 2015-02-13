Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 8/9] android/avdtp: Refactor local SEP list handling
Date: Fri, 13 Feb 2015 11:06:07 +0200
Message-Id: <1423818368-15899-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In order to deduplicate similar code in android/ and profiles/ we need
to handle local SEP list outside of avdtp.c.
---
 android/a2dp.c      | 19 ++++++++++++++++---
 android/avdtp.c     | 44 +++++++++++++++++++++++---------------------
 android/avdtp.h     |  2 ++
 android/avdtptest.c |  6 ++++++
 unit/test-avdtp.c   | 44 +++++++++++++++++++++++++++++++++++++-------
 5 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 10f5523..f8f418f 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -52,6 +52,7 @@
 #define SVC_HINT_CAPTURING 0x08
 #define IDLE_TIMEOUT 1
 #define AUDIO_RETRY_TIMEOUT 2
+#define MAX_SEID 0x3E
 
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
@@ -65,6 +66,8 @@ static bool audio_retrying = false;
 static struct ipc *hal_ipc = NULL;
 static struct ipc *audio_ipc = NULL;
 
+static GSList *lseps = NULL;
+
 struct a2dp_preset {
 	void *data;
 	int8_t len;
@@ -114,8 +117,10 @@ static void unregister_endpoint(void *data)
 {
 	struct a2dp_endpoint *endpoint = data;
 
-	if (endpoint->sep)
+	if (endpoint->sep) {
+		lseps = g_slist_remove(lseps, endpoint->sep);
 		avdtp_unregister_sep(endpoint->sep);
+	}
 
 	if (endpoint->caps)
 		preset_free(endpoint->caps);
@@ -620,6 +625,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 							gpointer user_data)
 {
 	struct a2dp_device *dev = user_data;
+	struct avdtp *session;
 	uint16_t imtu, omtu;
 	GError *gerr = NULL;
 	int fd;
@@ -643,10 +649,13 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	fd = g_io_channel_unix_get_fd(chan);
 
 	/* FIXME: Add proper version */
-	dev->session = avdtp_new(fd, imtu, omtu, 0x0100);
-	if (!dev->session)
+	session = avdtp_new(fd, imtu, omtu, 0x0100);
+	if (!session)
 		goto failed;
 
+	avdtp_set_lseps(session, lseps);
+	dev->session = session;
+
 	avdtp_add_disconnect_cb(dev->session, disconnect_cb, dev);
 
 	/* Proceed to stream setup if initiator */
@@ -1324,6 +1333,9 @@ static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 
 	/* FIXME: Add proper check for uuid */
 
+	if (g_slist_length(lseps) > MAX_SEID)
+		return 0;
+
 	endpoint = g_new0(struct a2dp_endpoint, 1);
 	endpoint->id = g_slist_length(endpoints) + 1;
 	endpoint->codec = codec;
@@ -1342,6 +1354,7 @@ static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 						btohs(vndcodec->codec_id));
 	}
 
+	lseps = g_slist_append(lseps, endpoint->sep);
 	endpoints = g_slist_append(endpoints, endpoint);
 
 	return endpoint->id;
diff --git a/android/avdtp.c b/android/avdtp.c
index f4b2d45..6c750f8 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -383,6 +383,7 @@ struct avdtp {
 	guint io_id;
 
 	GSList *seps; /* Elements of type struct avdtp_remote_sep * */
+	GSList *lseps; /* Elements of type struct avdtp_local_sep * */
 
 	GSList *streams; /* Elements of type struct avdtp_stream * */
 
@@ -406,8 +407,6 @@ struct avdtp {
 	bool shutdown;
 };
 
-static GSList *lseps = NULL;
-
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
 			void *buffer, size_t size);
@@ -993,6 +992,9 @@ static void avdtp_free(void *data)
 	g_slist_free_full(session->seps, sep_free);
 	g_slist_free_full(session->disconnect, g_free);
 
+	/* Free copy of the SEP list */
+	g_slist_free(session->lseps);
+
 	g_free(session->buf);
 
 	g_free(session);
@@ -1050,11 +1052,12 @@ struct avdtp *avdtp_ref(struct avdtp *session)
 	return session;
 }
 
-static struct avdtp_local_sep *find_local_sep_by_seid(uint8_t seid)
+static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
+								uint8_t seid)
 {
 	GSList *l;
 
-	for (l = lseps; l != NULL; l = g_slist_next(l)) {
+	for (l = session->lseps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_local_sep *sep = l->data;
 
 		if (sep->info.seid == seid)
@@ -1169,7 +1172,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	struct seid_info *seps;
 	gboolean ret;
 
-	sep_count = g_slist_length(lseps);
+	sep_count = g_slist_length(session->lseps);
 
 	if (sep_count == 0) {
 		uint8_t err = AVDTP_NOT_SUPPORTED_COMMAND;
@@ -1181,7 +1184,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 
 	seps = g_new0(struct seid_info, sep_count);
 
-	for (l = lseps, i = 0; l != NULL; l = l->next, i++) {
+	for (l = session->lseps, i = 0; l != NULL; l = l->next, i++) {
 		struct avdtp_local_sep *sep = l->data;
 
 		memcpy(&seps[i], &sep->info, sizeof(struct seid_info));
@@ -1211,7 +1214,7 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1293,7 +1296,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1381,7 +1384,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 
 	memset(buf, 0, sizeof(buf));
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1497,7 +1500,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1557,7 +1560,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1607,7 +1610,7 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1668,7 +1671,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1715,7 +1718,7 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream)
 		return TRUE;
 
@@ -1753,7 +1756,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -2141,6 +2144,11 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 	return avdtp_ref(session);
 }
 
+void avdtp_set_lseps(struct avdtp *session, GSList *lseps)
+{
+	session->lseps = g_slist_copy(lseps);
+}
+
 unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						avdtp_disconnect_cb_t cb,
 						void *user_data)
@@ -3373,9 +3381,6 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	if (!seid)
 		return NULL;
 
-	if (g_slist_length(lseps) > MAX_SEID)
-		return NULL;
-
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
@@ -3390,7 +3395,6 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
-	lseps = g_slist_append(lseps, sep);
 
 	return sep;
 }
@@ -3407,8 +3411,6 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 	if (!sep)
 		return -EINVAL;
 
-	lseps = g_slist_remove(lseps, sep);
-
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
 
diff --git a/android/avdtp.h b/android/avdtp.h
index d5335e4..68786fe 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -207,6 +207,8 @@ typedef void (*avdtp_disconnect_cb_t) (void *user_data);
 
 struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 
+void avdtp_set_lseps(struct avdtp *session, GSList *lseps);
+
 unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						avdtp_disconnect_cb_t cb,
 						void *user_data);
diff --git a/android/avdtptest.c b/android/avdtptest.c
index ce39519..f7f4749 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -57,6 +57,7 @@ static uint16_t version = 0x0103;
 static guint media_player = 0;
 static guint media_recorder = 0;
 static guint idle_id = 0;
+static GSList *lseps = NULL;
 
 static bool fragment = false;
 
@@ -418,6 +419,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
+	avdtp_set_lseps(avdtp, lseps);
 	avdtp_add_disconnect_cb(avdtp, disconnect_cb, NULL);
 
 	if (preconf) {
@@ -871,6 +873,8 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
+	lseps = g_slist_append(lseps, local_sep);
+
 	if (!bacmp(&dst, BDADDR_ANY)) {
 		printf("Listening...\n");
 		io = do_listen(&err);
@@ -889,6 +893,8 @@ int main(int argc, char *argv[])
 
 	printf("Done\n");
 
+	g_slist_free(lseps);
+
 	avdtp_unref(avdtp);
 	avdtp = NULL;
 
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 471cdde..a76198a 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -509,10 +509,14 @@ static void test_server(gconstpointer data)
 					0x00, FALSE, &sep_ind, &sep_cfm,
 					context);
 
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
@@ -524,10 +528,14 @@ static void test_server_1_3(gconstpointer data)
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, NULL, context);
 
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
@@ -539,10 +547,14 @@ static void test_server_1_3_sink(gconstpointer data)
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, NULL, context);
 
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
@@ -619,7 +631,9 @@ static void test_server_seid_duplicate(gconstpointer data)
 	g_assert(sep);
 	lseps = g_slist_append(lseps, sep);
 
-	/* Check SEID ids */
+	avdtp_set_lseps(context->session, lseps);
+
+	/* Check SEID ids with DISCOVER */
 
 	g_idle_add(send_pdu, context);
 
@@ -679,10 +693,14 @@ static void test_server_frg(gconstpointer data)
 						0x00, TRUE, &sep_ind_frg,
 						NULL, context);
 
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
@@ -759,14 +777,18 @@ static void test_client(gconstpointer data)
 	struct avdtp_local_sep *sep;
 
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, NULL, &sep_cfm,
-					context);
+					0x00, FALSE, NULL, &sep_cfm, context);
+
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
@@ -776,14 +798,18 @@ static void test_client_1_3(gconstpointer data)
 	struct avdtp_local_sep *sep;
 
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, TRUE, NULL, &sep_cfm,
-					context);
+					0x00, TRUE, NULL, &sep_cfm, context);
+
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
@@ -793,14 +819,18 @@ static void test_client_frg(gconstpointer data)
 	struct avdtp_local_sep *sep;
 
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, TRUE, NULL, &sep_cfm,
-					context);
+					0x00, TRUE, NULL, &sep_cfm, context);
+
+	lseps = g_slist_append(lseps, sep);
+	avdtp_set_lseps(context->session, lseps);
+
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
 
+	lseps = g_slist_remove(lseps, sep);
 	avdtp_unregister_sep(sep);
 }
 
-- 
2.1.0

