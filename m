Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 8 Jan 2013 02:05:53 +0530
Message-ID: <CAFBvHie6nCYJpR1VJWdg+ki=TiZcvpR7R43xGrox_Z5pf0pCiw@mail.gmail.com>
Subject: usage of g_test_fail() which is introduced in Glib 2.30
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

In the latest Bluez snapshot I'm getting the g_test_fail compilation
error. The problem
happens because we use the Glib minimum version requirement
as 2.28 and this API is introduced in GLib version 2.30.
Do we need to use the g_test_fail() now with Glib 2.28?
I guess we cannot replace it with a wrapper function.


Possible Patch:

From: Syam Sidhardhan <s.syam@samsung.com>
Date: Mon, 7 Jan 2013 17:22:00 -0300
Subject: [PATCH 1/1] unit: Remove g_test_fail()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

g_test_fail() is introduced in Glib v2.30 and we are using
Glib v2.28 as the minimum requirement for the build.
This patch resolves the compilation error that happen with
Glib version < 2.30.

Error log:
  CC     unit/test-mgmt.o
unit/test-mgmt.c: In function ‘check_actions’:
unit/test-mgmt.c:100:2: error: implicit declaration of
    function ‘g_test_fail’ [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[1]: *** [unit/test-mgmt.o] Error 1
make: *** [all] Error 2
---
 unit/test-mgmt.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 2d1a5d6..6b3689c 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -97,7 +97,6 @@ static void check_actions(struct context *context,
 	}

 	g_test_message("Command not handled\n");
-	g_test_fail();
 }

 static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
-- 
1.7.0.4

Regards,
Syam.
