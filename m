Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVRCP: change debug to better reflect packets protocol/profile
Date: Wed, 14 Sep 2011 12:16:50 +0300
Message-Id: <1315991810-12013-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/avctp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index cf34107..2800a16 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -217,17 +217,17 @@ static size_t handle_panel_passthrough(struct avctp *session,
 		if ((operands[0] & 0x7F) != key_map[i].avc)
 			continue;
 
-		DBG("AVRCP: %s %s", key_map[i].name, status);
+		DBG("AV/C: %s %s", key_map[i].name, status);
 
 		key_quirks = session->key_quirks[key_map[i].avc];
 
 		if (key_quirks & QUIRK_NO_RELEASE) {
 			if (!pressed) {
-				DBG("AVRCP: Ignoring release");
+				DBG("AV/C: Ignoring release");
 				break;
 			}
 
-			DBG("AVRCP: treating key press as press + release");
+			DBG("AV/C: treating key press as press + release");
 			send_key(session->uinput, key_map[i].uinput, 1);
 			send_key(session->uinput, key_map[i].uinput, 0);
 			break;
@@ -238,7 +238,7 @@ static size_t handle_panel_passthrough(struct avctp *session,
 	}
 
 	if (key_map[i].name == NULL)
-		DBG("AVRCP: unknown button 0x%02X %s",
+		DBG("AV/C: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
 
 done:
@@ -429,7 +429,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	ret -= sizeof(struct avctp_header);
 	if ((unsigned int) ret < sizeof(struct avc_header)) {
-		error("Too small AVRCP packet");
+		error("Too small AVCTP packet");
 		goto failed;
 	}
 
-- 
1.7.6.1

