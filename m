Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 04/17] Bluetooth: A2MP: Add chan callbacks
Date: Tue, 29 May 2012 13:59:04 +0300
Message-Id: <1338289158-25655-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add L2CAP chan ops callbacks.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 53f49a0..4ba67dc 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -63,8 +63,65 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+static void a2mp_chan_close_cb(struct l2cap_chan *chan)
+{
+	l2cap_chan_destroy(chan);
+}
+
+static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state)
+{
+	struct amp_mgr *mgr = chan->data;
+
+	if (!mgr)
+		return;
+
+	chan = mgr->a2mp_chan;
+
+	BT_DBG("chan %p state %s", chan, state_to_string(state));
+
+	chan->state = state;
+
+	switch (state) {
+	case BT_CLOSED:
+		if (mgr)
+			amp_mgr_put(mgr);
+		break;
+	}
+}
+
+static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
+					      unsigned long len, int nb)
+{
+	return bt_skb_alloc(len, GFP_KERNEL);
+}
+
+static struct l2cap_chan *a2mp_chan_no_new_conn_cb(struct l2cap_chan *chan)
+{
+	BT_ERR("new_connection for chan %p not implemented", chan);
+
+	return NULL;
+}
+
+static void a2mp_chan_no_teardown_cb(struct l2cap_chan *chan, int err)
+{
+	BT_ERR("teardown for chan %p not implemented", chan);
+}
+
+static void a2mp_chan_no_ready(struct l2cap_chan *chan)
+{
+	BT_ERR("ready for chan %p not implemented", chan);
+}
+
 static struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
+	.close = a2mp_chan_close_cb,
+	.state_change = a2mp_chan_state_change_cb,
+	.alloc_skb = a2mp_chan_alloc_skb_cb,
+
+	/* Not implemented for A2MP */
+	.new_connection = a2mp_chan_no_new_conn_cb,
+	.teardown = a2mp_chan_no_teardown_cb,
+	.ready = a2mp_chan_no_ready,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
-- 
1.7.9.5

