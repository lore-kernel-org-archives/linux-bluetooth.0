Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6 v2] AVRCP: Avoid repeating command due to changed event
Date: Fri,  1 Feb 2013 15:28:21 -0600
Message-Id: <1359754105-8185-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently we are repeating the same command twice for notification, first
for changed and then latter for interim response.

To avoid this the code now just do it for interim responses, changed
responses just trigger another registration.
---
 profiles/audio/avrcp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 728ba91..0a173bc 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1877,6 +1877,12 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 	event = pdu->params[0];
 
+	if (code == AVC_CTYPE_CHANGED) {
+		session->registered_events ^= (1 << event);
+		avrcp_register_notification(session, event);
+		return FALSE;
+	}
+
 	switch (event) {
 	case AVRCP_EVENT_VOLUME_CHANGED:
 		value = pdu->params[1] & 0x7F;
@@ -1900,12 +1906,8 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
-		mp = player->user_data;
-
 		avrcp_get_element_attributes(session);
-
-		if (code == AVC_CTYPE_CHANGED)
-			avrcp_get_play_status(session);
+		avrcp_get_play_status(session);
 
 		break;
 
@@ -1932,12 +1934,6 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 		break;
 	}
 
-	if (code == AVC_CTYPE_CHANGED) {
-		session->registered_events ^= (1 << event);
-		avrcp_register_notification(session, event);
-		return FALSE;
-	}
-
 	session->registered_events |= (1 << event);
 
 	return TRUE;
-- 
1.8.1

