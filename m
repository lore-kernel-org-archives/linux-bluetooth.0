Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <patila@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 4/4] bluetooth: btmrvl: increase the priority of firmware download message
Date: Wed, 31 Dec 2014 03:14:02 -0800
Message-ID: <1420024442-12137-4-git-send-email-akarwar@marvell.com>
In-Reply-To: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
References: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

When driver is loaded, it is important to know if FW was already
active or it is freshly downloaded. This patch increases the
priority of the message.

Signed-off-by: Marc Yang <yangyang@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 80ec200..01d6da5 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -573,7 +573,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 		offset += txlen;
 	} while (true);
 
-	BT_DBG("FW download over, size %d bytes", offset);
+	BT_INFO("FW download over, size %d bytes", offset);
 
 	ret = 0;
 
-- 
1.8.1.4
