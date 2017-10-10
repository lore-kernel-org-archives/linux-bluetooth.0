Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Hyuk Lee <hyuk0512.lee@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hyuk Lee <hyuk0512@gmail.com>
Subject: [PATCH BlueZ] audio: Typo fix
Date: Tue, 10 Oct 2017 10:57:20 +0900
Message-id: <1507600640-22735-1-git-send-email-hyuk0512.lee@samsung.com>
References: <CGME20171010015745epcas1p16db1d2c58f63f62c5860f3099fb41ff8@epcas1p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Hyuk Lee <hyuk0512@gmail.com>

---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2c1434d..f80ae5e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1208,7 +1208,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 	len = 0;
 
 	/*
-	 * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should ignore non-existent IDs
 	 * and send a response with the existent ones. Only if all IDs are
 	 * non-existent we should send an error.
 	 */
@@ -1260,7 +1260,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp *session,
 		goto err;
 
 	/*
-	 * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should ignore non-existent IDs
 	 * and set the existent ones. Sec. 5.2.4 is not clear however how to
 	 * indicate that a certain ID was not accepted. If at least one
 	 * attribute is valid, we respond with no parameters. Otherwise an
-- 
1.9.1

