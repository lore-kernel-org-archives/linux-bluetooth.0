Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2014 19:46:16 +0100
Message-ID: <CAD9L4re8KghqVZYjZ3ZC_Jnh9V050kZrk5ySWsY9t3YVO2yt6g@mail.gmail.com>
Subject: [PATCH BlueZ] Create FIFO in /run instead of /tmp
From: Marcos Marado <mindboosternoori@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

This patch changes BlueZ to create its test FIFO on /run instead of /tmp , to
make SELinux happy.

---

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 542ae25..580213e 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -40,7 +40,7 @@
 #include "src/log.h"
 #include "suspend.h"

-#define HOG_SUSPEND_FIFO       "/tmp/hogsuspend"
+#define HOG_SUSPEND_FIFO       "/run/hogsuspend"

 static suspend_event suspend_cb = NULL;
 static resume_event resume_cb = NULL;

---

Best regards,
-- 
Marcos Marado
