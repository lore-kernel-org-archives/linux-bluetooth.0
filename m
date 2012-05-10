Return-Path: <cyrus@holtmann.org>
From: Vani <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <vani.patel@stericsson.com>
Subject: [PATCH BlueZ 1/3] Adds TG Record for AVRCP 1.4
Date: Thu, 10 May 2012 15:58:59 +0530
Message-ID: <1336645739-25307-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index df39d04..9ec0730 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -238,7 +238,7 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103, feat = 0x000f;
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.5.4

