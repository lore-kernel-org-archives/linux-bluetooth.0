Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 2/5] Bluetooth: btmrvl: Delete an unnecessary variable
 initialisation in btmrvl_sdio_register_dev()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <86aa2939-9823-f3ed-0cd7-0ca04131cdd4@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:32:32 +0100
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 10:20:04 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index df2a04bd8428..84c222abf0f7 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -920,7 +920,7 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 {
 	struct sdio_func *func;
 	u8 reg;
-	int ret = 0;
+	int ret;
 
 	if (!card || !card->func) {
 		BT_ERR("Error: card or function is NULL!");
-- 
2.16.2
