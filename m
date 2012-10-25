Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/11] AVRCP: Fix not adding session to player's list of sessions
Date: Thu, 25 Oct 2012 16:59:07 +0300
Message-Id: <1351173554-28039-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the session is not added in the list if the player gets
unregistered it will not be cleared from the session which might cause a
crash if the tries to access it.
---
 audio/avrcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index a14833a..88ba3aa 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1442,10 +1442,16 @@ static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 static void session_tg_init(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
+	struct avrcp_player *player;
 
 	DBG("%p version 0x%04x", session, session->version);
 
-	session->player = g_slist_nth_data(server->players, 0);
+	player = g_slist_nth_data(server->players, 0);
+	if (player != NULL) {
+		session->player = player;
+		player->sessions = g_slist_prepend(player->sessions, session);
+	}
+
 	session->control_handlers = tg_control_handlers;
 
 	if (session->version >= 0x0104) {
-- 
1.7.11.7

