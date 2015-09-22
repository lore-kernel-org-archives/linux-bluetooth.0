Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] audio/avrcp: Remove not needed null check in
Date: Tue, 22 Sep 2015 20:56:52 +0200
Message-Id: <1442948212-28447-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Browsing handlers are always getting valid pdu pointer so there is no
need to double check that. Also pdu pointer is already dereferenced
before calling handler.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 53170ec..24deac5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1946,7 +1946,7 @@ static void avrcp_handle_get_folder_items(struct avrcp *session,
 	uint8_t scope;
 	uint8_t status = AVRCP_STATUS_SUCCESS;
 
-	if (!pdu || ntohs(pdu->param_len) < 10) {
+	if (ntohs(pdu->param_len) < 10) {
 		status = AVRCP_STATUS_INVALID_PARAM;
 		goto failed;
 	}
-- 
2.5.0

