Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] avrcp: Fix buffer size check
Date: Mon,  3 Mar 2014 14:53:41 +0200
Message-Id: <1393851227-23483-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393851227-23483-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393851227-23483-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix size check taking into account that attributes starts from 1 (0 is
illegal).
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index bea2dd2..aa932e0 100644
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

