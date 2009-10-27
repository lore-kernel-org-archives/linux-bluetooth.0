Return-Path: <cyrus@holtmann.org>
From: David Vrabel <david.vrabel@csr.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, David Vrabel <david.vrabel@csr.com>
Subject: [PATCH] bluetooth: don't DMA to stack in btsdio driver
Date: Tue, 27 Oct 2009 14:28:31 +0000
Message-Id: <1256653711-17959-1-git-send-email-david.vrabel@csr.com>
In-Reply-To: <1256143300-16149-1-git-send-email-david.vrabel@csr.com>
References: <1256143300-16149-1-git-send-email-david.vrabel@csr.com>
List-ID: <linux-bluetooth.vger.kernel.org>

sdio_read() may use DMA so read the Type-A header into a kmalloc'd
buffer instead of an on-stack buffer (which results in a DMA API
warning).

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
Apply this instead, it frees the header buffer.

David

 drivers/bluetooth/btsdio.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 7e29827..59d0d3b 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -54,6 +54,7 @@ MODULE_DEVICE_TABLE(sdio, btsdio_table);
 struct btsdio_data {
 	struct hci_dev   *hdev;
 	struct sdio_func *func;
+	u8 *hdr_buf;
 
 	struct work_struct work;
 
@@ -122,7 +123,7 @@ static void btsdio_work(struct work_struct *work)
 
 static int btsdio_rx_packet(struct btsdio_data *data)
 {
-	u8 hdr[4] __attribute__ ((aligned(4)));
+	u8 *hdr = data->hdr_buf;
 	struct sk_buff *skb;
 	int err, len;
 
@@ -292,6 +293,7 @@ static void btsdio_destruct(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	kfree(data->hdr_buf);
 	kfree(data);
 }
 
@@ -299,9 +301,9 @@ static int btsdio_probe(struct sdio_func *func,
 				const struct sdio_device_id *id)
 {
 	struct btsdio_data *data;
-	struct hci_dev *hdev;
+	struct hci_dev *hdev = NULL;
 	struct sdio_func_tuple *tuple = func->tuples;
-	int err;
+	int err = -ENOMEM;
 
 	BT_DBG("func %p id %p class 0x%04x", func, id, func->class);
 
@@ -312,7 +314,11 @@ static int btsdio_probe(struct sdio_func *func,
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
+		goto error;
+
+	data->hdr_buf = kmalloc(4, GFP_KERNEL);
+	if (!data->hdr_buf)
+		goto error;
 
 	data->func = func;
 
@@ -321,10 +327,8 @@ static int btsdio_probe(struct sdio_func *func,
 	skb_queue_head_init(&data->txq);
 
 	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree(data);
-		return -ENOMEM;
-	}
+	if (!hdev)
+		goto error;
 
 	hdev->type = HCI_SDIO;
 	hdev->driver_data = data;
@@ -342,15 +346,20 @@ static int btsdio_probe(struct sdio_func *func,
 	hdev->owner = THIS_MODULE;
 
 	err = hci_register_dev(hdev);
-	if (err < 0) {
-		hci_free_dev(hdev);
-		kfree(data);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 
 	sdio_set_drvdata(func, data);
 
 	return 0;
+error:
+	if (data) {
+		if (hdev)
+			hci_free_dev(hdev);
+		kfree(data->hdr_buf);
+		kfree(data);
+	}
+	return err;
 }
 
 static void btsdio_remove(struct sdio_func *func)
-- 
1.6.3.3
