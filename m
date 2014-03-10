Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/3] android/avrcp: Fix setting wrong type for volume changed event
Date: Mon, 10 Mar 2014 14:05:16 +0200
Message-Id: <1394453116-9354-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394453116-9354-1-git-send-email-luiz.dentz@gmail.com>
References: <1394453116-9354-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Notification for volume changed should carry the original ctype and
not translate to HAL_AVRCP_EVENT_TYPE_INTERIM or
HAL_AVRCP_EVENT_TYPE_CHANGED which are only valid for register
notification command.
---
 android/avrcp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index eab519a..f0a6d59 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -788,17 +788,7 @@ static gboolean register_notification_rsp(struct avctp *conn,
 	if (params == NULL || params[0] != AVRCP_EVENT_VOLUME_CHANGED)
 		return FALSE;
 
-	switch (code) {
-	case AVC_CTYPE_INTERIM:
-		ev.type = HAL_AVRCP_EVENT_TYPE_INTERIM;
-		break;
-	case AVC_CTYPE_CHANGED:
-		ev.type = HAL_AVRCP_EVENT_TYPE_CHANGED;
-		break;
-	default:
-		return FALSE;
-	}
-
+	ev.type = code;
 	ev.volume = params[1] & 0x7F;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
-- 
1.8.5.3

