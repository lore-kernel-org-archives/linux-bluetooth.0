Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increase minor version of core module
Date: Thu, 20 Feb 2014 12:44:20 -0800
Message-Id: <1392929060-4999-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the addition of Resolvable Private Address (RPA) resolution
support for Bluetooth Low Energy connections, it makes sense to
increase the minor version of the Bluetooth core module.

The module version is not used anywhere, but it gives a nice extra
hint for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 0c5866bb49b6..2021c481cdb6 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -31,7 +31,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
-#define VERSION "2.18"
+#define VERSION "2.19"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
-- 
1.8.5.3

