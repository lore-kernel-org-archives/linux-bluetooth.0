Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH BlueZ 3/4] AVRCP: Gets Avrcp session
Date: Fri, 11 May 2012 16:33:16 +0530
Message-ID: <1336734196-17856-1-git-send-email-vani.patel@stericsson.com>
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
index f4f1b6a..b11dc21 100755
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1385,3 +1385,8 @@ void register_volume_notification(struct avctp *session)
 				AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
 				buf, length, COMMAND);
 }
+
+struct avctp *avrcp_get_session(struct avrcp_player *player)
+{
+	return player->session;
+}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 26432bc..21cbc5c 100755
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -103,3 +103,4 @@ int avrcp_player_set_volume(struct avrcp_player *player, void *data);
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 void register_volume_notification(struct avctp *session);
+struct avctp *avrcp_get_session(struct avrcp_player *player);
-- 
1.7.5.4

