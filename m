Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Provide hdev parameter to hci_recv_frame() driver callback
Date: Thu, 10 Oct 2013 16:52:43 -0700
Message-Id: <1381449163-19932-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid casting skb->dev into hdev, just let the drivers provide
the hdev directly when calling hci_recv_frame() function.

This patch also fixes up all drivers to provide the hdev.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c        |  3 +--
 drivers/bluetooth/bluecard_cs.c  |  3 +--
 drivers/bluetooth/bpa10x.c       |  4 +---
 drivers/bluetooth/bt3c_cs.c      |  3 +--
 drivers/bluetooth/btmrvl_sdio.c  |  8 +++-----
 drivers/bluetooth/btsdio.c       |  3 +--
 drivers/bluetooth/btuart_cs.c    |  3 +--
 drivers/bluetooth/btwilink.c     |  4 +---
 drivers/bluetooth/dtl1_cs.c      |  3 +--
 drivers/bluetooth/hci_bcsp.c     |  5 ++---
 drivers/bluetooth/hci_h5.c       |  2 +-
 drivers/bluetooth/hci_ll.c       | 13 ++++++-------
 drivers/bluetooth/hci_vhci.c     |  3 +--
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         |  6 ++----
 15 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 66faad0..b7b5bb8 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -318,7 +318,6 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 			return -ENOMEM;
 		}
 
-		skb->dev = (void *) data->hdev;
 		bt_cb(skb)->pkt_type = pkt_type;
 
 		data->reassembly = skb;
@@ -333,7 +332,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		memcpy(skb_put(data->reassembly, len), buf, len);
 
 	if (hdr & 0x08) {
-		hci_recv_frame(data->reassembly);
+		hci_recv_frame(data->hdev, data->reassembly);
 		data->reassembly = NULL;
 	}
 
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index aa872c9..395acde 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -399,7 +399,6 @@ static void bluecard_receive(bluecard_info_t *info, unsigned int offset)
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			info->rx_skb->dev = (void *) info->hdev;
 			bt_cb(info->rx_skb)->pkt_type = buf[i];
 
 			switch (bt_cb(info->rx_skb)->pkt_type) {
@@ -477,7 +476,7 @@ static void bluecard_receive(bluecard_info_t *info, unsigned int offset)
 					break;
 
 				case RECV_WAIT_DATA:
-					hci_recv_frame(info->rx_skb);
+					hci_recv_frame(info->hdev, info->rx_skb);
 					info->rx_skb = NULL;
 					break;
 
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 2fe4a80..3188fb4 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -129,8 +129,6 @@ static int bpa10x_recv(struct hci_dev *hdev, int queue, void *buf, int count)
 				return -ENOMEM;
 			}
 
-			skb->dev = (void *) hdev;
-
 			data->rx_skb[queue] = skb;
 
 			scb = (void *) skb->cb;
@@ -155,7 +153,7 @@ static int bpa10x_recv(struct hci_dev *hdev, int queue, void *buf, int count)
 			data->rx_skb[queue] = NULL;
 
 			bt_cb(skb)->pkt_type = scb->type;
-			hci_recv_frame(skb);
+			hci_recv_frame(hdev, skb);
 		}
 
 		count -= len; buf += len;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 673455c..d8e4b0d 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -247,7 +247,6 @@ static void bt3c_receive(bt3c_info_t *info)
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			info->rx_skb->dev = (void *) info->hdev;
 			bt_cb(info->rx_skb)->pkt_type = inb(iobase + DATA_L);
 			inb(iobase + DATA_H);
 			//printk("bt3c: PACKET_TYPE=%02x\n", bt_cb(info->rx_skb)->pkt_type);
@@ -318,7 +317,7 @@ static void bt3c_receive(bt3c_info_t *info)
 					break;
 
 				case RECV_WAIT_DATA:
-					hci_recv_frame(info->rx_skb);
+					hci_recv_frame(info->hdev, info->rx_skb);
 					info->rx_skb = NULL;
 					break;
 
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 332475e..fabcf5b 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -600,15 +600,14 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	case HCI_SCODATA_PKT:
 	case HCI_EVENT_PKT:
 		bt_cb(skb)->pkt_type = type;
-		skb->dev = (void *)hdev;
 		skb_put(skb, buf_len);
 		skb_pull(skb, SDIO_HEADER_LEN);
 
 		if (type == HCI_EVENT_PKT) {
 			if (btmrvl_check_evtpkt(priv, skb))
-				hci_recv_frame(skb);
+				hci_recv_frame(hdev, skb);
 		} else {
-			hci_recv_frame(skb);
+			hci_recv_frame(hdev, skb);
 		}
 
 		hdev->stat.byte_rx += buf_len;
@@ -616,12 +615,11 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 
 	case MRVL_VENDOR_PKT:
 		bt_cb(skb)->pkt_type = HCI_VENDOR_PKT;
-		skb->dev = (void *)hdev;
 		skb_put(skb, buf_len);
 		skb_pull(skb, SDIO_HEADER_LEN);
 
 		if (btmrvl_process_event(priv, skb))
-			hci_recv_frame(skb);
+			hci_recv_frame(hdev, skb);
 
 		hdev->stat.byte_rx += buf_len;
 		break;
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 4a99097..5df403d 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -157,10 +157,9 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	data->hdev->stat.byte_rx += len;
 
-	skb->dev = (void *) data->hdev;
 	bt_cb(skb)->pkt_type = hdr[3];
 
-	err = hci_recv_frame(skb);
+	err = hci_recv_frame(hdev, skb);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 970e2d3..d0b89ec 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -198,7 +198,6 @@ static void btuart_receive(btuart_info_t *info)
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			info->rx_skb->dev = (void *) info->hdev;
 			bt_cb(info->rx_skb)->pkt_type = inb(iobase + UART_RX);
 
 			switch (bt_cb(info->rx_skb)->pkt_type) {
@@ -265,7 +264,7 @@ static void btuart_receive(btuart_info_t *info)
 					break;
 
 				case RECV_WAIT_DATA:
-					hci_recv_frame(info->rx_skb);
+					hci_recv_frame(info->hdev, info->rx_skb);
 					info->rx_skb = NULL;
 					break;
 
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 60abf59..5e10fb0 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -108,10 +108,8 @@ static long st_receive(void *priv_data, struct sk_buff *skb)
 		return -EFAULT;
 	}
 
-	skb->dev = (void *) lhst->hdev;
-
 	/* Forward skb to HCI core layer */
-	err = hci_recv_frame(skb);
+	err = hci_recv_frame(lhst->hdev, skb);
 	if (err < 0) {
 		BT_ERR("Unable to push skb to HCI core(%d)", err);
 		return err;
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index c43aff8..2945141 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -256,9 +256,8 @@ static void dtl1_receive(dtl1_info_t *info)
 				case 0x83:
 				case 0x84:
 					/* send frame to the HCI layer */
-					info->rx_skb->dev = (void *) info->hdev;
 					bt_cb(info->rx_skb)->pkt_type &= 0x0f;
-					hci_recv_frame(info->rx_skb);
+					hci_recv_frame(info->hdev, info->rx_skb);
 					break;
 				default:
 					/* unknown packet */
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 57e502e..0bc87f7 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -522,7 +522,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 				memcpy(skb_push(bcsp->rx_skb, HCI_EVENT_HDR_SIZE), &hdr, HCI_EVENT_HDR_SIZE);
 				bt_cb(bcsp->rx_skb)->pkt_type = HCI_EVENT_PKT;
 
-				hci_recv_frame(bcsp->rx_skb);
+				hci_recv_frame(hu->hdev, bcsp->rx_skb);
 			} else {
 				BT_ERR ("Packet for unknown channel (%u %s)",
 					bcsp->rx_skb->data[1] & 0x0f,
@@ -536,7 +536,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 		/* Pull out BCSP hdr */
 		skb_pull(bcsp->rx_skb, 4);
 
-		hci_recv_frame(bcsp->rx_skb);
+		hci_recv_frame(hu->hdev, bcsp->rx_skb);
 	}
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
@@ -655,7 +655,6 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
 					bcsp->rx_count = 0;
 					return 0;
 				}
-				bcsp->rx_skb->dev = (void *) hu->hdev;
 				break;
 			}
 			break;
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index b6154d5..f6f4974 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -340,7 +340,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 		/* Remove Three-wire header */
 		skb_pull(h5->rx_skb, 4);
 
-		hci_recv_frame(h5->rx_skb);
+		hci_recv_frame(hu->hdev, h5->rx_skb);
 		h5->rx_skb = NULL;
 
 		break;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index cfc7679..58a9541 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -346,14 +346,14 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
-static inline int ll_check_data_len(struct ll_struct *ll, int len)
+static inline int ll_check_data_len(struct hci_dev *hdev, struct ll_struct *ll, int len)
 {
 	int room = skb_tailroom(ll->rx_skb);
 
 	BT_DBG("len %d room %d", len, room);
 
 	if (!len) {
-		hci_recv_frame(ll->rx_skb);
+		hci_recv_frame(hdev, ll->rx_skb);
 	} else if (len > room) {
 		BT_ERR("Data length is too large");
 		kfree_skb(ll->rx_skb);
@@ -395,7 +395,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 			switch (ll->rx_state) {
 			case HCILL_W4_DATA:
 				BT_DBG("Complete data");
-				hci_recv_frame(ll->rx_skb);
+				hci_recv_frame(hu->hdev, ll->rx_skb);
 
 				ll->rx_state = HCILL_W4_PACKET_TYPE;
 				ll->rx_skb = NULL;
@@ -406,7 +406,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 
 				BT_DBG("Event header: evt 0x%2.2x plen %d", eh->evt, eh->plen);
 
-				ll_check_data_len(ll, eh->plen);
+				ll_check_data_len(hu->hdev, ll, eh->plen);
 				continue;
 
 			case HCILL_W4_ACL_HDR:
@@ -415,7 +415,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 
 				BT_DBG("ACL header: dlen %d", dlen);
 
-				ll_check_data_len(ll, dlen);
+				ll_check_data_len(hu->hdev, ll, dlen);
 				continue;
 
 			case HCILL_W4_SCO_HDR:
@@ -423,7 +423,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 
 				BT_DBG("SCO header: dlen %d", sh->dlen);
 
-				ll_check_data_len(ll, sh->dlen);
+				ll_check_data_len(hu->hdev, ll, sh->dlen);
 				continue;
 			}
 		}
@@ -494,7 +494,6 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 			return -ENOMEM;
 		}
 
-		ll->rx_skb->dev = (void *) hu->hdev;
 		bt_cb(ll->rx_skb)->pkt_type = type;
 	}
 
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index c04a3e6..0fd522e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -179,10 +179,9 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 			return -ENODEV;
 		}
 
-		skb->dev = (void *) data->hdev;
 		bt_cb(skb)->pkt_type = pkt_type;
 
-		ret = hci_recv_frame(skb);
+		ret = hci_recv_frame(data->hdev, skb);
 		break;
 
 	case HCI_VENDOR_PKT:
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 237bf8c..29b8147 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -755,7 +755,7 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
-int hci_recv_frame(struct sk_buff *skb);
+int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6cc2f86..4f0d4b4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2485,9 +2485,8 @@ int hci_resume_dev(struct hci_dev *hdev)
 EXPORT_SYMBOL(hci_resume_dev);
 
 /* Receive frame from HCI drivers */
-int hci_recv_frame(struct sk_buff *skb)
+int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
@@ -2546,7 +2545,6 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 		scb->expect = hlen;
 		scb->pkt_type = type;
 
-		skb->dev = (void *) hdev;
 		hdev->reassembly[index] = skb;
 	}
 
@@ -2606,7 +2604,7 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 			/* Complete frame */
 
 			bt_cb(skb)->pkt_type = type;
-			hci_recv_frame(skb);
+			hci_recv_frame(hdev, skb);
 
 			hdev->reassembly[index] = NULL;
 			return remain;
-- 
1.8.3.1

