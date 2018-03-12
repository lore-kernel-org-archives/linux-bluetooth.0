Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 4/5] Bluetooth: btmrvl: Delete an unnecessary variable
 initialisation in btmrvl_sdio_card_to_host()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <2c2f8733-c5c0-cb2f-62eb-4fa360ee271e@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:34:15 +0100
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 11:15:59 +0100

The variable "payload" will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 9854addc8e96..05c78fcc13ff 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -691,5 +691,5 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	u32 type;
-	u8 *payload = NULL;
+	u8 *payload;
 	struct hci_dev *hdev = priv->btmrvl_dev.hcidev;
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 
-- 
2.16.2
