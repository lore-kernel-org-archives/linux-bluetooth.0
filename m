Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/16] AVRCP: Simplify state_changed callback
Date: Mon, 15 Oct 2012 16:05:26 +0200
Message-Id: <1350309936-31588-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move session creation and destroy to their own functions
---
 audio/avrcp.c | 91 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 38 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index f31372b..7188039 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1352,15 +1352,63 @@ static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 	return NULL;
 }
 
-static void state_changed(struct audio_device *dev, avctp_state_t old_state,
-				avctp_state_t new_state, void *user_data)
+static struct avrcp *session_create(struct avrcp_server *server,
+						struct audio_device *dev)
 {
-	struct avrcp_server *server;
 	struct avrcp *session;
 	const sdp_record_t *rec;
 	sdp_list_t *list;
 	sdp_profile_desc_t *desc;
 
+	session = g_new0(struct avrcp, 1);
+	session->server = server;
+	session->conn = avctp_connect(&dev->src, &dev->dst);
+	session->dev = dev;
+	session->player = g_slist_nth_data(server->players, 0);
+
+	server->sessions = g_slist_append(server->sessions, session);
+
+	rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+	if (rec == NULL)
+		return session;
+
+	if (sdp_get_profile_descs(rec, &list) < 0)
+		return session;
+
+	desc = list->data;
+	session->version = desc->version;
+	sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES, &session->features);
+
+	sdp_list_free(list, free);
+
+	return session;
+}
+
+static void session_destroy(struct avrcp *session)
+{
+	struct avrcp_server *server = session->server;
+	struct avrcp_player *player = session->player;
+
+	server->sessions = g_slist_remove(server->sessions, session);
+
+	if (session->control_id > 0)
+		avctp_unregister_pdu_handler(session->control_id);
+
+	if (session->browsing_id > 0)
+		avctp_unregister_browsing_pdu_handler(session->browsing_id);
+
+	if (player != NULL)
+		player->sessions = g_slist_remove(player->sessions, session);
+
+	g_free(session);
+}
+
+static void state_changed(struct audio_device *dev, avctp_state_t old_state,
+				avctp_state_t new_state, void *user_data)
+{
+	struct avrcp_server *server;
+	struct avrcp *session;
+
 	server = find_server(servers, &dev->src);
 	if (!server)
 		return;
@@ -1372,47 +1420,14 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		server->sessions = g_slist_remove(server->sessions, session);
+		session_destroy(session);
 
-		if (session->control_id > 0)
-			avctp_unregister_pdu_handler(session->control_id);
-
-		if (session->browsing_id > 0)
-			avctp_unregister_browsing_pdu_handler(
-							session->browsing_id);
-
-		if (session->player != NULL)
-			session->player->sessions = g_slist_remove(
-						session->player->sessions,
-						session);
-
-		g_free(session);
 		break;
 	case AVCTP_STATE_CONNECTING:
 		if (session != NULL)
 			break;
 
-		session = g_new0(struct avrcp, 1);
-		session->server = server;
-		session->conn = avctp_connect(&dev->src, &dev->dst);
-		session->dev = dev;
-		session->player = g_slist_nth_data(server->players, 0);
-
-		server->sessions = g_slist_append(server->sessions, session);
-
-		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
-		if (rec == NULL)
-			return;
-
-		if (sdp_get_profile_descs(rec, &list) < 0)
-			return;
-
-		desc = list->data;
-		session->version = desc->version;
-		sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES,
-							&session->features);
-
-		sdp_list_free(list, free);
+		session_create(server, dev);
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-- 
1.7.11.4

