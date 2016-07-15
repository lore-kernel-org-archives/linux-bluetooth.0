Return-Path: <marvell@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Minghsiu.Tsai@mediatek.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: reset is_suspending flag in failure path
Date: Fri, 15 Jul 2016 16:18:03 +0530
Message-ID: <1468579683-7061-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

is_suspending flag remains on when host sleep fails to enable. Data
path is unnecessarily blocked after this. This patch ensures to
reset the flag in failure path.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b7c3928..d02f2c1 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1625,6 +1625,7 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
 			BT_ERR("HS not actived, suspend failed!");
+			priv->adapter->is_suspending = false;
 			return -EBUSY;
 		}
 	}
-- 
1.8.1.4
