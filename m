Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH 2/2] AVRCP: Add missing Player Setting feature in TG record
Date: Thu, 10 May 2012 11:57:44 +0530
Message-ID: <1336631264-27977-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

---
 audio/avrcp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 1b35c3f..7ed1bbb 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -93,6 +93,7 @@
 #define AVRCP_FEATURE_CATEGORY_2	0x0002
 #define AVRCP_FEATURE_CATEGORY_3	0x0004
 #define AVRCP_FEATURE_CATEGORY_4	0x0008
+#define AVRCP_FEATURE_PLAYER_SETTINGS	0x0010
 
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
@@ -247,7 +248,8 @@ static sdp_record_t *avrcp_tg_record(void)
 	uint16_t lp = AVCTP_PSM;
 	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
 	uint16_t feat = (AVRCP_FEATURE_CATEGORY_1 | AVRCP_FEATURE_CATEGORY_2
-		| AVRCP_FEATURE_CATEGORY_3 | AVRCP_FEATURE_CATEGORY_4);
+		| AVRCP_FEATURE_CATEGORY_3 | AVRCP_FEATURE_CATEGORY_4
+		| AVRCP_FEATURE_PLAYER_SETTINGS);
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.5.4

