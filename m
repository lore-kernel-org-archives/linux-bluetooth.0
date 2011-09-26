Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Sep 2011 09:14:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] bluetooth: hci_ll: clean up types a bit
Message-ID: <20110926061412.GA11832@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

I'm doing an audit of places where min_t() casting truncates a
variable such as:
	len = min_t(unsigned int, ll->rx_count, count);
Here ll->rx_count is unsigned long, but we cast it to unsigned int
and lose the significant bits.

Looking at the code ->rx_count is never more than 256 so we could
just make it an int.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 7e4b435..7bb1d8e 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -78,7 +78,7 @@ struct hcill_cmd {
 
 struct ll_struct {
 	unsigned long rx_state;
-	unsigned long rx_count;
+	unsigned int rx_count;
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 	spinlock_t hcill_lock;		/* HCILL state lock	*/
@@ -346,7 +346,7 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
-static inline int ll_check_data_len(struct ll_struct *ll, int len)
+static inline int ll_check_data_len(struct ll_struct *ll, unsigned int len)
 {
 	register int room = skb_tailroom(ll->rx_skb);
 
@@ -380,7 +380,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 	struct hci_sco_hdr   *sh;
 	register int len, type, dlen;
 
-	BT_DBG("hu %p count %d rx_state %ld rx_count %ld", hu, count, ll->rx_state, ll->rx_count);
+	BT_DBG("hu %p count %d rx_state %ld rx_count %u", hu, count, ll->rx_state, ll->rx_count);
 
 	ptr = data;
 	while (count) {
