Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add hdev parameter to hdev->send driver callback
Date: Fri, 11 Oct 2013 07:00:56 -0700
Message-Id: <1381500064-24414-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of masking hdev inside the skb->dev parameter, hand it
directly to the driver as a parameter to hdev->send. This makes
the driver interface more clear and simpler.

This patch fixes all drivers to accept and handle the new parameter
of hdev->send callback. Special care has been taken for bpa10x
and btusb drivers that require having skb->dev set to hdev for
the URB transmit complete handlers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c        | 3 +--
 drivers/bluetooth/bluecard_cs.c  | 3 +--
 drivers/bluetooth/bpa10x.c       | 5 +++--
 drivers/bluetooth/bt3c_cs.c      | 3 +--
 drivers/bluetooth/btmrvl_main.c  | 4 +---
 drivers/bluetooth/btsdio.c       | 3 +--
 drivers/bluetooth/btuart_cs.c    | 3 +--
 drivers/bluetooth/btusb.c        | 5 +++--
 drivers/bluetooth/btwilink.c     | 5 +----
 drivers/bluetooth/dtl1_cs.c      | 3 +--
 drivers/bluetooth/hci_ldisc.c    | 3 +--
 drivers/bluetooth/hci_ll.c       | 1 -
 drivers/bluetooth/hci_vhci.c     | 3 +--
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 4 +---
 15 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index b7b5bb8..a675849 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -464,9 +464,8 @@ static int bfusb_close(struct hci_dev *hdev)
 	return 0;
 }
 
-static int bfusb_send_frame(struct sk_buff *skb)
+static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	struct bfusb_data *data;
 	struct sk_buff *nskb;
 	unsigned char buf[3];
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 395acde..9194a1b 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -658,10 +658,9 @@ static int bluecard_hci_close(struct hci_dev *hdev)
 }
 
 
-static int bluecard_hci_send_frame(struct sk_buff *skb)
+static int bluecard_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	bluecard_info_t *info;
-	struct hci_dev *hdev = (struct hci_dev *)(skb->dev);
 
 	if (!hdev) {
 		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 3188fb4..b9e4e62 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -350,9 +350,8 @@ static int bpa10x_flush(struct hci_dev *hdev)
 	return 0;
 }
 
-static int bpa10x_send_frame(struct sk_buff *skb)
+static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	struct bpa10x_data *data = hci_get_drvdata(hdev);
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
@@ -364,6 +363,8 @@ static int bpa10x_send_frame(struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
+	skb->dev = (void *) hdev;
+
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index d8e4b0d..fcd5fe9 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -415,10 +415,9 @@ static int bt3c_hci_close(struct hci_dev *hdev)
 }
 
 
-static int bt3c_hci_send_frame(struct sk_buff *skb)
+static int bt3c_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	bt3c_info_t *info;
-	struct hci_dev *hdev = (struct hci_dev *)(skb->dev);
 	unsigned long flags;
 
 	if (!hdev) {
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 8ac4d93..547a447 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -187,7 +187,6 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 cmd_no,
 
 	bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
 
-	skb->dev = (void *) priv->btmrvl_dev.hcidev;
 	skb_queue_head(&priv->adapter->tx_queue, skb);
 
 	priv->btmrvl_dev.sendcmdflag = true;
@@ -356,9 +355,8 @@ static void btmrvl_free_adapter(struct btmrvl_private *priv)
 	priv->adapter = NULL;
 }
 
-static int btmrvl_send_frame(struct sk_buff *skb)
+static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	struct btmrvl_private *priv = NULL;
 
 	BT_DBG("type=%d, len=%d", skb->pkt_type, skb->len);
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 72fe49e..b61440a 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -254,9 +254,8 @@ static int btsdio_flush(struct hci_dev *hdev)
 	return 0;
 }
 
-static int btsdio_send_frame(struct sk_buff *skb)
+static int btsdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	struct btsdio_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index d0b89ec..f567cd8 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -423,10 +423,9 @@ static int btuart_hci_close(struct hci_dev *hdev)
 }
 
 
-static int btuart_hci_send_frame(struct sk_buff *skb)
+static int btuart_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	btuart_info_t *info;
-	struct hci_dev *hdev = (struct hci_dev *)(skb->dev);
 
 	if (!hdev) {
 		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index faa429f..621069c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -716,9 +716,8 @@ static int btusb_flush(struct hci_dev *hdev)
 	return 0;
 }
 
-static int btusb_send_frame(struct sk_buff *skb)
+static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
@@ -730,6 +729,8 @@ static int btusb_send_frame(struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
+	skb->dev = (void *) hdev;
+
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 5e10fb0..f038dba 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -251,14 +251,11 @@ static int ti_st_close(struct hci_dev *hdev)
 	return err;
 }
 
-static int ti_st_send_frame(struct sk_buff *skb)
+static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev;
 	struct ti_st *hst;
 	long len;
 
-	hdev = (struct hci_dev *)skb->dev;
-
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 2945141..ad1a2f9 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -382,10 +382,9 @@ static int dtl1_hci_close(struct hci_dev *hdev)
 }
 
 
-static int dtl1_hci_send_frame(struct sk_buff *skb)
+static int dtl1_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	dtl1_info_t *info;
-	struct hci_dev *hdev = (struct hci_dev *)(skb->dev);
 	struct sk_buff *s;
 	nsh_t nsh;
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index bc68a44..b040546 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -234,9 +234,8 @@ static int hci_uart_close(struct hci_dev *hdev)
 }
 
 /* Send frames from HCI layer */
-static int hci_uart_send_frame(struct sk_buff *skb)
+static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev* hdev = (struct hci_dev *) skb->dev;
 	struct hci_uart *hu;
 
 	if (!hdev) {
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 58a9541..69a90b1 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -110,7 +110,6 @@ static int send_hcill_cmd(u8 cmd, struct hci_uart *hu)
 	/* prepare packet */
 	hcill_packet = (struct hcill_cmd *) skb_put(skb, 1);
 	hcill_packet->cmd = cmd;
-	skb->dev = (void *) hu->hdev;
 
 	/* send packet */
 	skb_queue_tail(&ll->txq, skb);
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 0fd522e..e6f5919 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -81,9 +81,8 @@ static int vhci_flush(struct hci_dev *hdev)
 	return 0;
 }
 
-static int vhci_send_frame(struct sk_buff *skb)
+static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev* hdev = (struct hci_dev *) skb->dev;
 	struct vhci_data *data;
 
 	if (!hdev) {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 29b8147..0e01dc2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -285,7 +285,7 @@ struct hci_dev {
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
 	int (*setup)(struct hci_dev *hdev);
-	int (*send)(struct sk_buff *skb);
+	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4f0d4b4..a097a62 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2713,9 +2713,7 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Get rid of skb owner, prior to sending to the driver. */
 	skb_orphan(skb);
 
-	skb->dev = (void *) hdev;
-
-	if (hdev->send(skb) < 0)
+	if (hdev->send(hdev, skb) < 0)
 		BT_ERR("%s sending frame failed", hdev->name);
 }
 
-- 
1.8.3.1

