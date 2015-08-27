Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/avrcp: Bump TG to version 1.5
Date: Thu, 27 Aug 2015 16:36:05 +0300
Message-Id: <1440682565-23653-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
References: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

1.4 is deprecated and 1.5 should be used instead.
---
 profiles/audio/avrcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5a1c8a3..2d76f54 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -137,6 +137,8 @@
 #define AVRCP_CHARSET_UTF8		106
 
 #define AVRCP_BROWSING_TIMEOUT		1
+#define AVRCP_CT_VERSION		0x0106
+#define AVRCP_TG_VERSION		0x0105
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -277,7 +279,7 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm[2], *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM, ap = AVCTP_BROWSING_PSM;
-	uint16_t avrcp_ver = 0x0106, avctp_ver = 0x0103;
+	uint16_t avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
@@ -332,7 +334,7 @@ static sdp_record_t *avrcp_ct_record(void)
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
-	profile[0].version = avrcp_ver;
+	profile[0].version = AVRCP_CT_VERSION;
 	pfseq = sdp_list_append(NULL, &profile[0]);
 	sdp_set_profile_descs(record, pfseq);
 
@@ -370,7 +372,7 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_list_t *aproto_browsing, *proto_browsing[2] = {0};
 	uint16_t lp = AVCTP_CONTROL_PSM;
 	uint16_t lp_browsing = AVCTP_BROWSING_PSM;
-	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
+	uint16_t avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 					AVRCP_FEATURE_CATEGORY_2 |
 					AVRCP_FEATURE_CATEGORY_3 |
@@ -420,7 +422,7 @@ static sdp_record_t *avrcp_tg_record(void)
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
-	profile[0].version = avrcp_ver;
+	profile[0].version = AVRCP_TG_VERSION;
 	pfseq = sdp_list_append(NULL, &profile[0]);
 	sdp_set_profile_descs(record, pfseq);
 
-- 
2.4.3

