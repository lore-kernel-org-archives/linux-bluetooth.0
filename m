Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Shengzhen Li <szli@marvell.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: change device pointer passed to dev_coredumpv
Date: Wed, 19 Aug 2015 03:12:19 -0700
Message-ID: <1439979139-15930-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Shengzhen Li <szli@marvell.com>

This change ensures we will get driver name as 'btmrvl_sdio'
in udev event.

Signed-off-by: Shengzhen Li <szli@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 7c09762..b9978a7 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1376,8 +1376,7 @@ done:
 
 	/* fw_dump_data will be free in device coredump release function
 	   after 5 min*/
-	dev_coredumpv(&priv->btmrvl_dev.hcidev->dev, fw_dump_data,
-		      fw_dump_len, GFP_KERNEL);
+	dev_coredumpv(&card->func->dev, fw_dump_data, fw_dump_len, GFP_KERNEL);
 	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump end");
 }
 
-- 
1.8.1.4
