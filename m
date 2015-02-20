Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 8/9] audio/avdtp: Move avdtp_server from avdtp SEP structures
Date: Fri, 20 Feb 2015 14:43:22 +0200
Message-Id: <1424436203-28935-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

a2dp_server and avdtp_server are handled inside a2dp_sep structure.
---
 profiles/audio/a2dp.c  | 14 ++++++++------
 profiles/audio/avdtp.c |  7 -------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2471954..8b812c3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -65,6 +65,7 @@
 
 struct a2dp_sep {
 	struct a2dp_server *server;
+	struct avdtp_server *avdtp_server;
 	struct a2dp_endpoint *endpoint;
 	uint8_t type;
 	uint8_t codec;
@@ -1251,10 +1252,10 @@ static void avdtp_server_destroy(struct avdtp_server *server)
 	g_free(server);
 }
 
-static void a2dp_clean_lsep(struct avdtp_local_sep *lsep)
+static void a2dp_clean_lsep(struct a2dp_sep *sep)
 {
-	struct avdtp_server *server = avdtp_get_server(lsep);
-
+	struct avdtp_local_sep *lsep = sep->lsep;
+	struct avdtp_server *server = sep->avdtp_server;
 
 	queue_remove(server->seps, lsep);
 	if (queue_isempty(server->seps))
@@ -1270,7 +1271,7 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 		sep->endpoint = NULL;
 	}
 
-	a2dp_clean_lsep(sep->lsep);
+	a2dp_clean_lsep(sep);
 
 	g_free(sep);
 }
@@ -1433,6 +1434,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	}
 
 	sep->server = server;
+	sep->avdtp_server = avdtp_server;
 	sep->endpoint = endpoint;
 	sep->codec = codec;
 	sep->type = type;
@@ -1454,7 +1456,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	record = a2dp_record(type);
 	if (!record) {
 		error("Unable to allocate new service record");
-		a2dp_clean_lsep(sep->lsep);
+		a2dp_clean_lsep(sep);
 		g_free(sep);
 		if (err)
 			*err = -EINVAL;
@@ -1464,7 +1466,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	if (adapter_service_add(server->adapter, record) < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
-		a2dp_clean_lsep(sep->lsep);
+		a2dp_clean_lsep(sep);
 		g_free(sep);
 		if (err)
 			*err = -EINVAL;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 39b0dd1..882e20d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -341,7 +341,6 @@ struct avdtp_local_sep {
 	struct avdtp_sep_ind *ind;
 	struct avdtp_sep_cfm *cfm;
 	void *user_data;
-	struct avdtp_server *server;
 };
 
 struct stream_callback {
@@ -3624,7 +3623,6 @@ struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 	sep->ind = ind;
 	sep->cfm = cfm;
 	sep->user_data = user_data;
-	sep->server = server;
 	sep->delay_reporting = delay_reporting;
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
@@ -3715,11 +3713,6 @@ struct btd_device *avdtp_get_device(struct avdtp *session)
 	return session->device;
 }
 
-struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep)
-{
-	return lsep->server;
-}
-
 gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 {
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
-- 
2.1.0

