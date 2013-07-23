Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] audio/AVRCP: Fix registration of VOLUME_CHANGED
Date: Tue, 23 Jul 2013 15:52:30 +0300
Message-Id: <1374583952-16361-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
References: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

First check with GetCapabilities if the event is really support before
registering.
---
 profiles/audio/avrcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ad7742d..9baf0d3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3205,6 +3205,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
 		case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
+		case AVRCP_EVENT_VOLUME_CHANGED:
 			avrcp_register_notification(session, event);
 			break;
 		}
@@ -3336,7 +3337,9 @@ static void target_init(struct avrcp *session)
 	if (target->version < 0x0104)
 		return;
 
-	avrcp_register_notification(session, AVRCP_EVENT_VOLUME_CHANGED);
+	/* Only check capabilities if controller is not supported */
+	if (session->controller == NULL)
+		avrcp_get_capabilities(session);
 
 	/* Auto-connect browsing channel only if initiator */
 	if (old_state == BTD_SERVICE_STATE_CONNECTING &&
-- 
1.8.3.1

