Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: make array 'param' static, shrinks object size
Date: Sat,  6 Jan 2018 16:23:28 +0000
Message-Id: <20180106162328.18625-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only array 'param' on the stack but instead
make it static. Makes the object code smaller by nearly 20 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  11605	   2629	     64	  14298	   37da	linux/drivers/bluetooth/btintel.o

After:
   text	   data	    bss	    dec	    hex	filename
  11531	   2685	     64	  14280	   37c8	linux/drivers/bluetooth/btintel.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 4459555c9d88..07f00e422e85 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -75,7 +75,7 @@ EXPORT_SYMBOL_GPL(btintel_check_bdaddr);
 
 int btintel_enter_mfg(struct hci_dev *hdev)
 {
-	const u8 param[] = { 0x01, 0x00 };
+	static const u8 param[] = { 0x01, 0x00 };
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc11, 2, param, HCI_CMD_TIMEOUT);
-- 
2.15.1
