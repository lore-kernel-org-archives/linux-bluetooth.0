Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] AVRCP: Fix not setting audio device connected to player
Date: Tue, 22 May 2012 17:00:52 +0300
Message-Id: <1337695255-9197-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While connecting device should be set to match the AVCTP session and when
disconnected reset it back to NULL.
---
 audio/avrcp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index cb6906d..b09fab0 100755
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1197,6 +1197,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
 		player->session = NULL;
+		player->dev = NULL;
 		player->registered_events = 0;
 
 		if (player->handler) {
@@ -1207,6 +1208,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		break;
 	case AVCTP_STATE_CONNECTING:
 		player->session = avctp_connect(&dev->src, &dev->dst);
+		player->dev = dev;
 
 		if (!player->handler)
 			player->handler = avctp_register_pdu_handler(
-- 
1.7.7.6

