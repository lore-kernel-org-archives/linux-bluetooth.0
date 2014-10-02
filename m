Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix lockdep warning with l2cap_chan_connect
Date: Thu,  2 Oct 2014 10:16:22 +0300
Message-Id: <1412234182-13370-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The L2CAP connection's channel list lock (conn->chan_lock) must never be
taken while already holding a channel lock (chan->lock) in order to
avoid lock-inversion and lockdep warnings. So far the l2cap_chan_connect
function has acquired the chan->lock early in the function and then
later called l2cap_chan_add(conn, chan) which will try to take the
conn->chan_lock. This violates the correct order of taking the locks and
may lead to the following type of lockdep warnings:

-> #1 (&conn->chan_lock){+.+...}:
       [<c109324d>] lock_acquire+0x9d/0x140
       [<c188459c>] mutex_lock_nested+0x6c/0x420
       [<d0aab48e>] l2cap_chan_add+0x1e/0x40 [bluetooth]
       [<d0aac618>] l2cap_chan_connect+0x348/0x8f0 [bluetooth]
       [<d0cc9a91>] lowpan_control_write+0x221/0x2d0 [bluetooth_6lowpan]
-> #0 (&chan->lock){+.+.+.}:
       [<c10928d8>] __lock_acquire+0x1a18/0x1d20
       [<c109324d>] lock_acquire+0x9d/0x140
       [<c188459c>] mutex_lock_nested+0x6c/0x420
       [<d0ab05fd>] l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
       [<d0a909c4>] hci_le_meta_evt+0x11a4/0x1260 [bluetooth]
       [<d0a910eb>] hci_event_packet+0x3ab/0x3120 [bluetooth]
       [<d0a7cb08>] hci_rx_work+0x208/0x4a0 [bluetooth]

       CPU0                    CPU1
       ----                    ----
  lock(&conn->chan_lock);
                               lock(&chan->lock);
                               lock(&conn->chan_lock);
  lock(&chan->lock);

Before calling l2cap_chan_add() the channel is not part of the
conn->chan_l list, and can therefore only be accessed by the L2CAP user
(such as l2cap_sock.c). We can therefore assume that it is the
responsibility of the user to handle mutual exclusion until this point
(which we can see is already true in l2cap_sock.c by it in many places
touching chan members without holding chan->lock).

Since the hci_conn and by exctension l2cap_conn creation in the
l2cap_chan_connect() function depend on chan details we cannot simply
add a mutex_lock(&conn->chan_lock) in the beginning of the function
(since the conn object doesn't yet exist there). What we can do however
is move the chan->lock taking later into the function where we already
have the conn object and can that way take conn->chan_lock first.

This patch implements the above strategy and does some other necessary
changes such as using __l2cap_chan_add() which assumes conn->chan_lock
is held, as well as adding a second needed label so the unlocking
happens as it should.

Reported-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8d53fc57faba..b6f9777e057d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6980,8 +6980,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	hci_dev_lock(hdev);
 
-	l2cap_chan_lock(chan);
-
 	if (!is_valid_psm(__le16_to_cpu(psm), dst_type) && !cid &&
 	    chan->chan_type != L2CAP_CHAN_RAW) {
 		err = -EINVAL;
@@ -7078,17 +7076,20 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+
 	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
-		goto done;
+		goto chan_unlock;
 	}
 
 	/* Update source addr of the socket */
 	bacpy(&chan->src, &hcon->src);
 	chan->src_type = bdaddr_type(hcon, hcon->src_type);
 
-	l2cap_chan_add(conn, chan);
+	__l2cap_chan_add(conn, chan);
 
 	/* l2cap_chan_add takes its own ref so we can drop this one */
 	hci_conn_drop(hcon);
@@ -7114,8 +7115,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	err = 0;
 
-done:
+chan_unlock:
 	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
+done:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
-- 
1.9.3

