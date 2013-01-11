Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 11/11] audio: Bump AVRCP CT version to 1.5
Date: Fri, 11 Jan 2013 17:25:34 -0300
Message-Id: <1357935934-20033-12-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 8bd5fb6..19b6721 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -231,7 +231,7 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
+	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
-- 
1.7.11.7

