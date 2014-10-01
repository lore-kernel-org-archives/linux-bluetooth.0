Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix locking issue when creating l2cap connection
Date: Wed,  1 Oct 2014 13:18:27 +0300
Message-Id: <1412158707-26604-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_chan_connect() was taking locks in different order than
other connection functions like l2cap_connect(). This makes
it possible to have a deadlock when conn->chan_lock (used to
protect the channel list) and chan->lock (used to protect
individual channel) are used in different order in different
kernel threads.

The issue was easily seen when creating a 6LoWPAN connection.

Excerpt from the lockdep report:

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

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
Hi,

this is version 2 of the fix for the locking issue I was seeing
when 6lowpan connection was created.
The patch is now much simpler thanks to Johan's help.

Cheers,
Jukka

 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8d53fc5..2f0415a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7088,7 +7088,16 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	bacpy(&chan->src, &hcon->src);
 	chan->src_type = bdaddr_type(hcon, hcon->src_type);
 
-	l2cap_chan_add(conn, chan);
+	/* The the conn->chan_lock must always be acquired before any
+	 * channel locks to avoid potential deadlocks. Therefore,
+	 * release the chan lock and (re)acquire the locks in the right
+	 * order.
+	 */
+	l2cap_chan_unlock(chan);
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+
+	__l2cap_chan_add(conn, chan);
 
 	/* l2cap_chan_add takes its own ref so we can drop this one */
 	hci_conn_drop(hcon);
@@ -7113,9 +7122,13 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	}
 
 	err = 0;
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
+	goto unlock_hdev;
 
 done:
 	l2cap_chan_unlock(chan);
+unlock_hdev:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
-- 
1.8.3.1

