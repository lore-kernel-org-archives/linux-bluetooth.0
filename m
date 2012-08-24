Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 15/22] Bluetooth: Close A2MP chan when deleting corr L2CAP chan
Date: Fri, 24 Aug 2012 17:00:14 +0300
Message-Id: <1345816821-32331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When we delete L2CAP channel (e.g. when closing socket) we shall
also delete corresponding A2MP channel.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 45c7c82..b6d901f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -589,6 +589,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	BT_DBG("chan %p, conn %p, err %d", chan, conn, err);
 
 	if (conn) {
+		struct amp_mgr *mgr = conn->hcon->amp_mgr;
 		/* Delete from channel list */
 		list_del(&chan->list);
 
@@ -596,6 +597,14 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		chan->conn = NULL;
 		hci_conn_put(conn->hcon);
+
+		/* BREDR chan corresponding to A2MP chan */
+		if (mgr && chan == mgr->bredr_chan) {
+			BT_DBG("Remove amp_mgr %p", mgr);
+			l2cap_chan_close(mgr->a2mp_chan, 0);
+			amp_mgr_put(mgr);
+			conn->hcon->amp_mgr = NULL;
+		}
 	}
 
 	if (chan->ops->teardown)
-- 
1.7.9.5

