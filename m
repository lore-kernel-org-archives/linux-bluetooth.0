Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 8/8] adapter: Remove not used defines
Date: Tue, 16 Oct 2012 12:12:59 +0200
Message-ID: <1350382379-30489-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

check_address and OFF_TIMER are not used anymore.

---
 src/adapter.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 86a2124..7c2aec0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -80,10 +80,6 @@
 #define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
 #define IO_CAPABILITY_INVALID		0xFF
 
-#define check_address(address) bachk(address)
-
-#define OFF_TIMER 3
-
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
 #define PENDING_FOUND_MAX 5
 
-- 
1.7.9.5

