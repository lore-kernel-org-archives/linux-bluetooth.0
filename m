Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] audio/a2dp: Move PSM definition to AVDTP header
Date: Fri, 22 May 2015 19:28:02 +0900
Message-id: <1432290483-2910-6-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
References: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves PSM definition to AVDTP header based on
7e518f2f9a7dfd195ec39825b41a58d8fcc4a849.
---
 profiles/audio/a2dp.c  | 2 --
 profiles/audio/avdtp.c | 2 --
 profiles/audio/avdtp.h | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 31c5086..0405f58 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -61,8 +61,6 @@
 #define SUSPEND_TIMEOUT 5
 #define RECONFIGURE_TIMEOUT 500
 
-#define AVDTP_PSM 25
-
 struct a2dp_sep {
 	struct a2dp_server *server;
 	struct a2dp_endpoint *endpoint;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index eed3f88..b26f1ba 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -52,8 +52,6 @@
 #include "sink.h"
 #include "source.h"
 
-#define AVDTP_PSM 25
-
 #define MAX_SEID 0x3E
 static unsigned int seids;
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 1b02232..81705fd 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -41,6 +41,8 @@ struct avdtp_error {
 	} err;
 };
 
+#define AVDTP_PSM 25
+
 /* SEP capability categories */
 #define AVDTP_MEDIA_TRANSPORT			0x01
 #define AVDTP_REPORTING				0x02
-- 
2.1.4

