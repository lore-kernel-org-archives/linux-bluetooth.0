Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/13 v2] AVRCP: Always create a controller player even for version 1.0
Date: Thu, 10 Jan 2013 15:37:10 +0200
Message-Id: <1357825038-21970-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since the buttons controls are now part of the MediaPlayer1 it can be used
even with AVRCP version 1.0.
---
 profiles/audio/avrcp.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3366b48..d0cc346 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1952,6 +1952,9 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 	if (session == NULL)
 		return false;
 
+	if (session->version < 0x0103)
+		return false;
+
 	attr = attr_to_val(key);
 	if (attr < 0)
 		return false;
@@ -2047,24 +2050,15 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
-	struct media_player *mp;
 	struct avrcp_header *pdu = (void *) operands;
 	uint16_t events = 0;
 	uint8_t count;
-	const char *path;
 
 	if (pdu->params[0] != CAP_EVENTS_SUPPORTED)
 		return FALSE;
 
 	count = pdu->params[1];
 
-	path = device_get_path(session->dev->btd_dev);
-
-	mp = media_player_controller_create(path);
-	if (mp == NULL)
-		return FALSE;
-
 	for (; count > 0; count--) {
 		uint8_t event = pdu->params[1 + count];
 
@@ -2079,10 +2073,6 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		}
 	}
 
-	media_player_set_callbacks(mp, &ct_cbs, player);
-	player->user_data = mp;
-	player->destroy = (GDestroyNotify) media_player_destroy;
-
 	if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
@@ -2169,6 +2159,8 @@ static void session_tg_init(struct avrcp *session)
 static void session_ct_init(struct avrcp *session)
 {
 	struct avrcp_player *player;
+	struct media_player *mp;
+	const char *path;
 
 	session->control_handlers = ct_control_handlers;
 
@@ -2179,13 +2171,22 @@ static void session_ct_init(struct avrcp *session)
 							handle_vendordep_pdu,
 							session);
 
-	if (session->version < 0x0103)
-		return;
-
 	player = g_new0(struct avrcp_player, 1);
 	player->sessions = g_slist_prepend(player->sessions, session);
 	session->player = player;
 
+	path = device_get_path(session->dev->btd_dev);
+
+	mp = media_player_controller_create(path);
+	if (mp != NULL) {
+		media_player_set_callbacks(mp, &ct_cbs, player);
+		player->user_data = mp;
+		player->destroy = (GDestroyNotify) media_player_destroy;
+	}
+
+	if (session->version < 0x0103)
+		return;
+
 	avrcp_get_capabilities(session);
 }
 
-- 
1.8.0.1

