Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] unit: Replace g_test_fail() with g_assert()
Date: Tue, 08 Jan 2013 17:07:47 +0530
Message-id: <1357645069-30841-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
References: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_test_fail() is introduced in Glib v2.30 and we are using
Glib v2.28 as the minimum requirement for the build.
This patch resolves the compilation error that happen with
Glib v2.28.

Error log:
  CC     unit/test-mgmt.o
unit/test-mgmt.c: In function ‘check_actions’:
unit/test-mgmt.c:100:2: error: implicit declaration of
    function ‘g_test_fail’ [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[1]: *** [unit/test-mgmt.o] Error 1
make: *** [all] Error 2
---
 unit/test-mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 2d1a5d6..ea679e5 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -97,7 +97,7 @@ static void check_actions(struct context *context,
 	}
 
 	g_test_message("Command not handled\n");
-	g_test_fail();
+	g_assert(0);
 }
 
 static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
-- 
1.7.9.5

