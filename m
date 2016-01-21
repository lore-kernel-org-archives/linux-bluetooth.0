Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Hsin-Yu Chao <hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH] audio/avrcp: Create avrcp_player for feature category 2
Date: Thu, 21 Jan 2016 19:51:34 +0800
Message-Id: <1453377094-22519-1-git-send-email-hychao@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are bluetooth speaker support AVRCP feature category 2 but
not category 1, for example: UE mini boom. Create the avrcp_player
for these peripherals so that absolute volume command/event can
work with registered media player app.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9187692..d2570f3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3843,7 +3843,8 @@ static void controller_init(struct avrcp *session)
 	btd_service_connecting_complete(service, 0);
 
 	/* Only create player if category 1 is supported */
-	if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
+	if (!(controller->features &
+	      (AVRCP_FEATURE_CATEGORY_1 | AVRCP_FEATURE_CATEGORY_2)))
 		return;
 
 	player = create_ct_player(session, 0);
-- 
2.1.2

