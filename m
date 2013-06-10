Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/15] AVRCP: Fix crash when current addressed player is removed
Date: Mon, 10 Jun 2013 13:37:01 +0300
Message-Id: <1370860630-30359-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In some stacks e.g. iOS the addressed player is removed before a new
player is set which leaves the session poiting to invalid player.

Moreover there is a race where both GetFolderItems and
RegisterNotification are pending on browsing and control channel
repectively, if RegisterNotification completes before GetFolderItems it
might cause an unknown player id to be set which would be discarded.

To overcome the race the browsing channel now has higher priority for
both sending and receiving.
---
 profiles/audio/avctp.c | 15 ++++++++++-----
 profiles/audio/avrcp.c | 21 +++++++++++++++++++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index a4d0153..33f344f 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -820,8 +820,10 @@ static void browsing_response(struct avctp_channel *browsing,
 		browsing->p = NULL;
 
 		if (browsing->process_id == 0)
-			browsing->process_id = g_idle_add(process_queue,
-								browsing);
+			browsing->process_id = g_idle_add_full(
+							G_PRIORITY_HIGH_IDLE,
+							process_queue,
+							browsing, NULL);
 	}
 
 	for (l = browsing->processed; l; l = l->next) {
@@ -1149,9 +1151,10 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	session->browsing->imtu = imtu;
 	session->browsing->omtu = omtu;
 	session->browsing->buffer = g_malloc0(MAX(imtu, omtu));
-	session->browsing->watch = g_io_add_watch(session->browsing->io,
+	session->browsing->watch = g_io_add_watch_full(session->browsing->io,
+				G_PRIORITY_HIGH,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) session_browsing_cb, session);
+				(GIOFunc) session_browsing_cb, session, NULL);
 
 	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED);
 	return;
@@ -1566,7 +1569,9 @@ int avctp_send_browsing_req(struct avctp *session,
 	g_queue_push_tail(browsing->queue, p);
 
 	if (browsing->process_id == 0)
-		browsing->process_id = g_idle_add(process_queue, browsing);
+		browsing->process_id = g_idle_add_full(G_PRIORITY_HIGH_IDLE,
+							process_queue,
+							browsing, NULL);
 
 	return 0;
 }
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e7ce9b5..66ab2b4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2424,6 +2424,20 @@ static void player_destroy(gpointer data)
 	g_free(player);
 }
 
+static void player_remove(gpointer data)
+{
+	struct avrcp_player *player = data;
+	GSList *l;
+
+	for (l = player->sessions; l; l = l->next) {
+		struct avrcp *session = l->data;
+
+		session->players = g_slist_remove(session->players, player);
+	}
+
+	player_destroy(player);
+}
+
 static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 						uint8_t *operands,
 						size_t operand_count,
@@ -2469,7 +2483,10 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 		i += len;
 	}
 
-	g_slist_free_full(removed, player_destroy);
+	if (g_slist_find(removed, session->player))
+		session->player = NULL;
+
+	g_slist_free_full(removed, player_remove);
 
 	return FALSE;
 }
@@ -2570,7 +2587,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	struct avrcp_player *player = session->player;
 	uint16_t id = bt_get_be16(&pdu->params[1]);
 
-	if (player->id == id)
+	if (player != NULL && player->id == id)
 		return;
 
 	player = find_ct_player(session, id);
-- 
1.8.1.4

