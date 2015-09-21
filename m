Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v2 1/2] Bluetooth: btmrvl: remove extra space in cast
Date: Mon, 21 Sep 2015 03:06:41 -0700
Message-ID: <1442830002-7626-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Coding style fix, extra spaces are removed to make casting
consistent.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 5f7c9be..68b7ff0 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -194,22 +194,22 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8688 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9105),
-			.driver_data = (unsigned long) &btmrvl_sdio_sd8688 },
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8688 },
 	/* Marvell SD8787 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911A),
-			.driver_data = (unsigned long) &btmrvl_sdio_sd8787 },
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
 	/* Marvell SD8787 Bluetooth AMP device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911B),
-			.driver_data = (unsigned long) &btmrvl_sdio_sd8787 },
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
 	/* Marvell SD8797 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912A),
-			.driver_data = (unsigned long) &btmrvl_sdio_sd8797 },
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8797 },
 	/* Marvell SD8887 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9136),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8887 },
 	/* Marvell SD8897 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912E),
-			.driver_data = (unsigned long) &btmrvl_sdio_sd8897 },
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8897 },
 
 	{ }	/* Terminating entry */
 };
-- 
1.8.1.4

