Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL
Date: Mon, 23 Jul 2018 11:56:51 +0800
Message-Id: <20180723035651.8423-1-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

qca_open() and qca_set_baudrate() are never called in atomic context.

They call kzalloc() and bt_skb_alloc() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05ec530b8a3a..021d966b8f08 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -390,7 +390,7 @@ static int qca_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p qca_open", hu);
 
-	qca = kzalloc(sizeof(struct qca_data), GFP_ATOMIC);
+	qca = kzalloc(sizeof(struct qca_data), GFP_KERNEL);
 	if (!qca)
 		return -ENOMEM;
 
@@ -861,7 +861,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	cmd[4] = baudrate;
 
-	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
+	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
 	if (!skb) {
 		bt_dev_err(hdev, "Failed to allocate baudrate packet");
 		return -ENOMEM;
-- 
2.17.0
