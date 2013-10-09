Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] tools/hcidump: Fix parsing for service class 0x110f
Date: Wed,  9 Oct 2013 14:16:17 +0300
Message-Id: <1381317377-11013-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to assigned number 0x110f is AV Remote Controller not VCP.
---
 tools/parser/sdp.c | 3 +--
 tools/parser/sdp.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/parser/sdp.c b/tools/parser/sdp.c
index b48e3ff..0e28328 100644
--- a/tools/parser/sdp.c
+++ b/tools/parser/sdp.c
@@ -121,7 +121,7 @@ static sdp_uuid_nam_lookup_table_t sdp_uuid_nam_lookup_table[] = {
 	{ SDP_UUID_AV_REMOTE_TARGET,         "AVRemTarget"  }, /* AVRCP */
 	{ SDP_UUID_ADVANCED_AUDIO,           "AdvAudio"     }, /* A2DP */
 	{ SDP_UUID_AV_REMOTE,                "AVRemote"     }, /* AVRCP */
-	{ SDP_UUID_VIDEO_CONFERENCING,       "VideoConf"    }, /* VCP */
+	{ SDP_UUID_AV_REMOTE_CONTROLLER,     "AVRemCt"      }, /* AVRCP */
 	{ SDP_UUID_INTERCOM,                 "Intercom"     },
 	{ SDP_UUID_FAX,                      "Fax"          },
 	{ SDP_UUID_HEADSET_AUDIO_GATEWAY,    "Headset AG"   },
@@ -145,7 +145,6 @@ static sdp_uuid_nam_lookup_table_t sdp_uuid_nam_lookup_table[] = {
 	{ SDP_UUID_HCR_PRINT,                "HCRPrint"     }, /* HCRP */
 	{ SDP_UUID_HCR_SCAN,                 "HCRScan"      }, /* HCRP */
 	{ SDP_UUID_COMMON_ISDN_ACCESS,       "CIP"          }, /* CIP */
-	{ SDP_UUID_VIDEO_CONFERENCING_GW,    "VideoConf GW" }, /* VCP */
 	{ SDP_UUID_UDI_MT,                   "UDI MT"       }, /* UDI */
 	{ SDP_UUID_UDI_TA,                   "UDI TA"       }, /* UDI */
 	{ SDP_UUID_AUDIO_VIDEO,              "AudioVideo"   }, /* VCP */
diff --git a/tools/parser/sdp.h b/tools/parser/sdp.h
index 41fc209..ed55a23 100644
--- a/tools/parser/sdp.h
+++ b/tools/parser/sdp.h
@@ -66,7 +66,7 @@
 #define SDP_UUID_AV_REMOTE_TARGET                      0x110c /* AVRCP */
 #define SDP_UUID_ADVANCED_AUDIO                        0x110d /* A2DP */
 #define SDP_UUID_AV_REMOTE                             0x110e /* AVRCP */
-#define SDP_UUID_VIDEO_CONFERENCING                    0x110f /* VCP */
+#define SDP_UUID_AV_REMOTE_CONTROLLER                  0x110f /* AVRCP */
 #define SDP_UUID_INTERCOM                              0x1110
 #define SDP_UUID_FAX                                   0x1111
 #define SDP_UUID_HEADSET_AUDIO_GATEWAY                 0x1112
@@ -93,7 +93,6 @@
 #define SDP_UUID_HCR_PRINT                             0x1126 /* HCRP */
 #define SDP_UUID_HCR_SCAN                              0x1127 /* HCRP */
 #define SDP_UUID_COMMON_ISDN_ACCESS                    0x1128 /* CIP */
-#define SDP_UUID_VIDEO_CONFERENCING_GW                 0x1129 /* VCP */
 #define SDP_UUID_UDI_MT                                0x112a /* UDI */
 #define SDP_UUID_UDI_TA                                0x112b /* UDI */
 #define SDP_UUID_AUDIO_VIDEO                           0x112c /* VCP */
-- 
1.8.3.1

