Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use MD SET register for changing SDIO Type-B to Type-A
Date: Sat, 28 Dec 2013 22:10:02 -0800
Message-Id: <1388297402-48660-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The register for setting the SDIO card mode of a Type-B Bluetooth card
is called MD SET. The MD STAT register is used for reading the current
mode back.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btsdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 1f6815825e61..83f6437dd91d 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -73,6 +73,7 @@ struct btsdio_data {
 #define REG_CL_INTRD 0x13	/* Interrupt Clear */
 #define REG_EN_INTRD 0x14	/* Interrupt Enable */
 #define REG_MD_STAT  0x20	/* Bluetooth Mode Status */
+#define REG_MD_SET   0x20	/* Bluetooth Mode Set */
 
 static int btsdio_tx_packet(struct btsdio_data *data, struct sk_buff *skb)
 {
@@ -212,7 +213,7 @@ static int btsdio_open(struct hci_dev *hdev)
 	}
 
 	if (data->func->class == SDIO_CLASS_BT_B)
-		sdio_writeb(data->func, 0x00, REG_MD_STAT, NULL);
+		sdio_writeb(data->func, 0x00, REG_MD_SET, NULL);
 
 	sdio_writeb(data->func, 0x01, REG_EN_INTRD, NULL);
 
-- 
1.8.4.2

