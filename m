Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 06/14] AVRCP: Keep AVRCP version of connected device in session
Date: Wed, 27 Jun 2012 15:27:40 +0200
Message-ID: <1340803668-31686-6-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This can be used to improve compatibility between
AVRCP 1.3 vs AVRCP 1.4 devices and implementation in stack.
---
 audio/avrcp.c |   42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 64f6086..4e3b641 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -158,12 +158,18 @@ struct avrcp_header {
 #define AVRCP_MTU	(AVC_MTU - AVC_HEADER_LENGTH)
 #define AVRCP_PDU_MTU	(AVRCP_MTU - AVRCP_HEADER_LENGTH)
 
+struct avrcp_session {
+	uint16_t version_tg;
+	uint16_t version_ct;
+};
+
 struct avrcp_server {
 	bdaddr_t src;
 	uint32_t tg_record_id;
 	uint32_t ct_record_id;
 	GSList *players;
 	struct avrcp_player *addressed_player;
+	struct avrcp_session session;
 };
 
 struct pending_pdu {
@@ -1209,7 +1215,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 {
 	struct avrcp_server *server;
 	struct avrcp_player *player;
-	const sdp_record_t *rec;
+	const sdp_record_t *rec_tg, *rec_ct;
 	sdp_list_t *list;
 	sdp_profile_desc_t *desc;
 
@@ -1244,19 +1250,32 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							player);
 		break;
 	case AVCTP_STATE_CONNECTED:
-		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
-		if (rec == NULL)
-			return;
+		rec_tg = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+		rec_ct = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
+
+		if (rec_tg && sdp_get_profile_descs(rec_tg, &list) >= 0) {
+			desc = list->data;
+			if (desc)
+				server->session.version_tg = desc->version;
+			else
+				server->session.version_tg = AVRCP_VERSION_UNKNOWN;
+			sdp_list_free(list, free);
+		}
 
-		if (sdp_get_profile_descs(rec, &list) < 0)
-			return;
+		if (rec_ct && sdp_get_profile_descs(rec_ct, &list) >= 0) {
+			desc = list->data;
+			if (desc)
+				server->session.version_ct = desc->version;
+			else
+				server->session.version_ct = AVRCP_VERSION_UNKNOWN;
+			sdp_list_free(list, free);
+		}
 
-		desc = list->data;
+		DBG("Remote Controller TG version: 0x%03x", server->session.version_tg);
+		DBG("Remote Controller CT version: 0x%03x", server->session.version_ct);
 
-		if (desc && desc->version >= AVRCP_VERSION_1_4)
+		if (server->session.version_tg >= AVRCP_VERSION_1_4)
 			register_volume_notification(player);
-
-		sdp_list_free(list, free);
 	default:
 		return;
 	}
@@ -1344,6 +1363,9 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 
 	bacpy(&server->src, src);
 
+	server->session.version_tg = AVRCP_VERSION_UNKNOWN;
+	server->session.version_ct = AVRCP_VERSION_UNKNOWN;
+
 	servers = g_slist_append(servers, server);
 
 	return 0;
-- 
on behalf of ST-Ericsson

