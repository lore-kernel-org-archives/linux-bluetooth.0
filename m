Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Bump A2DP version to 1.03
Date: Fri, 16 Nov 2012 15:11:53 +0200
Message-Id: <1353071513-32182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In addition remove support of setting DelayReporting in audio.conf as
it should always be supported in the service record since it doesn't
mean the endpoint must support it because it is actually negotiated
during the stream configuration.
---
 profiles/audio/a2dp.c  | 19 ++++---------------
 profiles/audio/avdtp.c | 20 +++-----------------
 profiles/audio/avdtp.h |  2 +-
 3 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 7799420..50c0f43 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -109,7 +109,6 @@ struct a2dp_server {
 	GSList *sources;
 	uint32_t source_record_id;
 	uint32_t sink_record_id;
-	uint16_t version;
 	gboolean sink_enabled;
 	gboolean source_enabled;
 };
@@ -1087,7 +1086,7 @@ static struct avdtp_sep_ind endpoint_ind = {
 	.delayreport		= endpoint_delayreport_ind,
 };
 
-static sdp_record_t *a2dp_record(uint8_t type, uint16_t avdtp_ver)
+static sdp_record_t *a2dp_record(uint8_t type)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, l2cap_uuid, avdtp_uuid, a2dp_uuid;
@@ -1096,7 +1095,7 @@ static sdp_record_t *a2dp_record(uint8_t type, uint16_t avdtp_ver)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVDTP_UUID;
-	uint16_t a2dp_ver = 0x0102, feat = 0x000f;
+	uint16_t a2dp_ver = 0x0103, avdtp_ver = 0x0103, feat = 0x000f;
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -1170,7 +1169,6 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 int a2dp_register(const bdaddr_t *src, GKeyFile *config)
 {
 	gboolean source = TRUE, sink = FALSE;
-	gboolean delay_reporting = FALSE;
 	char *str;
 	GError *err = NULL;
 	struct a2dp_server *server;
@@ -1212,7 +1210,7 @@ proceed:
 
 		server = g_new0(struct a2dp_server, 1);
 
-		av_err = avdtp_init(src, config, &server->version);
+		av_err = avdtp_init(src, config);
 		if (av_err < 0) {
 			g_free(server);
 			return av_err;
@@ -1222,15 +1220,6 @@ proceed:
 		servers = g_slist_append(servers, server);
 	}
 
-	if (config)
-		delay_reporting = g_key_file_get_boolean(config, "A2DP",
-						"DelayReporting", NULL);
-
-	if (delay_reporting)
-		server->version = 0x0103;
-	else
-		server->version = 0x0102;
-
 	server->source_enabled = source;
 
 	server->sink_enabled = sink;
@@ -1341,7 +1330,7 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 	if (*record_id != 0)
 		goto add;
 
-	record = a2dp_record(type, server->version);
+	record = a2dp_record(type);
 	if (!record) {
 		error("Unable to allocate new service record");
 		avdtp_unregister_sep(sep->lsep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 75b81fe..e38c95b 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -331,7 +331,6 @@ struct avdtp_remote_sep {
 
 struct avdtp_server {
 	bdaddr_t src;
-	uint16_t version;
 	GIOChannel *io;
 	GSList *seps;
 	GSList *sessions;
@@ -1392,9 +1391,6 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	if (get_all && session->server->version < 0x0103)
-		return avdtp_unknown_cmd(session, transaction, cmd);
-
 	if (!sep->ind->get_capability(session, sep, get_all, &caps,
 							&err, sep->user_data))
 		goto failed;
@@ -2785,7 +2781,7 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 	int ret = 0;
 	gboolean getcap_pending = FALSE;
 
-	if (session->version >= 0x0103 && session->server->version >= 0x0103)
+	if (session->version >= 0x0103)
 		getcap_cmd = AVDTP_GET_ALL_CAPABILITIES;
 	else
 		getcap_cmd = AVDTP_GET_CAPABILITIES;
@@ -3717,8 +3713,7 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 				stream->lsep->state != AVDTP_STATE_STREAMING)
 		return -EINVAL;
 
-	if (!stream->delay_reporting || session->version < 0x0103 ||
-					session->server->version < 0x0103)
+	if (!stream->delay_reporting || session->version < 0x0103)
 		return -EINVAL;
 
 	stream->delay = delay;
@@ -3868,12 +3863,11 @@ void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst)
 		bacpy(dst, &session->dst);
 }
 
-int avdtp_init(const bdaddr_t *src, GKeyFile *config, uint16_t *version)
+int avdtp_init(const bdaddr_t *src, GKeyFile *config)
 {
 	GError *err = NULL;
 	gboolean tmp, master = TRUE;
 	struct avdtp_server *server;
-	uint16_t ver = 0x0102;
 
 	if (!config)
 		goto proceed;
@@ -3893,17 +3887,9 @@ int avdtp_init(const bdaddr_t *src, GKeyFile *config, uint16_t *version)
 	else
 		auto_connect = tmp;
 
-	if (g_key_file_get_boolean(config, "A2DP", "DelayReporting", NULL))
-		ver = 0x0103;
-
 proceed:
 	server = g_new0(struct avdtp_server, 1);
 
-	server->version = ver;
-
-	if (version)
-		*version = server->version;
-
 	server->io = avdtp_server_socket(src, master);
 	if (!server->io) {
 		g_free(server);
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 7b330b9..cdf39bf 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -309,5 +309,5 @@ void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst);
 gboolean avdtp_stream_setup_active(struct avdtp *session);
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
 
-int avdtp_init(const bdaddr_t *src, GKeyFile *config, uint16_t *version);
+int avdtp_init(const bdaddr_t *src, GKeyFile *config);
 void avdtp_exit(const bdaddr_t *src);
-- 
1.7.11.7

