Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 05/12] Bluetooth: Don't use *_bh locks anymore
Date: Thu, 22 Dec 2011 16:56:06 -0200
Message-Id: <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Those locks are not shared between interrupt and process context anymore,
so remove the part that disable interruption. We are stiff safe because
preeption is disabled.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cd7bb3d..a1a50d2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -165,7 +165,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 {
 	int err;
 
-	write_lock_bh(&chan_list_lock);
+	write_lock(&chan_list_lock);
 
 	if (psm && __l2cap_global_chan_by_addr(psm, src)) {
 		err = -EADDRINUSE;
@@ -190,17 +190,17 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 	}
 
 done:
-	write_unlock_bh(&chan_list_lock);
+	write_unlock(&chan_list_lock);
 	return err;
 }
 
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
 {
-	write_lock_bh(&chan_list_lock);
+	write_lock(&chan_list_lock);
 
 	chan->scid = scid;
 
-	write_unlock_bh(&chan_list_lock);
+	write_unlock(&chan_list_lock);
 
 	return 0;
 }
@@ -289,9 +289,9 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 
 	chan->sk = sk;
 
-	write_lock_bh(&chan_list_lock);
+	write_lock(&chan_list_lock);
 	list_add(&chan->global_l, &chan_list);
-	write_unlock_bh(&chan_list_lock);
+	write_unlock(&chan_list_lock);
 
 	INIT_DELAYED_WORK(&chan->chan_timer, l2cap_chan_timeout);
 
@@ -306,9 +306,9 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 
 void l2cap_chan_destroy(struct l2cap_chan *chan)
 {
-	write_lock_bh(&chan_list_lock);
+	write_lock(&chan_list_lock);
 	list_del(&chan->global_l);
-	write_unlock_bh(&chan_list_lock);
+	write_unlock(&chan_list_lock);
 
 	l2cap_chan_put(chan);
 }
@@ -543,14 +543,14 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
 
-	spin_lock_bh(&conn->lock);
+	spin_lock(&conn->lock);
 
 	if (++conn->tx_ident > 128)
 		conn->tx_ident = 1;
 
 	id = conn->tx_ident;
 
-	spin_unlock_bh(&conn->lock);
+	spin_unlock(&conn->lock);
 
 	return id;
 }
@@ -4702,7 +4702,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 {
 	struct l2cap_chan *c;
 
-	read_lock_bh(&chan_list_lock);
+	read_lock(&chan_list_lock);
 
 	list_for_each_entry(c, &chan_list, global_l) {
 		struct sock *sk = c->sk;
@@ -4715,7 +4715,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 					c->sec_level, c->mode);
 }
 
-	read_unlock_bh(&chan_list_lock);
+	read_unlock(&chan_list_lock);
 
 	return 0;
 }
-- 
1.7.6.4

