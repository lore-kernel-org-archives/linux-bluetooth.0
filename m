Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew
 Bresticker <abrestic@chromium.org>,
        Chin-Ran Lo <crlo@marvell.com>,
        Amitkumar
 Karwar <akarwar@marvell.com>,
        Avinash Patil <patila@marvell.com>, Xinming Hu
	<huxm@marvell.com>,
        Bing Zhao <bzhao@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: avoid sending data to firmware after hs_activated
Date: Mon, 14 Jul 2014 21:05:37 -0700
Message-ID: <1405397137-19690-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chin-Ran Lo <crlo@marvell.com>

We should suspend hci device and purge remaining data in tx queue
before enabling host sleep in firmware. If any data is sent to
firmware after host sleep is activated, firmware may end up
sending a TX_DONE interrupt to driver. If this interrupt gets
delivered to host while the SDIO host controller is suspending,
it may crash the system.

Conversely, in resume handler, we should resume hci device after
host sleep is de-activated.

Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index efff064..3e683b1 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1169,6 +1169,10 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	}
 
 	priv = card->priv;
+	hcidev = priv->btmrvl_dev.hcidev;
+	BT_DBG("%s: SDIO suspend", hcidev->name);
+	hci_suspend_dev(hcidev);
+	skb_queue_purge(&priv->adapter->tx_queue);
 
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
@@ -1176,10 +1180,6 @@ static int btmrvl_sdio_suspend(struct device *dev)
 			return -EBUSY;
 		}
 	}
-	hcidev = priv->btmrvl_dev.hcidev;
-	BT_DBG("%s: SDIO suspend", hcidev->name);
-	hci_suspend_dev(hcidev);
-	skb_queue_purge(&priv->adapter->tx_queue);
 
 	priv->adapter->is_suspended = true;
 
@@ -1221,13 +1221,13 @@ static int btmrvl_sdio_resume(struct device *dev)
 		return 0;
 	}
 
-	priv->adapter->is_suspended = false;
-	hcidev = priv->btmrvl_dev.hcidev;
-	BT_DBG("%s: SDIO resume", hcidev->name);
-	hci_resume_dev(hcidev);
 	priv->hw_wakeup_firmware(priv);
 	priv->adapter->hs_state = HS_DEACTIVATED;
+	hcidev = priv->btmrvl_dev.hcidev;
 	BT_DBG("%s: HS DEACTIVATED in resume!", hcidev->name);
+	priv->adapter->is_suspended = false;
+	BT_DBG("%s: SDIO resume", hcidev->name);
+	hci_resume_dev(hcidev);
 
 	return 0;
 }
-- 
1.8.2.3
