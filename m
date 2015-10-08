Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: bpa10x: Use h4_recv_buf helper for frame reassembly
Date: Thu,  8 Oct 2015 03:06:53 +0200
Message-Id: <1444266413-77165-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The manually coded frame reassembly is actually broken. The h4_recv_buf
helper from the UART driver is a perfect fit for frame reassembly for
this driver. So just export that function and use it here as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig  |   1 +
 drivers/bluetooth/bpa10x.c | 136 +++++++++------------------------------------
 drivers/bluetooth/hci_h4.c |   1 +
 3 files changed, 29 insertions(+), 109 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 62999546a301..c9c5dd0bad36 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -184,6 +184,7 @@ config BT_HCIBCM203X
 config BT_HCIBPA10X
 	tristate "HCI BPA10x USB driver"
 	depends on USB
+	select BT_HCIUART_H4
 	help
 	  Bluetooth HCI BPA10x USB driver.
 	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index a1a0f80212b3..49c397e21b39 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -35,7 +35,9 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#define VERSION "0.10"
+#include "hci_uart.h"
+
+#define VERSION "0.11"
 
 static const struct usb_device_id bpa10x_table[] = {
 	/* Tektronix BPA 100/105 (Digianswer) */
@@ -56,112 +58,6 @@ struct bpa10x_data {
 	struct sk_buff *rx_skb[2];
 };
 
-#define HCI_VENDOR_HDR_SIZE 5
-
-struct hci_vendor_hdr {
-	__u8    type;
-	__le16  snum;
-	__le16  dlen;
-} __packed;
-
-static int bpa10x_recv(struct hci_dev *hdev, int queue, void *buf, int count)
-{
-	struct bpa10x_data *data = hci_get_drvdata(hdev);
-
-	BT_DBG("%s queue %d buffer %p count %d", hdev->name,
-							queue, buf, count);
-
-	if (queue < 0 || queue > 1)
-		return -EILSEQ;
-
-	hdev->stat.byte_rx += count;
-
-	while (count) {
-		struct sk_buff *skb = data->rx_skb[queue];
-		struct { __u8 type; int expect; } *scb;
-		int type, len = 0;
-
-		if (!skb) {
-			/* Start of the frame */
-
-			type = *((__u8 *) buf);
-			count--; buf++;
-
-			switch (type) {
-			case HCI_EVENT_PKT:
-				if (count >= HCI_EVENT_HDR_SIZE) {
-					struct hci_event_hdr *h = buf;
-					len = HCI_EVENT_HDR_SIZE + h->plen;
-				} else
-					return -EILSEQ;
-				break;
-
-			case HCI_ACLDATA_PKT:
-				if (count >= HCI_ACL_HDR_SIZE) {
-					struct hci_acl_hdr *h = buf;
-					len = HCI_ACL_HDR_SIZE +
-							__le16_to_cpu(h->dlen);
-				} else
-					return -EILSEQ;
-				break;
-
-			case HCI_SCODATA_PKT:
-				if (count >= HCI_SCO_HDR_SIZE) {
-					struct hci_sco_hdr *h = buf;
-					len = HCI_SCO_HDR_SIZE + h->dlen;
-				} else
-					return -EILSEQ;
-				break;
-
-			case HCI_VENDOR_PKT:
-				if (count >= HCI_VENDOR_HDR_SIZE) {
-					struct hci_vendor_hdr *h = buf;
-					len = HCI_VENDOR_HDR_SIZE +
-							__le16_to_cpu(h->dlen);
-				} else
-					return -EILSEQ;
-				break;
-			}
-
-			skb = bt_skb_alloc(len, GFP_ATOMIC);
-			if (!skb) {
-				BT_ERR("%s no memory for packet", hdev->name);
-				return -ENOMEM;
-			}
-
-			data->rx_skb[queue] = skb;
-
-			scb = (void *) skb->cb;
-			scb->type = type;
-			scb->expect = len;
-		} else {
-			/* Continuation */
-
-			scb = (void *) skb->cb;
-			len = scb->expect;
-		}
-
-		len = min(len, count);
-
-		memcpy(skb_put(skb, len), buf, len);
-
-		scb->expect -= len;
-
-		if (scb->expect == 0) {
-			/* Complete frame */
-
-			data->rx_skb[queue] = NULL;
-
-			bt_cb(skb)->pkt_type = scb->type;
-			hci_recv_frame(hdev, skb);
-		}
-
-		count -= len; buf += len;
-	}
-
-	return 0;
-}
-
 static void bpa10x_tx_complete(struct urb *urb)
 {
 	struct sk_buff *skb = urb->context;
@@ -184,6 +80,22 @@ done:
 	kfree_skb(skb);
 }
 
+#define HCI_VENDOR_HDR_SIZE 5
+
+#define HCI_RECV_VENDOR \
+	.type = HCI_VENDOR_PKT, \
+	.hlen = HCI_VENDOR_HDR_SIZE, \
+	.loff = 3, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE
+
+static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
+	{ H4_RECV_ACL,     .recv = hci_recv_frame },
+	{ H4_RECV_SCO,     .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,   .recv = hci_recv_frame },
+	{ HCI_RECV_VENDOR, .recv = hci_recv_diag  },
+};
+
 static void bpa10x_rx_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -197,11 +109,17 @@ static void bpa10x_rx_complete(struct urb *urb)
 		return;
 
 	if (urb->status == 0) {
-		if (bpa10x_recv(hdev, usb_pipebulk(urb->pipe),
+		bool idx = usb_pipebulk(urb->pipe);
+
+		data->rx_skb[idx] = h4_recv_buf(hdev, data->rx_skb[idx],
 						urb->transfer_buffer,
-						urb->actual_length) < 0) {
+						urb->actual_length,
+						bpa10x_recv_pkts,
+						ARRAY_SIZE(bpa10x_recv_pkts));
+		if (IS_ERR(data->rx_skb[idx])) {
 			BT_ERR("%s corrupted event packet", hdev->name);
 			hdev->stat.err_rx++;
+			data->rx_skb[idx] = NULL;
 		}
 	}
 
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index eec3f28e4bb9..a6fce48da0fb 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -266,3 +266,4 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 
 	return skb;
 }
+EXPORT_SYMBOL_GPL(h4_recv_buf);
-- 
2.4.3

