Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix bluez build break by initializing variable.
Date: Thu, 21 Apr 2016 10:18:49 +0200
Message-Id: <1461226729-17372-2-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1461226729-17372-1-git-send-email-beaufort.francois@gmail.com>
References: <1461226729-17372-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 37bc291..70c184b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3112,7 +3112,7 @@ static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
-	uint32_t num_of_items;
+	uint32_t num_of_items = 0;
 
 	if (pdu == NULL)
 		return -ETIMEDOUT;
-- 
2.7.0

