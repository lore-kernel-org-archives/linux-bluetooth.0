Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 19/22] avrcp: change TG record to use version 1.3
Date: Thu, 11 Aug 2011 12:53:30 -0300
Message-Id: <1313078013-19103-20-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 2070e10..f068539 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -414,7 +414,7 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.6

