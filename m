Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: btusb: Implement driver internal packet reassembly
Date: Tue, 16 Sep 2014 08:00:29 +0200
Message-Id: <1410847229-44007-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving USB interrupt, bulk or isochronous packet, they normally
come in fragments. So far the driver just handed each fragment off to
the hci_recv_fragment function of the Bluetooth core. That function is
however is so specific that is does not belong in the core. This patch
implements the same reassembly logic in the driver.

In addition this fixes a long standing bug where multiple complete
packets are received within a single USB packet.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 197 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 189 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index df585ab064fa..a423b84a0ed3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -275,13 +275,19 @@ struct btusb_data {
 	struct work_struct work;
 	struct work_struct waker;
 
+	struct usb_anchor deferred;
 	struct usb_anchor tx_anchor;
+	int tx_in_flight;
+	spinlock_t txlock;
+
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
-	struct usb_anchor deferred;
-	int tx_in_flight;
-	spinlock_t txlock;
+	spinlock_t rxlock;
+
+	struct sk_buff *evt_skb;
+	struct sk_buff *acl_skb;
+	struct sk_buff *sco_skb;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -296,19 +302,189 @@ struct btusb_data {
 	int suspend_count;
 };
 
+static inline void btusb_free_frags(struct btusb_data *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+
+	kfree_skb(data->evt_skb);
+	data->evt_skb = NULL;
+
+	kfree_skb(data->acl_skb);
+	data->acl_skb = NULL;
+
+	kfree_skb(data->sco_skb);
+	data->sco_skb = NULL;
+
+	spin_unlock_irqrestore(&data->rxlock, flags);
+}
+
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
-	return hci_recv_fragment(data->hdev, HCI_EVENT_PKT, buffer, count);
+	struct sk_buff *skb;
+	int err = 0;
+
+	spin_lock(&data->rxlock);
+	skb = data->evt_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_EVENT_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				err = -ENOMEM;
+				break;
+			}
+
+			bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+			bt_cb(skb)->expect = HCI_EVENT_HDR_SIZE;
+		}
+
+		len = min_t(uint, bt_cb(skb)->expect, count);
+		memcpy(skb_put(skb, len), buffer, len);
+
+		count -= len;
+		buffer += len;
+		bt_cb(skb)->expect -= len;
+
+		if (skb->len == HCI_EVENT_HDR_SIZE) {
+			/* Complete event header */
+			bt_cb(skb)->expect = hci_event_hdr(skb)->plen;
+
+			if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+				kfree_skb(skb);
+				skb = NULL;
+
+				err = -EILSEQ;
+				break;
+			}
+		}
+
+		if (bt_cb(skb)->expect == 0) {
+			/* Complete frame */
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->evt_skb = skb;
+	spin_unlock(&data->rxlock);
+
+	return err;
 }
 
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
-	return hci_recv_fragment(data->hdev, HCI_ACLDATA_PKT, buffer, count);
+	struct sk_buff *skb;
+	int err = 0;
+
+	spin_lock(&data->rxlock);
+	skb = data->acl_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				err = -ENOMEM;
+				break;
+			}
+
+			bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
+			bt_cb(skb)->expect = HCI_ACL_HDR_SIZE;
+		}
+
+		len = min_t(uint, bt_cb(skb)->expect, count);
+		memcpy(skb_put(skb, len), buffer, len);
+
+		count -= len;
+		buffer += len;
+		bt_cb(skb)->expect -= len;
+
+		if (skb->len == HCI_ACL_HDR_SIZE) {
+			__le16 dlen = hci_acl_hdr(skb)->dlen;
+
+			/* Complete ACL header */
+			bt_cb(skb)->expect = __le16_to_cpu(dlen);
+
+			if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+				kfree_skb(skb);
+				skb = NULL;
+
+				err = -EILSEQ;
+				break;
+			}
+		}
+
+		if (bt_cb(skb)->expect == 0) {
+			/* Complete frame */
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->acl_skb = skb;
+	spin_unlock(&data->rxlock);
+
+	return err;
 }
 
 static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 {
-	return hci_recv_fragment(data->hdev, HCI_SCODATA_PKT, buffer, count);
+	struct sk_buff *skb;
+	int err = 0;
+
+	spin_lock(&data->rxlock);
+	skb = data->sco_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_SCO_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				err = -ENOMEM;
+				break;
+			}
+
+			bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
+			bt_cb(skb)->expect = HCI_SCO_HDR_SIZE;
+		}
+
+		len = min_t(uint, bt_cb(skb)->expect, count);
+		memcpy(skb_put(skb, len), buffer, len);
+
+		count -= len;
+		buffer += len;
+		bt_cb(skb)->expect -= len;
+
+		if (skb->len == HCI_SCO_HDR_SIZE) {
+			/* Complete SCO header */
+			bt_cb(skb)->expect = hci_sco_hdr(skb)->dlen;
+
+			if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+				kfree_skb(skb);
+				skb = NULL;
+
+				err = -EILSEQ;
+				break;
+			}
+		}
+
+		if (bt_cb(skb)->expect == 0) {
+			/* Complete frame */
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->sco_skb = skb;
+	spin_unlock(&data->rxlock);
+
+	return err;
 }
 
 static void btusb_intr_complete(struct urb *urb)
@@ -726,6 +902,8 @@ static int btusb_close(struct hci_dev *hdev)
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
 
 	btusb_stop_traffic(data);
+	btusb_free_frags(data);
+
 	err = usb_autopm_get_interface(data->intf);
 	if (err < 0)
 		goto failed;
@@ -745,6 +923,7 @@ static int btusb_flush(struct hci_dev *hdev)
 	BT_DBG("%s", hdev->name);
 
 	usb_kill_anchored_urbs(&data->tx_anchor);
+	btusb_free_frags(data);
 
 	return 0;
 }
@@ -1827,13 +2006,14 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	init_usb_anchor(&data->deferred);
+	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
 
-	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
-	init_usb_anchor(&data->deferred);
+	spin_lock_init(&data->rxlock);
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
@@ -1966,6 +2146,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
+	btusb_free_frags(data);
 	hci_free_dev(hdev);
 }
 
-- 
1.9.3

