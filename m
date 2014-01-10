Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avrcp: Remove dead code
Date: Fri, 10 Jan 2014 16:56:20 +0200
Message-Id: <1389365780-20136-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

session->target cannot be NULL since it is already checked 11 lines
above:
...
	if (session == NULL || session->target == NULL)
		return -ENOTCONN;
...
---
 profiles/audio/avrcp.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 8d4309a..197959f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3722,30 +3722,14 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
 
 	DBG("volume=%u", volume);
 
-	if (session->target) {
-		pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
-		pdu->params[0] = volume;
-		pdu->params_len = htons(1);
+	pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
+	pdu->params[0] = volume;
+	pdu->params_len = htons(1);
 
-		return avctp_send_vendordep_req(session->conn,
+	return avctp_send_vendordep_req(session->conn,
 					AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
 					buf, sizeof(buf),
 					avrcp_handle_set_volume, session);
-	} else if (session->registered_events &
-					(1 << AVRCP_EVENT_VOLUME_CHANGED)) {
-		uint8_t id = AVRCP_EVENT_VOLUME_CHANGED;
-		pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
-		pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
-		pdu->params[1] = volume;
-		pdu->params_len = htons(2);
-
-		return avctp_send_vendordep(session->conn,
-					session->transaction_events[id],
-					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
-					buf, sizeof(buf));
-	}
-
-	return 0;
 }
 
 static int avrcp_connect(struct btd_service *service)
-- 
1.8.3.2

