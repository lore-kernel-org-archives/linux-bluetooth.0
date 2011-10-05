Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix not being able to register pdu handlers
Date: Wed,  5 Oct 2011 17:24:30 +0300
Message-Id: <1317824670-7671-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This happens when removing and adding again an adapter
---
 audio/avctp.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index b8cb36e..89ef70c 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -463,6 +463,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	handler = find_handler(handlers, avc->opcode);
 	if (!handler) {
+		DBG("handler not found for 0x%02x", avc->opcode);
 		avc->code = AVC_CTYPE_REJECTED;
 		goto done;
 	}
@@ -824,14 +825,20 @@ void avctp_unregister(const bdaddr_t *src)
 	if (servers)
 		return;
 
-	if (passthrough_id)
+	if (passthrough_id) {
 		avctp_unregister_pdu_handler(passthrough_id);
+		passthrough_id = 0;
+	}
 
-	if (unit_id)
+	if (unit_id) {
 		avctp_unregister_pdu_handler(unit_id);
+		passthrough_id = 0;
+	}
 
-	if (subunit_id)
-		avctp_unregister_pdu_handler(unit_id);
+	if (subunit_id) {
+		avctp_unregister_pdu_handler(subunit_id);
+		subunit_id = 0;
+	}
 }
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op)
-- 
1.7.6.4

