Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd] syncevolution: added missing header file
Date: Wed, 16 Nov 2011 16:44:54 +0100
Message-ID: <1321458294-20000-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/syncevolution.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index 41386b3..8a8b531 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -30,6 +30,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <glib.h>
+#include <sys/types.h>
 #include <dbus/dbus.h>
 
 #include <bluetooth/bluetooth.h>
-- 
1.7.6.4

