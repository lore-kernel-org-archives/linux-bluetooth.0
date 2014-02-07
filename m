Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avrcp: Avoids unneeded memory allocation
Date: Fri,  7 Feb 2014 15:27:54 +0200
Message-Id: <1391779674-9410-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Allocate as much memory as we need since we know this in advance.
Simplifies also length calculation.
---
 profiles/audio/avrcp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index be67fe5..7c7de38 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2263,11 +2263,9 @@ done:
 static void avrcp_list_items(struct avrcp *session, uint32_t start,
 								uint32_t end)
 {
-	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 +
-			AVRCP_MEDIA_ATTRIBUTE_LAST * sizeof(uint32_t)];
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 + sizeof(uint32_t)];
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) buf;
-	uint16_t length = AVRCP_BROWSING_HEADER_LENGTH + 10;
 	uint32_t attribute;
 
 	memset(buf, 0, sizeof(buf));
@@ -2287,9 +2285,7 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 	attribute = htonl(AVRCP_MEDIA_ATTRIBUTE_TITLE);
 	memcpy(&pdu->params[10], &attribute, sizeof(uint32_t));
 
-	length += sizeof(uint32_t);
-
-	avctp_send_browsing_req(session->conn, buf, length,
+	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 					avrcp_list_items_rsp, session);
 }
 
-- 
1.8.3.2

