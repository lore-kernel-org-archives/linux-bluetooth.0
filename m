Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 12/30] Bluetooth: A2MP: skb allocation callback
Date: Thu, 15 Mar 2012 14:30:03 +0200
Message-Id: <1331814621-13905-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 19a8ac3..1607592 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -89,11 +89,18 @@ static void a2mp_chan_close_cb(void *data)
 	l2cap_chan_destroy(mgr->a2mp_chan);
 }
 
+static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
+					unsigned long len, int nb, int *err)
+{
+	return bt_skb_alloc(len, GFP_KERNEL);
+}
+
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
 	.close		= a2mp_chan_close_cb,
 	.send		= l2cap_chan_send,
 	.state_change	= a2mp_chan_state_change_cb,
+	.alloc_skb	= a2mp_chan_alloc_skb_cb,
 };
 
 static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
-- 
1.7.9.1

