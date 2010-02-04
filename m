Return-Path: <cyrus@holtmann.org>
Sender: Yoichi Yuasa <yuasa.linux@gmail.com>
Date: Thu, 4 Feb 2010 09:55:51 +0900
From: Yoichi Yuasa <yuasa@linux-mips.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: yuasa@linux-mips.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: fix memory leak Marvell BT-over-SDIO driver
Message-Id: <20100204095551.8d6a8c40.yuasa@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/bluetooth/btmrvl_sdio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index f36defa..57d965b 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -808,6 +808,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 
 exit:
 	sdio_release_host(card->func);
+	kfree(tmpbuf);
 
 	return ret;
 }
-- 
1.6.6.1
