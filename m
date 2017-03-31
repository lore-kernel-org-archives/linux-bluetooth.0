Return-Path: <root@localhost.localdomain>
From: Xinming Hu <huxm@marvell.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Amitkumar Karwar
	<akarwar@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Xinming Hu
	<huxm@marvell.com>
Subject: [PATCH v3 1/2] Bluetooth: btmrvl: disable platform wakeup interrupt in suspend failure path
Date: Fri, 31 Mar 2017 14:32:31 +0800
Message-ID: <1490941952-9048-1-git-send-email-huxm@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Host sleep handshake with device might been fail, disable platform wakeup
interrupt in this case.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
v2: same as v1
v3: use Reported-by (Guenter)
---
 drivers/bluetooth/btmrvl_sdio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 2424ea2..95e40ec 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1630,6 +1630,13 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
 			BT_ERR("HS not activated, suspend failed!");
+			/* Disable platform specific wakeup interrupt */
+			if (card->plt_wake_cfg &&
+			    card->plt_wake_cfg->irq_bt >= 0) {
+				disable_irq_wake(card->plt_wake_cfg->irq_bt);
+				disable_irq(card->plt_wake_cfg->irq_bt);
+			}
+
 			priv->adapter->is_suspending = false;
 			return -EBUSY;
 		}
-- 
1.8.1.4
