Return-Path: <lukas@wunner.de>
Message-Id: <ae2d4efbe3ffbaf8b979f1b8a192cbb17d97499d.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 06/10] Bluetooth: hci_bcm: Silence IRQ printk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The host wake IRQ is optional, but if none is found, "BCM irq: -22" is
logged which may irritate users.  This is really a debug message, so use
dev_dbg() instead of dev_info().  If users are interested in the IRQ,
they can always consult /proc/interrupts.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 01d0943b7bbb..632939d413df 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -798,7 +798,7 @@ static int bcm_get_resources(struct bcm_device *dev)
 		dev->irq = gpiod_to_irq(gpio);
 	}
 
-	dev_info(dev->dev, "BCM irq: %d\n", dev->irq);
+	dev_dbg(dev->dev, "BCM irq: %d\n", dev->irq);
 	return 0;
 }
 
-- 
2.15.1
