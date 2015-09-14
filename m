Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/avrcp: Fix rejecting SetAbsoluteVolume without a player
Date: Mon, 14 Sep 2015 14:07:30 +0300
Message-Id: <1442228851-9652-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1442228851-9652-1-git-send-email-luiz.dentz@gmail.com>
References: <1442228851-9652-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A player is not necessary in order for SetAbsoluteVolume to work.
---
 profiles/audio/avrcp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 703d084..a9297f6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1676,16 +1676,12 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->controller->player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint8_t volume;
 
 	if (len != 1)
 		goto err;
 
-	if (!player)
-		goto err;
-
 	volume = pdu->params[0] & 0x7F;
 
 	media_transport_update_device_volume(session->dev, volume);
-- 
2.4.3

