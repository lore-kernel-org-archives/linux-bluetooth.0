Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/14] Bluetooth: btusb: Update version number of the module
Date: Sun,  5 Apr 2015 03:04:59 -0700
Message-Id: <1428228299-28415-14-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The version number is cosmetic, but pretty handy for debugging purposes
and since the Broadcom protocol support is now optional, just increase
it to indicate the difference.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b11141aa2f4f..c06ceec13dbb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -31,7 +31,7 @@
 #include "btintel.h"
 #include "btbcm.h"
 
-#define VERSION "0.7"
+#define VERSION "0.8"
 
 static bool disable_scofix;
 static bool force_scofix;
-- 
2.1.0

