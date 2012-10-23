Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Replace include linux/module.h with
 linux/export.h
Date: Tue, 23 Oct 2012 19:02:18 +0530
Message-id: <1350999140-7481-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

include <linux/export.h> is the right to go here.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/cmtp/capi.c |    2 +-
 net/bluetooth/cmtp/sock.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 50f0d13..a4a9d4b 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -20,7 +20,7 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/types.h>
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index d5cacef..ea0e813 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -20,7 +20,7 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <linux/types.h>
 #include <linux/capability.h>
-- 
1.7.9.5

