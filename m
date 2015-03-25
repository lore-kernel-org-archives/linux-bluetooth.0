Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/avrcp: Move SDP features defines to common header
Date: Wed, 25 Mar 2015 09:52:47 +0100
Message-Id: <1427273567-8711-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1427273567-8711-1-git-send-email-szymon.janc@tieto.com>
References: <1427273567-8711-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those will be used also by linux implementation so no need to
duplicate them.
---
 android/avrcp-lib.h | 10 ++++++++++
 android/avrcp.c     |  5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 8e6ee40..add7739 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -126,6 +126,16 @@
 #define AVRCP_MEDIA_SEARCH			0x02
 #define AVRCP_MEDIA_NOW_PLAYING			0x03
 
+/* SDP features */
+#define AVRCP_FEATURE_CATEGORY_1	0x0001
+#define AVRCP_FEATURE_CATEGORY_2	0x0002
+#define AVRCP_FEATURE_CATEGORY_3	0x0004
+#define AVRCP_FEATURE_CATEGORY_4	0x0008
+#define AVRCP_FEATURE_PLAYER_SETTINGS	0x0010
+#define AVRCP_FEATURE_GROUP_NAVIGATION	0x0020
+#define AVRCP_FEATURE_BROWSING		0x0040
+#define AVRCP_FEATURE_MULTIPLE_PLAYERS	0x0080
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
diff --git a/android/avrcp.c b/android/avrcp.c
index a0d412d..bcb4228 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -49,11 +49,6 @@
 
 #define L2CAP_PSM_AVCTP 0x17
 
-#define AVRCP_FEATURE_CATEGORY_1	0x0001
-#define AVRCP_FEATURE_CATEGORY_2	0x0002
-#define AVRCP_FEATURE_CATEGORY_3	0x0004
-#define AVRCP_FEATURE_CATEGORY_4	0x0008
-
 static bdaddr_t adapter_addr;
 static uint32_t record_tg_id = 0;
 static uint32_t record_ct_id = 0;
-- 
1.9.3

