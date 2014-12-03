Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increase minor version of core module
Date: Wed,  3 Dec 2014 19:46:10 +0100
Message-Id: <1417632370-31742-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the addition of support for Bluetooth Low Energy Secure Connections
feature, it makes sense to increase the minor version of the Bluetooth
core module.

The module version is not used anywhere, but it gives a nice extra
hint for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 339c74ad4553..4ba15917da5e 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -31,7 +31,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
-#define VERSION "2.19"
+#define VERSION "2.20"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
-- 
1.9.3

