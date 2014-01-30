Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] avrcp: Fix possible buffer overflow and correct length
Date: Thu, 30 Jan 2014 18:12:56 +0200
Message-Id: <1391098376-26834-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Wrong length was given and it was also possible to crash.
---
 profiles/audio/avrcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 128f7d3..f9fce5c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1899,8 +1899,12 @@ static void avrcp_get_current_player_value(struct avrcp *session,
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 5];
 	struct avrcp_header *pdu = (void *) buf;
+	uint16_t length = AVRCP_HEADER_LENGTH + count + 1;
 	int i;
 
+	if (count + 1 > 5)
+		return;
+
 	memset(buf, 0, sizeof(buf));
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
@@ -1913,7 +1917,7 @@ static void avrcp_get_current_player_value(struct avrcp *session,
 		pdu->params[i + 1] = attrs[i];
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
-					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					AVC_SUBUNIT_PANEL, buf, length,
 					avrcp_player_value_rsp, session);
 }
 
-- 
1.8.3.2

