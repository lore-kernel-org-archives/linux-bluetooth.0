Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 1/3] Bluetooth: Refactor locking in amp_physical_cfm
Date: Wed, 14 Nov 2012 17:39:30 +0200
Message-Id: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove locking from l2cap_physical_cfm and lock chan inside
amp_physical_cfm.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/amp.c           |    6 +++++-
 net/bluetooth/l2cap_core.c    |    7 ++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d65db45..f57fab0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -811,6 +811,6 @@ void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
 void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
-void l2cap_physical_cfm(struct l2cap_chan *chan, int result);
+void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 4b2fea6..eaf473f 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -386,13 +386,17 @@ void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
 
 	bredr_chan = mgr->bredr_chan;
 
+	l2cap_chan_lock(bredr_chan);
+
 	set_bit(FLAG_EFS_ENABLE, &bredr_chan->flags);
 	bredr_chan->remote_amp_id = hs_hcon->remote_id;
 	bredr_chan->hs_hcon = hs_hcon;
 	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;
 	bredr_chan->fcs = L2CAP_FCS_NONE;
 
-	l2cap_physical_cfm(bredr_chan, 0);
+	__l2cap_physical_cfm(bredr_chan, 0);
+
+	l2cap_chan_unlock(bredr_chan);
 
 	hci_dev_put(bredr_hdev);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a1faaab..138d505 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4612,7 +4612,8 @@ static void l2cap_do_move_cancel(struct l2cap_chan *chan, int result)
 	l2cap_ertm_send(chan);
 }
 
-void l2cap_physical_cfm(struct l2cap_chan *chan, int result)
+/* Invoke with locked chan */
+void __l2cap_physical_cfm(struct l2cap_chan *chan, int result)
 {
 	u8 local_amp_id = chan->local_amp_id;
 	u8 remote_amp_id = chan->remote_amp_id;
@@ -4620,8 +4621,6 @@ void l2cap_physical_cfm(struct l2cap_chan *chan, int result)
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
 	       chan, result, local_amp_id, remote_amp_id);
 
-	l2cap_chan_lock(chan);
-
 	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED) {
 		l2cap_chan_unlock(chan);
 		return;
@@ -4645,8 +4644,6 @@ void l2cap_physical_cfm(struct l2cap_chan *chan, int result)
 			break;
 		}
 	}
-
-	l2cap_chan_unlock(chan);
 }
 
 static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
-- 
1.7.10.4

