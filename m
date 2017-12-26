Return-Path: <lukas@wunner.de>
Message-Id: <1958f497c2710a67d3549122ee7bd71a69b0dd6c.1514143015.git.lukas@wunner.de>
In-Reply-To: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 26 Dec 2017 17:07:34 +0200
Subject: [PATCH 2/3] Bluetooth: hci_bcm: Streamline runtime PM code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This driver seeks to force the Bluetooth device on for the duration of
5 seconds when the Bluetooth device has woken the host and after a
complete packet has been received.  It does that by calling:

    pm_runtime_get();
    pm_runtime_mark_last_busy();
    pm_runtime_put_autosuspend();

The same can be achieved more succinctly with:

    pm_request_resume();

That's because after runtime resuming the device, rpm_resume() invokes
pm_runtime_mark_last_busy() followed by rpm_idle(), which will cause
the device to be suspended after expiration of the autosuspend_delay.

No functional change intended.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index a1e59fc4acbc..539ba1c8615c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -251,9 +251,7 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 
 	bt_dev_dbg(bdev, "Host wake IRQ");
 
-	pm_runtime_get(bdev->dev);
-	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	pm_request_resume(bdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -580,11 +578,8 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 	} else if (!bcm->rx_skb) {
 		/* Delay auto-suspend when receiving completed packet */
 		mutex_lock(&bcm_device_lock);
-		if (bcm->dev && bcm_device_exists(bcm->dev)) {
-			pm_runtime_get(bcm->dev->dev);
-			pm_runtime_mark_last_busy(bcm->dev->dev);
-			pm_runtime_put_autosuspend(bcm->dev->dev);
-		}
+		if (bcm->dev && bcm_device_exists(bcm->dev))
+			pm_request_resume(bcm->dev->dev);
 		mutex_unlock(&bcm_device_lock);
 	}
 
-- 
2.15.1
