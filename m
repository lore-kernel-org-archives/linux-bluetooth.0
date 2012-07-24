Return-Path: <cyrus@holtmann.org>
From: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
Subject: [PATCH 1/2] Bluetooth: Usage of HCI channels in L2CAP
Date: Tue, 24 Jul 2012 15:24:59 +0530
Message-ID: <1343123700-23375-2-git-send-email-manojkr.sharma@stericsson.com>
In-Reply-To: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
References: <y>
 <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An HCI channel should be used per L2CAP channel. This one to one
mapping would allow enforcing L2CAP channel features on related
HCI channel. Existing HCI channel will be used only for L2CAP
signalling.

Signed-off-by: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9b242c6..f26a468 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -410,6 +410,7 @@ struct l2cap_chan {
 	struct sock *sk;
 
 	struct l2cap_conn	*conn;
+	struct hci_chan	*hchan;
 
 	__u8		state;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6f9c25b..ad6a65f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -300,6 +300,8 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
+	struct hci_chan *hchan;
+
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
 
@@ -342,6 +344,9 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	chan->local_acc_lat	= L2CAP_DEFAULT_ACC_LAT;
 	chan->local_flush_to	= L2CAP_DEFAULT_FLUSH_TO;
 
+	hchan = hci_chan_create(conn->hcon);
+	chan->hchan = hchan;
+
 	l2cap_chan_hold(chan);
 
 	list_add(&chan->list, &conn->chan_l);
@@ -396,6 +401,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	skb_queue_purge(&chan->tx_q);
 
+	hci_chan_del(chan->hchan);
+
 	if (chan->mode == L2CAP_MODE_ERTM) {
 		struct srej_list *l, *tmp;
 
@@ -596,7 +603,7 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 		flags = ACL_START;
 
 	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-	hci_send_acl(chan->conn->hchan, skb, flags);
+	hci_send_acl(chan->hchan, skb, flags);
 }
 
 static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
-- 
1.6.6.1

