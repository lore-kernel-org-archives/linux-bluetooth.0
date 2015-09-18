Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>,
	Nachiket Kukade <kukaden@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 1/2] Bluetooth: btmrvl: fix firmware dump issue
Date: Fri, 18 Sep 2015 06:40:40 -0700
Message-ID: <1442583641-3182-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nachiket Kukade <kukaden@marvell.com>

First firmware dump attempt from user works fine, but firmware goes
into bad state after this. Subsequent attempts fails.

As required by the firmware dump implementation, this change writes
FW_DUMP_READ_DONE value to dump ctrl register to address this issue.

Signed-off-by: Nachiket Kukade <kukaden@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b9978a7..5f7c9be 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1278,6 +1278,12 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 
 		if (memory_size == 0) {
 			BT_INFO("Firmware dump finished!");
+			sdio_writeb(card->func, FW_DUMP_READ_DONE,
+				    card->reg->fw_dump_ctrl, &ret);
+			if (ret) {
+				BT_ERR("SDIO Write MEMDUMP_FINISH ERR");
+				goto done;
+			}
 			break;
 		}
 
-- 
1.8.1.4

