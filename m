Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] btmrvl: fix spelling mistake: "unregester" -> "unregister"
Date: Tue, 21 Mar 2017 12:20:28 +0000
Message-Id: <20170321122028.16224-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 08e01f002bad..7d052ce2052b 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1574,7 +1574,7 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 							MODULE_SHUTDOWN_REQ);
 				btmrvl_sdio_disable_host_int(card);
 			}
-			BT_DBG("unregester dev");
+			BT_DBG("unregister dev");
 			card->priv->surprise_removed = true;
 			btmrvl_sdio_unregister_dev(card);
 			btmrvl_remove_card(card->priv);
-- 
2.11.0
