Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: btusb: Implement driver internal packet reassembly
Date: Tue, 16 Sep 2014 06:19:03 +0200
Message-Id: <1410841143-27058-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving USB interrupt, bulk or isochronous packet, they normally
come in fragments. So far the driver just handed each fragment off to
the hci_recv_fragment function of the Bluetooth core. That function is
however so specific that is does not belong in the core. This patch
implements the same reassembly logic in the driver.

In addition this fixes a long standing bug where multiple complete
packets are received within a single USB packet.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 118 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index df585ab064fa..aa67408840b4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -291,6 +291,10 @@ struct btusb_data {
 
 	__u8 cmdreq_type;
 
+	struct sk_buff *evt_skb;
+	struct sk_buff *acl_skb;
+	struct sk_buff *sco_skb;
+
 	unsigned int sco_num;
 	int isoc_altsetting;
 	int suspend_count;
@@ -298,17 +302,116 @@ struct btusb_data {
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
-	return hci_recv_fragment(data->hdev, HCI_EVENT_PKT, buffer, count);
+	struct sk_buff *skb = data->evt_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_EVENT_SIZE, GFP_ATOMIC);
+			if (!skb)
+				return -ENOMEM;
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
+		if (skb->len == HCI_EVENT_HDR_SIZE)
+			bt_cb(skb)->expect = hci_event_hdr(skb)->plen;
+
+		if (bt_cb(skb)->expect == 0) {
+			/* Complete frame */
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->evt_skb = skb;
+	return 0;
 }
 
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
-	return hci_recv_fragment(data->hdev, HCI_ACLDATA_PKT, buffer, count);
+	struct sk_buff *skb = data->acl_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!skb)
+				return -ENOMEM;
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
+			bt_cb(skb)->expect = __le16_to_cpu(dlen);
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
+	return 0;
 }
 
 static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 {
-	return hci_recv_fragment(data->hdev, HCI_SCODATA_PKT, buffer, count);
+	struct sk_buff *skb = data->sco_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_SCO_SIZE, GFP_ATOMIC);
+			if (!skb)
+				return -ENOMEM;
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
+		if (skb->len == HCI_SCO_HDR_SIZE)
+			bt_cb(skb)->expect = hci_sco_hdr(skb)->dlen;
+
+		if (bt_cb(skb)->expect == 0) {
+			/* Complete frame */
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->sco_skb = skb;
+	return 0;
 }
 
 static void btusb_intr_complete(struct urb *urb)
@@ -1966,6 +2069,15 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
+	kfree_skb(data->evt_skb);
+	data->evt_skb = NULL;
+
+	kfree_skb(data->acl_skb);
+	data->acl_skb = NULL;
+
+	kfree_skb(data->sco_skb);
+	data->sco_skb = NULL;
+
 	hci_free_dev(hdev);
 }
 
-- 
1.9.3

