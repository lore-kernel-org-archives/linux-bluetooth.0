Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 7/7] Bluetooth: Zero bredr pointer when chan is deleted
Date: Fri, 12 Oct 2012 17:10:05 +0300
Message-Id: <1350051005-6015-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1e717fd..eb286ca 100644
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
 
 	if (chan->ops->teardown)
-- 
1.7.9.5

