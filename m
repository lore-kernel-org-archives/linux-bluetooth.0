Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo
	<cluo@marvell.com>, Avinash Patil <patila@marvell.com>
Subject: [PATCH 3/3] Bluetooth: btmrvl: update hs_state in interrupt handler
Date: Wed, 19 Nov 2014 01:28:34 -0800
Message-ID: <1416389314-6327-3-git-send-email-akarwar@marvell.com>
In-Reply-To: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
References: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Host sleep status flag should be reset when there is an
interrupt from device.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Avinash Patil <patila@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e43c495..bb0d2c2 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -41,6 +41,11 @@ void btmrvl_interrupt(struct btmrvl_private *priv)
 
 	priv->adapter->int_count++;
 
+	if (priv->adapter->hs_state == HS_ACTIVATED) {
+		BT_DBG("BT: HS DEACTIVATED in ISR!\n");
+		priv->adapter->hs_state = HS_DEACTIVATED;
+	}
+
 	wake_up_interruptible(&priv->main_thread.wait_q);
 }
 EXPORT_SYMBOL_GPL(btmrvl_interrupt);
@@ -323,6 +328,7 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 		} else {
 			ret = priv->hw_wakeup_firmware(priv);
 			priv->adapter->hs_state = HS_DEACTIVATED;
+			BT_DBG("BT: HS DEACTIVATED due to host activity!\n");
 		}
 	}
 
-- 
1.8.1.4
