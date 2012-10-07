Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 5/8] Bluetooth: Remove GFP_ATOMIC usage from l2cap_core.c
Date: Mon,  8 Oct 2012 07:19:38 +0800
Message-Id: <1349651981-6251-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
References: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Since we change the Bluetooth core to run in process context we don't need
to use GFP_ATOMIC in many of places we were using it. The we just replace
by GFP_KERNEL.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 02a66fb..7914641 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -396,7 +396,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 {
 	struct l2cap_chan *chan;
 
-	chan = kzalloc(sizeof(*chan), GFP_ATOMIC);
+	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
 	if (!chan)
 		return NULL;
 
@@ -1378,7 +1378,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	if (!hchan)
 		return NULL;
 
-	conn = kzalloc(sizeof(struct l2cap_conn), GFP_ATOMIC);
+	conn = kzalloc(sizeof(struct l2cap_conn), GFP_KERNEL);
 	if (!conn) {
 		hci_chan_del(hchan);
 		return NULL;
@@ -1830,9 +1830,9 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 			/* Cloned sk_buffs are read-only, so we need a
 			 * writeable copy
 			 */
-			tx_skb = skb_copy(skb, GFP_ATOMIC);
+			tx_skb = skb_copy(skb, GFP_KERNEL);
 		} else {
-			tx_skb = skb_clone(skb, GFP_ATOMIC);
+			tx_skb = skb_clone(skb, GFP_KERNEL);
 		}
 
 		if (!tx_skb) {
@@ -2578,7 +2578,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		/* Don't send frame to the socket it came from */
 		if (skb->sk == sk)
 			continue;
-		nskb = skb_clone(skb, GFP_ATOMIC);
+		nskb = skb_clone(skb, GFP_KERNEL);
 		if (!nskb)
 			continue;
 
@@ -2604,7 +2604,7 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
 	len = L2CAP_HDR_SIZE + L2CAP_CMD_HDR_SIZE + dlen;
 	count = min_t(unsigned int, conn->mtu, len);
 
-	skb = bt_skb_alloc(count, GFP_ATOMIC);
+	skb = bt_skb_alloc(count, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -2634,7 +2634,7 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
 	while (len) {
 		count = min_t(unsigned int, conn->mtu, len);
 
-		*frag = bt_skb_alloc(count, GFP_ATOMIC);
+		*frag = bt_skb_alloc(count, GFP_KERNEL);
 		if (!*frag)
 			goto fail;
 
@@ -5612,7 +5612,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		}
 
 		/* Allocate skb for the complete frame (with header) */
-		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
+		conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
 		if (!conn->rx_skb)
 			goto drop;
 
-- 
1.7.11.4

