Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] audio/avrcp: Fix not setting player id
Date: Thu, 18 Aug 2016 15:45:25 +0300
Message-Id: <1471524327-15455-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
References: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The id shall be initialized properly otherwise it maybe reused by
another player since its id will be 0 which is reserved as placeholder
when discovering the player list.
---
 profiles/audio/avrcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c100149..90faa1d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3212,6 +3212,7 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 	const char *path;
 
 	player = g_new0(struct avrcp_player, 1);
+	player->id = id;
 	player->sessions = g_slist_prepend(player->sessions, session);
 
 	path = device_get_path(session->dev);
-- 
2.7.4

