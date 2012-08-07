Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	raja_mani@ti.com, sachin.kamat@linaro.org, patches@linaro.org
Subject: [PATCH] Bluetooth: Use module_platform_driver() in btwilink.c file
Date: Tue,  7 Aug 2012 10:37:45 +0530
Message-Id: <1344316065-2032-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

module_platform_driver() makes the code simpler by eliminating module_init
and module_exit calls.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This patch is based on bluetooth-next tree and is compile tested.
---
 drivers/bluetooth/btwilink.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 4ad7b35..60abf59 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -358,21 +358,7 @@ static struct platform_driver btwilink_driver = {
 	},
 };
 
-/* ------- Module Init/Exit interfaces ------ */
-static int __init btwilink_init(void)
-{
-	BT_INFO("Bluetooth Driver for TI WiLink - Version %s", VERSION);
-
-	return platform_driver_register(&btwilink_driver);
-}
-
-static void __exit btwilink_exit(void)
-{
-	platform_driver_unregister(&btwilink_driver);
-}
-
-module_init(btwilink_init);
-module_exit(btwilink_exit);
+module_platform_driver(btwilink_driver);
 
 /* ------ Module Info ------ */
 
-- 
1.7.4.1

