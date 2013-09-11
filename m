Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] avdtp: Remove unused STREAM_TIMEOUT define
Date: Wed, 11 Sep 2013 15:52:14 +0200
Message-ID: <1378907534-6899-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1378907534-6899-1-git-send-email-szymon.janc@tieto.com>
References: <1378907534-6899-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avdtp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 5422ca3..fe63a40 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -86,7 +86,6 @@
 #define REQ_TIMEOUT 6
 #define ABORT_TIMEOUT 2
 #define DISCONNECT_TIMEOUT 1
-#define STREAM_TIMEOUT 20
 #define START_TIMEOUT 1
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-- 
1.8.4

