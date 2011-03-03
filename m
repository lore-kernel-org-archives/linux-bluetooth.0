Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix hal plugin compilation error
Date: Thu, 3 Mar 2011 10:24:14 +0100
Message-ID: <1299144254-5405-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hal.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/hal.c b/plugins/hal.c
index 05a1c46..21d7688 100644
--- a/plugins/hal.c
+++ b/plugins/hal.c
@@ -33,7 +33,6 @@
 #include "plugin.h"
 #include "adapter.h"
 #include "log.h"
-#include "dbus-hci.h"
 
 static void formfactor_reply(DBusPendingCall *call, void *user_data)
 {
-- 
1.7.0.4
on behalf of ST-Ericsson
