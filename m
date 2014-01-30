Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] avrcp: Avoid unneeded calculation
Date: Thu, 30 Jan 2014 18:12:54 +0200
Message-Id: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There no need to calculate those values
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index fa5adab..2e1a940 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3177,7 +3177,7 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 	pdu->params[0] = event;
 	pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH;
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
 					AVC_SUBUNIT_PANEL, buf, length,
@@ -3250,7 +3250,7 @@ static void avrcp_get_capabilities(struct avrcp *session)
 	pdu->params[0] = CAP_EVENTS_SUPPORTED;
 	pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
 
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	length = AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH;
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
 					AVC_SUBUNIT_PANEL, buf, length,
-- 
1.8.3.2

