Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH BlueZ 1/2 v2] AVRCP: Refactor the code using constants
Date: Mon, 21 May 2012 17:18:09 +0530
Message-ID: <1337600889-23515-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

---
 audio/avrcp.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 audio/avrcp.c

diff --git a/audio/avrcp.c b/audio/avrcp.c
old mode 100644
new mode 100755
index d278d4e..356fd76
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -94,6 +94,11 @@
 
 #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
 
+#define AVRCP_FEATURE_CATEGORY_1	0x0001
+#define AVRCP_FEATURE_CATEGORY_2	0x0002
+#define AVRCP_FEATURE_CATEGORY_3	0x0004
+#define AVRCP_FEATURE_CATEGORY_4	0x0008
+
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
 	BATTERY_STATUS_WARNING =	1,
@@ -179,7 +184,11 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
+	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
+						AVRCP_FEATURE_CATEGORY_2 |
+						AVRCP_FEATURE_CATEGORY_3 |
+						AVRCP_FEATURE_CATEGORY_4 );
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -243,7 +252,11 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
+	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
+						AVRCP_FEATURE_CATEGORY_2 |
+						AVRCP_FEATURE_CATEGORY_3 |
+						AVRCP_FEATURE_CATEGORY_4 );
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.5.4

