Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Move handling of HCI_RUNNING flag into core
Date: Sun,  4 Oct 2015 23:34:02 +0200
Message-Id: <1443994443-123453-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Setting and clearing of HCI_RUNNING flag in each and every driver is
just duplicating the same code all over the place. So instead of having
the driver do it in their hdev->open and hdev->close callbacks, set it
globally in the core transport handling.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c       |  8 --------
 drivers/bluetooth/bluecard_cs.c |  6 ------
 drivers/bluetooth/bpa10x.c      |  8 --------
 drivers/bluetooth/bt3c_cs.c     |  6 ------
 drivers/bluetooth/btmrvl_main.c |  5 -----
 drivers/bluetooth/btsdio.c      | 11 +----------
 drivers/bluetooth/btuart_cs.c   |  6 ------
 drivers/bluetooth/btusb.c       |  7 -------
 drivers/bluetooth/btwilink.c    | 10 ----------
 drivers/bluetooth/dtl1_cs.c     |  5 -----
 drivers/bluetooth/hci_ldisc.c   |  6 ------
 drivers/bluetooth/hci_vhci.c    |  5 -----
 net/bluetooth/hci_core.c        |  3 +++
 13 files changed, 4 insertions(+), 82 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 3ba8170d08d3..616ec2ac1b22 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -422,17 +422,12 @@ static int bfusb_open(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p bfusb %p", hdev, data);
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	write_lock_irqsave(&data->lock, flags);
 
 	err = bfusb_rx_submit(data, NULL);
 	if (!err) {
 		for (i = 1; i < BFUSB_MAX_BULK_RX; i++)
 			bfusb_rx_submit(data, NULL);
-	} else {
-		clear_bit(HCI_RUNNING, &hdev->flags);
 	}
 
 	write_unlock_irqrestore(&data->lock, flags);
@@ -458,9 +453,6 @@ static int bfusb_close(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p bfusb %p", hdev, data);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	write_lock_irqsave(&data->lock, flags);
 	write_unlock_irqrestore(&data->lock, flags);
 
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 25b71664cdc3..36fa1c958c74 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -628,9 +628,6 @@ static int bluecard_hci_open(struct hci_dev *hdev)
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
 		bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
 
-	if (test_and_set_bit(HCI_RUNNING, &(hdev->flags)))
-		return 0;
-
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
 		unsigned int iobase = info->p_dev->resource[0]->start;
 
@@ -646,9 +643,6 @@ static int bluecard_hci_close(struct hci_dev *hdev)
 {
 	struct bluecard_info *info = hci_get_drvdata(hdev);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
-		return 0;
-
 	bluecard_hci_flush(hdev);
 
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 59b892464be5..88e004ee137e 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -304,9 +304,6 @@ static int bpa10x_open(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	err = bpa10x_submit_intr_urb(hdev);
 	if (err < 0)
 		goto error;
@@ -320,8 +317,6 @@ static int bpa10x_open(struct hci_dev *hdev)
 error:
 	usb_kill_anchored_urbs(&data->rx_anchor);
 
-	clear_bit(HCI_RUNNING, &hdev->flags);
-
 	return err;
 }
 
@@ -331,9 +326,6 @@ static int bpa10x_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	usb_kill_anchored_urbs(&data->rx_anchor);
 
 	return 0;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index b8f4b63175e7..5803aaed958f 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -270,7 +270,6 @@ static void bt3c_receive(struct bt3c_info *info)
 				/* Unknown packet */
 				BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
 				info->hdev->stat.err_rx++;
-				clear_bit(HCI_RUNNING, &(info->hdev->flags));
 
 				kfree_skb(info->rx_skb);
 				info->rx_skb = NULL;
@@ -395,17 +394,12 @@ static int bt3c_hci_flush(struct hci_dev *hdev)
 
 static int bt3c_hci_open(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &(hdev->flags));
-
 	return 0;
 }
 
 
 static int bt3c_hci_close(struct hci_dev *hdev)
 {
-	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
-		return 0;
-
 	bt3c_hci_flush(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 39552a8e9cc7..6ba22862d788 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -470,9 +470,6 @@ static int btmrvl_close(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	skb_queue_purge(&priv->adapter->tx_queue);
 
 	return 0;
@@ -480,8 +477,6 @@ static int btmrvl_close(struct hci_dev *hdev)
 
 static int btmrvl_open(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &hdev->flags);
-
 	return 0;
 }
 
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 21f99cc8c669..7b624423a7e8 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -194,21 +194,15 @@ static int btsdio_open(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	sdio_claim_host(data->func);
 
 	err = sdio_enable_func(data->func);
-	if (err < 0) {
-		clear_bit(HCI_RUNNING, &hdev->flags);
+	if (err < 0)
 		goto release;
-	}
 
 	err = sdio_claim_irq(data->func, btsdio_interrupt);
 	if (err < 0) {
 		sdio_disable_func(data->func);
-		clear_bit(HCI_RUNNING, &hdev->flags);
 		goto release;
 	}
 
@@ -229,9 +223,6 @@ static int btsdio_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	sdio_claim_host(data->func);
 
 	sdio_writeb(data->func, 0x00, REG_EN_INTRD, NULL);
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 4c001a8f7fbd..bb8e4025fb9e 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -223,7 +223,6 @@ static void btuart_receive(struct btuart_info *info)
 				/* Unknown packet */
 				BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
 				info->hdev->stat.err_rx++;
-				clear_bit(HCI_RUNNING, &(info->hdev->flags));
 
 				kfree_skb(info->rx_skb);
 				info->rx_skb = NULL;
@@ -409,17 +408,12 @@ static int btuart_hci_flush(struct hci_dev *hdev)
 
 static int btuart_hci_open(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &(hdev->flags));
-
 	return 0;
 }
 
 
 static int btuart_hci_close(struct hci_dev *hdev)
 {
-	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
-		return 0;
-
 	btuart_hci_flush(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9cf3796f92aa..247b1062cb9a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -940,9 +940,6 @@ static int btusb_open(struct hci_dev *hdev)
 
 	data->intf->needs_remote_wakeup = 1;
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
-		goto done;
-
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
 
@@ -965,7 +962,6 @@ done:
 
 failed:
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	clear_bit(HCI_RUNNING, &hdev->flags);
 	usb_autopm_put_interface(data->intf);
 	return err;
 }
@@ -984,9 +980,6 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 4db99a44f671..57eb935aedc7 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -155,9 +155,6 @@ static int ti_st_open(struct hci_dev *hdev)
 
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	/* provide contexts for callbacks from ST */
 	hst = hci_get_drvdata(hdev);
 
@@ -181,7 +178,6 @@ static int ti_st_open(struct hci_dev *hdev)
 			goto done;
 
 		if (err != -EINPROGRESS) {
-			clear_bit(HCI_RUNNING, &hdev->flags);
 			BT_ERR("st_register failed %d", err);
 			return err;
 		}
@@ -195,7 +191,6 @@ static int ti_st_open(struct hci_dev *hdev)
 			(&hst->wait_reg_completion,
 			 msecs_to_jiffies(BT_REGISTER_TIMEOUT));
 		if (!timeleft) {
-			clear_bit(HCI_RUNNING, &hdev->flags);
 			BT_ERR("Timeout(%d sec),didn't get reg "
 					"completion signal from ST",
 					BT_REGISTER_TIMEOUT / 1000);
@@ -205,7 +200,6 @@ static int ti_st_open(struct hci_dev *hdev)
 		/* Is ST registration callback
 		 * called with ERROR status? */
 		if (hst->reg_status != 0) {
-			clear_bit(HCI_RUNNING, &hdev->flags);
 			BT_ERR("ST registration completed with invalid "
 					"status %d", hst->reg_status);
 			return -EAGAIN;
@@ -215,7 +209,6 @@ done:
 		hst->st_write = ti_st_proto[i].write;
 		if (!hst->st_write) {
 			BT_ERR("undefined ST write function");
-			clear_bit(HCI_RUNNING, &hdev->flags);
 			for (i = 0; i < MAX_BT_CHNL_IDS; i++) {
 				/* Undo registration with ST */
 				err = st_unregister(&ti_st_proto[i]);
@@ -236,9 +229,6 @@ static int ti_st_close(struct hci_dev *hdev)
 	int err, i;
 	struct ti_st *hst = hci_get_drvdata(hdev);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	for (i = MAX_BT_CHNL_IDS-1; i >= 0; i--) {
 		err = st_unregister(&ti_st_proto[i]);
 		if (err)
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 84135c54ed2e..5026f66fac88 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -357,8 +357,6 @@ static irqreturn_t dtl1_interrupt(int irq, void *dev_inst)
 
 static int dtl1_hci_open(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &(hdev->flags));
-
 	return 0;
 }
 
@@ -376,9 +374,6 @@ static int dtl1_hci_flush(struct hci_dev *hdev)
 
 static int dtl1_hci_close(struct hci_dev *hdev)
 {
-	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
-		return 0;
-
 	dtl1_hci_flush(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 443feaebe275..01a83a3f8a1d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -208,9 +208,6 @@ static int hci_uart_open(struct hci_dev *hdev)
 	BT_DBG("%s %p", hdev->name, hdev);
 
 	/* Nothing to do for UART driver */
-
-	set_bit(HCI_RUNNING, &hdev->flags);
-
 	return 0;
 }
 
@@ -241,9 +238,6 @@ static int hci_uart_close(struct hci_dev *hdev)
 {
 	BT_DBG("hdev %p", hdev);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 15c344c9a00d..ed888e302bc3 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -55,8 +55,6 @@ struct vhci_data {
 
 static int vhci_open_dev(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &hdev->flags);
-
 	return 0;
 }
 
@@ -64,9 +62,6 @@ static int vhci_close_dev(struct hci_dev *hdev)
 {
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
-
 	skb_queue_purge(&data->readq);
 
 	return 0;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b955f7192651..40a67017bd32 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1385,6 +1385,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		goto done;
 	}
 
+	set_bit(HCI_RUNNING, &hdev->flags);
 	hci_notify(hdev, HCI_DEV_OPEN);
 
 	atomic_set(&hdev->cmd_cnt, 1);
@@ -1468,6 +1469,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 			hdev->sent_cmd = NULL;
 		}
 
+		clear_bit(HCI_RUNNING, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_CLOSE);
 
 		hdev->close(hdev);
@@ -1653,6 +1655,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->sent_cmd = NULL;
 	}
 
+	clear_bit(HCI_RUNNING, &hdev->flags);
 	hci_notify(hdev, HCI_DEV_CLOSE);
 
 	/* After this point our queues are empty
-- 
2.4.3

