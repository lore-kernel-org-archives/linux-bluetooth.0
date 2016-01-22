Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/avrcp: Fix not always requesting capabilities
Date: Fri, 22 Jan 2016 17:14:26 +0200
Message-Id: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not requesting capabilities of targets that are not player
category, instead just make the creation of the player object
conditional to the category 1 so that GetCapabities is still sent in
order to fetch the supported events which might be still useful even
without a player.
---
 profiles/audio/avrcp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7b60012..076766d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3843,12 +3843,11 @@ static void controller_init(struct avrcp *session)
 	btd_service_connecting_complete(service, 0);
 
 	/* Only create player if category 1 is supported */
-	if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
-		return;
-
-	player = create_ct_player(session, 0);
-	if (player == NULL)
-		return;
+	if (controller->features & AVRCP_FEATURE_CATEGORY_1) {
+		player = create_ct_player(session, 0);
+		if (player == NULL)
+			return;
+	}
 
 	if (controller->version < 0x0103)
 		return;
-- 
2.5.0

