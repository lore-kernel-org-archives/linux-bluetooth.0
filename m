Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avrcp: Fix buffer size
Date: Fri, 28 Feb 2014 12:44:12 +0200
Message-Id: <1393584252-10947-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For avrcp_get_current_player_value() buffer size needs to be
AVRCP_ATTRIBUTE_LAST + 1 for all attributes + 1 for number of attributes
written first, not counting header.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c0e5d07..8098c62 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1905,7 +1905,7 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn,
 static void avrcp_get_current_player_value(struct avrcp *session,
 						uint8_t *attrs, uint8_t count)
 {
-	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_ATTRIBUTE_LAST + 1];
+	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_ATTRIBUTE_LAST + 2];
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t length = AVRCP_HEADER_LENGTH + count + 1;
 
-- 
1.8.3.2

