Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nishant Sarmukadam <nishants@marvell.com>,
	Aniket Nagarnaik <aniketn@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: release sdio bus after firmware is up
Date: Thu, 6 Aug 2015 03:43:09 -0700
Message-ID: <1438857789-3909-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aniket Nagarnaik <aniketn@marvell.com>

We will not release sdio bus until firmware is completely
downloaded and becomes ready. Our 8887 A2 chip can have
separate firmware images for WLAN and bluetooth. This
patch fixes an issue observed when both drivers
simultaneously try to download respective firmwares.

Signed-off-by: Aniket Nagarnaik <aniketn@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b9a8119..7c09762 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1071,8 +1071,6 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 		}
 	}
 
-	sdio_release_host(card->func);
-
 	/*
 	 * winner or not, with this test the FW synchronizes when the
 	 * module can continue its initialization
@@ -1082,6 +1080,8 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 		return -ETIMEDOUT;
 	}
 
+	sdio_release_host(card->func);
+
 	return 0;
 
 done:
-- 
1.8.1.4

