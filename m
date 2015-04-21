Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <patila@marvell.com>,
        Xinming Hu
	<huxm@marvell.com>, Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: fix compilation warning
Date: Tue, 21 Apr 2015 06:59:56 -0700
Message-ID: <1429624796-4598-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

This patch fixes a compile warnning "dump_num maybe used uninitialized in
this function".

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 01d6da5..b9a8119 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1217,7 +1217,7 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	unsigned int reg, reg_start, reg_end;
 	enum rdwr_status stat;
 	u8 *dbg_ptr, *end_ptr, *fw_dump_data, *fw_dump_ptr;
-	u8 dump_num, idx, i, read_reg, doneflag = 0;
+	u8 dump_num = 0, idx, i, read_reg, doneflag = 0;
 	u32 memory_size, fw_dump_len = 0;
 
 	/* dump sdio register first */
-- 
1.8.1.4
