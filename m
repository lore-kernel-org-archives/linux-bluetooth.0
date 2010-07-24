Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Use hci_recv_stream_fragment() in UART driver
Date: Sat, 24 Jul 2010 01:46:57 -0300
Message-Id: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Use the new hci_recv_stream_fragment() to reassembly incoming UART
streams.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/hci_h4.c |  103 +-------------------------------------------
 1 files changed, 2 insertions(+), 101 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 3f038f5..b2cf50e 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -151,107 +151,8 @@ static inline int h4_check_data_len(struct h4_struct *h4, int len)
 /* Recv data */
 static int h4_recv(struct hci_uart *hu, void *data, int count)
 {
-	struct h4_struct *h4 = hu->priv;
-	register char *ptr;
-	struct hci_event_hdr *eh;
-	struct hci_acl_hdr   *ah;
-	struct hci_sco_hdr   *sh;
-	register int len, type, dlen;
-
-	BT_DBG("hu %p count %d rx_state %ld rx_count %ld", 
-			hu, count, h4->rx_state, h4->rx_count);
-
-	ptr = data;
-	while (count) {
-		if (h4->rx_count) {
-			len = min_t(unsigned int, h4->rx_count, count);
-			memcpy(skb_put(h4->rx_skb, len), ptr, len);
-			h4->rx_count -= len; count -= len; ptr += len;
-
-			if (h4->rx_count)
-				continue;
-
-			switch (h4->rx_state) {
-			case H4_W4_DATA:
-				BT_DBG("Complete data");
-
-				hci_recv_frame(h4->rx_skb);
-
-				h4->rx_state = H4_W4_PACKET_TYPE;
-				h4->rx_skb = NULL;
-				continue;
-
-			case H4_W4_EVENT_HDR:
-				eh = hci_event_hdr(h4->rx_skb);
-
-				BT_DBG("Event header: evt 0x%2.2x plen %d", eh->evt, eh->plen);
-
-				h4_check_data_len(h4, eh->plen);
-				continue;
-
-			case H4_W4_ACL_HDR:
-				ah = hci_acl_hdr(h4->rx_skb);
-				dlen = __le16_to_cpu(ah->dlen);
-
-				BT_DBG("ACL header: dlen %d", dlen);
-
-				h4_check_data_len(h4, dlen);
-				continue;
-
-			case H4_W4_SCO_HDR:
-				sh = hci_sco_hdr(h4->rx_skb);
-
-				BT_DBG("SCO header: dlen %d", sh->dlen);
-
-				h4_check_data_len(h4, sh->dlen);
-				continue;
-			}
-		}
-
-		/* H4_W4_PACKET_TYPE */
-		switch (*ptr) {
-		case HCI_EVENT_PKT:
-			BT_DBG("Event packet");
-			h4->rx_state = H4_W4_EVENT_HDR;
-			h4->rx_count = HCI_EVENT_HDR_SIZE;
-			type = HCI_EVENT_PKT;
-			break;
-
-		case HCI_ACLDATA_PKT:
-			BT_DBG("ACL packet");
-			h4->rx_state = H4_W4_ACL_HDR;
-			h4->rx_count = HCI_ACL_HDR_SIZE;
-			type = HCI_ACLDATA_PKT;
-			break;
-
-		case HCI_SCODATA_PKT:
-			BT_DBG("SCO packet");
-			h4->rx_state = H4_W4_SCO_HDR;
-			h4->rx_count = HCI_SCO_HDR_SIZE;
-			type = HCI_SCODATA_PKT;
-			break;
-
-		default:
-			BT_ERR("Unknown HCI packet type %2.2x", (__u8)*ptr);
-			hu->hdev->stat.err_rx++;
-			ptr++; count--;
-			continue;
-		};
-
-		ptr++; count--;
-
-		/* Allocate packet */
-		h4->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
-		if (!h4->rx_skb) {
-			BT_ERR("Can't allocate mem for new packet");
-			h4->rx_state = H4_W4_PACKET_TYPE;
-			h4->rx_count = 0;
-			return -ENOMEM;
-		}
-
-		h4->rx_skb->dev = (void *) hu->hdev;
-		bt_cb(h4->rx_skb)->pkt_type = type;
-	}
+	if (hci_recv_stream_fragment(hu->hdev, data, count) < 0)
+		BT_ERR("Frame Reassembly Failed");
 
 	return count;
 }
-- 
1.7.1.1
