Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 04/13] AVRCP: Keep AVRCP version of connected device in server
Date: Wed, 6 Jun 2012 18:06:02 +0200
Message-ID: <1338998771-18683-4-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This can be used to improve compatibility between
AVRCP 1.3 vs AVRCP 1.4 devices and implementation in stack.
---
 audio/avrcp.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 7576e19..9ff0700 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -200,6 +200,7 @@ struct avrcp_server {
 	uint32_t ct_record_id;
 	GSList *players;
 	struct avrcp_player *addressed_player;
+	uint16_t version;
 };
 
 struct pending_pdu {
@@ -1288,8 +1289,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			return;
 
 		desc = list->data;
+		if (desc)
+			server->version = desc->version;
+		else
+			server->version = AVRCP_VERSION_UNKNOWN;
 
-		if (desc && desc->version >= AVRCP_VERSION_1_4)
+		if (server->version >= AVRCP_VERSION_1_4)
 			register_volume_notification(player);
 
 		sdp_list_free(list, free);
@@ -1380,6 +1385,8 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 
 	bacpy(&server->src, src);
 
+	server->version = AVRCP_VERSION_UNKNOWN;
+
 	servers = g_slist_append(servers, server);
 
 	return 0;
-- 
on behalf of ST-Ericsson

