Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] AVRCP: Fix initializing volume before checking PDU type
Date: Fri, 25 May 2012 18:02:43 +0300
Message-Id: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Response may be rejected or not implemented so the operand used to
initialize the variable may not even exist.
---
 audio/avrcp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 87a785b..2f96f27 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1145,12 +1145,14 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
 {
 	struct avrcp_player *player = user_data;
 	struct avrcp_header *pdu = (void *) operands;
-	uint8_t abs_volume = pdu->params[1] & 0x7F;
+	uint8_t volume;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
 		return FALSE;
 
-	player->cb->set_volume(abs_volume, player->dev, player->user_data);
+	volume = pdu->params[1] & 0x7F;
+
+	player->cb->set_volume(volume, player->dev, player->user_data);
 
 	return TRUE;
 }
-- 
1.7.7.6

