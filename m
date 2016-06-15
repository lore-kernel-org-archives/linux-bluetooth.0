Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio/avrcp: Fix crash if no player is available
Date: Wed, 15 Jun 2016 15:26:37 +0300
Message-Id: <1465993598-30695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It seems some Samsung Android devices may actually report no players
at all causing the following crash:

Program terminated with signal 11, Segmentation fault.
  #0  set_ct_player (player=0x0, session=<value optimized out>)
    at profiles/audio/avrcp.c:3139
  #1  0xb76c0aab in player_remove (data=0xb849a100)
    at profiles/audio/avrcp.c:3278
---
 profiles/audio/avrcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 6c8ed81..c100149 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3200,7 +3200,8 @@ static void set_ct_player(struct avrcp *session, struct avrcp_player *player)
 
 	session->controller->player = player;
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
-	control_set_player(service, media_player_get_path(player->user_data));
+	control_set_player(service, player ?
+			media_player_get_path(player->user_data) : NULL);
 }
 
 static struct avrcp_player *create_ct_player(struct avrcp *session,
@@ -3330,6 +3331,10 @@ static void player_remove(gpointer data)
 	struct avrcp_player *player = data;
 	GSList *l;
 
+	/* Don't remove reserved player */
+	if (!player->id)
+		return;
+
 	for (l = player->sessions; l; l = l->next) {
 		struct avrcp *session = l->data;
 		struct avrcp_data *controller = session->controller;
@@ -3393,6 +3398,10 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 
 	g_slist_free_full(removed, player_remove);
 
+	/* There should always be an active player */
+	if (!session->controller->player)
+		create_ct_player(session, 0);
+
 	return FALSE;
 }
 
-- 
2.5.5

