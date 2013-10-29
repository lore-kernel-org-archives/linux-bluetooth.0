Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/AVRCP: Always assign a player to TG role
Date: Tue, 29 Oct 2013 16:07:14 +0200
Message-Id: <1383055634-11953-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code does not assign a player if version is bellow 1.3,
but sometimes the version may not be initialized correctly e.g: record
could not be fetch.

Futhermore by assigning a player for 1.0 CT it won't break backward
compatibility as no commands will be sent but adds the possibility to
respond properly in case the CT is sending commands above its own
version which is a violation of the spec but unfortunately there exists
such stacks on the market.
---
 profiles/audio/avrcp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 296067c..cd027c6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3363,9 +3363,6 @@ static void target_init(struct avrcp *session)
 	if (service != NULL)
 		btd_service_connecting_complete(service, 0);
 
-	if (target->version < 0x0103)
-		return;
-
 	player = g_slist_nth_data(server->players, 0);
 	if (player != NULL) {
 		target->player = player;
-- 
1.8.3.1

