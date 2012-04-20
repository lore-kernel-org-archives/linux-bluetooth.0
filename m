Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 04/23] Bluetooth: A2MP: Add chan callbacks
Date: Fri, 20 Apr 2012 14:09:32 +0300
Message-Id: <1334920191-29308-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add state change, close and skb allocation callbacks.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index cb3bf74..67a7ad4 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -63,8 +63,46 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+static void a2mp_chan_state_change_cb(void *data, int state)
+{
+	struct amp_mgr *mgr = data;
+	struct l2cap_chan *chan;
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
+static void a2mp_chan_close_cb(void *data)
+{
+	struct amp_mgr *mgr = data;
+
+	l2cap_chan_destroy(mgr->a2mp_chan);
+}
+
+static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
+					      unsigned long len, int nb)
+{
+	return bt_skb_alloc(len, GFP_KERNEL);
+}
+
 static struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
+	.state_change = a2mp_chan_state_change_cb,
+	.close = a2mp_chan_close_cb,
+	.alloc_skb = a2mp_chan_alloc_skb_cb,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
@@ -102,6 +140,8 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 	chan->remote_mps = chan->omtu;
 	chan->mps = chan->omtu;
 
+	chan->state = BT_CONNECTED;
+
 	return chan;
 }
 
-- 
1.7.9.5

