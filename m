Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] Fix possible crash when player is destroyed
Date: Mon,  3 Oct 2011 17:57:51 +0300
Message-Id: <1317653871-14689-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1317653871-14689-1-git-send-email-luiz.dentz@gmail.com>
References: <1317653871-14689-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When player is unregistered/destroyed its pdu handler should also be
removed.
---
 audio/avrcp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 5aa8dc5..9a73ff4 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1101,6 +1101,9 @@ static void player_destroy(gpointer data)
 	if (player->destroy)
 		player->destroy(player->user_data);
 
+	if (player->handler)
+		avctp_unregister_pdu_handler(player->handler);
+
 	g_free(player);
 }
 
-- 
1.7.6.2

