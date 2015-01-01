Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <patila@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v2 4/4] bluetooth: btmrvl: increase the priority of firmware download message
Date: Thu, 1 Jan 2015 00:13:42 -0800
Message-ID: <1420100022-4134-4-git-send-email-akarwar@marvell.com>
In-Reply-To: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
References: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

When driver is loaded, it is important to know if FW was already
active or it is freshly downloaded. This patch increases the
priority of the message.

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
