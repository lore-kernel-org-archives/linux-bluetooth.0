Return-Path: <cyrus@holtmann.org>
From: yes@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: Anurag Biradar <biradar.a@samsung.com>
Subject: [PATCH 1/1] audio/avrcp: Fix set absolute volume
Date: Mon, 24 Nov 2014 16:41:43 +0530
Message-id: <1416827503-17260-1-git-send-email-yes@samsung.com>
In-reply-to: <yes@samsung.com>
References: <yes@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anurag Biradar <biradar.a@samsung.com>

Player object should be getting from target not from controller
---
 profiles/audio/avrcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5c3c4f9..be9cb56 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1588,7 +1588,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->controller->player;
+	struct avrcp_player *player = target_get_player(session);
 	uint16_t len = ntohs(pdu->params_len);
 	uint8_t volume;
 
-- 
1.7.9.5

