Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVRCP: Fix not registering to VolumeChanged event again when notified
Date: Mon, 28 May 2012 14:00:29 +0300
Message-Id: <1338202829-14902-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec says:

"A registered notification gets changed on receiving CHANGED event
notification. For a new notification additional NOTIFY command is
expected to be sent."
---
 audio/avrcp.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 131490f..ea60ef1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -177,6 +177,8 @@ static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
 
+static void register_volume_notification(struct avrcp_player *player);
+
 static sdp_record_t *avrcp_ct_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -1148,13 +1150,18 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t volume;
 
-	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
+	if (code != AVC_CTYPE_INTERIM || code != AVC_CTYPE_CHANGED)
 		return FALSE;
 
 	volume = pdu->params[1] & 0x7F;
 
 	player->cb->set_volume(volume, player->dev, player->user_data);
 
+	if (code == AVC_CTYPE_CHANGED) {
+		register_volume_notification(player);
+		return FALSE;
+	}
+
 	return TRUE;
 }
 
-- 
1.7.7.6

