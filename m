Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] AVRCP: Reduce number of request to refresh the player list
Date: Wed, 13 Mar 2013 17:02:53 -0300
Message-Id: <1363204974-21023-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1363204974-21023-1-git-send-email-luiz.dentz@gmail.com>
References: <1363204974-21023-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the addressed player changes but it features is already known
the list of players don't need to be refreshed.
---
 profiles/audio/avrcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aba7e86..3fbdaf6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2456,6 +2456,9 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	player->uid_counter = bt_get_be16(&pdu->params[3]);
 	session->player = player;
 
+	if (player->features != NULL)
+		return;
+
 	avrcp_get_media_player_list(session);
 }
 
-- 
1.8.1.4

