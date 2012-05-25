Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] AVRCP: Fix not registering to VolumeChanged event again when notified
Date: Fri, 25 May 2012 18:02:44 +0300
Message-Id: <1337958168-9875-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec says:

"A registered notification gets changed on receiving CHANGED event
notification. For a new notification additional NOTIFY command is
expected to be sent."
---
 audio/avrcp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 2f96f27..30d696a 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -176,6 +176,8 @@ static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
 
+static void register_volume_notification(struct avrcp_player *player);
+
 static sdp_record_t *avrcp_ct_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -1154,6 +1156,11 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
 
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

