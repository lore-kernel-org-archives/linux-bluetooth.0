Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 2/6] audio/avdtp: Copy SEP list to avdtp session
Date: Tue, 24 Feb 2015 14:26:45 +0200
Message-Id: <1424780809-23449-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Copying SEP list allows to remove server usage from
find_local_sep_by_seid() and other SEP list code.
---
 profiles/audio/avdtp.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 926f01c..1a16170 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -402,6 +402,7 @@ struct avdtp {
 	guint io_id;
 
 	GSList *seps; /* Elements of type struct avdtp_remote_sep * */
+	struct queue *lseps; /* Elements of type struct avdtp_local_sep * */
 
 	GSList *streams; /* Elements of type struct avdtp_stream * */
 
@@ -1222,10 +1223,10 @@ static bool match_by_seid(const void *data, const void *user_data)
 	return sep->info.seid == seid;
 }
 
-static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp_server *server,
+static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
 								uint8_t seid)
 {
-	return queue_find(server->seps, match_by_seid, INT_TO_PTR(seid));
+	return queue_find(session->lseps, match_by_seid, INT_TO_PTR(seid));
 }
 
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
@@ -1329,7 +1330,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	struct seid_info *seps, *p;
 	gboolean ret;
 
-	sep_count = queue_length(session->server->seps);
+	sep_count = queue_length(session->lseps);
 
 	if (sep_count == 0) {
 		uint8_t err = AVDTP_NOT_SUPPORTED_COMMAND;
@@ -1342,7 +1343,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	seps = g_new0(struct seid_info, sep_count);
 	p = seps;
 
-	queue_foreach(session->server->seps, copy_seps, &p);
+	queue_foreach(session->lseps, copy_seps, &p);
 
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 				AVDTP_DISCOVER, seps, rsp_size);
@@ -1368,7 +1369,7 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1445,7 +1446,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1560,7 +1561,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 
 	memset(buf, 0, sizeof(buf));
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1676,7 +1677,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1736,8 +1737,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session->server,
-					req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1787,7 +1787,7 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1848,8 +1848,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session->server,
-					req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1896,7 +1895,7 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream)
 		return TRUE;
 
@@ -1934,7 +1933,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -2396,6 +2395,7 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
 
 	server->sessions = g_slist_append(server->sessions, session);
 
+	session->lseps = server->seps;
 	if (!chan)
 		return session;
 
-- 
2.1.0

