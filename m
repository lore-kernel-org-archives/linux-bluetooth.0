Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH 1/2] AVRCP: Refactor the code using constants
Date: Thu, 10 May 2012 11:56:44 +0530
Message-ID: <1336631204-25794-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

Adds macros for category features
---
 audio/avrcp.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index df39d04..1b35c3f 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -89,6 +89,11 @@
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
 
+#define AVRCP_FEATURE_CATEGORY_1	0x0001
+#define AVRCP_FEATURE_CATEGORY_2	0x0002
+#define AVRCP_FEATURE_CATEGORY_3	0x0004
+#define AVRCP_FEATURE_CATEGORY_4	0x0008
+
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
 	BATTERY_STATUS_WARNING =	1,
@@ -174,7 +179,9 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
+	uint16_t feat = (AVRCP_FEATURE_CATEGORY_1 | AVRCP_FEATURE_CATEGORY_2
+		| AVRCP_FEATURE_CATEGORY_3 | AVRCP_FEATURE_CATEGORY_4);
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -238,7 +245,9 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
+	uint16_t feat = (AVRCP_FEATURE_CATEGORY_1 | AVRCP_FEATURE_CATEGORY_2
+		| AVRCP_FEATURE_CATEGORY_3 | AVRCP_FEATURE_CATEGORY_4);
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.5.4

