Return-Path: <geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Geliang Tang <geliangtang@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl: drop duplicate header slab.h
Date: Wed, 23 Nov 2016 23:14:01 +0800
Message-Id: <b8d01e387dcb3e909041baeea25b8bf81ad481a1.1479913974.git.geliangtang@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Drop duplicate header slab.h from btmrvl_drv.h.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/bluetooth/btmrvl_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index f742384..fc3caf4 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -32,7 +32,6 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/slab.h>
 #include <linux/of_irq.h>
 
 #define BTM_HEADER_LEN			4
-- 
2.9.3
