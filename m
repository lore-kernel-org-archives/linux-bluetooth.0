Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increase minor version of core module
Date: Sun, 13 Oct 2013 13:09:02 -0700
Message-Id: <1381694942-59440-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There have been a lot of changes in the core Bluetooth handling
lately. So it is a good idea to increase the module version.

The module version is not used anywhere, but it makes debugging
a little bit simpler if versions can be distinguished.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index f0aadea..61501c9 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -30,7 +30,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
-#define VERSION "2.16"
+#define VERSION "2.17"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
-- 
1.8.3.1

