Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] fakehid: Remove unneeded header includes
Date: Thu,  5 Apr 2012 19:54:37 -0300
Message-Id: <1333666478-9744-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/fakehid.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/input/fakehid.c b/input/fakehid.c
index b809870..f56eb2b 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -33,11 +33,8 @@
 #include <sys/types.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/hidp.h>
-#include <bluetooth/sdp.h>
 
 #include <glib.h>
-#include <dbus/dbus.h>
 
 #include "../src/adapter.h"
 #include "../src/device.h"
-- 
1.7.8.5

