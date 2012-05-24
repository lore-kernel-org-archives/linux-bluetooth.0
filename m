Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] AVRCP: Remove unneeded check for set_volume callback
Date: Thu, 24 May 2012 14:26:25 -0300
Message-Id: <1337880385-3894-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

Luiz, feel free to put this in your patchset if you prefer so it doesn't
conflict with your patches.

 audio/avrcp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index cb6906d..7eda6e8 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1150,8 +1150,7 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
 		return FALSE;
 
-	if (player->cb->set_volume != NULL)
-		player->cb->set_volume(abs_volume, player->dev, player->user_data);
+	player->cb->set_volume(abs_volume, player->dev, player->user_data);
 
 	return TRUE;
 }
-- 
1.7.10.2

