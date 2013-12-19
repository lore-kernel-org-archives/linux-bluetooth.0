Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avrcp: Remove unneeded code
Date: Thu, 19 Dec 2013 11:13:24 +0200
Message-Id: <1387444404-6834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Checking (val & 0x7f) > 127 does not make any sense.
---
 profiles/audio/avrcp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cd027c6..7731e88 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1577,15 +1577,10 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 {
 	struct avrcp_player *player = session->controller->player;
 	uint16_t len = ntohs(pdu->params_len);
-	uint8_t volume;
 
 	if (len != 1)
 		goto err;
 
-	volume = pdu->params[0] & 0x7F;
-	if (volume > 127)
-		goto err;
-
 	if (!player)
 		goto err;
 
-- 
1.8.3.2

