Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] Bluetooth: Zero bredr pointer when chan is deleted
Date: Mon, 15 Oct 2012 11:58:44 +0300
Message-Id: <1350291524-13258-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If BREDR L2CAP chan is deleted and this chan is the channel through
which High Speed traffic is routed to AMP then zero pointer to
the chan in amp_mgr to prevent accessing it.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 978b203..32b3fae 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -531,6 +531,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	BT_DBG("chan %p, conn %p, err %d", chan, conn, err);
 
 	if (conn) {
+		struct amp_mgr *mgr = conn->hcon->amp_mgr;
 		/* Delete from channel list */
 		list_del(&chan->list);
 
@@ -540,6 +541,9 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
 			hci_conn_put(conn->hcon);
+
+		if (mgr && mgr->bredr_chan == chan)
+			mgr->bredr_chan = NULL;
 	}
 
 	chan->ops->teardown(chan, err);
-- 
1.7.9.5

