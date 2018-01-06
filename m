Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bpa10x: make array 'req' static, shrinks object size
Date: Sat,  6 Jan 2018 16:15:14 +0000
Message-Id: <20180106161514.18308-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only array 'req' on the stack but instead
make it static. Makes the object code smaller by over 40 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   8497	   3408	    128	  12033	   2f01	linux/drivers/bluetooth/bpa10x.o

After:
   text	   data	    bss	    dec	    hex	filename
   8366	   3496	    128	  11990	   2ed6	linux/drivers/bluetooth/bpa10x.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/bpa10x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 7971bfbd4321..801ea4ca65e4 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -259,7 +259,7 @@ static int bpa10x_flush(struct hci_dev *hdev)
 
 static int bpa10x_setup(struct hci_dev *hdev)
 {
-	const u8 req[] = { 0x07 };
+	static const u8 req[] = { 0x07 };
 	struct sk_buff *skb;
 
 	BT_DBG("%s", hdev->name);
-- 
2.15.1
