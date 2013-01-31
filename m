Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] AVCTP: Fix allways destroying browsing channel
Date: Thu, 31 Jan 2013 11:12:40 -0600
Message-Id: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts commit 53d3fc3fad5152167458625ad2acf19070cdf26a that leads
to always destroy the browsing channel because the callback changes the
state.

To fix session_browsing_cb naw takes care of destroying the channel if it
disconnects.
---
 profiles/audio/avctp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 41e2f46..303427e 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -490,10 +490,6 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 		break;
 	case AVCTP_STATE_CONNECTED:
 		DBG("AVCTP Connected");
-		if (session->browsing) {
-			avctp_channel_destroy(session->browsing);
-			session->browsing = NULL;
-		}
 		break;
 	case AVCTP_STATE_BROWSING_CONNECTING:
 		DBG("AVCTP Browsing Connecting");
@@ -817,6 +813,13 @@ send:
 
 failed:
 	DBG("AVCTP Browsing: disconnected");
+	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+
+	if (session->browsing) {
+		avctp_channel_destroy(session->browsing);
+		session->browsing = NULL;
+	}
+
 	return FALSE;
 }
 
-- 
1.8.1

