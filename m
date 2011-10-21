Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/5] Unregister players' events when disconnected
Date: Fri, 21 Oct 2011 15:58:27 -0200
Message-Id: <1319219908-2819-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index e908bf4..f06afbf 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1119,6 +1119,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
 		player->session = NULL;
+		player->registered_events = 0;
 
 		if (player->handler) {
 			avctp_unregister_pdu_handler(player->handler);
-- 
1.7.7

