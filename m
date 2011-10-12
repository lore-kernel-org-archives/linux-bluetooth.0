Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 08/12] AVRCP: Return error for invalid metadata IDs
Date: Wed, 12 Oct 2011 12:11:18 -0300
Message-Id: <1318432282-25002-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index a7987fb..0ca91a5 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -427,6 +427,10 @@ static int player_get_media_attribute(struct avrcp_player *player,
 
 	DBG("Get media attribute: %u", id);
 
+	if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
+			id > AVRCP_MEDIA_ATTRIBUTE_LAST)
+		return -ENOENT;
+
 	value = player->cb->get_metadata(id, player->user_data);
 	if (value == NULL) {
 		len = 0;
@@ -452,8 +456,6 @@ static int player_get_media_attribute(struct avrcp_player *player,
 			return -ENOBUFS;
 		memcpy(elem->val, valstr, len);
 		break;
-	default:
-		return -ENOENT;
 	}
 
 done:
-- 
1.7.7

