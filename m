Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Wei-Ning Huang <wnhuang@chromium.org>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, akarwar@marvell.com,
	Wei-Ning Huang <wnhuang@chromium.org>
Subject: [PATCH] Bluetooth: btmrvl_main: read wakeup-pin and gpio_gap as u32
Date: Wed,  1 Jun 2016 15:24:05 +0800
Message-Id: <1464765845-9079-1-git-send-email-wnhuang@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The dt binding document for Marvell bt-sd8897 specify the
'marvell,wakeup-pin' and 'marvell,gpio-gap-ms' attributes to be a 32-bit
value, but the driver parse it as 16-bit instead. Fix this to meet the
dt-binding document, and to be consistent with the 'marvell,wakeup-pin'
property in the mwifiex driver.

Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
---
 drivers/bluetooth/btmrvl_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 7ad8d61..b6d3404 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -513,21 +513,21 @@ static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
 	int ret = 0;
-	u16 gpio, gap;
+	u32 gpio, gap;
 
 	if (card->plt_of_node) {
 		dt_node = card->plt_of_node;
-		ret = of_property_read_u16(dt_node, "marvell,wakeup-pin",
+		ret = of_property_read_u32(dt_node, "marvell,wakeup-pin",
 					   &gpio);
 		if (ret)
 			gpio = (priv->btmrvl_dev.gpio_gap & 0xff00) >> 8;
 
-		ret = of_property_read_u16(dt_node, "marvell,wakeup-gap-ms",
+		ret = of_property_read_u32(dt_node, "marvell,wakeup-gap-ms",
 					   &gap);
 		if (ret)
 			gap = (u8)(priv->btmrvl_dev.gpio_gap & 0x00ff);
 
-		priv->btmrvl_dev.gpio_gap = (gpio << 8) + gap;
+		priv->btmrvl_dev.gpio_gap = ((gpio & 0xff) << 8) + (gap & 0xff);
 
 		ret = of_property_read_u8_array(dt_node, "marvell,cal-data",
 						cal_data + BT_CAL_HDR_LEN,
-- 
2.1.2

