Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 7/8] android/avdtp: Refactor local SEP list handling
Date: Fri, 13 Feb 2015 16:52:48 +0200
Message-Id: <1423839169-8944-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423839169-8944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423839169-8944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In order to deduplicate similar code in android/ and profiles/ we need
to handle local SEP list outside of avdtp.c.
---
 android/Makefile.am |   1 +
 android/a2dp.c      |  15 +++++--
 android/avdtp.c     |  93 +++++++++++++++++++++++++++---------------
 android/avdtp.h     |  10 +++--
 android/avdtptest.c |  10 ++++-
 unit/test-avdtp.c   | 115 +++++++++++++++++++++++++++++++++-------------------
 6 files changed, 161 insertions(+), 83 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index ebbb28e..ecf97c0 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -103,6 +103,7 @@ android_avdtptest_SOURCES = android/avdtptest.c \
 				src/log.h src/log.c \
 				btio/btio.h btio/btio.c \
 				src/shared/util.h src/shared/util.c \
+				src/shared/queue.h src/shared/queue.c \
 				android/avdtp.h android/avdtp.c
 android_avdtptest_CFLAGS = $(AM_CFLAGS)
 android_avdtptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
diff --git a/android/a2dp.c b/android/a2dp.c
index 10f5523..c8baf56 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -38,6 +38,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "profiles/audio/a2dp-codecs.h"
+#include "src/shared/queue.h"
 #include "src/log.h"
 #include "hal-msg.h"
 #include "ipc-common.h"
@@ -52,6 +53,7 @@
 #define SVC_HINT_CAPTURING 0x08
 #define IDLE_TIMEOUT 1
 #define AUDIO_RETRY_TIMEOUT 2
+#define MAX_SEID 0x3E
 
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
@@ -65,6 +67,8 @@ static bool audio_retrying = false;
 static struct ipc *hal_ipc = NULL;
 static struct ipc *audio_ipc = NULL;
 
+static struct queue *lseps = NULL;
+
 struct a2dp_preset {
 	void *data;
 	int8_t len;
@@ -115,7 +119,7 @@ static void unregister_endpoint(void *data)
 	struct a2dp_endpoint *endpoint = data;
 
 	if (endpoint->sep)
-		avdtp_unregister_sep(endpoint->sep);
+		avdtp_unregister_sep(lseps, endpoint->sep);
 
 	if (endpoint->caps)
 		preset_free(endpoint->caps);
@@ -620,6 +624,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 							gpointer user_data)
 {
 	struct a2dp_device *dev = user_data;
+	struct avdtp *session;
 	uint16_t imtu, omtu;
 	GError *gerr = NULL;
 	int fd;
@@ -643,10 +648,12 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	fd = g_io_channel_unix_get_fd(chan);
 
 	/* FIXME: Add proper version */
-	dev->session = avdtp_new(fd, imtu, omtu, 0x0100);
-	if (!dev->session)
+	session = avdtp_new(fd, imtu, omtu, 0x0100, lseps);
+	if (!session)
 		goto failed;
 
+	dev->session = session;
+
 	avdtp_add_disconnect_cb(dev->session, disconnect_cb, dev);
 
 	/* Proceed to stream setup if initiator */
@@ -1327,7 +1334,7 @@ static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
 	endpoint = g_new0(struct a2dp_endpoint, 1);
 	endpoint->id = g_slist_length(endpoints) + 1;
 	endpoint->codec = codec;
-	endpoint->sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE,
+	endpoint->sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SOURCE,
 						AVDTP_MEDIA_TYPE_AUDIO,
 						codec, FALSE, &sep_ind,
 						&sep_cfm, endpoint);
diff --git a/android/avdtp.c b/android/avdtp.c
index a601457..4e607eb 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -42,6 +42,7 @@
 #include "lib/bluetooth.h"
 #include "src/log.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "avdtp.h"
 #include "../profiles/audio/a2dp-codecs.h"
 
@@ -383,6 +384,7 @@ struct avdtp {
 	guint io_id;
 
 	GSList *seps; /* Elements of type struct avdtp_remote_sep * */
+	struct queue *lseps; /* Elements of type struct avdtp_local_sep * */
 
 	GSList *streams; /* Elements of type struct avdtp_stream * */
 
@@ -406,8 +408,6 @@ struct avdtp {
 	bool shutdown;
 };
 
-static GSList *lseps = NULL;
-
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
 			void *buffer, size_t size);
@@ -993,6 +993,9 @@ static void avdtp_free(void *data)
 	g_slist_free_full(session->seps, sep_free);
 	g_slist_free_full(session->disconnect, g_free);
 
+	/* Free copy of the SEP list */
+	session->lseps = NULL;
+
 	g_free(session->buf);
 
 	g_free(session);
@@ -1050,18 +1053,18 @@ struct avdtp *avdtp_ref(struct avdtp *session)
 	return session;
 }
 
-static struct avdtp_local_sep *find_local_sep_by_seid(uint8_t seid)
+static bool match_by_seid(const void *data, const void *user_data)
 {
-	GSList *l;
+	const struct avdtp_local_sep *sep = data;
+	uint8_t seid = PTR_TO_UINT(user_data);
 
-	for (l = lseps; l != NULL; l = g_slist_next(l)) {
-		struct avdtp_local_sep *sep = l->data;
-
-		if (sep->info.seid == seid)
-			return sep;
-	}
+	return sep->info.seid == seid;
+}
 
-	return NULL;
+static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
+								uint8_t seid)
+{
+	return queue_find(session->lseps, match_by_seid, INT_TO_PTR(seid));
 }
 
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
@@ -1161,15 +1164,23 @@ static gboolean avdtp_unknown_cmd(struct avdtp *session, uint8_t transaction,
 							signal_id, NULL, 0);
 }
 
+static void copy_seps(void *data, void *user_data)
+{
+	struct avdtp_local_sep *sep = data;
+	struct seid_info **p = user_data;
+
+	memcpy(*p, &sep->info, sizeof(struct seid_info));
+	*p = *p + 1;
+}
+
 static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 							void *buf, int size)
 {
-	GSList *l;
-	unsigned int rsp_size, sep_count, i;
-	struct seid_info *seps;
+	unsigned int rsp_size, sep_count;
+	struct seid_info *seps, *p;
 	gboolean ret;
 
-	sep_count = g_slist_length(lseps);
+	sep_count = queue_length(session->lseps);
 
 	if (sep_count == 0) {
 		uint8_t err = AVDTP_NOT_SUPPORTED_COMMAND;
@@ -1180,13 +1191,17 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	rsp_size = sep_count * sizeof(struct seid_info);
 
 	seps = g_new0(struct seid_info, sep_count);
+	p = seps;
 
-	for (l = lseps, i = 0; l != NULL; l = l->next, i++) {
+	queue_foreach(session->lseps, copy_seps, &p);
+
+#if 0
+	for (l = session->lseps, i = 0; l != NULL; l = l->next, i++) {
 		struct avdtp_local_sep *sep = l->data;
 
 		memcpy(&seps[i], &sep->info, sizeof(struct seid_info));
 	}
-
+#endif
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 				AVDTP_DISCOVER, seps, rsp_size);
 	g_free(seps);
@@ -1211,7 +1226,7 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1293,7 +1308,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1381,7 +1396,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 
 	memset(buf, 0, sizeof(buf));
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1497,7 +1512,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1557,7 +1572,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1607,7 +1622,7 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1668,7 +1683,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1715,7 +1730,7 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream)
 		return TRUE;
 
@@ -1753,7 +1768,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -2105,7 +2120,8 @@ static int set_priority(int fd, int priority)
 	return err;
 }
 
-struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
+struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version,
+							struct queue *lseps)
 {
 	struct avdtp *session;
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
@@ -2138,9 +2154,16 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 						(GIOFunc) session_cb, session,
 						NULL);
 
+	session->lseps = lseps;
+
 	return avdtp_ref(session);
 }
 
+void avdtp_set_lseps(struct avdtp *session, struct queue *lseps)
+{
+	session->lseps = lseps;
+}
+
 unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						avdtp_disconnect_cb_t cb,
 						void *user_data)
@@ -3344,7 +3367,8 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
+struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
+						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
 						struct avdtp_sep_ind *ind,
@@ -3357,7 +3381,7 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	if (!seid)
 		return NULL;
 
-	if (g_slist_length(lseps) > MAX_SEID)
+	if (queue_length(lseps) > MAX_SEID)
 		return NULL;
 
 	sep = g_new0(struct avdtp_local_sep, 1);
@@ -3374,7 +3398,11 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
-	lseps = g_slist_append(lseps, sep);
+
+	if (!queue_push_tail(lseps, sep)) {
+		g_free(sep);
+		return NULL;
+	}
 
 	return sep;
 }
@@ -3386,13 +3414,11 @@ void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
 	sep->vndcodec_codec = codec_id;
 }
 
-int avdtp_unregister_sep(struct avdtp_local_sep *sep)
+int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
 {
 	if (!sep)
 		return -EINVAL;
 
-	lseps = g_slist_remove(lseps, sep);
-
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
 
@@ -3400,6 +3426,7 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 			sep->info.type, sep->codec, sep->info.seid);
 
 	util_clear_bitmap64(&seids, sep->info.seid);
+	queue_remove(lseps, sep);
 	g_free(sep);
 
 	return 0;
diff --git a/android/avdtp.h b/android/avdtp.h
index d5335e4..f560924 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -205,7 +205,10 @@ typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 typedef void (*avdtp_disconnect_cb_t) (void *user_data);
 
-struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
+struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version,
+							struct queue *lseps);
+
+void avdtp_set_lseps(struct avdtp *session, struct queue *lseps);
 
 unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						avdtp_disconnect_cb_t cb,
@@ -265,7 +268,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
+struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
+						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
 						struct avdtp_sep_ind *ind,
@@ -278,7 +282,7 @@ void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep);
 
-int avdtp_unregister_sep(struct avdtp_local_sep *sep);
+int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep);
 
 avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
 
diff --git a/android/avdtptest.c b/android/avdtptest.c
index ce39519..6529423 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -40,6 +40,7 @@
 
 #include "src/shared/util.h"
 #include "btio/btio.h"
+#include "src/shared/queue.h"
 #include "avdtp.h"
 
 static GMainLoop *mainloop = NULL;
@@ -57,6 +58,7 @@ static uint16_t version = 0x0103;
 static guint media_player = 0;
 static guint media_recorder = 0;
 static guint idle_id = 0;
+static struct queue *lseps = NULL;
 
 static bool fragment = false;
 
@@ -411,7 +413,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	avdtp = avdtp_new(fd, imtu, omtu, version);
+	avdtp = avdtp_new(fd, imtu, omtu, version, lseps);
 	if (!avdtp) {
 		printf("Failed to create avdtp instance\n");
 		g_main_loop_quit(mainloop);
@@ -864,13 +866,15 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	local_sep = avdtp_register_sep(dev_role, AVDTP_MEDIA_TYPE_AUDIO,
+	local_sep = avdtp_register_sep(lseps, dev_role, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, &sep_cfm, NULL);
 	if (!local_sep) {
 		printf("Failed to register sep\n");
 		exit(0);
 	}
 
+	queue_push_tail(lseps, local_sep);
+
 	if (!bacmp(&dst, BDADDR_ANY)) {
 		printf("Listening...\n");
 		io = do_listen(&err);
@@ -889,6 +893,8 @@ int main(int argc, char *argv[])
 
 	printf("Done\n");
 
+	queue_destroy(lseps, NULL);
+
 	avdtp_unref(avdtp);
 	avdtp = NULL;
 
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 87c1c3a..0f59061 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -36,13 +36,12 @@
 #include <glib.h>
 
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/log.h"
 #include "android/avdtp.h"
 
 #define MAX_SEID 0x3E
 
-GSList *lseps = NULL;
-
 struct test_pdu {
 	bool valid;
 	bool fragmented;
@@ -233,7 +232,7 @@ static struct context *context_new(uint16_t version, uint16_t imtu,
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
-	context->session = avdtp_new(sv[0], imtu, omtu, version);
+	context->session = avdtp_new(sv[0], imtu, omtu, version, NULL);
 	g_assert(context->session != NULL);
 
 	channel = g_io_channel_unix_new(sv[1]);
@@ -503,47 +502,62 @@ static struct avdtp_sep_cfm sep_cfm = {
 static void test_server(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SOURCE,
+					AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, FALSE, &sep_ind, &sep_cfm,
 					context);
 
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 static void test_server_1_3(gconstpointer data)
 {
 	struct context *context = create_context(0x0103, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SOURCE,
+					AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, NULL, context);
 
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 static void test_server_1_3_sink(gconstpointer data)
 {
 	struct context *context = create_context(0x0103, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
+					AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, NULL, context);
 
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 static void test_server_0_sep(gconstpointer data)
@@ -559,75 +573,74 @@ static void unregister_sep(void *data)
 {
 	struct avdtp_local_sep *sep = data;
 
-	avdtp_unregister_sep(sep);
+	/* Removed from the queue by caller */
+	avdtp_unregister_sep(NULL, sep);
 }
 
 static void test_server_seid(gconstpointer data)
 {
 	struct context *context = create_context(0x0103, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 	int i;
 
 	for (i = 0; i < MAX_SEID; i++) {
-		sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+		sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
 						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind, NULL,
 						context);
 		g_assert(sep);
-
-		lseps = g_slist_append(lseps, sep);
 	}
 
 	/* Now add (MAX_SEID + 1) SEP -> it shall fail */
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
 						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind, NULL,
 						context);
 	g_assert(!sep);
 
 	/* Remove all SEPs */
-	g_slist_free_full(lseps, unregister_sep);
-	lseps = NULL;
+	queue_destroy(lseps, unregister_sep);
 }
 
 static void test_server_seid_duplicate(gconstpointer data)
 {
 	struct context *context = create_context(0x0103, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 	int i;
 
 	for (i = 0; i < 2; i++) {
-		sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+		sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
 						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind, NULL,
 						context);
 		g_assert(sep);
-
-		lseps = g_slist_append(lseps, sep);
 	}
 
 	/* Remove 1st element */
-	sep = g_slist_nth_data(lseps, 0);
-	lseps = g_slist_remove(lseps, sep);
-	avdtp_unregister_sep(sep);
+	sep = queue_peek_head(lseps);
+	g_assert(sep);
+
+	avdtp_unregister_sep(lseps, sep);
 
 	/* Now register new element */
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
 						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind, NULL,
 						context);
 	g_assert(sep);
-	lseps = g_slist_append(lseps, sep);
 
-	/* Check SEID ids */
+	avdtp_set_lseps(context->session, lseps);
+
+	/* Check SEID ids with DISCOVER */
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
 	/* Remove all SEPs */
-	g_slist_free_full(lseps, unregister_sep);
-	lseps = NULL;
+	queue_destroy(lseps, unregister_sep);
 }
 
 static gboolean sep_getcap_ind_frg(struct avdtp *session,
@@ -673,17 +686,22 @@ static struct avdtp_sep_ind sep_ind_frg = {
 static void test_server_frg(gconstpointer data)
 {
 	struct context *context = context_new(0x0100, 48, 48, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SOURCE,
+						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind_frg,
 						NULL, context);
 
+	avdtp_set_lseps(context->session, lseps);
+
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
@@ -756,52 +774,67 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, NULL, &sep_cfm,
-					context);
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
+					AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, FALSE, NULL, &sep_cfm, context);
+
+	avdtp_set_lseps(context->session, lseps);
+
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 static void test_client_1_3(gconstpointer data)
 {
 	struct context *context = create_context(0x0103, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, TRUE, NULL, &sep_cfm,
-					context);
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
+					AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, TRUE, NULL, &sep_cfm, context);
+
+	avdtp_set_lseps(context->session, lseps);
+
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 static void test_client_frg(gconstpointer data)
 {
 	struct context *context = context_new(0x0100, 48, 48, data);
+	struct queue *lseps = queue_new();
 	struct avdtp_local_sep *sep;
 
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, TRUE, NULL, &sep_cfm,
-					context);
+	sep = avdtp_register_sep(lseps, AVDTP_SEP_TYPE_SINK,
+					AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, TRUE, NULL, &sep_cfm, context);
+
+	avdtp_set_lseps(context->session, lseps);
+
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
 
-	avdtp_unregister_sep(sep);
+	avdtp_unregister_sep(lseps, sep);
+	queue_destroy(lseps, NULL);
 }
 
 int main(int argc, char *argv[])
-- 
2.1.0

