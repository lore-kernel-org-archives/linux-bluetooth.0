Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Subject: [PATCH] Bluetooth: A2MP: Do not reference hci_conn
Date: Thu, 31 May 2012 11:01:37 +0300
Message-Id: <1338451297-20109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make A2MP channel special channel which do not reference hci_conn.
This prevents from keeping ACL connection open when all L2CAP
channels got closed.

hci_conn_hold and hci_conn_put are not reference counts on the
hci_conn structure in the typical way.  They are reference counts for
the ACL.  When you do the last hci_conn_put, the ACL is disconnected
after a timeout.

Reported-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c       |    2 --
 net/bluetooth/l2cap_core.c |    4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index e08ca2a..0772c68 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -481,8 +481,6 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 
 	BT_DBG("chan %p", chan);
 
-	hci_conn_hold(conn->hcon);
-
 	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 953ac53..bef5266 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -514,7 +514,9 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		l2cap_chan_put(chan);
 
 		chan->conn = NULL;
-		hci_conn_put(conn->hcon);
+
+		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
+			hci_conn_put(conn->hcon);
 	}
 
 	if (chan->ops->teardown)
-- 
1.7.9.5

