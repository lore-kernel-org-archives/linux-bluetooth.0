Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increase minor version of core module
Date: Sat,  7 Dec 2013 09:06:24 -0800
Message-Id: <1386435984-35260-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the addition of L2CAP Connection Oriented Channels for Bluetooth
Low Energy connections, it makes sense to increase the minor version
of the Bluetooth core module.

The module version is not used anywhere, but it gives a nice extra
hint for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 56ca494621c6..0c5866bb49b6 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -31,7 +31,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
-#define VERSION "2.17"
+#define VERSION "2.18"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
-- 
1.8.3.1

