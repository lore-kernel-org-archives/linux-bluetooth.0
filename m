Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/9] avrcp: Fix buffer size check
Date: Fri, 28 Feb 2014 16:18:40 +0200
Message-Id: <1393597125-18176-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix size check taking into account that attributes starts from 1 (0 is
illegal).
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c0e5d07..48c3355 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1909,7 +1909,7 @@ static void avrcp_get_current_player_value(struct avrcp *session,
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t length = AVRCP_HEADER_LENGTH + count + 1;
 
-	if (count > AVRCP_ATTRIBUTE_LAST + 1)
+	if (count > AVRCP_ATTRIBUTE_LAST)
 		return;
 
 	memset(buf, 0, sizeof(buf));
-- 
1.8.3.2

