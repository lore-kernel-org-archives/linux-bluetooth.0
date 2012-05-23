Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/6] Bluetooth: Remove 'register' usage from the subsystem
Date: Wed, 23 May 2012 04:04:19 -0300
Message-Id: <1337756663-19805-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
References: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Let the compiler chooses what is best.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/bluetooth/bluecard_cs.c |   10 +++++-----
 drivers/bluetooth/bt3c_cs.c     |    4 ++--
 drivers/bluetooth/btuart_cs.c   |    4 ++--
 drivers/bluetooth/dtl1_cs.c     |    4 ++--
 drivers/bluetooth/hci_bcsp.c    |    2 +-
 drivers/bluetooth/hci_h4.c      |    2 +-
 drivers/bluetooth/hci_ll.c      |    6 +++---
 net/bluetooth/hci_conn.c        |    2 +-
 net/bluetooth/hci_sock.c        |    2 +-
 net/bluetooth/sco.c             |    2 +-
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 1fcd923..585c88e 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -231,12 +231,12 @@ static void bluecard_write_wakeup(bluecard_info_t *info)
 	}
 
 	do {
-		register unsigned int iobase = info->p_dev->resource[0]->start;
-		register unsigned int offset;
-		register unsigned char command;
-		register unsigned long ready_bit;
+		unsigned int iobase = info->p_dev->resource[0]->start;
+		unsigned int offset;
+		unsigned char command;
+		unsigned long ready_bit;
 		register struct sk_buff *skb;
-		register int len;
+		int len;
 
 		clear_bit(XMIT_WAKEUP, &(info->tx_state));
 
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 308c859..b2b0fbb 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -186,9 +186,9 @@ static void bt3c_write_wakeup(bt3c_info_t *info)
 		return;
 
 	do {
-		register unsigned int iobase = info->p_dev->resource[0]->start;
+		unsigned int iobase = info->p_dev->resource[0]->start;
 		register struct sk_buff *skb;
-		register int len;
+		int len;
 
 		if (!pcmcia_dev_present(info->p_dev))
 			break;
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index c4fc2f3..65b8d99 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -140,9 +140,9 @@ static void btuart_write_wakeup(btuart_info_t *info)
 	}
 
 	do {
-		register unsigned int iobase = info->p_dev->resource[0]->start;
+		unsigned int iobase = info->p_dev->resource[0]->start;
 		register struct sk_buff *skb;
-		register int len;
+		int len;
 
 		clear_bit(XMIT_WAKEUP, &(info->tx_state));
 
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 6e8d961..b1b37cc 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -144,9 +144,9 @@ static void dtl1_write_wakeup(dtl1_info_t *info)
 	}
 
 	do {
-		register unsigned int iobase = info->p_dev->resource[0]->start;
+		unsigned int iobase = info->p_dev->resource[0]->start;
 		register struct sk_buff *skb;
-		register int len;
+		int len;
 
 		clear_bit(XMIT_WAKEUP, &(info->tx_state));
 
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 661a8dc..57e502e 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -552,7 +552,7 @@ static u16 bscp_get_crc(struct bcsp_struct *bcsp)
 static int bcsp_recv(struct hci_uart *hu, void *data, int count)
 {
 	struct bcsp_struct *bcsp = hu->priv;
-	register unsigned char *ptr;
+	unsigned char *ptr;
 
 	BT_DBG("hu %p count %d rx_state %d rx_count %ld", 
 		hu, count, bcsp->rx_state, bcsp->rx_count);
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 7483294..c60623f 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -126,7 +126,7 @@ static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 
 static inline int h4_check_data_len(struct h4_struct *h4, int len)
 {
-	register int room = skb_tailroom(h4->rx_skb);
+	int room = skb_tailroom(h4->rx_skb);
 
 	BT_DBG("len %d room %d", len, room);
 
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index b874c0e..ff6d589 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -348,7 +348,7 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 
 static inline int ll_check_data_len(struct ll_struct *ll, int len)
 {
-	register int room = skb_tailroom(ll->rx_skb);
+	int room = skb_tailroom(ll->rx_skb);
 
 	BT_DBG("len %d room %d", len, room);
 
@@ -374,11 +374,11 @@ static inline int ll_check_data_len(struct ll_struct *ll, int len)
 static int ll_recv(struct hci_uart *hu, void *data, int count)
 {
 	struct ll_struct *ll = hu->priv;
-	register char *ptr;
+	char *ptr;
 	struct hci_event_hdr *eh;
 	struct hci_acl_hdr   *ah;
 	struct hci_sco_hdr   *sh;
-	register int len, type, dlen;
+	int len, type, dlen;
 
 	BT_DBG("hu %p count %d rx_state %ld rx_count %ld", hu, count, ll->rx_state, ll->rx_count);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 971601e..b9f13f6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -800,7 +800,7 @@ EXPORT_SYMBOL(hci_conn_put_device);
 
 int hci_get_conn_list(void __user *arg)
 {
-	register struct hci_conn *c;
+	struct hci_conn *c;
 	struct hci_conn_list_req req, *cl;
 	struct hci_conn_info *ci;
 	struct hci_dev *hdev;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 89767ad..c1e0c3d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -118,7 +118,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			continue;
 
 		if (bt_cb(skb)->pkt_type == HCI_EVENT_PKT) {
-			register int evt = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
+			int evt = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
 
 			if (!hci_test_bit(evt, &flt->event_mask))
 				continue;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 824ae2f..6401cca 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -908,7 +908,7 @@ done:
 /* ----- SCO interface with lower layer (HCI) ----- */
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
-	register struct sock *sk;
+	struct sock *sk;
 	struct hlist_node *node;
 	int lm = 0;
 
-- 
1.7.10.1

