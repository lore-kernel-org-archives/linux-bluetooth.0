Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] AVRCP: Register to AVCTP state changes without depending on player
Date: Fri,  5 Oct 2012 23:20:47 +0200
Message-Id: <1349472050-25928-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
References: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is not longer necessary to have a player to be able to register the
extra pdu handlers.
---
 audio/avrcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index aa62987..295a1e1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1467,6 +1467,9 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 
 	servers = g_slist_append(servers, server);
 
+	if (!avctp_id)
+		avctp_id = avctp_add_state_cb(state_changed, NULL);
+
 	return 0;
 }
 
@@ -1528,9 +1531,6 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 	player->user_data = user_data;
 	player->destroy = destroy;
 
-	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(state_changed, NULL);
-
 	server->players = g_slist_append(server->players, player);
 
 	/* Assign player to session without current player */
-- 
1.7.11.4

