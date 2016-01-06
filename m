Return-Path: <root@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <marcel@holtmann.org>,
        Chin-Ran Lo
	<crlo@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 1/2] Bluetooth: btmrvl: max out host sleep parameter 'gap'
Date: Wed, 6 Jan 2016 06:34:37 -0800
Message-ID: <1452090878-19586-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chin-Ran Lo <crlo@marvell.com>

For gpio=0xff (wake up host through SDIO interface) case,
gap=0xff means no delay (same as gap=0) for incoming data packet
to be sent to host after host sleep is activated.
Change it to the maximum delay to reduce the chance that RX
interrupt could be delivered while host controller suspends.

Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index f2b38c8..b2a567b 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -543,7 +543,7 @@ static int btmrvl_setup(struct hci_dev *hdev)
 	if (ret)
 		return ret;
 
-	priv->btmrvl_dev.gpio_gap = 0xffff;
+	priv->btmrvl_dev.gpio_gap = 0xfffe;
 
 	btmrvl_check_device_tree(priv);
 
-- 
1.8.1.4
