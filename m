Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increase minor version of core module
Date: Thu, 22 Oct 2015 12:29:27 +0200
Message-Id: <1445509767-23389-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the addition of support for diagnostic feature, it makes sense to
increase the minor version of the Bluetooth core module.

The module version is not used anywhere, but it gives a nice extra
hint for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 70f9d945faf7..c55717929213 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -33,7 +33,7 @@
 
 #include "selftest.h"
 
-#define VERSION "2.20"
+#define VERSION "2.21"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
-- 
2.4.3

