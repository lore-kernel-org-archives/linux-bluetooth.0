Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/avrcp: Fix registering to player events
Date: Fri,  1 Apr 2016 11:11:46 +0300
Message-Id: <1459498306-17672-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If controller does not have a player skip registering to events which
requires a player.
---
 profiles/audio/avrcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 0c6279a..37bc291 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3647,8 +3647,9 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
 		case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
-			/* These events above are controller specific */
-			if (!session->controller)
+			/* These events above requires a player */
+			if (!session->controller ||
+						!session->controller->player)
 				break;
 		case AVRCP_EVENT_VOLUME_CHANGED:
 			avrcp_register_notification(session, event);
-- 
2.5.0

