Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/16] android/avrcp: Bump version to 1.3
Date: Sun,  2 Mar 2014 20:48:29 +0200
Message-Id: <1393786109-6554-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 875c6e2..268c1b1 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -355,7 +355,7 @@ static sdp_record_t *avrcp_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = L2CAP_PSM_AVCTP;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
+	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 					AVRCP_FEATURE_CATEGORY_2 |
 					AVRCP_FEATURE_CATEGORY_3 |
-- 
1.8.5.3

