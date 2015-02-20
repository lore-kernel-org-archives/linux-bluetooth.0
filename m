Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 6/9] audio/avdtp: Replace GSList with queue for SEP list
Date: Fri, 20 Feb 2015 14:43:20 +0200
Message-Id: <1424436203-28935-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/a2dp.c  |  7 ++++---
 profiles/audio/avdtp.c | 51 +++++++++++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 33e66a7..1ecbf3a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -45,6 +45,7 @@
 #include "src/service.h"
 #include "src/log.h"
 #include "src/sdpd.h"
+#include "src/shared/queue.h"
 
 #include "btio/btio.h"
 
@@ -117,7 +118,7 @@ struct a2dp_server {
 struct avdtp_server {
 	struct btd_adapter *adapter;
 	GIOChannel *io;
-	GSList *seps;
+	struct queue *seps;
 	GSList *sessions;
 };
 
@@ -1239,8 +1240,8 @@ static void a2dp_clean_lsep(struct avdtp_local_sep *lsep)
 	struct avdtp_server *server = avdtp_get_server(lsep);
 
 
-	server->seps = g_slist_remove(server->seps, lsep);
-	if (!server->seps)
+	queue_remove(server->seps, lsep);
+	if (queue_isempty(server->seps))
 		avdtp_server_destroy(server);
 
 	avdtp_unregister_sep(lsep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 7b43613..4d0b506 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -42,6 +42,7 @@
 
 #include "src/log.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "btio/btio.h"
 #include "lib/uuid.h"
@@ -326,7 +327,7 @@ struct avdtp_remote_sep {
 struct avdtp_server {
 	struct btd_adapter *adapter;
 	GIOChannel *io;
-	GSList *seps;
+	struct queue *seps;
 	GSList *sessions;
 };
 
@@ -1228,19 +1229,18 @@ struct avdtp *avdtp_ref(struct avdtp *session)
 	return session;
 }
 
-static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp_server *server,
-							uint8_t seid)
+static bool match_by_seid(const void *data, const void *user_data)
 {
-	GSList *l;
-
-	for (l = server->seps; l != NULL; l = g_slist_next(l)) {
-		struct avdtp_local_sep *sep = l->data;
+	const struct avdtp_local_sep *sep = data;
+	uint8_t seid = PTR_TO_UINT(user_data);
 
-		if (sep->info.seid == seid)
-			return sep;
-	}
+	return sep->info.seid == seid;
+}
 
-	return NULL;
+static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp_server *server,
+								uint8_t seid)
+{
+	return queue_find(server->seps, match_by_seid, INT_TO_PTR(seid));
 }
 
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
@@ -1328,15 +1328,23 @@ static gboolean avdtp_unknown_cmd(struct avdtp *session, uint8_t transaction,
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
 
-	sep_count = g_slist_length(session->server->seps);
+	sep_count = queue_length(session->server->seps);
 
 	if (sep_count == 0) {
 		uint8_t err = AVDTP_NOT_SUPPORTED_COMMAND;
@@ -1347,12 +1355,9 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	rsp_size = sep_count * sizeof(struct seid_info);
 
 	seps = g_new0(struct seid_info, sep_count);
+	p = seps;
 
-	for (l = session->server->seps, i = 0; l != NULL; l = l->next, i++) {
-		struct avdtp_local_sep *sep = l->data;
-
-		memcpy(&seps[i], &sep->info, sizeof(struct seid_info));
-	}
+	queue_foreach(session->server->seps, copy_seps, &p);
 
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 				AVDTP_DISCOVER, seps, rsp_size);
@@ -3675,7 +3680,11 @@ struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
-	server->seps = g_slist_append(server->seps, sep);
+
+	if (!queue_push_tail(server->seps, sep)) {
+		g_free(sep);
+		return NULL;
+	}
 
 	return sep;
 }
-- 
2.1.0

