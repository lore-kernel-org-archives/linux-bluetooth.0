Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/15] AVRCP: Fix crash if player status is NULL
Date: Mon, 10 Jun 2013 13:37:02 +0300
Message-Id: <1370860630-30359-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Assume status is 'stopped' in case the status is NULL.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 66ab2b4..45ca490 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -575,7 +575,7 @@ static int player_get_setting(struct avrcp_player *player, uint8_t id)
 
 static int play_status_to_val(const char *status)
 {
-	if (!strcasecmp(status, "stopped"))
+	if (status == NULL || !strcasecmp(status, "stopped"))
 		return AVRCP_PLAY_STATUS_STOPPED;
 	else if (!strcasecmp(status, "playing"))
 		return AVRCP_PLAY_STATUS_PLAYING;
-- 
1.8.1.4

