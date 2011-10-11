Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 12/16] Bluetooth: EWS: recalculate L2CAP header size
Date: Tue, 11 Oct 2011 13:37:52 +0300
Message-Id: <1318329476-30153-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Recalculate length of L2CAP header based on Control field length.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6a5d1d6..92b0f03 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -566,12 +566,17 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
 	struct l2cap_conn *conn = chan->conn;
-	int count, hlen = L2CAP_HDR_SIZE + 2;
+	int count, hlen;
 	u8 flags;
 
 	if (chan->state != BT_CONNECTED)
 		return;
 
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		hlen = L2CAP_EXT_HDR_SIZE;
+	else
+		hlen = L2CAP_ENH_HDR_SIZE;
+
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += 2;
 
@@ -1539,7 +1544,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
-	int err, count, hlen = L2CAP_HDR_SIZE + 2;
+	int err, count, hlen;
 	struct l2cap_hdr *lh;
 
 	BT_DBG("sk %p len %d", sk, (int)len);
@@ -1547,6 +1552,11 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
 
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		hlen = L2CAP_EXT_HDR_SIZE;
+	else
+		hlen = L2CAP_ENH_HDR_SIZE;
+
 	if (sdulen)
 		hlen += 2;
 
@@ -3105,7 +3115,12 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 {
 	u16 our_fcs, rcv_fcs;
-	int hdr_size = L2CAP_HDR_SIZE + 2;
+	int hdr_size;
+
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		hdr_size = L2CAP_EXT_HDR_SIZE;
+	else
+		hdr_size = L2CAP_ENH_HDR_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		skb_trim(skb, skb->len - 2);
-- 
1.7.4.1

