Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH Bluez 2/2 v2] AVRCP: Add missing Player Setting feature in TG record
Date: Tue, 22 May 2012 08:55:47 +0530
Message-ID: <1337657147-18140-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

---
 audio/avrcp.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 356fd76..cb6906d 100755
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -98,6 +98,7 @@
 #define AVRCP_FEATURE_CATEGORY_2	0x0002
 #define AVRCP_FEATURE_CATEGORY_3	0x0004
 #define AVRCP_FEATURE_CATEGORY_4	0x0008
+#define AVRCP_FEATURE_PLAYER_SETTINGS	0x0010
 
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
@@ -254,9 +255,10 @@ static sdp_record_t *avrcp_tg_record(void)
 	uint16_t lp = AVCTP_PSM;
 	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
-						AVRCP_FEATURE_CATEGORY_2 |
-						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4 );
+					AVRCP_FEATURE_CATEGORY_2 |
+					AVRCP_FEATURE_CATEGORY_3 |
+					AVRCP_FEATURE_CATEGORY_4 |
+					AVRCP_FEATURE_PLAYER_SETTINGS );
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.5.4

