Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 02/12] avrcp: Remove unnecessary "if (...)"
Date: Fri,  3 Jan 2014 21:55:18 -0400
Message-Id: <1388800528-10699-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is already a "if (type != 0x03 && type != 0x02)" check earlier on
the code, so a plain "if (...) else ..." is enough.

Fixes clang error:

profiles/audio/avrcp.c:2211:12: error: variable 'item' is used
uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2eb2ad6..8d4309a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2208,7 +2208,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 
 		if (type == 0x03)
 			item = parse_media_element(session, &operands[i], len);
-		else if (type == 0x02)
+		else
 			item = parse_media_folder(session, &operands[i], len);
 
 		if (item) {
-- 
1.8.3.2

