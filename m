Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/16] a2dp: Remove not used macros definitions
Date: Wed, 12 Dec 2012 11:27:55 +0100
Message-ID: <1355308088-9080-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MIN and MAX macros are not used.
---
 profiles/audio/a2dp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index aef998a..ac5c513 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -52,14 +52,6 @@
 #define SUSPEND_TIMEOUT 5
 #define RECONFIGURE_TIMEOUT 500
 
-#ifndef MIN
-# define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
-#ifndef MAX
-# define MAX(x, y) ((x) > (y) ? (x) : (y))
-#endif
-
 struct a2dp_sep {
 	struct a2dp_server *server;
 	struct a2dp_endpoint *endpoint;
-- 
1.8.0

