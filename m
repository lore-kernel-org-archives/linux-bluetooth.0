Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increase the subsystem minor version number
Date: Thu,  8 Sep 2016 18:07:07 +0200
Message-Id: <1473350827-64104-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While the subsystem version information are purely informational,
increase the minor number due to the addition of user channel and
management control monitoring suppport. It is helpful for debugging
purposes to see the version numbers change.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d705bcf40710..0a1e21d7bce1 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -30,7 +30,7 @@
 #include <linux/seq_file.h>
 
 #define BT_SUBSYS_VERSION	2
-#define BT_SUBSYS_REVISION	21
+#define BT_SUBSYS_REVISION	22
 
 #ifndef AF_BLUETOOTH
 #define AF_BLUETOOTH	31
-- 
2.7.4

