Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] AVRCP: Bump TG record to 1.4
Date: Fri, 18 May 2012 19:00:07 +0300
Message-Id: <1337356807-7199-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337356807-7199-1-git-send-email-luiz.dentz@gmail.com>
References: <1337356807-7199-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The only mandatory feature for 1.4 is absolute volume control which is
now supported.
---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 5c8328f..a1f49ea 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -243,7 +243,7 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103, feat = 0x000f;
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
1.7.7.6

