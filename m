Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] Bluetooth: check L2CAP length in first ACL fragment
Date: Tue,  7 Sep 2010 11:57:47 +0300
Message-Id: <1283849867-916-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1283849867-916-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1283849867-916-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Current Bluetooth code assembles fragments of big L2CAP packets
in l2cap_recv_acldata and then checks allowed L2CAP size in
assemled L2CAP packet (pi->imtu < skb->len).

The patch moves allowed L2CAP size check to the early stage when
we receive the first fragment of L2CAP packet. We do not need to
reserve and keep L2CAP fragments for bad packets.

Trace below is received when using stress tools sending big
fragmented L2CAP packets.
...
[ 1712.798492] swapper: page allocation failure. order:4, mode:0x4020
[ 1712.804809] [<c0031870>] (unwind_backtrace+0x0/0xdc) from [<c00a1f70>]
(__alloc_pages_nodemask+0x4)
[ 1712.814666] [<c00a1f70>] (__alloc_pages_nodemask+0x47c/0x4d4) from
[<c00a1fd8>] (__get_free_pages+)
[ 1712.824645] [<c00a1fd8>] (__get_free_pages+0x10/0x3c) from [<c026eb5c>]
(__alloc_skb+0x4c/0xfc)
[ 1712.833465] [<c026eb5c>] (__alloc_skb+0x4c/0xfc) from [<bf28c738>]
(l2cap_recv_acldata+0xf0/0x1f8 )
[ 1712.843322] [<bf28c738>] (l2cap_recv_acldata+0xf0/0x1f8 [l2cap]) from
[<bf0094ac>] (hci_rx_task+0x)
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 774e134..5adbaf8 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4654,6 +4654,8 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 
 	if (flags & ACL_START) {
 		struct l2cap_hdr *hdr;
+		struct sock *sk;
+		u16 cid;
 		int len;
 
 		if (conn->rx_len) {
@@ -4672,6 +4674,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 
 		hdr = (struct l2cap_hdr *) skb->data;
 		len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
+		cid = __le16_to_cpu(hdr->cid);
 
 		if (len == skb->len) {
 			/* Complete frame received */
@@ -4688,6 +4691,20 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 			goto drop;
 		}
 
+		sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
+		if (!sk)
+			goto drop;
+
+		if (l2cap_pi(sk)->imtu < len) {
+			BT_ERR("Frame exceeding recv MTU (len %d, MTU %d)",
+					len, l2cap_pi(sk)->imtu);
+			conn->rx_len = 0; /* needed? */
+			bh_unlock_sock(sk);
+			goto drop;
+		}
+
+		bh_unlock_sock(sk);
+
 		/* Allocate skb for the complete frame (with header) */
 		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
 		if (!conn->rx_skb)
-- 
1.7.0.4

