Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/core: Fix extra assignment
Date: Fri, 26 Sep 2014 11:16:45 +0300
Message-Id: <1411719405-14321-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

prop is assigned in the beginning of for() loop. Fixes warning:
...
android/main.c:336:3: warning: Value stored to 'prop' is never read
                prop = buf;
                ^      ~~~
...
---
 android/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 663995e..2bc2dfe 100644
--- a/android/main.c
+++ b/android/main.c
@@ -334,7 +334,6 @@ static void configuration(const void *buf, uint16_t len)
 
 		buf += sizeof(*prop) + prop->len;
 		len -= sizeof(*prop) + prop->len;
-		prop = buf;
 	}
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_CORE, HAL_OP_CONFIGURATION,
-- 
1.9.1

