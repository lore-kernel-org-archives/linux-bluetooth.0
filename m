Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btmrvl: fix spelling mistake: "actived" -> "activated"
Date: Sat, 18 Feb 2017 22:52:55 +0000
Message-Id: <20170218225255.16735-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 23711fe..08e01f0 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1624,7 +1624,7 @@ static int btmrvl_sdio_suspend(struct device *dev)
 
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
-			BT_ERR("HS not actived, suspend failed!");
+			BT_ERR("HS not activated, suspend failed!");
 			priv->adapter->is_suspending = false;
 			return -EBUSY;
 		}
-- 
2.10.2
