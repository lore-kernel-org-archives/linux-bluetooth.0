Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Subject: [PATCH 1/1] audio/avrcp: Assign player id during player registration
Date: Wed, 21 Jan 2015 16:24:22 +0530
Message-id: <1421837662-25727-1-git-send-email-s.nageshmurt@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 11de6ee..d258c28 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3662,6 +3662,7 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 	struct avrcp_server *server;
 	struct avrcp_player *player;
 	GSList *l;
+	static uint16_t id = 0;
 
 	server = find_server(servers, adapter);
 	if (!server)
@@ -3672,6 +3673,7 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 	player->cb = cb;
 	player->user_data = user_data;
 	player->destroy = destroy;
+	player->id = ++id;
 
 	server->players = g_slist_append(server->players, player);
 
-- 
1.7.9.5

