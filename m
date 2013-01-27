Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3 v3] AVCTP: Fix not destroying browsing channel if disconnected
Date: Sun, 27 Jan 2013 17:52:15 -0600
Message-Id: <1359330736-9190-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
References: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the browsing channel is disconnected it should be destroyed
immediatelly and set to NULL otherwise it will point to invalid channel.
---
 profiles/audio/avctp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 6ad2b66..6cac718 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -485,6 +485,10 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 		break;
 	case AVCTP_STATE_CONNECTED:
 		DBG("AVCTP Connected");
+		if (session->browsing) {
+			avctp_channel_destroy(session->browsing);
+			session->browsing = NULL;
+		}
 		break;
 	case AVCTP_STATE_BROWSING_CONNECTING:
 		DBG("AVCTP Browsing Connecting");
-- 
1.8.1

