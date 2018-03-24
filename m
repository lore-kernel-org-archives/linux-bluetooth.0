Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
Date: Sat, 24 Mar 2018 10:19:52 +0100
Message-Id: <20180324091954.73229-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCILL or eHCILL protocol from TI is actually an H:4 protocol with a
few extra events and thus can also use the h4_recv_buf helper. Instead
of open coding the same funtionality add the extra events to the packet
description table and use h4_recv_buf.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bluetooth/Kconfig  |   1 +
 drivers/bluetooth/hci_ll.c | 214 +++++++++++++++------------------------------
 2 files changed, 70 insertions(+), 145 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 07e55cd8f8c8..d2abcb768ae8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -147,6 +147,7 @@ config BT_HCIUART_ATH3K
 config BT_HCIUART_LL
 	bool "HCILL protocol support"
 	depends on BT_HCIUART_SERDEV
+	select BT_HCIUART_H4
 	help
 	  HCILL (HCI Low Level) is a serial protocol for communication
 	  between Bluetooth device and host. This protocol is required for
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 7c55a9f77808..27e414b4e3a2 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -67,13 +67,6 @@
 #define HCILL_WAKE_UP_IND	0x32
 #define HCILL_WAKE_UP_ACK	0x33
 
-/* HCILL receiver States */
-#define HCILL_W4_PACKET_TYPE	0
-#define HCILL_W4_EVENT_HDR	1
-#define HCILL_W4_ACL_HDR	2
-#define HCILL_W4_SCO_HDR	3
-#define HCILL_W4_DATA		4
-
 /* HCILL states */
 enum hcill_states_e {
 	HCILL_ASLEEP,
@@ -91,8 +84,6 @@ struct ll_device {
 };
 
 struct ll_struct {
-	unsigned long rx_state;
-	unsigned long rx_count;
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 	spinlock_t hcill_lock;		/* HCILL state lock	*/
@@ -373,155 +364,88 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
-static inline int ll_check_data_len(struct hci_dev *hdev, struct ll_struct *ll, int len)
+static int ll_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	int room = skb_tailroom(ll->rx_skb);
-
-	BT_DBG("len %d room %d", len, room);
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct ll_struct *ll = hu->priv;
 
-	if (!len) {
-		hci_recv_frame(hdev, ll->rx_skb);
-	} else if (len > room) {
-		BT_ERR("Data length is too large");
-		kfree_skb(ll->rx_skb);
-	} else {
-		ll->rx_state = HCILL_W4_DATA;
-		ll->rx_count = len;
-		return len;
+	switch (hci_skb_pkt_type(skb)) {
+	case HCILL_GO_TO_SLEEP_IND:
+		BT_DBG("HCILL_GO_TO_SLEEP_IND packet");
+		ll_device_want_to_sleep(hu);
+		break;
+	case HCILL_GO_TO_SLEEP_ACK:
+		/* shouldn't happen */
+		bt_dev_err(hdev, "received HCILL_GO_TO_SLEEP_ACK in state %ld",
+			   ll->hcill_state);
+		break;
+	case HCILL_WAKE_UP_IND:
+		BT_DBG("HCILL_WAKE_UP_IND packet");
+		ll_device_want_to_wakeup(hu);
+		break;
+	case HCILL_WAKE_UP_ACK:
+		BT_DBG("HCILL_WAKE_UP_ACK packet");
+		ll_device_woke_up(hu);
+		break;
 	}
 
-	ll->rx_state = HCILL_W4_PACKET_TYPE;
-	ll->rx_skb   = NULL;
-	ll->rx_count = 0;
-
+	kfree_skb(skb);
 	return 0;
 }
 
+#define LL_RECV_SLEEP_IND \
+	.type = HCILL_GO_TO_SLEEP_IND, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = 0
+
+#define LL_RECV_SLEEP_ACK \
+	.type = HCILL_GO_TO_SLEEP_ACK, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = 0
+
+#define LL_RECV_WAKE_IND \
+	.type = HCILL_WAKE_UP_IND, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = 0
+
+#define LL_RECV_WAKE_ACK \
+	.type = HCILL_WAKE_UP_ACK, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = 0
+
+static const struct h4_recv_pkt ll_recv_pkts[] = {
+	{ H4_RECV_ACL,       .recv = hci_recv_frame },
+	{ H4_RECV_SCO,       .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,     .recv = hci_recv_frame },
+	{ LL_RECV_SLEEP_IND, .recv = ll_recv_frame  },
+	{ LL_RECV_SLEEP_ACK, .recv = ll_recv_frame  },
+	{ LL_RECV_WAKE_IND,  .recv = ll_recv_frame  },
+	{ LL_RECV_WAKE_ACK,  .recv = ll_recv_frame  },
+};
+
 /* Recv data */
 static int ll_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct ll_struct *ll = hu->priv;
-	const char *ptr;
-	struct hci_event_hdr *eh;
-	struct hci_acl_hdr   *ah;
-	struct hci_sco_hdr   *sh;
-	int len, type, dlen;
-
-	BT_DBG("hu %p count %d rx_state %ld rx_count %ld", hu, count, ll->rx_state, ll->rx_count);
-
-	ptr = data;
-	while (count) {
-		if (ll->rx_count) {
-			len = min_t(unsigned int, ll->rx_count, count);
-			skb_put_data(ll->rx_skb, ptr, len);
-			ll->rx_count -= len; count -= len; ptr += len;
-
-			if (ll->rx_count)
-				continue;
-
-			switch (ll->rx_state) {
-			case HCILL_W4_DATA:
-				BT_DBG("Complete data");
-				hci_recv_frame(hu->hdev, ll->rx_skb);
-
-				ll->rx_state = HCILL_W4_PACKET_TYPE;
-				ll->rx_skb = NULL;
-				continue;
-
-			case HCILL_W4_EVENT_HDR:
-				eh = hci_event_hdr(ll->rx_skb);
-
-				BT_DBG("Event header: evt 0x%2.2x plen %d", eh->evt, eh->plen);
-
-				ll_check_data_len(hu->hdev, ll, eh->plen);
-				continue;
 
-			case HCILL_W4_ACL_HDR:
-				ah = hci_acl_hdr(ll->rx_skb);
-				dlen = __le16_to_cpu(ah->dlen);
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
 
-				BT_DBG("ACL header: dlen %d", dlen);
-
-				ll_check_data_len(hu->hdev, ll, dlen);
-				continue;
-
-			case HCILL_W4_SCO_HDR:
-				sh = hci_sco_hdr(ll->rx_skb);
-
-				BT_DBG("SCO header: dlen %d", sh->dlen);
-
-				ll_check_data_len(hu->hdev, ll, sh->dlen);
-				continue;
-			}
-		}
-
-		/* HCILL_W4_PACKET_TYPE */
-		switch (*ptr) {
-		case HCI_EVENT_PKT:
-			BT_DBG("Event packet");
-			ll->rx_state = HCILL_W4_EVENT_HDR;
-			ll->rx_count = HCI_EVENT_HDR_SIZE;
-			type = HCI_EVENT_PKT;
-			break;
-
-		case HCI_ACLDATA_PKT:
-			BT_DBG("ACL packet");
-			ll->rx_state = HCILL_W4_ACL_HDR;
-			ll->rx_count = HCI_ACL_HDR_SIZE;
-			type = HCI_ACLDATA_PKT;
-			break;
-
-		case HCI_SCODATA_PKT:
-			BT_DBG("SCO packet");
-			ll->rx_state = HCILL_W4_SCO_HDR;
-			ll->rx_count = HCI_SCO_HDR_SIZE;
-			type = HCI_SCODATA_PKT;
-			break;
-
-		/* HCILL signals */
-		case HCILL_GO_TO_SLEEP_IND:
-			BT_DBG("HCILL_GO_TO_SLEEP_IND packet");
-			ll_device_want_to_sleep(hu);
-			ptr++; count--;
-			continue;
-
-		case HCILL_GO_TO_SLEEP_ACK:
-			/* shouldn't happen */
-			BT_ERR("received HCILL_GO_TO_SLEEP_ACK (in state %ld)", ll->hcill_state);
-			ptr++; count--;
-			continue;
-
-		case HCILL_WAKE_UP_IND:
-			BT_DBG("HCILL_WAKE_UP_IND packet");
-			ll_device_want_to_wakeup(hu);
-			ptr++; count--;
-			continue;
-
-		case HCILL_WAKE_UP_ACK:
-			BT_DBG("HCILL_WAKE_UP_ACK packet");
-			ll_device_woke_up(hu);
-			ptr++; count--;
-			continue;
-
-		default:
-			BT_ERR("Unknown HCI packet type %2.2x", (__u8)*ptr);
-			hu->hdev->stat.err_rx++;
-			ptr++; count--;
-			continue;
-		}
-
-		ptr++; count--;
-
-		/* Allocate packet */
-		ll->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
-		if (!ll->rx_skb) {
-			BT_ERR("Can't allocate mem for new packet");
-			ll->rx_state = HCILL_W4_PACKET_TYPE;
-			ll->rx_count = 0;
-			return -ENOMEM;
-		}
-
-		hci_skb_pkt_type(ll->rx_skb) = type;
+	ll->rx_skb = h4_recv_buf(hu->hdev, ll->rx_skb, data, count,
+				 ll_recv_pkts, ARRAY_SIZE(ll_recv_pkts));
+	if (IS_ERR(ll->rx_skb)) {
+		int err = PTR_ERR(ll->rx_skb);
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
+		ll->rx_skb = NULL;
+		return err;
 	}
 
 	return count;
-- 
2.14.3

