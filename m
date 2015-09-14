Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/avrcp: Fix missing event for volume control
Date: Mon, 14 Sep 2015 14:07:29 +0300
Message-Id: <1442228851-9652-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CT and TG are always relative to client and server role, so although TG is
associated with a player and CT with a remote controller in case of volume
control the CT is in fact the player and the TG the remote controller,
because of that PTS will not register any TG record when testing this thus
controller_init will not register the necessary events.
---
 profiles/audio/avrcp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 750bdd9..703d084 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3805,7 +3805,8 @@ static void target_init(struct avrcp *session)
 
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
-				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
+				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
+				(1 << AVRCP_EVENT_VOLUME_CHANGED);
 
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
@@ -3831,9 +3832,6 @@ static void controller_init(struct avrcp *session)
 
 	DBG("%p version 0x%04x", controller, controller->version);
 
-	if (controller->version >= 0x0104)
-		session->supported_events |= (1 << AVRCP_EVENT_VOLUME_CHANGED);
-
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	btd_service_connecting_complete(service, 0);
 
-- 
2.4.3

