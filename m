Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: make array extension_sig static, shrinks object size
Date: Tue,  4 Sep 2018 17:01:10 +0100
Message-Id: <20180904160110.27837-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array extension_sig on the stack but instead make it
static. Makes the object code smaller by 59 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  14366	   4920	      0	  19286	   4b56	linux/drivers/bluetooth/btrtl.o

After:
   text	   data	    bss	    dec	    hex	filename
  14243	   4984	      0	  19227	   4b1b	linux/drivers/bluetooth/btrtl.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7f9ea8e4c1b2..52a9a55057c0 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -206,7 +206,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 				struct btrtl_device_info *btrtl_dev,
 				unsigned char **_buf)
 {
-	const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
+	static const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
 	struct rtl_epatch_header *epatch_info;
 	unsigned char *buf;
 	int i, len;
-- 
2.17.1
