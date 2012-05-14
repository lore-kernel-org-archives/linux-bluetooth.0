Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH Bluez v2 3/4] AVRCP: Gets Avrcp session
Date: Mon, 14 May 2012 15:47:53 +0530
Message-ID: <1336990673-24414-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Defines a function that will return player session
---
 audio/avrcp.c |    5 +++++
 audio/avrcp.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 9ab8020..3964777 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1353,3 +1353,8 @@ void register_volume_notification(struct avctp *session)
 						buf, length, COMMAND);
 
 }
+
+struct avctp *avrcp_get_session(struct avrcp_player *player)
+{
+	return player->session;
+}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index d299b67..6ca5ea4 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -102,3 +102,4 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 void register_volume_notification ( struct avctp *session);
+struct avctp *avrcp_get_session(struct avrcp_player *player);
-- 
1.7.5.4

