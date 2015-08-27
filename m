Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/avrcp: Fix invalid read
Date: Thu, 27 Aug 2015 16:36:03 +0300
Message-Id: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Player pointer cannot be used after being freed.
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 76e89af..fa95bf9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3942,9 +3942,10 @@ void avrcp_unregister_player(struct avrcp_player *player)
 			target->player = g_slist_nth_data(server->players, 0);
 	}
 
-	player_destroy(player);
 	avrcp_player_event(player,
 				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
+	player_destroy(player);
 }
 
 static gboolean avrcp_handle_set_volume(struct avctp *conn,
-- 
2.4.3

