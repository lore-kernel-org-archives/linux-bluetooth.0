Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] AVRCP: Add define for VolumeChanged event
Date: Fri, 18 May 2012 19:00:05 +0300
Message-Id: <1337356807-7199-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/avrcp.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.h b/audio/avrcp.h
index 8a09546..9aef081 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -73,7 +73,8 @@
 #define AVRCP_EVENT_TRACK_CHANGED	0x02
 #define AVRCP_EVENT_TRACK_REACHED_END	0x03
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
-#define AVRCP_EVENT_LAST		AVRCP_EVENT_TRACK_REACHED_START
+#define AVRCP_EVENT_VOLUME_CHANGED	0x0d
+#define AVRCP_EVENT_LAST		AVRCP_EVENT_VOLUME_CHANGED
 
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
-- 
1.7.7.6

