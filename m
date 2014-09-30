Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
        <patila@marvell.com>, <huxm@marvell.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH 1/2] Bluetooth: btmrvl: rename definitions from 88xx to 8897
Date: Tue, 30 Sep 2014 06:45:32 -0400
Message-ID: <1412073933-7760-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Register offsets are different for SD8897 and newer chip SD8887.
We can not have common btmrvl_sdio_card_reg map for them.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 3e683b1..b549fb5 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -84,7 +84,7 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_87xx = {
 	.int_read_to_clear = false,
 };
 
-static const struct btmrvl_sdio_card_reg btmrvl_reg_88xx = {
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8897 = {
 	.cfg = 0x00,
 	.host_int_mask = 0x02,
 	.host_intstatus = 0x03,
@@ -131,7 +131,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 	.helper		= NULL,
 	.firmware	= "mrvl/sd8897_uapsta.bin",
-	.reg		= &btmrvl_reg_88xx,
+	.reg		= &btmrvl_reg_8897,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl	= 256,
 };
-- 
1.8.1.4
